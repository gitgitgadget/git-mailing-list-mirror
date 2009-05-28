From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really menas
 XPG6
Date: Thu, 28 May 2009 11:46:50 -0500
Message-ID: <WLNdjYtfqcg2bT6yOBtAykIqOBTeSLRUdlB6-sTM2KzTjwOmzN3fLg@cipher.nrlssc.navy.mil>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com> <1243106697-6424-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 18:47:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9ilF-0003PZ-0p
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 18:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302AbZE1QrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 12:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbZE1QrM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 12:47:12 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53788 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbZE1QrL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 12:47:11 -0400
Received: by mail.nrlssc.navy.mil id n4SGkpnG018629; Thu, 28 May 2009 11:46:52 -0500
In-Reply-To: <1243106697-6424-2-git-send-email-gitster@pobox.com>
X-OriginalArrivalTime: 28 May 2009 16:46:51.0106 (UTC) FILETIME=[E633BC20:01C9DFB3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120198>

Junio C Hamano wrote:
> In git-compat-util.h, we do
> 
>     #define _XOPEN_SOURCE 600
>     #define _XOPEN_SOURCE_EXTENDED 1
> 
> unless we are on BSD or SCO.
> 
> On OpenSolaris (200811), /usr/include/sys/feature_tests.h has this nice
> table:
> 
>     Feature Test Macro				     Specification
>     ------------------------------------------------  -------------
>     _XOPEN_SOURCE                                         XPG3
>     _XOPEN_SOURCE && _XOPEN_VERSION = 4                   XPG4
>     _XOPEN_SOURCE && _XOPEN_SOURCE_EXTENDED = 1           XPG4v2
>     _XOPEN_SOURCE = 500                                   XPG5
>     _XOPEN_SOURCE = 600  (or POSIX_C_SOURCE=200112L)      XPG6
> 
> Later in the same header, compilation with -c99 is made to fail if _XPG6 is
> not set, like this:
> 
>     #if defined(_STDC_C99) && (defined(__XOPEN_OR_POSIX) && !defined(_XPG6))
>     #error "Compiler or options invalid for pre-UNIX 03 X/Open applications \
>             and pre-2001 POSIX applications"
>     #elif ...
> 
> The problem is that they check things in an order that is inconvenient for
> us.  When they see _XOPEN_SOURCE_EXTENDED, they declare that we are XPG4v2,
> regardless of the value of _XOPEN_SOURCE.
> 
> To work around this problem, do not define _XOPEN_SOURCE_EXTENDED on
> Sun's.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-compat-util.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index c7cf2d5..4236647 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -41,8 +41,10 @@
>  
>  #if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
> +#ifndef __sun__

__sun__ is not defined by the SUNWspro compiler.  We can fix that by adding
a -D__sun__ in the SunOS section of the Makefile though.

A more important issue, is that now that this causes _XPG6 to be defined,
sun's header files _require_ a c99 compiler to be used.

Here's the comment that goes along with the partial snippet that you showed
above from /usr/include/sys/feature_tests.h:

  /*
   * It is invalid to compile an XPG3, XPG4, XPG4v2, or XPG5 application
   * using c99.  The same is true for POSIX.1-1990, POSIX.2-1992, POSIX.1b,
   * and POSIX.1c applications. Likewise, it is invalid to compile an XPG6
   * or a POSIX.1-2001 application with anything other than a c99 or later
   * compiler.  Therefore, we force an error in both cases.
   */

And the rest of the macro implements the check for source/compiler
suitability.

So we either require compiling with a c99 compiler (by ensuring that
_XPG6 is set) or exclude compiling with a c99 compiler on sun (by
ensuring that _XPG6 is not set).  Actually, this would only affect Solaris
versions which support XPG6.  Solaris 11 and 10 do.  I don't know about
Solaris 9 and 8.  Solaris 7 doesn't.

Which do we want to do?

>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>  #endif
> +#endif
>  #define _ALL_SOURCE 1
>  #define _GNU_SOURCE 1
>  #define _BSD_SOURCE 1
