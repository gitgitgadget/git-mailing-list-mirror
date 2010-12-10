From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/10] vcs-svn: simplifications for repo_modify_path et al
Date: Fri, 10 Dec 2010 04:30:23 -0600
Message-ID: <20101210103023.GI26331@burratino>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:30:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR0FT-0005l5-HK
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab0LJKal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:30:41 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:57104 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530Ab0LJKal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:30:41 -0500
Received: by gwb20 with SMTP id 20so2888900gwb.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rPzin2tdK7vzsRTMw0/v9Vs5cHkCjfrg0F0SoHMyoG8=;
        b=XoQ30J+tdI6Wn60hr90j7StwTKdJAeS/e5xlGC0vAu4JfsAhjAPtnXeae0eO+gxGVY
         DRmNCSGMZV+CMp6PyC1cerwJCDUk6Nhuf9D/t1hLR5Ba/u5FI1YIxFc7jfbO1HPKi0NN
         7F78x00HdfxoGmxG1wh1YPyOxaj4KhmNJWbms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iP2vihh4g4jV6NJhbkzmUUvGMo4lOONr6d6UMi8vD6HMJl6CeStaQPa8XNM6FxHMJJ
         JwsayC+edReaynKr/+HRs4/4yYrYBiBj9zTwAM9tTqRR7olgRLxzr2q5ePX6eSGxTYe2
         x8ez/gwfCBYUPtEv5KSfWDMz8/SnsPDvs2Wmo=
Received: by 10.150.133.20 with SMTP id g20mr1124370ybd.146.1291977040293;
        Fri, 10 Dec 2010 02:30:40 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id q18sm330269ybk.3.2010.12.10.02.30.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:30:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163404>

Restrict repo_modify_path API to functions that are actually
needed.  That is:

 - decouple reading the mode and content of dirents from
   other operations
 - remove repo_modify_path.  It was only used to read the
   mode from dirents.
 - remove the ability to use repo_read_mode on a missing
   path.  The existing code only errored out in that case,
   anyway.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/repo_tree.c |   25 +++++++++----------------
 vcs-svn/repo_tree.h |    4 ++--
 vcs-svn/svndump.c   |    4 +---
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index a4d8340..4d98185 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -166,7 +166,15 @@ uint32_t repo_read_path(uint32_t *path)
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
+void repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst)
 {
 	uint32_t mode = 0, content_offset = 0;
 	struct repo_dirent *src_dent;
@@ -176,7 +184,6 @@ uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst)
 		content_offset = src_dent->content_offset;
 		repo_write_dirent(dst, mode, content_offset, 0);
 	}
-	return mode;
 }
 
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark)
@@ -184,20 +191,6 @@ void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark)
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
index 7070839..0499a19 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -12,10 +12,10 @@
 #define REPO_MAX_PATH_DEPTH 1000
 
 uint32_t next_blob_mark(void);
-uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst);
+void repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst);
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark);
-uint32_t repo_modify_path(uint32_t *path, uint32_t mode, uint32_t blob_mark);
 uint32_t repo_read_path(uint32_t *path);
+uint32_t repo_read_mode(const uint32_t *path);
 void repo_delete(uint32_t *path);
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 		 uint32_t url, long unsigned timestamp);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 649a468..31c6056 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -236,9 +236,7 @@ static void handle_node(void)
 		old_mark = repo_read_path(node_ctx.dst);
 		if (!have_text)
 			mark = old_mark;
-		mode = repo_modify_path(node_ctx.dst, 0, 0);
-		if (!mode)
-			die("invalid dump: path to be modified is missing");
+		mode = repo_read_mode(node_ctx.dst);
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
 			die("invalid dump: cannot modify a directory into a file");
 		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
-- 
1.7.2.4
