From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/12] vcs-svn: simplify repo_modify_path and repo_copy
Date: Sun, 6 Mar 2011 17:09:23 -0600
Message-ID: <20110306230923.GG24327@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 00:09:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwN4v-0008GK-3b
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab1CFXJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:09:29 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50720 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1CFXJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:09:28 -0500
Received: by ywj3 with SMTP id 3so1416737ywj.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gpH5tXsl0dPFLBIefTdmUti/VEBl4eOK++Dhm5RGQZA=;
        b=tTfYcF7k/IUyfmeNN5xrSkqYKGGjH4TbjyCLU5svoxUcWfiDFYyNt7B5UDMiEpH5sH
         q/D3bDWE/y2rcvQJg7/BKHsTe7IzWw9j0Xc6DOMKxMlRpuyf48jOq6xDYTeUHL8VXW94
         MNjn+rdsSpXtwSmA/n+Yypa+EppSkm3Za4ND4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sxvdZRkfgJwEu0jWxxZU1saisxslr++jsgTBOJwcRGDfZpXX8cFoBKRzIXMv5HEuAw
         D7J56BYAClK3yppl4so/3QBbO3y0J9mfMTHKs6jrEtsW5Brf0rp2XuSnK1I6VmLNOFWl
         2lyIc+JBUaa75vfIt/LPbeHsbDqaf24LpW3QI=
Received: by 10.150.204.11 with SMTP id b11mr2156219ybg.38.1299452967606;
        Sun, 06 Mar 2011 15:09:27 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.sbcglobal.net [69.209.66.207])
        by mx.google.com with ESMTPS id l2sm1300514ybn.15.2011.03.06.15.09.25
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:09:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168552>

Date: Fri, 10 Dec 2010 00:53:54 -0600

Restrict the repo_tree API to functions that are actually needed.

 - decouple reading the mode and content of dirents from other
   operations.
 - remove repo_modify_path.  It is only used to read the mode from
   dirents.
 - remove the ability to use repo_read_mode on a missing path.  The
   existing code only errors out in that case, anyway.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/repo_tree.c |   27 ++++++++++-----------------
 vcs-svn/repo_tree.h |    4 ++--
 vcs-svn/svndump.c   |    4 +---
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 23a9371..036a686 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -106,7 +106,7 @@ static struct repo_dirent *repo_read_dirent(uint32_t revision,
 	return dent;
 }
 
-static void repo_write_dirent(uint32_t *path, uint32_t mode,
+static void repo_write_dirent(const uint32_t *path, uint32_t mode,
 			      uint32_t content_offset, uint32_t del)
 {
 	uint32_t name, revision, dir_o = ~0, parent_dir_o = ~0;
@@ -167,7 +167,15 @@ uint32_t repo_read_path(const uint32_t *path)
 	return content_offset;
 }
 
-uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst)
+uint32_t repo_read_mode(const uint32_t *path)
+{
+	struct repo_dirent *dent = repo_read_dirent(active_commit, path);
+	if (dent == NULL)
+		die("invalid dump: path to be modified is missing");
+	return dent->mode;
+}
+
+void repo_copy(uint32_t revision, const uint32_t *src, const uint32_t *dst)
 {
 	uint32_t mode = 0, content_offset = 0;
 	struct repo_dirent *src_dent;
@@ -177,7 +185,6 @@ uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst)
 		content_offset = src_dent->content_offset;
 		repo_write_dirent(dst, mode, content_offset, 0);
 	}
-	return mode;
 }
 
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark)
@@ -185,20 +192,6 @@ void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark)
 	repo_write_dirent(path, mode, blob_mark, 0);
 }
 
-uint32_t repo_modify_path(uint32_t *path, uint32_t mode, uint32_t blob_mark)
-{
-	struct repo_dirent *src_dent;
-	src_dent = repo_read_dirent(active_commit, path);
-	if (!src_dent)
-		return 0;
-	if (!blob_mark)
-		blob_mark = src_dent->content_offset;
-	if (!mode)
-		mode = src_dent->mode;
-	repo_write_dirent(path, mode, blob_mark, 0);
-	return mode;
-}
-
 void repo_delete(uint32_t *path)
 {
 	repo_write_dirent(path, 0, 0, 1);
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 3202bbe..11d48c2 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -12,10 +12,10 @@
 #define REPO_MAX_PATH_DEPTH 1000
 
 uint32_t next_blob_mark(void);
-uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst);
+void repo_copy(uint32_t revision, const uint32_t *src, const uint32_t *dst);
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark);
-uint32_t repo_modify_path(uint32_t *path, uint32_t mode, uint32_t blob_mark);
 uint32_t repo_read_path(const uint32_t *path);
+uint32_t repo_read_mode(const uint32_t *path);
 void repo_delete(uint32_t *path);
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 		 uint32_t url, long unsigned timestamp);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index f07376f..e6d84ba 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -235,9 +235,7 @@ static void handle_node(void)
 		uint32_t mode;
 		if (!have_text)
 			mark = repo_read_path(node_ctx.dst);
-		mode = repo_modify_path(node_ctx.dst, 0, 0);
-		if (!mode)
-			die("invalid dump: path to be modified is missing");
+		mode = repo_read_mode(node_ctx.dst);
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
 			die("invalid dump: cannot modify a directory into a file");
 		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
-- 
1.7.4.1
