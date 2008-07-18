From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH] Support gitlinks in fast-import/export.
Date: Fri, 18 Jul 2008 21:03:36 +0400
Organization: TEPKOM
Message-ID: <200807182103.37272.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 19:04:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJtNy-0008Q4-BU
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 19:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974AbYGRRDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 13:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756861AbYGRRDv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 13:03:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:39753 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727AbYGRRDu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 13:03:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so182412fgg.17
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=S9Gp4NeFa8FjFHiDrrboQfMiiSOx4l4QFfrvubZtjog=;
        b=nMfeMjxWb8mbN2nvHTernRhU0+1FSn7blA2YEjtJt43sfjPsO8KIi/CBlVzEqkj7r9
         ziPUec2kWcew48dkMJWDcBn20NQOJWK4ZDURuaLF1dqn0oIoU8uKFNy7fcWRGTbV+LZ8
         yDEn+a+sorp2KmhNxT0WBOh9QpZuHMUMsbkaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=gcx0KM+tAKFhxuTgY+3LeDSkD2XUAu5oElgpF5imQ9c/TeKXILe2gSFnISgxcg9CkL
         8zOpv68P4Kcnmi6lA+6IcHiA/d/4AHWxXi2fj/S2ZkLkZG6CWCn39HlNnD+yJBfLwLck
         4njn9Oni6zzRFCPP68EmA480XrC6OydvI5qUk=
Received: by 10.86.82.6 with SMTP id f6mr614480fgb.73.1216400629023;
        Fri, 18 Jul 2008 10:03:49 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id e20sm2782559fga.1.2008.07.18.10.03.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 10:03:48 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89057>

Currently fast-import/export cannot be used for
repositories with submodules. This patch extends
the relevant programs to make them correctly
process gitlinks.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I noticed that fast-export & fast-import cannot work with
	repositories using submodules: import complains about
	an invalid mode, and export fails while trying to open the SHA
	as a blob.

	As I didn't see any particular reason for it to be so, I tried to
	implement support for gitlinks.

	What I'm unsure of is, should fast-export try to reuse commit
	marks for gitlinks where it happened to recognize the object,
	or always output the SHA as it is stored in the tree?

	-- Alexander

 Documentation/git-fast-import.txt |    3 +++
 builtin-fast-export.c             |   18 +++++++++++++++---
 fast-import.c                     |   12 +++++++++++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 395c055..80c591a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -481,6 +481,9 @@ in octal.  Git only supports the following modes:
   what you want.
 * `100755` or `755`: A normal, but executable, file.
 * `120000`: A symlink, the content of the file will be the link target.
+* `160000`: A gitlink, SHA-1 of the object refers to a commit in
+  another repository. Git links can only be specified by SHA or through
+  a commit mark. They are used to implements submodules.
 
 In both formats `<path>` is the complete path of the file to be added
 (if not already existing) or modified (if already existing).
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index d0a462f..14b1549 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -123,8 +123,19 @@ static void show_filemodify(struct diff_queue_struct *q,
 			printf("D %s\n", spec->path);
 		else {
 			struct object *object = lookup_object(spec->sha1);
-			printf("M %06o :%d %s\n", spec->mode,
-			       get_object_mark(object), spec->path);
+			int mark = object ? get_object_mark(object) : 0;
+
+			if (mark)
+				printf("M %06o :%d %s\n", spec->mode,
+				       mark, spec->path);
+			else {
+				if (!S_ISGITLINK(spec->mode))
+					die("Unknown object added: %s at %s",
+					    sha1_to_hex(spec->sha1), spec->path);
+
+				printf("M %06o %s %s\n", spec->mode,
+				       sha1_to_hex(spec->sha1), spec->path);
+			}
 		}
 	}
 }
@@ -183,7 +194,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 				    "", &rev->diffopt);
 
 	for (i = 0; i < diff_queued_diff.nr; i++)
-		handle_object(diff_queued_diff.queue[i]->two->sha1);
+		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
+			handle_object(diff_queued_diff.queue[i]->two->sha1);
 
 	mark_object(&commit->object);
 	if (!is_encoding_utf8(encoding))
diff --git a/fast-import.c b/fast-import.c
index e72b286..e7977c1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1868,6 +1868,7 @@ static void file_change_m(struct branch *b)
 	case S_IFREG | 0644:
 	case S_IFREG | 0755:
 	case S_IFLNK:
+	case S_IFGITLINK:
 	case 0644:
 	case 0755:
 		/* ok */
@@ -1900,7 +1901,16 @@ static void file_change_m(struct branch *b)
 		p = uq.buf;
 	}
 
-	if (inline_data) {
+	if (S_ISGITLINK(mode)) {
+		if (inline_data)
+			die("Git links cannot be specified 'inline': %s",
+				command_buf.buf);
+		else if (oe) {
+			if (oe->type != OBJ_COMMIT)
+				die("Not a commit (actually a %s): %s",
+					typename(oe->type), command_buf.buf);
+		}
+	} else if (inline_data) {
 		static struct strbuf buf = STRBUF_INIT;
 
 		if (p != uq.buf) {
-- 
1.5.6.3.18.gfe82
