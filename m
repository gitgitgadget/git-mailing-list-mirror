From: Marc Finet <m.dreadlock@gmail.com>
Subject: PATCH/RFC: format-patch: Add format.subjectprefixsep to change separators
Date: Sun,  4 Jan 2015 14:21:26 +0100
Message-ID: <1420377686-25608-1-git-send-email-m.dreadlock@gmail.com>
Cc: Marc Finet <m.dreadlock@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 04 14:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7l8S-0001FY-I1
	for gcvg-git-2@plane.gmane.org; Sun, 04 Jan 2015 14:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbbADNVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 08:21:43 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:44789 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbbADNVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 08:21:42 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so1769669wiw.9
        for <git@vger.kernel.org>; Sun, 04 Jan 2015 05:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=87tcGeTT20fj/I1cV6iKm6jZg7PSZeVKYe5krd7bcf8=;
        b=EzDVVf2d9GTeEd6Z/yzgo6TVtb4oircuq7/az8To85lZqrkYoeH8/8Lfb4w85+Ncri
         vhpEo+s9Vgj0iimZBbKJrvTnw17kRLyb4aKVuo6B5XVZO2urxqYkmZ6z7qvLe2MUJYka
         yPPPytnof2yqWj7E995Xn+r5MuVLtfBSaM4nHlQ+bowQwX/E2wx/XFcG7gCyb2mchSqD
         BftHqeXlXadT51oq22P0YOgwvkc6GK+U3s/rx6yBW44Tuq6UYOeuxuQZQZUGbdyq2anS
         W8v346iiRHFEoYTdf950H8oCF4QKxpfCKv01DZ/HY53tqUWVUYaL6FOqDA9ekMJeFRdT
         dsRw==
X-Received: by 10.180.95.136 with SMTP id dk8mr15904332wib.64.1420377697702;
        Sun, 04 Jan 2015 05:21:37 -0800 (PST)
Received: from mlap.lactee (amg01-2-78-227-45-71.fbx.proxad.net. [78.227.45.71])
        by mx.google.com with ESMTPSA id i3sm6026499wie.23.2015.01.04.05.21.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jan 2015 05:21:37 -0800 (PST)
Received: by mlap.lactee (Postfix, from userid 1000)
	id BAD90180D7B; Sun,  4 Jan 2015 14:21:35 +0100 (CET)
X-Mailer: git-send-email 2.2.1.213.gdc6c5b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262006>

Some mailing list use "PATCH:" rather than "[PATCH]" to prefix
patches, so introduce a new option to configure:
 - 2 chars that would enclose PATCH (and counters)
 - 1 char that would come just after the PATCH (and counters)
---
This mail has been sent with:
 git -c format.subjectprefixsep=: send-email --annotate --subject-prefix=PATCH/RFC

 Documentation/config.txt                           |  5 ++
 builtin/log.c                                      |  5 ++
 log-tree.c                                         | 23 ++++--
 revision.h                                         |  1 +
 t/t4013-diff-various.sh                            |  2 +
 ...fixsep=:_format-patch_--stdout_initial..master^ | 81 ++++++++++++++++++++++
 ...ixsep=<>_format-patch_--stdout_initial..master^ | 81 ++++++++++++++++++++++
 7 files changed, 194 insertions(+), 4 deletions(-)
 create mode 100644 t/t4013/diff.-c_format.subjectprefixsep=:_format-patch_--stdout_initial..master^
 create mode 100644 t/t4013/diff.-c_format.subjectprefixsep=<>_format-patch_--stdout_initial..master^

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6862e3e..8cf8aac 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1151,6 +1151,11 @@ format.subjectprefix::
 	The default for format-patch is to output files with the '[PATCH]'
 	subject prefix. Use this variable to change that prefix.
 
+format.subjectprefixsep::
+	The default for format-patch is to enclose subjectprefix with '[]'.
+	If only one char is given it is placed after the prefix. If it
+	contains two chars, they enclose the prefix.
+
 format.signature::
 	The default for format-patch is to output a signature containing
 	the Git version number. Use this variable to change that default.
diff --git a/builtin/log.c b/builtin/log.c
index f2a9f01..18a4e7e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -35,6 +35,7 @@ static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config;
 static const char *fmt_patch_subject_prefix = "PATCH";
+static const char *fmt_patch_subject_prefix_sep = "[]";
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
@@ -109,6 +110,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
+	rev->subject_prefix_sep = fmt_patch_subject_prefix_sep;
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 
 	if (default_date_mode)
