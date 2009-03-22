From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 2/3] format-patch: --attach/inline uses filename instead of SHA1
Date: Sat, 21 Mar 2009 21:32:42 -0700
Message-ID: <1237696363-6819-3-git-send-email-bebarino@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <1237696363-6819-2-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 05:34:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlFOY-00048I-OU
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 05:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbZCVEc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 00:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbZCVEcz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 00:32:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:16810 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbZCVEcx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 00:32:53 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2242279wff.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 21:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=X4LnrRK2REC8LKKhZue813fkV1c5ijxsJCScGMaQM3s=;
        b=txxhkcG89POEoTRpRMzhxV5tZB6AdR5faOjU8hPZ29lSh5ljnHHwOSHZFz2nTC+wtF
         3W8leAJ8QmwVCqnY8AWWd1g/8oded3jmC2gZA06Amh4lo5znVm5+Zhp8lDueeGOj6kXL
         OQkZ6/eHIiD7YYpwuvu0N+VF6u0Gsm0eFMrQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kYIa0Y/veU3O/jC4nZfSKIMxwTsCnahngSQxoVmcDLwt/46z9qyWeGekM9uqNoAFHK
         K/yg56twiruEFDjComPiXo1/nt6WzHA09tWRQuRl85TUKSHMCGK38dsmRfa0hbOotfzg
         6XnYRsaAvXDVGnGtIVjR0kmLEAC2cNApd7uco=
Received: by 10.142.217.17 with SMTP id p17mr2226582wfg.235.1237696371928;
        Sat, 21 Mar 2009 21:32:51 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 27sm7999759wff.28.2009.03.21.21.32.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 21 Mar 2009 21:32:51 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 21 Mar 2009 21:32:49 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237696363-6819-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114116>

Currently when format-patch is used with --attach or --inline the patch
attachment has the SHA1 of the commit for its filename. This replaces
the SHA1 with the filename used by format-patch when outputting to files.

Fix tests relying on the SHA1 output and add a test showing how the
--suffix option affects the attachment filename output.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
Is modifying the rev_info struct correct?

 builtin-log.c                                      |    6 +-
 log-tree.c                                         |    8 +-
 revision.h                                         |    1 +
 t/t4013-diff-various.sh                            |    1 +
 ..._--attach_--stdout_--suffix=.diff_initial..side |   61 ++++++++++++++++++++
 ....format-patch_--attach_--stdout_initial..master |   12 ++--
 ...format-patch_--attach_--stdout_initial..master^ |    8 +-
 ...ff.format-patch_--attach_--stdout_initial..side |    4 +-
 ...tdout_--subject-prefix=TESTCASE_initial..master |   12 ++--
 ....format-patch_--inline_--stdout_initial..master |   12 ++--
 ...format-patch_--inline_--stdout_initial..master^ |    8 +-
 ...ormat-patch_--inline_--stdout_initial..master^^ |    4 +-
 ...ff.format-patch_--inline_--stdout_initial..side |    4 +-
 13 files changed, 102 insertions(+), 39 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side

diff --git a/builtin-log.c b/builtin-log.c
index cc6d663..8ea25e0 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1107,9 +1107,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		 */
 		if (!numbered_files && (sol = strstr(commit->buffer, "\n\n")))
 			sol += 2;
-		if (!use_stdout && reopen_stdout(get_patch_filename(sol,
-								keep_subject,
-								rev.nr), &rev))
+		rev.fmt_patch_filename = get_patch_filename(sol, keep_subject,
+								rev.nr);
+		if (!use_stdout && reopen_stdout(rev.fmt_patch_filename, &rev))
 			die("Failed to create output files");
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
diff --git a/log-tree.c b/log-tree.c
index 9565c18..dc37d16 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -245,14 +245,14 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 		snprintf(buffer, sizeof(buffer) - 1,
 			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
-			 " name=\"%s.diff\"\n"
+			 " name=\"%s\"\n"
 			 "Content-Transfer-Encoding: 8bit\n"
 			 "Content-Disposition: %s;"
-			 " filename=\"%s.diff\"\n\n",
+			 " filename=\"%s\"\n\n",
 			 mime_boundary_leader, opt->mime_boundary,
-			 name,
+			 opt->fmt_patch_filename,
 			 opt->no_inline ? "attachment" : "inline",
-			 name);
+			 opt->fmt_patch_filename);
 		opt->diffopt.stat_sep = buffer;
 	}
 	*subject_p = subject;
diff --git a/revision.h b/revision.h
index ad123d7..c34eac9 100644
--- a/revision.h
+++ b/revision.h
@@ -86,6 +86,7 @@ struct rev_info {
 	struct log_info *loginfo;
 	int		nr, total;
 	const char	*mime_boundary;
+	const char	*fmt_patch_filename;
 	char		*message_id;
 	struct string_list *ref_message_ids;
 	const char	*add_signoff;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 426e64e..6592a4f 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -246,6 +246,7 @@ format-patch --stdout initial..master
 format-patch --stdout --no-numbered initial..master
 format-patch --stdout --numbered initial..master
 format-patch --attach --stdout initial..side
+format-patch --attach --stdout --suffix=.diff initial..side
 format-patch --attach --stdout initial..master^
 format-patch --attach --stdout initial..master
 format-patch --inline --stdout initial..side
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side
new file mode 100644
index 0000000..52116d3
--- /dev/null
+++ b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side
@@ -0,0 +1,61 @@
+$ git format-patch --attach --stdout --suffix=.diff initial..side
+From c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:03:00 +0000
+Subject: [PATCH] Side
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
+
+This is a multi-part message in MIME format.
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/plain; charset=UTF-8; format=fixed
+Content-Transfer-Encoding: 8bit
+
+---
+ dir/sub |    2 ++
+ file0   |    3 +++
+ file3   |    4 ++++
+ 3 files changed, 9 insertions(+), 0 deletions(-)
+ create mode 100644 file3
+
+
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/x-patch; name="0001-Side.diff"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: attachment; filename="0001-Side.diff"
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+
+--------------g-i-t--v-e-r-s-i-o-n--
+
+
+$
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index e5ab744..ce49bd6 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: attachment; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: attachment; filename="0002-Third.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -129,9 +129,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0003-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: attachment; filename="0003-Side.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index 2c71d20..5f1b238 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: attachment; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: attachment; filename="0002-Third.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index 38f7902..4a2364a 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
@@ -20,9 +20,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0001-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: attachment; filename="0001-Side.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
index 58f8a7b..ca3f60b 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="0002-Third.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -129,9 +129,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0003-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="0003-Side.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
index 9e7bbdf..08f2301 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="0002-Third.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -129,9 +129,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0003-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="0003-Side.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
index f881f64..07f1230 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="0002-Third.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
index 4f258b8..29e00ab 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
@@ -22,9 +22,9 @@ This is the second commit.
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..side b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
index e86dce6..67633d4 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
@@ -20,9 +20,9 @@ Content-Transfer-Encoding: 8bit
 
 
 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0001-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="0001-Side.patch"
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
-- 
1.6.2
