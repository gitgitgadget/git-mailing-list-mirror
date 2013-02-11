From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Allow building with xmlparse.h
Date: Mon, 11 Feb 2013 14:03:45 -0800
Message-ID: <1360620225-19587-1-git-send-email-kraai@ftbfs.org>
References: <20130211212411.GA19113@ftbfs.org>
Cc: Matt Kraai <matt.kraai@amo.abbott.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:04:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U51U2-00026M-UO
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 23:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740Ab3BKWDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 17:03:55 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:57424 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932691Ab3BKWDz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 17:03:55 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1U51Tc-00056a-RE; Mon, 11 Feb 2013 14:03:52 -0800
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <20130211212411.GA19113@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216099>

From: Matt Kraai <matt.kraai@amo.abbott.com>

expat 1.1 and 1.2 provide xmlparse.h instead of expat.h.  Include the
former on systems that define the EXPAT_NEEDS_XMLPARSE_H variable and
define that variable on QNX systems, which ship with expat 1.1.

Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
---
 Makefile         | 6 ++++++
 config.mak.uname | 1 +
 http-push.c      | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/Makefile b/Makefile
index 5a2e02d..720fc18 100644
--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,9 @@ all::
 # Define EXPATDIR=/foo/bar if your expat header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
+# Define EXPAT_NEEDS_XMLPARSE_H if you have an old version of expat (e.g.,
+# 1.1 or 1.2) that provides xmlparse.h instead of expat.h.
+#
 # Define NO_GETTEXT if you don't want Git output to be translated.
 # A translated Git requires GNU libintl or another gettext implementation,
 # plus libintl-perl at runtime.
@@ -1089,6 +1092,9 @@ else
 		else
 			EXPAT_LIBEXPAT = -lexpat
 		endif
+		ifdef EXPAT_NEEDS_XMLPARSE_H
+			BASIC_CFLAGS += -DEXPAT_NEEDS_XMLPARSE_H
+		endif
 	endif
 endif
 
diff --git a/config.mak.uname b/config.mak.uname
index bea34f0..8743a6d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -523,6 +523,7 @@ endif
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS += -DSA_RESTART=0
+	EXPAT_NEEDS_XMLPARSE_H = YesPlease
 	HAVE_STRINGS_H = YesPlease
 	NEEDS_SOCKET = YesPlease
 	NO_FNMATCH_CASEFOLD = YesPlease
diff --git a/http-push.c b/http-push.c
index 9923441..7202e2d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -11,7 +11,11 @@
 #include "list-objects.h"
 #include "sigchain.h"
 
+#ifndef EXPAT_NEEDS_XMLPARSE_H
 #include <expat.h>
+#else
+#include <xmlparse.h>
+#endif
 
 static const char http_push_usage[] =
 "git http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
-- 
1.8.1.2.547.g7ce9def
