From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/8] vcs-svn: Introduce repo_read_path to check the content
 at a path
Date: Sat, 20 Nov 2010 13:25:28 -0600
Message-ID: <20101120192528.GD17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:25:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJt4A-0001X7-2D
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab0KTTZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:25:37 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42627 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab0KTTZg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:25:36 -0500
Received: by gwb20 with SMTP id 20so635625gwb.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qwjjXGMezQd1dwd/kypnlEeAV6NN7G5NcUGkZNG8KlU=;
        b=T0/yfU5JiYAQOYpj+kvClIihJQ4Hryq6akCtySMyN4bShiCXl0Pn58LjVs34ZZ+MAR
         WE68LYBv34XoHDPb5fnHGsRoBR0SeDfXWGdOLyK/Nw7FLF6lC4x66gjo/ne3x29/Z31h
         6QlBh45ZmCGfd9mfcskL6XlLeP90ztcXcFNDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j61AWYAYL1iVpx1asZ92gTuv+kQBTLD8/K7LdNMmOd20p7Dk/lQ6p1gZoqX3j1Mhg7
         nrr8ryQm/MBD1f9VEIyEvDir85lVq24ZIEs9nCRIJXBhag4/kCAkgiaZoRt7jAmDDPGb
         T8bhKIAl74PJ1uxVZIaRqrBTbUKNSV1fhSGPc=
Received: by 10.151.149.9 with SMTP id b9mr6017643ybo.394.1290281135940;
        Sat, 20 Nov 2010 11:25:35 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 31sm1983903yhl.30.2010.11.20.11.25.34
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:25:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192153.GA17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161833>

repo_modify_path returns the mode.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/repo_tree.c |    9 +++++++++
 vcs-svn/repo_tree.h |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 7214ac8..eb55636 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -157,6 +157,15 @@ static void repo_write_dirent(uint32_t *path, uint32_t mode,
 		dent_remove(&dir_pointer(parent_dir_o)->entries, dent);
 }
 
+uint32_t repo_read_path(uint32_t *path)
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
index 68baeb5..7070839 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -15,6 +15,7 @@ uint32_t next_blob_mark(void);
 uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst);
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark);
 uint32_t repo_modify_path(uint32_t *path, uint32_t mode, uint32_t blob_mark);
+uint32_t repo_read_path(uint32_t *path);
 void repo_delete(uint32_t *path);
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 		 uint32_t url, long unsigned timestamp);
-- 
1.7.2.3
