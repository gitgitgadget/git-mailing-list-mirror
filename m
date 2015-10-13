From: evgeny litvinenko <evgeny.v.litvinenko@gmail.com>
Subject: Solaris: Fail to build git with CFLAGS=-m64
Date: Tue, 13 Oct 2015 09:30:48 +0300
Message-ID: <CAKzKBF0MH+f3=frtwwxKfaELNXm4fCR5LWVhvJ7-YQF-ngfM+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 08:31:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlt74-0001yi-G3
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 08:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbbJMGbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 02:31:02 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36061 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbbJMGau (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 02:30:50 -0400
Received: by lbcao8 with SMTP id ao8so7856424lbc.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=OqfyXZ0SdZg8DuN2csJxRUohq/1bFO0+RpU4xBeeqNY=;
        b=geb7lUNBkuJuBIyYZO3I6yU82GD1YoA8KhhLxf1GSOJVHO7fQE8w25G9W7WEvFMU0V
         cwQJPf9kinzZcO1RW5NbZsGTlwryjJUoLiULRID1DO0KhuzWIq/rFZNZdwlWThqCL5yO
         VkM/p7pQvvsFVYr1x824frl2bMjG5LLF60NVV/7J2eGUckLtgQkvXx0AFmRJpk1CzCkG
         zVydZ7bnuSD2DLabqbPlAqG6FumizBQ+emS94P/MJ9MfkpHinq4JNesX06CBH3gSG+7C
         kMbAkgRAbH9HAJ9LrtZNavIFkW6BJ1vo0LYrtaAwhvRNKKodAdQRaZHzJTQmq8/Ujuxq
         ZRFA==
X-Received: by 10.112.173.198 with SMTP id bm6mr14053594lbc.43.1444717848802;
 Mon, 12 Oct 2015 23:30:48 -0700 (PDT)
Received: by 10.25.153.14 with HTTP; Mon, 12 Oct 2015 23:30:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279481>

Hi.

Tried to build git-2.6.1 on Solaris (Oracle Solaris 11.2 and
OpenIndiana 151.1.9)
with CFLAGS="-m64" and got an error during make step:

GIT_VERSION = 2.6.1
    * new build flags
gcc -o credential-store.o -c -MF ./.depend/credential-store.o.d -MQ
credential-store.o -MMD -MP  --save-temps -O2 -m64 -I.
-D__EXTENSIONS__ -D__sun__ -DHAVE_ALLOCA_H -DNO_D_TYPE_IN_DIRENT
-DNO_INET_NTOP -DNO_INET_PTON  -DHAVE_PATHS_H -DHAVE_STRINGS_H
-DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC
-DHAVE_GETDELIM -DSHA1_HEADER='<openssl/sha.h>'  -Icompat/regex
-DSHELL_PATH='"/bin/bash"'  credential-store.c
In file included from cache.h:4:0,
                 from credential-store.c:1:
git-compat-util.h:689:13: error: conflicting types for inet_ntop
/usr/include/arpa/inet.h:43:20: note: previous declaration of inet_ntop was here
gmake: *** [credential-store.o] Error 1

Solaris has the following prototype in the file /usr/include/arpa/inet.h:

extern const char *inet_ntop(int, const void *_RESTRICT_KYWD, char
*_RESTRICT_KYWD, socklen_t);

Git's prototype for inet_ntop is in file git-compat-util.h:

#ifdef NO_INET_NTOP
const char *inet_ntop(int af, const void *src, char *dst, size_t size);
#endif

When build with -m64
typedefs for socklen_t

typedef unsigned int uint32_t;
typedef uint32_t socklen_t;

and typedefs for size_t

typedef unsigned long ulong_t;
typedef ulong_t size_t;

With -m32 both socklen_t and size_t are "unsigned int" and there is no
any errors.

Also Solaris has the functions inet_ntop and inet_pton in libnsl.so so
I did the following correction to configure.ac to build git with -m64:

diff --git a/configure.ac b/configure.ac
index 14012fa..4cf1929 100644
--- a/configure.ac
+++ b/configure.ac
@@ -637,6 +637,11 @@ AC_CHECK_FUNC([inet_ntop],
        [NEEDS_RESOLV=YesPlease],
        [NO_INET_NTOP=YesPlease])
 ])
+if test "x$ac_cv_func_inet_ntop" != xyes; then
+AC_CHECK_LIB([nsl], [inet_ntop],
+       [NEEDS_NSL=YesPlease; NO_INET_NTOP=],
+       [])
+fi
 GIT_CONF_SUBST([NO_INET_NTOP])
 #
 # Define NO_INET_PTON if linking with -lresolv is not enough.
@@ -648,6 +653,11 @@ AC_CHECK_FUNC([inet_pton],
        [NEEDS_RESOLV=YesPlease],
        [NO_INET_PTON=YesPlease])
 ])
+if test "x$ac_cv_func_inet_pton" != xyes; then
+AC_CHECK_LIB([nsl], [inet_pton],
+       [NEEDS_NSL=YesPlease; NO_INET_PTON=],
+       [])
+fi
 GIT_CONF_SUBST([NO_INET_PTON])
 #
 # Define NO_HSTRERROR if linking with -lresolv is not enough.

Is it possible to change prototype for inet_ntop in git-compat-util.h
or use Solaris's inet_ntop and inet_pton
?

Evgeny
