From: "Blake Ramsdell" <blaker@gmail.com>
Subject: Re: [PATCH] Silence iconv warnings on Leopard
Date: Thu, 6 Dec 2007 16:41:24 -0800
Message-ID: <985966520712061641y4eba054dj5dea1d0308d50b12@mail.gmail.com>
References: <1196968023-45284-1-git-send-email-win@wincent.com>
	 <985966520712061504s686395d6jf680363c7b3b9de7@mail.gmail.com>
	 <200712070111.23283.jnareb@gmail.com>
	 <alpine.LFD.0.9999.0712061628070.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 01:42:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0RI4-0000x6-C3
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 01:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbXLGAl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 19:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbXLGAl3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 19:41:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:16479 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbXLGAl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 19:41:28 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1006422wah
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 16:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=F6uu3wY5SZSKo9N+/ywnEC70tPeI8aEV/ljd93aypN4=;
        b=VDk02HLf297ItimZaNG6w7GwJkS/yx2tGniL+yi8VR1wOR4pdTWElKF2W7r2RfsE7l5i1GEVtXjDCew2v03v+yCCf59zoaa+vAt1xn49JGbJNR1hF8PkLsm6Agd2XROv91ja0evmWjGLYNUtxRhvNiiKJBWnWP20wz5ujcwL9/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KmCGsk4b9m24UYjAomIB6Z5gwg7OG5iUIduqSrnGlRUcJ0I3da1s8vjztrILsjYd6bcNYUySMtXxqzPyNhqrNJysaoNXCgyUv+HSb1xSFZJza6uei07Z2LbMuXjKxI9pYb7QuvauVMDtXfTMzZQyzMa9Si5UmRaPt0ciOSW831c=
Received: by 10.114.190.6 with SMTP id n6mr2560321waf.1196988084565;
        Thu, 06 Dec 2007 16:41:24 -0800 (PST)
Received: by 10.115.110.7 with HTTP; Thu, 6 Dec 2007 16:41:24 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712061628070.13796@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67361>

On Dec 6, 2007 4:30 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Umm. Why not just make the test be whether the following compiles cleanly?
>
>         #include <iconv.h>
>
>         extern size_t iconv(iconv_t cd,
>           char **inbuf, size_t *inbytesleft,
>           char **outbuf, size_t *outbytesleft);
>
> because if the compiler has seen a "const char **inbuf", then it  should
> error out with a "conflicting types for 'iconv'" style message..

Yeah, this is what I did:

diff --git a/configure.ac b/configure.ac
index 5f8a15b..675d3e0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -182,6 +182,29 @@ AC_SUBST(NEEDS_LIBICONV)
 AC_SUBST(NO_ICONV)
 test -n "$NEEDS_LIBICONV" && LIBS="$LIBS -liconv"
 #
+# Define OLD_ICONV if the iconv function prototype uses const** (Darwin and
+# some FreeBSD installations).
+AC_DEFUN([OLDICONVTEST_SRC], [
+#include <iconv.h>
+
+int main(void)
+{
+    char* value = "test";
+
+    (void) iconv (NULL, &value, NULL, NULL, NULL);
+}
+])
+AC_MSG_CHECKING([for old iconv])
+old_CFLAGS="$CFLAGS"
+CFLAGS="$CFLAGS -Werror"
+AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
+	[AC_MSG_RESULT([no])
+	OLD_ICONV=],
+	[AC_MSG_RESULT([yes])
+	OLD_ICONV=UnfortunatelyYes])
+CFLAGS="$old_CFLAGS"
+AC_SUBST(OLD_ICONV)
+#
 # Define NO_DEFLATE_BOUND if deflateBound is missing from zlib.
 AC_DEFUN([ZLIBTEST_SRC], [
 #include <zlib.h>

The problem is that AC_COMPILE_IFELSE doesn't barf on warnings, so I
had to put in the CFLAGS hack to do -Werror (this is what Jakub did
also, I think).

So if this isn't rude to use -Werror (which is probably gcc-specific
in one or more ways), then fine. If it is rude to use -Werror, then
yeah, there needs to be some check for the warning, which I confess in
my five minutes of learning autoconf I don't understand well enough to
say if it's possible.

Blake
-- 
Blake Ramsdell | http://www.blakeramsdell.com
