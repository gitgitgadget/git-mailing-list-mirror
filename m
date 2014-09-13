From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] refs: make rev-parse --quiet actually quiet
Date: Sat, 13 Sep 2014 14:58:06 -0700
Message-ID: <1410645486-40818-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 23:58:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSvKr-00019B-Ur
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 23:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbaIMV6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 17:58:16 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:45670 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbaIMV6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 17:58:12 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so3797986pad.21
        for <git@vger.kernel.org>; Sat, 13 Sep 2014 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=q855ZDxtW610sBAKzKVO1urWwbWP9xLETphSi5hoSuw=;
        b=p6S0FhqNzp2wuELdYrJDljvR4XOYIb6NXI/Z2iKzWgtmsdhY7ljupGZHv0Gt+vLZin
         LuPFJGrdn9QWUsb6/msjh/vfjAvPMH60/kKBAN+Z4V7XvpxoPSLAw2ZDEsN4s6wyfycQ
         bpPhc82yZNDAKivpJkGk/0O1lPtxBf8HM+M81nUeRUrbMVdkcJyVdfdnjq2MAe3+8vKb
         AEr4sLZHtvyEOMT9uvjjj57O75GksU8zqNq4hmCP12Hg5ybGXHQnYHoBBKIW/RgRuMHj
         oRBJEQly4rXpHd2OYTyUVpsIVTc7w6/E/5YDcsF6Dl7U26qMJeOq8e54wpI3DAQ+yWLg
         lYZg==
X-Received: by 10.68.220.105 with SMTP id pv9mr26124733pbc.8.1410645491989;
        Sat, 13 Sep 2014 14:58:11 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ra8sm7718442pab.9.2014.09.13.14.58.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Sep 2014 14:58:11 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.28.gcf9f0e7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256983>

When a reflog is deleted, e.g. when "git stash" clears its stashes,
"git rev-parse --verify --quiet" dies:

	fatal: Log for refs/stash is empty.

The reason is that the get_sha1() code path does not allow us
to suppress this message.

Pass the flags bitfield through the get_sha1_with_context()
so that read_ref_at() can suppress the message.

Use get_sha1_with_context1() instead of get_sha1() in rev-parse
so that the --quiet flag is honored.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This should be applied before "stash: prefer --quiet over shell redirection"
which is currently in pu.

This fixes t3903-stash.sh.

Ronnie, I see you've been making a lot of changes in this area so you
may want to take a look.

 builtin/rev-parse.c   |  5 ++++-
 builtin/show-branch.c |  5 +++--
 refs.c                | 10 +++++++---
 refs.h                |  3 ++-
 sha1_name.c           |  7 ++++---
 5 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index d85e08c..8bc1374 100644
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
index 27927f2..fff0513 100644
--- a/refs.c
+++ b/refs.c
@@ -3104,7 +3104,7 @@ static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
 	return 1;
 }
 
-int read_ref_at(const char *refname, unsigned long at_time, int cnt,
+int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time, int cnt,
 		unsigned char *sha1, char **msg,
 		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
@@ -3122,8 +3122,12 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 
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
index ec46acd..fb4f2c5 100644
--- a/refs.h
+++ b/refs.h
@@ -171,7 +171,8 @@ extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, cons
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
 /** Reads log for the value of ref during at_time. **/
-extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
+extern int read_ref_at(const char *refname, unsigned int flags,
+		       unsigned long at_time, int cnt,
 		       unsigned char *sha1, char **msg,
 		       unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
diff --git a/sha1_name.c b/sha1_name.c
index 63ee66f..30845f1 100644
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
 
-- 
2.1.0.28.gcf9f0e7.dirty
