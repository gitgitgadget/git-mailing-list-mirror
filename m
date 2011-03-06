From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/12] vcs-svn: introduce repo_read_path to check the content
 at a path
Date: Sun, 6 Mar 2011 17:07:03 -0600
Message-ID: <20110306230703.GE24327@elie>
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
X-From: git-owner@vger.kernel.org Mon Mar 07 00:07:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwN2g-0007Q7-5p
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab1CFXHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:07:10 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55698 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1CFXHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:07:08 -0500
Received: by yxs7 with SMTP id 7so1418013yxs.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8Ah78P9LS+koa0Yqdgv4LUo/6oT7Mp0kI4nvVcPNEjU=;
        b=VFxmxDjbvhWCOXGFMCbJiFVcqLqfohkOrZI1EOVdYCXQpi0aRW2G96LPSQ/hGaALXR
         imggnYcfxaZY1Ep99CvcNCBr6EjP2dNhip7fiCy/70N0r3LzldemWBZMjDxuK7+ynHbi
         sqKfEsJh9ca/IwFjrju0hGaIDVS5pJuXDt/Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tgZJF/Hndj8dKSP+dN/ZHoHz2FTOY+1372gvKFxuw1tlhAjuiy/T9/BkMESxhLeFfq
         x2qjgZb+Y9jLjkE+CijRPu9r7KDozEUCJvRb69tneFPNJAEehedsxhtVlNki3l6gEzPx
         e2G3FJU+CVLYsTlOEgpVYZMbLoDQ4T9m7hfE8=
Received: by 10.151.134.30 with SMTP id l30mr3874654ybn.136.1299452827471;
        Sun, 06 Mar 2011 15:07:07 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.sbcglobal.net [69.209.66.207])
        by mx.google.com with ESMTPS id q20sm1249939ybk.5.2011.03.06.15.07.05
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:07:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168550>

Date: Sat, 20 Nov 2010 13:25:28 -0600

The repo_tree structure remembers, for each path in each revision, a
mode (regular file, executable, symlink, or directory) and content
(blob mark or directory structure).  Maintaining a second copy of all
this information when it's already in the target repository is
wasteful, it does not persist between svn-fe invocations, and most
importantly, there is no convenient way to transfer it from one
machine to another.  So it would be nice to get rid of it.

As a first step, let's change the repo_tree API to match fast-import's
read commands more closely.  Currently to read the mode for a path,
one uses

	repo_modify_path(path, new_mode, new_content);

which changes the mode and content as a side effect.  There is no
function to read the content at a path; add one.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/repo_tree.c |   12 +++++++++++-
 vcs-svn/repo_tree.h |    1 +
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 093c5ff..23a9371 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -87,7 +87,8 @@ static struct repo_dir *repo_clone_dir(struct repo_dir *orig_dir)
 	return dir_pointer(new_o);
 }
 
-static struct repo_dirent *repo_read_dirent(uint32_t revision, uint32_t *path)
+static struct repo_dirent *repo_read_dirent(uint32_t revision,
+					    const uint32_t *path)
 {
 	uint32_t name = 0;
 	struct repo_dirent *key = dent_pointer(dent_alloc(1));
@@ -157,6 +158,15 @@ static void repo_write_dirent(uint32_t *path, uint32_t mode,
 		dent_remove(&dir_pointer(parent_dir_o)->entries, dent);
 }
 
+uint32_t repo_read_path(const uint32_t *path)
+{
+	uint32_t content_offset = 0;
+	struct repo_dirent *dent = repo_read_dirent(active_commit, path);
+	if (dent != NULL)
+		content_offset = dent->content_offset;
+	return content_offset;
+}
+
 uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst)
 {
 	uint32_t mode = 0, content_offset = 0;
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 68baeb5..3202bbe 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -15,6 +15,7 @@ uint32_t next_blob_mark(void);
 uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst);
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark);
 uint32_t repo_modify_path(uint32_t *path, uint32_t mode, uint32_t blob_mark);
+uint32_t repo_read_path(const uint32_t *path);
 void repo_delete(uint32_t *path);
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 		 uint32_t url, long unsigned timestamp);
-- 
1.7.4.1
