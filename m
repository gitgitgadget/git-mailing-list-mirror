From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] Consistent use of AC_LANG_PROGRAM in configure.ac and
 aclocal.m4.
Date: Sun, 2 Jan 2011 10:47:30 +0100
Organization: Institute for Numerical Simulation, University of Bonn
Message-ID: <20110102094730.GA10365@gmx.de>
References: <20110102060044.GJ19818@gmx.de>
 <20110102075953.GB8937@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 02 10:47:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZKXM-0004Qf-Vq
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 10:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab1ABJre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 04:47:34 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:37632 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751002Ab1ABJrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 04:47:33 -0500
Received: (qmail invoked by alias); 02 Jan 2011 09:47:31 -0000
Received: from xdsl-78-34-215-55.netcologne.de (EHLO localhost.localdomain) [78.34.215.55]
  by mail.gmx.net (mp021) with SMTP; 02 Jan 2011 10:47:31 +0100
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX19e1W4KbrdeYSW9upSKbc7HECjP96hiFVgltB0iWd
	ZSY2PVjmEhuIGW
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1PZKXC-0002i4-EG; Sun, 02 Jan 2011 10:47:30 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110102075953.GB8937@burratino>
User-Agent: Mutt/1.5.20 (2010-08-04)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164413>

* Jonathan Nieder wrote on Sun, Jan 02, 2011 at 08:59:53AM CET:
> Ralf Wildenhues wrote:
> 
> > The patch should not cause any semantic changes in the generated
> > configure script.
> 
> This part belongs in the commit message too, imho (though no need to
> resend just for that, of course).

Yeah, you're right.

> > -   AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_dashr=yes], [git_cv_ld_dashr=no])
> > +   AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_dashr=yes], [git_cv_ld_dashr=no])
> 
> Could you say a few words about the effect of this?  Mostly because
> it would be useful to people down the line tempted to make the same
> mistake again.

Allow me to quote autoconf-2.68/NEWS:

  ** The macros AC_PREPROC_IFELSE, AC_COMPILE_IFELSE, AC_LINK_IFELSE, and
     AC_RUN_IFELSE now warn if the first argument failed to use
     AC_LANG_SOURCE or AC_LANG_PROGRAM to generate the conftest file
     contents.  A new macro AC_LANG_DEFINES_PROVIDED exists if you have
     a compelling reason why you cannot use AC_LANG_SOURCE but must
     avoid the warning.

The underlying reason for this change is that AC_LANG_{SOURCE,PROGRAM}
take care to actually supply the previously computed set of #defines
(and include the standard headers if so desired), for preprocessed
languages like C and C++.  In the above case, AC_LANG_PROGRAM is already
used, but not sufficiently m4-quoted, so that the autoconf warning will
be triggered bogusly.

The general rule for m4 quotation is: one set of quotes for each macro
argument, e.g.:
  MACRO1([arg with MACRO2([arg], [arg])], [arg], ...)

and for innermost arguments which need to undergo no m4 expansion at all
a double set of quotes should be used, e.g.:
  AC_LANG_SOURCE([[int s[42]; /* Program sources containing brackets.  */]])

Only for some special macros that need to be expanded before recursion
no quoting should be used.

These and more rules are described in detail in 'info Autoconf
"Programming in M4"'.  The rules can often be relaxed when the macro
arguments contain no active characters like comma, brackets or other
macro invocations themselves, but IMVHO it is easier getting used to
just quote things normally.

> > @@ -500,7 +494,7 @@ for l in $lib_order; do
> >      old_LIBS="$LIBS"
> >      LIBS="$LIBS $l"
> >      AC_MSG_CHECKING([for iconv in $l])
> > -    AC_LINK_IFELSE(ICONVTEST_SRC,
> > +    AC_LINK_IFELSE([ICONVTEST_SRC],
> 
> I'm curious about this one, too.

Likewise this is just underquotation leading to false positive.

> > @@ -931,18 +915,16 @@ AC_SUBST(NO_INITGROUPS)
> >  #
> >  # Define PTHREAD_LIBS to the linker flag used for Pthread support.
> >  AC_DEFUN([PTHREADTEST_SRC], [
> > +AC_LANG_PROGRAM([[
> >  #include <pthread.h>
> > -
> > -int main(void)
> > -{
> > +]], [[
> >  	pthread_mutex_t test_mutex;
> 
> By the way, what problem is the warning about AC_LANG_PROGRAM meant to
> prevent?  (Just curious.  A five-minute google search didn't reveal
> anything obvious.)

See above.

I would be happy to update the patch in a way that makes it more
helpful, but most of the above is fairly general Autoconf rules,
so I'm not sure what you need (being blinded by looking at this
stuff too often).

Cheers,
Ralf
