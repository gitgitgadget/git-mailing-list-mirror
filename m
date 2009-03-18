From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/3] format-patch: --attach/inline uses filename instead of 
	sha1
Date: Wed, 18 Mar 2009 12:51:25 -0700
Message-ID: <780e0a6b0903181251ua7b6992y45407c8ee806011c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 20:53:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk1pP-0007aw-Sx
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 20:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbZCRTva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 15:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbZCRTv3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 15:51:29 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:10635 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbZCRTv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 15:51:28 -0400
Received: by yw-out-2324.google.com with SMTP id 5so211020ywb.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=P5b8T7ZePfgIa6+h0NCiAfwhEmQmc5pc6CpV+3ccI9g=;
        b=lmpFpvxsfdq4WlmTMp5mAFrpEyQ6A+R9Xr54O0OpkANWwMOUYyZ4uZp0z/pqrghfkn
         HFhBBTcUo98xsNZhjJBEvVEruMELzN+4GJtcQhuRZdzVxo2CA8nOifgyoUwcvx4UpzRf
         6qtAyJiiHx3wCNK1jUzZyJVRyFuQYGGD44KmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ezP3iaWdAJCFj7fWxVEJL+prpxJ4+tTpl6KMqnXS/VUJkJcOowEV7gL9/sAdRdi/zG
         yVc9AkMBKwK149sBB+WYLFsMuUCLyq4ertC8uQGIEVzkOUBjLJndv9xdCI80VBDbILGp
         nY21OR8CK5ITYeWgew0EnKtYXeKt/WWj9mkYY=
Received: by 10.142.246.20 with SMTP id t20mr418331wfh.292.1237405885508; Wed, 
	18 Mar 2009 12:51:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113656>

Currently when format-patch is used with --attach or --inline the patch
attachment has the sha1 of the commit for the filename. This replaces
the sha1 with the filename used by format-patch when outputting to files.

This allows users to do something like:

    git format-patch --attach --suffix=.diff --numbered-files HEAD~~

and get two patches attached to the email with filenames 1.diff and
2.diff

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
I'm not sure if adding fmt_patch_filename to the rev_info struct is a good idea.

 builtin-log.c                                      |    6 +++---
 log-tree.c                                         |    8 ++++----
 revision.h                                         |    1 +
 ....format-patch_--attach_--stdout_initial..master |   12 ++++++------
 ...format-patch_--attach_--stdout_initial..master^ |    8 ++++----
 ...ff.format-patch_--attach_--stdout_initial..side |    4 ++--
 ...tdout_--subject-prefix=TESTCASE_initial..master |   12 ++++++------
 ....format-patch_--inline_--stdout_initial..master |   12 ++++++------
 ...format-patch_--inline_--stdout_initial..master^ |    8 ++++----
 ...ormat-patch_--inline_--stdout_initial..master^^ |    4 ++--
 ...ff.format-patch_--inline_--stdout_initial..side |    4 ++--
 11 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index f2a687f..491cebb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1104,9 +1104,9 @@ int cmd_format_patch(int argc, const char
**argv, const char *prefix)
 		 * subject line.
 		 */
 		sol = numbered_files ? NULL : strstr(commit->buffer, "\n\n")+2;
-		if (!use_stdout && reopen_stdout(get_patch_filename(sol,
-								keep_subject,
-								rev.nr)))
+		rev.fmt_patch_filename = get_patch_filename(sol, keep_subject,
+								rev.nr);
+		if (!use_stdout && reopen_stdout(rev.fmt_patch_filename))
 			die("Failed to create output files");
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
diff --git a/log-tree.c b/log-tree.c
index 9565c18..dc37d16 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -245,14 +245,14 @@ void log_write_email_headers(struct rev_info
*opt, const char *name,
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
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index e5ab744..ce49bd6 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
@@ -22,9 +22,9 @@ This is the second commit.


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: attachment; filename="0001-Second.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: attachment; filename="0002-Third.patch"

 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -129,9 +129,9 @@ Content-Transfer-Encoding: 8bit


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0003-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: attachment; filename="0003-Side.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index 2c71d20..5f1b238 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
@@ -22,9 +22,9 @@ This is the second commit.


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: attachment; filename="0001-Second.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: attachment; filename="0002-Third.patch"

 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index 38f7902..4a2364a 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
@@ -20,9 +20,9 @@ Content-Transfer-Encoding: 8bit


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0001-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: attachment;
filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: attachment; filename="0001-Side.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
index 58f8a7b..ca3f60b 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
@@ -22,9 +22,9 @@ This is the second commit.


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="0002-Third.patch"

 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -129,9 +129,9 @@ Content-Transfer-Encoding: 8bit


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0003-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="0003-Side.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
index 9e7bbdf..08f2301 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
@@ -22,9 +22,9 @@ This is the second commit.


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="0002-Third.patch"

 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -129,9 +129,9 @@ Content-Transfer-Encoding: 8bit


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0003-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="0003-Side.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
index f881f64..07f1230 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
@@ -22,9 +22,9 @@ This is the second commit.


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -80,9 +80,9 @@ Content-Transfer-Encoding: 8bit


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Type: text/x-patch; name="0002-Third.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Disposition: inline; filename="0002-Third.patch"

 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
index 4f258b8..29e00ab 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
@@ -22,9 +22,9 @@ This is the second commit.


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Type: text/x-patch; name="0001-Second.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Disposition: inline; filename="0001-Second.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..side
b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
index e86dce6..67633d4 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
@@ -20,9 +20,9 @@ Content-Transfer-Encoding: 8bit


 --------------g-i-t--v-e-r-s-i-o-n
-Content-Type: text/x-patch;
name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Type: text/x-patch; name="0001-Side.patch"
 Content-Transfer-Encoding: 8bit
-Content-Disposition: inline;
filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Disposition: inline; filename="0001-Side.patch"

 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
-- 
1.6.2
