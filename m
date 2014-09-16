From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 2/3] refs: make rev-parse --quiet actually quiet
Date: Mon, 15 Sep 2014 20:24:09 -0700
Message-ID: <1410837850-5169-2-git-send-email-davvid@gmail.com>
References: <1410837850-5169-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 05:24:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTjNR-0000g3-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 05:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbaIPDYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 23:24:21 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41750 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbaIPDYU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 23:24:20 -0400
Received: by mail-pd0-f172.google.com with SMTP id v10so7760029pde.31
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 20:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XNGdtbP1HusuR1lutQdQNAZ6CKcgFZCYYCWg4HU46uI=;
        b=rk2oVZ01R2NfSCOrysFwfw1csjSE1PfWmD0waN3XeK33moEiccnIWfFEJyg5+PnMeu
         fr+BzQeE+sNk8EIQrpD2mx6QQs4FYJ+YT1tEr9yBz73d6l9qANCyaJ6rV89QtWocoMEt
         pBXGgsie/QFKhgTEtWn6CdkQFIckGTct1xeNJI+YKfp6wnXbmTT0rg21KcQa2jKJ6E42
         kQNgHR0OaV/Nw4a/maAd93X54UdEwUoGyW4z8ZynCZuuqptvj/aZqwf4pFBgv6CfZxtb
         deTuecI3J0olXOWgHnRuallRJI6LMtnhZrPNa5e6wZkfnnXtd1PTo5rn2iUQUMhoIBe/
         RL8A==
X-Received: by 10.66.180.98 with SMTP id dn2mr45041601pac.83.1410837858941;
        Mon, 15 Sep 2014 20:24:18 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id v1sm12633581pdp.76.2014.09.15.20.24.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Sep 2014 20:24:18 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g05c535b.dirty
In-Reply-To: <1410837850-5169-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257125>

When a reflog is deleted, e.g. when "git stash" clears its stashes,
"git rev-parse --verify --quiet" dies:

	fatal: Log for refs/stash is empty.

The reason is that the get_sha1() code path does not allow us
to suppress this message.

Pass the flags bitfield through get_sha1_with_context() so that
read_ref_at() can suppress the message.

Use get_sha1_with_context1() instead of get_sha1() in rev-parse
so that the --quiet flag is honored.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch now has the t1503 test case squashed into it.
It was previously a separate patch, but it makes more sense
for them to go together.

 builtin/rev-parse.c         |  5 ++++-
 builtin/show-branch.c       |  5 +++--
 refs.c                      | 10 +++++++---
 refs.h                      |  3 ++-
 sha1_name.c                 |  7 ++++---
 t/t1503-rev-parse-verify.sh |  9 +++++++++
 6 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c911b45..35d3c43 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -508,7 +508,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	int has_dashdash = 0;
 	int output_prefix = 0;
 	unsigned char sha1[20];
+	unsigned int flags = 0;
 	const char *name = NULL;
+	struct object_context unused;
 
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
@@ -596,6 +598,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--quiet") || !strcmp(arg, "-q")) {
 				quiet = 1;
+				flags |= GET_SHA1_QUIETLY;
 				continue;
 			}
 			if (!strcmp(arg, "--short") ||
@@ -818,7 +821,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			name++;
 			type = REVERSED;
 		}
-		if (!get_sha1(name, sha1)) {
+		if (!get_sha1_with_context(name, flags, sha1, &unused)) {
 			if (verify)
 				revs_count++;
 			else
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 298c95e..46498e1 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -723,6 +723,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		char nth_desc[256];
 		char *ref;
 		int base = 0;
+		unsigned int flags = 0;
 
 		if (ac == 0) {
 			static const char *fake_av[2];
@@ -749,7 +750,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				/* Ah, that is a date spec... */
 				unsigned long at;
 				at = approxidate(reflog_base);
-				read_ref_at(ref, at, -1, sha1, NULL,
+				read_ref_at(ref, flags, at, -1, sha1, NULL,
 					    NULL, NULL, &base);
 			}
 		}
@@ -760,7 +761,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			unsigned long timestamp;
 			int tz;
 
-			if (read_ref_at(ref, 0, base+i, sha1, &logmsg,
+			if (read_ref_at(ref, flags, 0, base+i, sha1, &logmsg,
 					&timestamp, &tz, NULL)) {
 				reflog = i;
 				break;
diff --git a/refs.c b/refs.c
index 2ce5d69..447e339 100644
--- a/refs.c
+++ b/refs.c
@@ -3108,7 +3108,7 @@ static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
 	return 1;
 }
 
-int read_ref_at(const char *refname, unsigned long at_time, int cnt,
+int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time, int cnt,
 		unsigned char *sha1, char **msg,
 		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
@@ -3126,8 +3126,12 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 
 	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
 
-	if (!cb.reccnt)
-		die("Log for %s is empty.", refname);
+	if (!cb.reccnt) {
+		if (flags & GET_SHA1_QUIETLY)
+			exit(1);
+		else
+			die("Log for %s is empty.", refname);
+	}
 	if (cb.found_it)
 		return 0;
 
diff --git a/refs.h b/refs.h
index 68c5770..0ca6059 100644
--- a/refs.h
+++ b/refs.h
@@ -206,7 +206,8 @@ extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, cons
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
 /** Reads log for the value of ref during at_time. **/
-extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
+extern int read_ref_at(const char *refname, unsigned int flags,
+		       unsigned long at_time, int cnt,
 		       unsigned char *sha1, char **msg,
 		       unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
diff --git a/sha1_name.c b/sha1_name.c
index 7098b10..d292e31 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -432,7 +432,8 @@ static inline int upstream_mark(const char *string, int len)
 static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(const char *name, int namelen, struct strbuf *buf);
 
-static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
+static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
+			  unsigned int flags)
 {
 	static const char *warn_msg = "refname '%.*s' is ambiguous.";
 	static const char *object_name_msg = N_(
@@ -545,7 +546,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 				return -1;
 			}
 		}
-		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
+		if (read_ref_at(real_ref, flags, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
 				if (starts_with(real_ref, "refs/heads/")) {
@@ -801,7 +802,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
 	if (!ret)
 		return 0;
 
-	ret = get_sha1_basic(name, len, sha1);
+	ret = get_sha1_basic(name, len, sha1, lookup_flags);
 	if (!ret)
 		return 0;
 
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index d1f93b3..4fe9f0e 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -83,6 +83,15 @@ test_expect_success 'fails silently when using -q' '
 	test_must_be_empty error
 '
 
+test_expect_success 'fails silently when using -q with deleted reflogs' '
+	ref=$(git rev-parse HEAD) &&
+	: >.git/logs/refs/test &&
+	git update-ref -m "reflog message for refs/test" refs/test "$ref" &&
+	git reflog delete --updateref --rewrite refs/test@{0} &&
+	test_must_fail git rev-parse -q --verify refs/test@{0} >error 2>&1 &&
+	test_must_be_empty error
+'
+
 test_expect_success 'no stdout output on error' '
 	test -z "$(git rev-parse --verify)" &&
 	test -z "$(git rev-parse --verify foo)" &&
-- 
2.1.0.30.g05c535b.dirty
