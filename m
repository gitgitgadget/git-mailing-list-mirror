From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] autoconf: Add support for setting NO_ICONV and ICONVDIR
Date: Thu, 7 Sep 2006 13:48:49 +0200
Message-ID: <200609071348.49935.jnareb@gmail.com>
References: <200609071347.32152.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 07 13:49:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLIN8-0004Zk-EW
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 13:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWIGLsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 07:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWIGLsj
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 07:48:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:36381 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751356AbWIGLsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 07:48:37 -0400
Received: by nf-out-0910.google.com with SMTP id o25so422621nfa
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 04:48:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=O7k1wd0NUJfitNHJuaIhx5FE/ciG2jK9g71/7IH5TNIbq6FIMlpYD2i38zMP8GjONNpmyCh+YeLUXjcGoXaFMqDzz7GbQ4l1jMEVB6rjXXUF9QkMr1LnV26b5UvtD6FQ2s8VKf+aueDDvYP46n2HUF0wtznGCARsi1+IDlY2i74=
Received: by 10.48.254.10 with SMTP id b10mr2365285nfi;
        Thu, 07 Sep 2006 04:48:36 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id c10sm3234658nfb.2006.09.07.04.48.35;
        Thu, 07 Sep 2006 04:48:36 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609071347.32152.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26629>

Add support for ./configure options --without-iconv (if neither libc
nor libiconv properly support iconv), and for --with-iconv=PATH (to
set prefix to libiconv library and headers, used only when
NEED_LIBICONV is set).  While at it, make ./configure set or unset
NO_ICONV always (it is not autodetected in Makefile).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The config.mak.in patch just adds or uncomments 

NO_ICONV=@NO_ICONV@

at the end of the file. If there is conflict during applying this part
of patchset (for example "autoconf: Add some commented out variables
to config.mak.in" and "autoconf: Preliminary check for working mmap"
are not applied), just modify config.mak.in to have this line at the
end.

 config.mak.in |    2 +-
 configure.ac  |   13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 2c8fd2c..fccde61 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -38,5 +38,5 @@ NO_STRCASESTR=@NO_STRCASESTR@
 NO_STRLCPY=@NO_STRLCPY@
 NO_SETENV=@NO_SETENV@
 NO_MMAP=@NO_MMAP@
-#NO_ICONV=@NO_ICONV@
+NO_ICONV=@NO_ICONV@
 
diff --git a/configure.ac b/configure.ac
index 8af276c..6a980a5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -148,8 +148,9 @@ AC_CHECK_LIB([c], [iconv],
 	[NEEDS_LIBICONV=],
 	AC_CHECK_LIB([iconv], [iconv],
 		[NEEDS_LIBICONV=YesPlease],
-		[GIT_CONF_APPEND_LINE([NO_ICONV=YesPlease])]))
+		[NO_ICONV=YesPlease]))
 AC_SUBST(NEEDS_LIBICONV)
+AC_SUBST(NO_ICONV)
 test -n "$NEEDS_LIBICONV" && LIBS="$LIBS -liconv"
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
@@ -350,6 +351,16 @@ # specify your own (or DarwinPort's) inc
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
 # Define NO_MMAP if you want to avoid mmap.
+#
+# Define NO_ICONV if your libc does not properly support iconv.
+AC_ARG_WITH(iconv,
+AS_HELP_STRING([--without-iconv],
+[if your architecture doesn't properly support iconv])
+AS_HELP_STRING([--with-iconv=PATH],
+[PATH is prefix for libiconv library and headers])
+AS_HELP_STRING([],
+[used only if you need linking with libiconv]),
+GIT_PARSE_WITH(iconv))
 
 ## --enable-FEATURE[=ARG] and --disable-FEATURE
 #
-- 
1.4.2
