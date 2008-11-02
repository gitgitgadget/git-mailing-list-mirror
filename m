From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] autoconf: Add link tests to each AC_CHECK_FUNC() test
Date: Sun, 02 Nov 2008 01:04:21 -0700
Message-ID: <7v4p2q3662.fsf@gitster.siamese.dyndns.org>
References: <1225021939-11858-1-git-send-email-david.syzdek@acsalaska.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com
To: "David M. Syzdek" <david.syzdek@acsalaska.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 09:09:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwY1E-0006gY-2X
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 09:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbYKBIEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 03:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbYKBIEn
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 03:04:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYKBIEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 03:04:42 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A80A7753D;
	Sun,  2 Nov 2008 03:04:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 94DF27753B; Sun,  2 Nov 2008 03:04:28 -0500 (EST)
In-Reply-To: <1225021939-11858-1-git-send-email-david.syzdek@acsalaska.net>
 (David M. Syzdek's message of "Sun, 26 Oct 2008 03:52:19 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E6D8BCC4-A8B4-11DD-89D8-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99820>

"David M. Syzdek" <david.syzdek@acsalaska.net> writes:

> Update configure.ac to test libraries for getaddrinfo, strcasestr, memmem,
> strlcpy, strtoumax, setenv, unsetenv, and mkdtemp.  The default compilers
> on FreeBSD 4.9-SECURITY and FreeBSD 6.2-RELEASE-p4 do not generate warnings
> for missing prototypes unless `-Wall' is used. This behavior renders the
> results of AC_CHECK_FUNC() void on these platforms. The test AC_SEARCH_LIBS()
> verifies a function is valid by linking to symbol within the system libraries.

> diff --git a/configure.ac b/configure.ac
> index 7c2856e..d3b8bc3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -293,9 +293,11 @@ AC_SUBST(NO_SOCKADDR_STORAGE)
>  #
>  # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
>  AC_CHECK_TYPE([struct addrinfo],[
> - AC_CHECK_FUNC([getaddrinfo],
> -  [NO_IPV6=],
> -  [NO_IPV6=YesPlease])
> + AC_CHECK_FUNC([getaddrinfo],[
> +  AC_SEARCH_LIBS([getaddrinfo],,
> +    [NO_IPV6=],
> +    [NO_IPV6=YesPlease])
> + ],[NO_IPV6=YesPlease])

It's been a looong time since I did any sizeable autoconf/m4 hacking, but
the repetitititiveness of this patch loudly calls for a convenience macro
of a higher order, perhaps something like:

        AC_DEFUN([GIT_CHECK_FUNC],[
         AC_CHECK_FUNC([$1],[
          AC_SEARCH_LIBS([$1},,
          [$2],[$3])],
          [$3])])

Then we can use it like:

	GIT_CHECK_FUNC([getaddrinfo],[NO_IPV6=],[NO_IPV6=YesPlease])

Hmm?

-- >8 --
[PATCH] autoconf: use AC_CHECK_FUNC() with AC_SEARCH_LIBS() test

Update configure.ac to test libraries for getaddrinfo, strcasestr, memmem,
strlcpy, strtoumax, setenv, unsetenv, and mkdtemp.  The default compilers
on FreeBSD 4.9-SECURITY and FreeBSD 6.2-RELEASE-p4 do not generate warnings
for missing prototypes unless `-Wall' is used. This behavior renders the
results of AC_CHECK_FUNC() void on these platforms. The test AC_SEARCH_LIBS()
verifies a function is valid by linking to symbol within the system libraries.

---
 configure.ac |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git c/configure.ac w/configure.ac
index 27bab00..ef544e8 100644
--- c/configure.ac
+++ w/configure.ac
@@ -65,7 +65,17 @@ else \
 fi \
 ])# GIT_PARSE_WITH
 
-
+dnl
+dnl GIT_CHECK_FUNC(FUNCTION, IFTRUE, IFFALSE)
+dnl -----------------------------------------
+dnl Similar to AC_CHECK_FUNC, but on systems that do not generate
+dnl warnings for missing prototypes (e.g. FreeBSD when compiling without
+dnl -Wall), it does not work.  By looking for function definition in
+dnl libraries, this problem can be worked around.
+AC_DEFUN([GIT_CHECK_FUNC],[AC_CHECK_FUNC([$1],[
+  AC_SEARCH_LIBS([$1],,
+  [$2],[$3])
+],[$3])])
 ## Site configuration related to programs (before tests)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 #
@@ -325,7 +335,7 @@ AC_SUBST(NO_SOCKADDR_STORAGE)
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
 AC_CHECK_TYPE([struct addrinfo],[
- AC_CHECK_FUNC([getaddrinfo],
+ GIT_CHECK_FUNC([getaddrinfo],
   [NO_IPV6=],
   [NO_IPV6=YesPlease])
 ],[NO_IPV6=YesPlease],[
@@ -419,43 +429,43 @@ AC_SUBST(SNPRINTF_RETURNS_BOGUS)
 AC_MSG_NOTICE([CHECKS for library functions])
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
-AC_CHECK_FUNC(strcasestr,
+GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=],
 [NO_STRCASESTR=YesPlease])
 AC_SUBST(NO_STRCASESTR)
 #
 # Define NO_MEMMEM if you don't have memmem.
-AC_CHECK_FUNC(memmem,
+GIT_CHECK_FUNC(memmem,
 [NO_MEMMEM=],
 [NO_MEMMEM=YesPlease])
 AC_SUBST(NO_MEMMEM)
 #
 # Define NO_STRLCPY if you don't have strlcpy.
-AC_CHECK_FUNC(strlcpy,
+GIT_CHECK_FUNC(strlcpy,
 [NO_STRLCPY=],
 [NO_STRLCPY=YesPlease])
 AC_SUBST(NO_STRLCPY)
 #
 # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
-AC_CHECK_FUNC(strtoumax,
+GIT_CHECK_FUNC(strtoumax,
 [NO_STRTOUMAX=],
 [NO_STRTOUMAX=YesPlease])
 AC_SUBST(NO_STRTOUMAX)
 #
 # Define NO_SETENV if you don't have setenv in the C library.
-AC_CHECK_FUNC(setenv,
+GIT_CHECK_FUNC(setenv,
 [NO_SETENV=],
 [NO_SETENV=YesPlease])
 AC_SUBST(NO_SETENV)
 #
 # Define NO_UNSETENV if you don't have unsetenv in the C library.
-AC_CHECK_FUNC(unsetenv,
+GIT_CHECK_FUNC(unsetenv,
 [NO_UNSETENV=],
 [NO_UNSETENV=YesPlease])
 AC_SUBST(NO_UNSETENV)
 #
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
-AC_CHECK_FUNC(mkdtemp,
+GIT_CHECK_FUNC(mkdtemp,
 [NO_MKDTEMP=],
 [NO_MKDTEMP=YesPlease])
 AC_SUBST(NO_MKDTEMP)
