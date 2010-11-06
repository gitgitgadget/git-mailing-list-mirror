From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/8] wrapper: move odb_* to environment.c
Date: Sat, 6 Nov 2010 06:45:38 -0500
Message-ID: <20101106114538.GB27641@burratino>
References: <20101106113905.GA27405@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:45:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEhDU-00026S-3i
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab0KFLpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:45:47 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51231 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab0KFLpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 07:45:46 -0400
Received: by gxk23 with SMTP id 23so2656713gxk.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qFjw1ZWZ9MefSK70hn5SuHQ/KF3jrvEpIuiFIY4VKkU=;
        b=pnYpaCrqnAhPvh0xxM0H0m1ku3KxxmWXuIrvCcBI6juDZ0UYj1Z7uqnxDBXeaIKPGB
         0/UeA+IhUWNDeSJlGbbxGtL8l1jfSdjOM+8vQWBSZ2E9rjDiMmWyhtmt0JRw6l8jTdhH
         pod5/zMxG645hxLVeqTIiVvNJSCk9tURGC7x4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ryO/5nEjOWOPtGHncvg0TWwjZe6O+/haAc40ZffwRyHrBzjeKA84BJOd+PwU0JT4X5
         E2dQjaCp2MRtg2Cefv4CUhdt4TGe5+0z8H4Of7sgA1Usyb+5VWkoMUodKWmaCrErMNt2
         Lh+CCtpR3VI0w493x9vjQjevaeJcEW0pkJgN0=
Received: by 10.100.57.4 with SMTP id f4mr691131ana.105.1289043945938;
        Sat, 06 Nov 2010 04:45:45 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d8sm2876598ana.2.2010.11.06.04.45.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 04:45:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101106113905.GA27405@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160844>

The odb_mkstemp and odb_pack_keep functions open files under the
$GIT_OBJECT_DIRECTORY directory.  This requires access to the git
configuration which very simple programs do not need.

Move these functions to environment.o, closer to their dependencies.
This should make it easier for programs to link to wrapper.o without
linking to environment.o.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 environment.c     |   37 +++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    1 +
 wrapper.c         |   37 -------------------------------------
 3 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/environment.c b/environment.c
index de5581f..95777f4 100644
--- a/environment.c
+++ b/environment.c
@@ -171,6 +171,43 @@ char *get_object_directory(void)
 	return git_object_dir;
 }
 
+int odb_mkstemp(char *template, size_t limit, const char *pattern)
+{
+	int fd;
+	/*
+	 * we let the umask do its job, don't try to be more
+	 * restrictive except to remove write permission.
+	 */
+	int mode = 0444;
+	snprintf(template, limit, "%s/%s",
+		 get_object_directory(), pattern);
+	fd = git_mkstemp_mode(template, mode);
+	if (0 <= fd)
+		return fd;
+
+	/* slow path */
+	/* some mkstemp implementations erase template on failure */
+	snprintf(template, limit, "%s/%s",
+		 get_object_directory(), pattern);
+	safe_create_leading_directories(template);
+	return xmkstemp_mode(template, mode);
+}
+
+int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1)
+{
+	int fd;
+
+	snprintf(name, namesz, "%s/pack/pack-%s.keep",
+		 get_object_directory(), sha1_to_hex(sha1));
+	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+	if (0 <= fd)
+		return fd;
+
+	/* slow path */
+	safe_create_leading_directories(name);
+	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+}
+
 char *get_index_file(void)
 {
 	if (!git_index_file)
diff --git a/git-compat-util.h b/git-compat-util.h
index 2af8d3e..029162e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -404,6 +404,7 @@ extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
+extern int xmkstemp_mode(char *template, int mode);
 extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 extern int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1);
 
diff --git a/wrapper.c b/wrapper.c
index 3195ef3..e67b70a 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -274,43 +274,6 @@ int git_inflate(z_streamp strm, int flush)
 	return ret;
 }
 
-int odb_mkstemp(char *template, size_t limit, const char *pattern)
-{
-	int fd;
-	/*
-	 * we let the umask do its job, don't try to be more
-	 * restrictive except to remove write permission.
-	 */
-	int mode = 0444;
-	snprintf(template, limit, "%s/%s",
-		 get_object_directory(), pattern);
-	fd = git_mkstemp_mode(template, mode);
-	if (0 <= fd)
-		return fd;
-
-	/* slow path */
-	/* some mkstemp implementations erase template on failure */
-	snprintf(template, limit, "%s/%s",
-		 get_object_directory(), pattern);
-	safe_create_leading_directories(template);
-	return xmkstemp_mode(template, mode);
-}
-
-int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1)
-{
-	int fd;
-
-	snprintf(name, namesz, "%s/pack/pack-%s.keep",
-		 get_object_directory(), sha1_to_hex(sha1));
-	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-	if (0 <= fd)
-		return fd;
-
-	/* slow path */
-	safe_create_leading_directories(name);
-	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-}
-
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	if (rc < 0) {
-- 
1.7.2.3.557.gab647.dirty
