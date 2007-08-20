From: Michael Poole <mdpoole@troilus.org>
Subject: Re: va_copy is not available on all systems.
Date: Mon, 20 Aug 2007 09:39:34 -0400
Message-ID: <87y7g6wcix.fsf@graviton.dyn.troilus.org>
References: <46C99448.2AB33DFF@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 16:10:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN7xO-0007zm-Of
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 16:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbXHTOKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 10:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756382AbXHTOKK
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 10:10:10 -0400
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:45173
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755705AbXHTOKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2007 10:10:09 -0400
X-Greylist: delayed 1833 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2007 10:10:09 EDT
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id 9261789C04D; Mon, 20 Aug 2007 09:39:34 -0400 (EDT)
In-Reply-To: <46C99448.2AB33DFF@eudaptics.com> (Johannes Sixt's message of
	"Mon, 20 Aug 2007 15:16:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56219>

Johannes Sixt writes:

> This is just too ugly to be included...
>
> die_nicely() uses the variable argument list twice. The recent fix for
> this in 7e5dcea8311 uses va_copy. However, on older systems this function
> is not available. This fix assumes that those systems that do have
> the function actually implement it as macro, and we use it to remove
> the entire nicely() functionality.
>
> Since va_copy() must be provided by the compiler, we don't have a
> reasonable chance to provide a working definition in git_compat_util.h.

Some older (pre-C99) versions of gcc name it __va_copy() instead.  Is
there any guarantee that va_copy() will be a macro on systems that
provide it?  If neither va_copy() nor __va_copy() are available,
memcpy(&(DEST), &(SRC), sizeof(DEST)) should work for any va_list
type.  It's what I use on one project:

#ifdef HAVE_VA_COPY
#define VA_COPY(DEST, SRC) va_copy(DEST, SRC)
#elif HAVE___VA_COPY
#define VA_COPY(DEST, SRC) __va_copy(DEST, SRC)
#else
#define VA_COPY(DEST, SRC) memcpy(&(DEST), &(SRC), sizeof(DEST))
#endif

with appropriate autoconf tests, basically two copies of this:

dnl How to copy one va_list to another?
AC_CACHE_CHECK([for va_copy], ac_cv_c_va_copy, [AC_LINK_IFELSE(
  [AC_LANG_PROGRAM([#include <stdarg.h>], [va_list ap1, ap2; va_copy(ap1, ap2);])],
  [ac_cv_c_va_copy="yes"],
  [ac_cv_c_va_copy="no"]
)])
if test "$ac_cv_c_va_copy" = "yes" ; then
  AC_DEFINE(HAVE_VA_COPY, 1, [Define if we have va_copy])
fi

I'm not sure how to translate the tests to git's coding style most
easily.

Michael Poole
