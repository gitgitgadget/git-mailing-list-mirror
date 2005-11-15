From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 00:59:50 -0500
Message-ID: <1132034390.22207.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 15 07:06:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbtrL-0003Sr-4q
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 07:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVKOF7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 00:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVKOF7x
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 00:59:53 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:31189 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751341AbVKOF7x
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 00:59:53 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EbtrD-0004pR-QL
	for git@vger.kernel.org; Tue, 15 Nov 2005 00:59:52 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EbtrC-000612-S6
	for git@vger.kernel.org; Tue, 15 Nov 2005 00:59:50 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11877>

Disable USE_SYMLINK_HEAD by default.  Recommend using it only for
compatibility with older software.

Treat USE_SYMLINK_HEAD like other optional defines - check whether it's
defined, not its value.

Signed-off-by: Pavel Roskin <proski@gnu.org>

---
Applying this patch before 1.0 may be controversial, but I think there
is a very good reason for that.  There should be exactly one git 1.0
repository format.  Now we have two that are present in the sources and
that have received testing from the git users.

Of those two formats, I prefer the one that is platform independent and
not very demanding with regard to filesystems and transfer protocols.
That format should be good enough so that we don't plan to change it as
soon as version 1.0 is released. Any third party software claiming to
support git 1.0 should need to support one repository format.


diff --git a/Makefile b/Makefile
index 63cb998..585552e 100644
--- a/Makefile
+++ b/Makefile
@@ -18,6 +18,10 @@
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
+# Define USE_SYMLINK_HEAD if you want .git/HEAD to be a symbolic link.
+# This feature is phased out, enable it only for compatibility with other
+# software.  Don't enable it on Windows.
+#
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
@@ -210,7 +214,6 @@ ifeq ($(uname_O),Cygwin)
 	NEEDS_LIBICONV = YesPlease
 	NO_IPV6 = YesPlease
 	X = .exe
-	ALL_CFLAGS += -DUSE_SYMLINK_HEAD=0
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
diff --git a/refs.c b/refs.c
index a52b038..9b88742 100644
--- a/refs.c
+++ b/refs.c
@@ -6,10 +6,6 @@
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 
-#ifndef USE_SYMLINK_HEAD
-#define USE_SYMLINK_HEAD 1
-#endif
-
 int validate_symref(const char *path)
 {
 	struct stat st;
@@ -120,7 +116,7 @@ int create_symref(const char *git_HEAD, 
 	char ref[1000];
 	int fd, len, written;
 
-#if USE_SYMLINK_HEAD
+#ifdef USE_SYMLINK_HEAD
 	unlink(git_HEAD);
 	if (!symlink(refs_heads_master, git_HEAD))
 		return 0;


-- 
Regards,
Pavel Roskin
