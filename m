From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] refs: make rev-parse --quiet actually quiet
Date: Thu, 18 Sep 2014 20:45:37 -0700
Message-ID: <1411098337-35406-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 05:45:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUp8g-0007Xv-P8
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 05:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbaISDph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 23:45:37 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:60330 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbaISDpg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 23:45:36 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so2961104pab.40
        for <git@vger.kernel.org>; Thu, 18 Sep 2014 20:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=URxtP16nxzedvbGw04RKRrVMSV6hq4H4zDl7Zah9P1Y=;
        b=SRjXSuadO5AbGZe8qXaNbPo5J2aavwi9oCvJaI0xWThRs1Cnf9uOKe06DAI8IvRMox
         8cFoIQR7EougLat98bZ79i3CjKRPvkCPCzAdceqoW1N845umnMrj7jo+1UekTH8u8cfh
         HRVG7W0BIVZBArUsKRuiTxEyCWbz5vrh/11vy2wQfAaauC1Imn75DVfqTHs4Dsj2/JFb
         ZXDPf1YnpmihTWpgpKC17CDw28aFQRth0w476haMbyGik8/s5pIDLOz4LaIPSgwbtc+L
         ermezqW6GIbo1cC8qo9WI0ojvgyhcE9o1Oz0P/fEIEVqBa20EIH7MbjtRapk0y3jUBGv
         jLDw==
X-Received: by 10.70.138.102 with SMTP id qp6mr13459963pdb.127.1411098335927;
        Thu, 18 Sep 2014 20:45:35 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id p3sm436831pde.35.2014.09.18.20.45.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Sep 2014 20:45:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.247.gd1adca9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257278>

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
This is a replacement patch for "refs: make rev-parse --quiet actually quiet"
from da/rev-parse-verify-quiet in pu.

The test message now mentions "reflogs that do not go far back enough in time"
and the conditional above the warning() has been adjusted.

This also includes the warning patch squashed in.
I can split them apart if desired, but this seems nice and coherent.

 builtin/rev-parse.c         |  5 ++++-
 builtin/show-branch.c       |  5 +++--
 refs.c                      | 10 +++++++---
 refs.h                      |  3 ++-
 sha1_name.c                 | 24 +++++++++++++++---------
 t/t1503-rev-parse-verify.sh | 27 +++++++++++++++++++++++++++
 6 files changed, 58 insertions(+), 16 deletions(-)

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
index 2ce5d69..9e405f9 100644
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
+			exit(128);
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
index 7098b10..5b004f5 100644
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
@@ -511,7 +512,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (!refs_found)
 		return -1;
 
-	if (warn_ambiguous_refs &&
+	if (warn_ambiguous_refs && !(flags & GET_SHA1_QUIETLY) &&
 	    (refs_found > 1 ||
 	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
 		warning(warn_msg, len, str);
@@ -545,7 +546,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 				return -1;
 			}
 		}
-		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
+		if (read_ref_at(real_ref, flags, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
 				if (starts_with(real_ref, "refs/heads/")) {
@@ -557,11 +558,16 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 					len = 4;
 				}
 			}
-			if (at_time)
-				warning("Log for '%.*s' only goes "
-					"back to %s.", len, str,
-					show_date(co_time, co_tz, DATE_RFC2822));
-			else {
+			if (at_time) {
+				if (!(flags & GET_SHA1_QUIETLY)) {
+					warning("Log for '%.*s' only goes "
+						"back to %s.", len, str,
+						show_date(co_time, co_tz, DATE_RFC2822));
+				}
+			} else {
+				if (flags & GET_SHA1_QUIETLY) {
+					exit(128);
+				}
 				die("Log for '%.*s' only has %d entries.",
 				    len, str, co_cnt);
 			}
@@ -801,7 +807,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
 	if (!ret)
 		return 0;
 
-	ret = get_sha1_basic(name, len, sha1);
+	ret = get_sha1_basic(name, len, sha1, lookup_flags);
 	if (!ret)
 		return 0;
 
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index d1f93b3..823fe1d 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -83,6 +83,33 @@ test_expect_success 'fails silently when using -q' '
 	test_must_be_empty error
 '
 
+test_expect_success 'fails silently when using -q with deleted reflogs' '
+	ref=$(git rev-parse HEAD) &&
+	: >.git/logs/refs/test &&
+	git update-ref -m "message for refs/test" refs/test "$ref" &&
+	git reflog delete --updateref --rewrite refs/test@{0} &&
+	test_must_fail git rev-parse -q --verify refs/test@{0} >error 2>&1 &&
+	test_must_be_empty error
+'
+
+test_expect_success 'fails silently when using -q with not enough reflogs' '
+	ref=$(git rev-parse HEAD) &&
+	: >.git/logs/refs/test2 &&
+	git update-ref -m "message for refs/test2" refs/test2 "$ref" &&
+	test_must_fail git rev-parse -q --verify refs/test2@{999} >error 2>&1 &&
+	test_must_be_empty error
+'
+
+test_expect_success 'succeeds silently with -q and reflogs that do not go far back enough in time' '
+	ref=$(git rev-parse HEAD) &&
+	: >.git/logs/refs/test3 &&
+	git update-ref -m "message for refs/test3" refs/test3 "$ref" &&
+	git rev-parse -q --verify refs/test3@{1.year.ago} >actual 2>error &&
+	test_must_be_empty error &&
+	echo "$ref" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no stdout output on error' '
 	test -z "$(git rev-parse --verify)" &&
 	test -z "$(git rev-parse --verify foo)" &&
-- 
2.1.0.247.g18aa141.dirty
