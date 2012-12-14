From: David Michael <fedora.dm0@gmail.com>
Subject: [PATCH 1/4] Support builds when sys/param.h is missing
Date: Fri, 14 Dec 2012 14:56:58 -0500
Message-ID: <CAEvUa7mHHy1=aOMfg4hNnDzod4zSnNHZN87isgf6Yxh5cRAf0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 20:57:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjbNm-0006W3-0y
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 20:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab2LNT47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 14:56:59 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56065 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146Ab2LNT47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 14:56:59 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so4499104vby.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 11:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=vP3XvbzQXMPQU4xaYcV/HdoJ1zImRvmEjbChbwbmCFA=;
        b=arsEW/DC5DbGmEaot8jbJUBmT8Fvv2DiLTr/W5c2wkhelsQA+h/7A6CTICnoJcCH/L
         Ky0j4A8deo/5iHUgAjh918F6uPfSU2lE8Bd8VP9RcGS9pN03190MaqNfCbEidBsjNZmV
         tsuuDYzo8II/Ul22CHHJKaXDVoppt9K4Q/HP0zz0QVh0mfp26xsfU44sm8WVUFTy8ssQ
         ctVnFm4XDZSa31GY0+k/IYVeS6c7sfpS7E90Pxr3tOOnQXMFFNoVbBW/VS1C0v4cTRD5
         +L/cEhXpn38YA7SMnx1atrbpkXydpVJN0I2oJQtwFYXAkwLnthY/7wumJqRPAbP/TFwB
         sGDg==
Received: by 10.58.2.226 with SMTP id 2mr11107489vex.53.1355515018367; Fri, 14
 Dec 2012 11:56:58 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Fri, 14 Dec 2012 11:56:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211501>

An option is added to the Makefile to skip the inclusion of sys/param.h.
The only known platform with this condition thus far is the z/OS UNIX System
Services environment.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---
 Makefile          | 5 +++++
 configure.ac      | 6 ++++++
 git-compat-util.h | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 736ecd4..8c3a0dd 100644
--- a/Makefile
+++ b/Makefile
@@ -165,6 +165,8 @@ all::
 # Define NO_POLL if you do not have or don't want to use poll().
 # This also implies NO_SYS_POLL_H.
 #
+# Define NO_SYS_PARAM_H if you don't have sys/param.h.
+#
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
 #
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
@@ -1748,6 +1750,9 @@ endif
 ifdef NO_SYS_POLL_H
     BASIC_CFLAGS += -DNO_SYS_POLL_H
 endif
+ifdef NO_SYS_PARAM_H
+    BASIC_CFLAGS += -DNO_SYS_PARAM_H
+endif
 ifdef NO_INTTYPES_H
     BASIC_CFLAGS += -DNO_INTTYPES_H
 endif
diff --git a/configure.ac b/configure.ac
index ad215cc..317bfc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -699,6 +699,12 @@ AC_CHECK_HEADER([sys/poll.h],
 [NO_SYS_POLL_H=UnfortunatelyYes])
 GIT_CONF_SUBST([NO_SYS_POLL_H])
 #
+# Define NO_SYS_PARAM_H if you don't have sys/param.h
+AC_CHECK_HEADER([sys/param.h],
+[NO_SYS_PARAM_H=],
+[NO_SYS_PARAM_H=UnfortunatelyYes])
+GIT_CONF_SUBST([NO_SYS_PARAM_H])
+#
 # Define NO_INTTYPES_H if you don't have inttypes.h
 AC_CHECK_HEADER([inttypes.h],
 [NO_INTTYPES_H=],
diff --git a/git-compat-util.h b/git-compat-util.h
index 2e79b8a..ace1549 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -104,7 +104,9 @@
 #endif
 #include <errno.h>
 #include <limits.h>
+#ifndef NO_SYS_PARAM_H
 #include <sys/param.h>
+#endif
 #include <sys/types.h>
 #include <dirent.h>
 #include <sys/time.h>
--
1.7.11.7
