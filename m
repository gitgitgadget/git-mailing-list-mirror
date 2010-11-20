From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/15] vcs-svn: Combine repo_replace and repo_modify functions
Date: Fri, 19 Nov 2010 18:51:50 -0600
Message-ID: <20101120005150.GI17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:52:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbh5-0002Pd-Oi
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab0KTAwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:52:39 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55441 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab0KTAwi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:52:38 -0500
Received: by yxf34 with SMTP id 34so3101257yxf.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DNlA9UbiSvEcEY9xx2ffVQQZCv4VUlHEEkMtQeT49HY=;
        b=r/ktVCiJgR4Sxq6YFVYLsbKGBVGdK4m7TL388VhtuHXZP3AuzTGQZB5CENdOyHm74H
         YyNPllw7WwHwH+YV8mNGPylUr62hbakF8hIgQ0QSGeK14sPXIDZUWstxNChDc/gA0PME
         cRqZBIThDDjDIGTgR6j3GMrCVIryIQtBdkrSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bYbsX7Y6QtT1w5LwUiiXm3AJYU3OPioRvdxh1VR7wyLTXBSgHk6Wp4UceXgg95TGuG
         EomAUW7vYZPxyRzFkz4ShiqjM49WdoBdKSv2wk3eHHWY35+bePvOCH+8rKhmjGUWGGDf
         Q/zTz2p04aIeoLKN6yOhVrPBbnzH2cuRLhHt4=
Received: by 10.100.168.5 with SMTP id q5mr1946998ane.223.1290214357916;
        Fri, 19 Nov 2010 16:52:37 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id w15sm2443159anw.33.2010.11.19.16.52.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:52:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161808>

There are two functions to change the staged content for a path in the
svn importer's active commit: repo_replace, which changes the text and
returns the mode, and repo_modify, which changes the text and mode and
returns nothing.

Worse, there are more subtle differences:

 - A mark of 0 passed to repo_modify means "use the existing content".
   repo_replace uses it as mark :0 and produces a corrupt stream.

 - When passed a path that is not part of the active commit,
   repo_replace returns without doing anything.  repo_modify
   transparently adds a new directory entry.

Get rid of both and introduce a new function with the best features of
both: repo_modify_path modifies the mode, content, or both for a path,
depending on which arguments are zero.  If no such dirent already
exists, it does nothing and reports the error by returning 0.
Otherwise, the return value is the resulting mode.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
David, I think we discussed doing something like this a few months
ago.  It seems appropriate because Subversion's Replace FS operation
is not similar to repo_replace after all.

 vcs-svn/repo_tree.c |   21 +++++++--------------
 vcs-svn/repo_tree.h |    3 +--
 vcs-svn/svndump.c   |    8 ++++----
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index e94d91d..7214ac8 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -175,25 +175,18 @@ void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark)
 	repo_write_dirent(path, mode, blob_mark, 0);
 }
 
-uint32_t repo_replace(uint32_t *path, uint32_t blob_mark)
+uint32_t repo_modify_path(uint32_t *path, uint32_t mode, uint32_t blob_mark)
 {
-	uint32_t mode = 0;
 	struct repo_dirent *src_dent;
 	src_dent = repo_read_dirent(active_commit, path);
-	if (src_dent != NULL) {
-		mode = src_dent->mode;
-		repo_write_dirent(path, mode, blob_mark, 0);
-	}
-	return mode;
-}
-
-void repo_modify(uint32_t *path, uint32_t mode, uint32_t blob_mark)
-{
-	struct repo_dirent *src_dent;
-	src_dent = repo_read_dirent(active_commit, path);
-	if (src_dent != NULL && blob_mark == 0)
+	if (!src_dent)
+		return 0;
+	if (!blob_mark)
 		blob_mark = src_dent->content_offset;
+	if (!mode)
+		mode = src_dent->mode;
 	repo_write_dirent(path, mode, blob_mark, 0);
+	return mode;
 }
 
 void repo_delete(uint32_t *path)
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 5476175..68baeb5 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -14,8 +14,7 @@
 uint32_t next_blob_mark(void);
 uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst);
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark);
-uint32_t repo_replace(uint32_t *path, uint32_t blob_mark);
-void repo_modify(uint32_t *path, uint32_t mode, uint32_t blob_mark);
+uint32_t repo_modify_path(uint32_t *path, uint32_t mode, uint32_t blob_mark);
 void repo_delete(uint32_t *path);
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 		 uint32_t url, long unsigned timestamp);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 6a6aaf9..e40be58 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -182,14 +182,14 @@ static void handle_node(void)
 
 	if (node_ctx.action == NODEACT_CHANGE) {
 		if (have_props)
-			repo_modify(node_ctx.dst, node_ctx.type, mark);
+			repo_modify_path(node_ctx.dst, node_ctx.type, mark);
 		else if (mark)
-			old_mode = repo_replace(node_ctx.dst, mark);
+			old_mode = repo_modify_path(node_ctx.dst, 0, mark);
 	} else if (node_ctx.action == NODEACT_ADD) {
 		if (node_ctx.srcRev && have_props)
-			repo_modify(node_ctx.dst, node_ctx.type, mark);
+			repo_modify_path(node_ctx.dst, node_ctx.type, mark);
 		else if (node_ctx.srcRev && mark)
-			old_mode = repo_replace(node_ctx.dst, mark);
+			old_mode = repo_modify_path(node_ctx.dst, 0, mark);
 		else if ((node_ctx.type == REPO_MODE_DIR && !node_ctx.srcRev) ||
 			 mark)
 			repo_add(node_ctx.dst, node_ctx.type, mark);
-- 
1.7.2.3