@@ -374,6 +376,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
+	if (!strcmp(var, "format.subjectprefixsep"))
+		return git_config_string(&fmt_patch_subject_prefix_sep, var, value);
 	if (!strcmp(var, "log.abbrevcommit")) {
 		default_abbrev_commit = git_config_bool(var, value);
 		return 0;
@@ -1259,6 +1263,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.max_parents = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 	rev.subject_prefix = fmt_patch_subject_prefix;
+	rev.subject_prefix_sep = fmt_patch_subject_prefix_sep;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
diff --git a/log-tree.c b/log-tree.c
index 7f0890e..8449d19 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -269,22 +269,37 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 	const char *subject = NULL;
 	const char *extra_headers = opt->extra_headers;
 	const char *name = sha1_to_hex(commit->object.sha1);
+	char subject_sep_pre[2];
+	char subject_sep_post[2];
+
+	subject_sep_pre[0] = subject_sep_post[0] = '\0';
+	if (strlen(opt->subject_prefix_sep) > 1) {
+		subject_sep_pre[0] = opt->subject_prefix_sep[0];
+		subject_sep_post[0] = opt->subject_prefix_sep[1];
+	} else {
+		subject_sep_post[0] = opt->subject_prefix_sep[0];
+	}
+	subject_sep_pre[1] = subject_sep_post[1] = '\0';
 
 	*need_8bit_cte_p = 0; /* unknown */
 	if (opt->total > 0) {
 		static char buffer[64];
 		snprintf(buffer, sizeof(buffer),
-			 "Subject: [%s%s%0*d/%d] ",
+			 "Subject: %s%s%s%0*d/%d%s ",
+			 subject_sep_pre,
 			 opt->subject_prefix,
 			 *opt->subject_prefix ? " " : "",
 			 digits_in_number(opt->total),
-			 opt->nr, opt->total);
+			 opt->nr, opt->total,
+			 subject_sep_post);
 		subject = buffer;
 	} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
 		static char buffer[256];
 		snprintf(buffer, sizeof(buffer),
-			 "Subject: [%s] ",
-			 opt->subject_prefix);
+			 "Subject: %s%s%s ",
+			 subject_sep_pre,
+			 opt->subject_prefix,
+			 subject_sep_post);
 		subject = buffer;
 	} else {
 		subject = "Subject: ";
diff --git a/revision.h b/revision.h
index 9cb5adc..baae88f 100644
--- a/revision.h
+++ b/revision.h
@@ -162,6 +162,7 @@ struct rev_info {
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
+	const char	*subject_prefix_sep;
 	int		no_inline;
 	int		show_log_size;
 	struct string_list *mailmap;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6ec6072..d2257ab 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -289,6 +289,8 @@ format-patch --inline --stdout --subject-prefix=TESTCASE initial..master
 config format.subjectprefix DIFFERENT_PREFIX
 format-patch --inline --stdout initial..master^^
 format-patch --stdout --cover-letter -n initial..master^
+-c format.subjectprefixsep=: format-patch --stdout initial..master^
+-c format.subjectprefixsep=<> format-patch --stdout initial..master^
 
 diff --abbrev initial..side
 diff -r initial..side
diff --git a/t/t4013/diff.-c_format.subjectprefixsep=:_format-patch_--stdout_initial..master^ b/t/t4013/diff.-c_format.subjectprefixsep=:_format-patch_--stdout_initial..master^
new file mode 100644
index 0000000..b4a741b
--- /dev/null
+++ b/t/t4013/diff.-c_format.subjectprefixsep=:_format-patch_--stdout_initial..master^
@@ -0,0 +1,81 @@
+$ git -c format.subjectprefixsep=: format-patch --stdout initial..master^
+From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:01:00 +0000
+Subject: DIFFERENT_PREFIX 1/2: Second
+
+This is the second commit.
+---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
+ 3 files changed, 5 insertions(+), 3 deletions(-)
+ delete mode 100644 file2
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..8422d40 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++C
++D
+diff --git a/file0 b/file0
+index 01e79c3..b414108 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++4
++5
++6
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+-- 
+g-i-t--v-e-r-s-i-o-n
+
+
+From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:02:00 +0000
+Subject: DIFFERENT_PREFIX 2/2: Third
+
+---
+ dir/sub | 2 ++
+ file1   | 3 +++
+ 2 files changed, 5 insertions(+)
+ create mode 100644 file1
+
+diff --git a/dir/sub b/dir/sub
+index 8422d40..cead32e 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2,3 +2,5 @@ A
+ B
+ C
+ D
++E
++F
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+-- 
+g-i-t--v-e-r-s-i-o-n
+
+$
diff --git a/t/t4013/diff.-c_format.subjectprefixsep=<>_format-patch_--stdout_initial..master^ b/t/t4013/diff.-c_format.subjectprefixsep=<>_format-patch_--stdout_initial..master^
new file mode 100644
index 0000000..c0305df
--- /dev/null
+++ b/t/t4013/diff.-c_format.subjectprefixsep=<>_format-patch_--stdout_initial..master^
@@ -0,0 +1,81 @@
+$ git -c format.subjectprefixsep=<> format-patch --stdout initial..master^
+From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:01:00 +0000
+Subject: <DIFFERENT_PREFIX 1/2> Second
+
+This is the second commit.
+---
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
+ 3 files changed, 5 insertions(+), 3 deletions(-)
+ delete mode 100644 file2
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..8422d40 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++C
++D
+diff --git a/file0 b/file0
+index 01e79c3..b414108 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++4
++5
++6
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+-- 
+g-i-t--v-e-r-s-i-o-n
+
+
+From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:02:00 +0000
+Subject: <DIFFERENT_PREFIX 2/2> Third
+
+---
+ dir/sub | 2 ++
+ file1   | 3 +++
+ 2 files changed, 5 insertions(+)
+ create mode 100644 file1
+
+diff --git a/dir/sub b/dir/sub
+index 8422d40..cead32e 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2,3 +2,5 @@ A
+ B
+ C
+ D
++E
++F
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+-- 
+g-i-t--v-e-r-s-i-o-n
+
+$
-- 
2.2.1.213.gdc6c5b9
