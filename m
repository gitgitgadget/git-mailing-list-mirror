From: Adam Roben <aroben@apple.com>
Subject: [PATCH] format-patch: Add format.subjectprefix config option
Date: Sun,  1 Jul 2007 17:48:59 -0700
Message-ID: <1183337339745-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 02:49:04 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5A6A-0001dM-5O
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 02:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbXGBAtA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 20:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754822AbXGBAs7
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 20:48:59 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:60656 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056AbXGBAs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 20:48:59 -0400
Received: from relay5.apple.com (relay5.apple.com [17.128.113.35])
	by mail-out4.apple.com (Postfix) with ESMTP id C53D1AF42E8;
	Sun,  1 Jul 2007 17:48:58 -0700 (PDT)
Received: from relay5.apple.com (unknown [127.0.0.1])
	by relay5.apple.com (Symantec Mail Security) with ESMTP id AE5CB29C004;
	Sun,  1 Jul 2007 17:48:58 -0700 (PDT)
X-AuditID: 11807123-a401ebb000000a55-22-46884b7a6475
Received: from localhost.localdomain (int-si-a.apple.com [17.128.113.41])
	by relay5.apple.com (Apple SCV relay) with ESMTP id 74C4230400B;
	Sun,  1 Jul 2007 17:48:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.2.619.g06f59-dirty
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51332>

This change lets you use the format.subjectprefix config option to override the
default subject prefix.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Documentation/git-format-patch.txt                 |    5 +-
 builtin-log.c                                      |    9 +++
 revision.c                                         |    1 -
 t/t4013-diff-various.sh                            |    2 +
 ...ff.config_format.subjectprefix_DIFFERENT_PREFIX |    2 +
 ...ormat-patch_--inline_--stdout_initial..master^^ |   60 ++++++++++++++++++++
 6 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 t/t4013/diff.config_format.subjectprefix_DIFFERENT_PREFIX
 create mode 100644 t/t4013/diff.format-patch_--inline_--stdout_initial..master^^

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 647de90..e563810 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -126,12 +126,13 @@ not add any suffix.
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each
-message in the repository configuration.  Also you can specify
-the default suffix different from the built-in one:
+message in the repository configuration.  You can also specify
+new defaults for the subject prefix and file suffix.
 
 ------------
 [format]
         headers = "Organization: git-foo\n"
+        subjectprefix = CHANGE
         suffix = .txt
 ------------
 
diff --git a/builtin-log.c b/builtin-log.c
index a4186ea..5dc2c1c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -265,6 +265,7 @@ static int istitlechar(char c)
 
 static char *extra_headers = NULL;
 static int extra_headers_size = 0;
+static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_patch_suffix = ".patch";
 
 static int git_format_config(const char *var, const char *value)
@@ -290,6 +291,13 @@ static int git_format_config(const char *var, const char *value)
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		return 0;
 	}
+	if (!strcmp(var, "format.subjectprefix")) {
+		if (!value)
+			die("format.subjectprefix without value");
+		fmt_patch_subject_prefix = xstrdup(value);
+		return 0;
+	}
+
 	return git_log_config(var, value);
 }
 
@@ -459,6 +467,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diffopt.msg_sep = "";
 	rev.diffopt.recursive = 1;
 
+	rev.subject_prefix = fmt_patch_subject_prefix;
 	rev.extra_headers = extra_headers;
 
 	/*
diff --git a/revision.c b/revision.c
index 7834bb1..5184716 100644
--- a/revision.c
+++ b/revision.c
@@ -667,7 +667,6 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->min_age = -1;
 	revs->skip_count = -1;
 	revs->max_count = -1;
-	revs->subject_prefix = "PATCH";
 
 	revs->prune_fn = NULL;
 	revs->prune_data = NULL;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8f4c29a..b453b42 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -242,6 +242,8 @@ format-patch --inline --stdout initial..side
 format-patch --inline --stdout initial..master^
 format-patch --inline --stdout initial..master
 format-patch --inline --stdout --subject-prefix=TESTCASE initial..master
+config format.subjectprefix DIFFERENT_PREFIX
+format-patch --inline --stdout initial..master^^
 
 diff --abbrev initial..side
 diff -r initial..side
diff --git a/t/t4013/diff.config_format.subjectprefix_DIFFERENT_PREFIX b/t/t4013/diff.config_format.subjectprefix_DIFFERENT_PREFIX
new file mode 100644
index 0000000..78f8970
--- /dev/null
+++ b/t/t4013/diff.config_format.subjectprefix_DIFFERENT_PREFIX
@@ -0,0 +1,2 @@
+$ git config format.subjectprefix DIFFERENT_PREFIX
+$
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
new file mode 100644
index 0000000..b8e81e1
--- /dev/null
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
@@ -0,0 +1,60 @@
+$ git format-patch --inline --stdout initial..master^^
+From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:01:00 +0000
+Subject: [DIFFERENT_PREFIX] Second
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
+
+This is a multi-part message in MIME format.
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/plain; charset=UTF-8; format=fixed
+Content-Transfer-Encoding: 8bit
+
+
+This is the second commit.
+---
+ dir/sub |    2 ++
+ file0   |    3 +++
+ file2   |    3 ---
+ 3 files changed, 5 insertions(+), 3 deletions(-)
+ delete mode 100644 file2
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
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
+
+--------------g-i-t--v-e-r-s-i-o-n--
+
+
+$
-- 
1.5.2.2.619.g06f59-dirty
