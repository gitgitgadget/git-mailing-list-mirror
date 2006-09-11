From: Linus Torvalds <torvalds@osdl.org>
Subject: Allow multiple "git_path()" uses
Date: Mon, 11 Sep 2006 12:03:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 11 21:04:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMr4R-0003au-SP
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 21:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWIKTD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 15:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWIKTD3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 15:03:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964952AbWIKTD2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 15:03:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8BJ3JnW020038
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Sep 2006 12:03:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8BJ3FFB021024;
	Mon, 11 Sep 2006 12:03:17 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=-3.51 required=5 tests=AWL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26857>


This allows you to maintain a few filesystem pathnames concurrently, by 
simply replacing the single static "pathname" buffer with a LRU of four 
buffers.

We did exactly the same thing with sha1_to_hex(), for pretty much exactly 
the same reason. Sometimes you want to use two pathnames, and while it's 
easy enough to xstrdup() them, why not just do the LU buffer thing.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

[ This actually came up when I was playing with git_path("refs-packed") 
  when following refs, so while it doesn't hit us right now, it's for some 
  future work.. ]

diff --git a/path.c b/path.c
index db8905f..bb89fb0 100644
--- a/path.c
+++ b/path.c
@@ -13,9 +13,15 @@
 #include "cache.h"
 #include <pwd.h>
 
-static char pathname[PATH_MAX];
 static char bad_path[] = "/bad-path/";
 
+static char *get_pathname(void)
+{
+	static char pathname_array[4][PATH_MAX];
+	static int index;
+	return pathname_array[3 & ++index];
+}
+
 static char *cleanup_path(char *path)
 {
 	/* Clean it up */
@@ -31,6 +37,7 @@ char *mkpath(const char *fmt, ...)
 {
 	va_list args;
 	unsigned len;
+	char *pathname = get_pathname();
 
 	va_start(args, fmt);
 	len = vsnprintf(pathname, PATH_MAX, fmt, args);
@@ -43,6 +50,7 @@ char *mkpath(const char *fmt, ...)
 char *git_path(const char *fmt, ...)
 {
 	const char *git_dir = get_git_dir();
+	char *pathname = get_pathname();
 	va_list args;
 	unsigned len;
 
