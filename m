From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] Don't define _XOPEN_SOURCE on MacOSX and FreeBSD as it is too restricting
Date: Fri, 22 Dec 2006 12:47:22 +0100
Message-ID: <20061222114722.GA11274@fiberbit.xs4all.nl>
References: <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net> <caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com> <7vodpy3vxi.fsf@assigned-by-dhcp.cox.net> <86vek6vyc7.fsf@blue.stonehenge.com> <caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com> <20061221103938.GA7055@fiberbit.xs4all.nl> <20061221112835.GA7713@fiberbit.xs4all.nl> <7v64c492fv.fsf@assigned-by-dhcp.cox.net> <20061222075142.GA9595@fiberbit.xs4all.nl> <7v4pro5nsa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>,
	Terje Sten Bjerkseth <terje@bjerkseth.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 12:47:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxisD-0001H9-M0
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 12:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbWLVLrf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 06:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754814AbWLVLrf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 06:47:35 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:37710 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbWLVLre (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 06:47:34 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1Gxiry-00032q-Uq; Fri, 22 Dec 2006 12:47:22 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pro5nsa.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35163>

On Friday December 22nd 2006 at 00:37 Junio C Hamano wrote:

> (offtopic) Yeah, but my point was that ANSI C reserves _all_
> symbols that begin with str ("Names reserved for expansion"),
> not just a specific set of functions like strcmp, strcpy, etc.,
> so if a program tries to be compliant with it, it cannot use,
> for example, strncasecmp (was that the symbol we had trouble
> with?)  for its own purpose anyway -- which means the system
> header implementation should not have to worry about namespace
> pollution.  I do not see any reason for them to hide
> strncasecmp, for example.

(ontopic for offtopic, that makes it still offtopic probably) I think
the intention from Apple might have been to provide a strict least
common denominator environment for developing software that will run
on strictly standardized POSIX standards. Think of someone that has
to develop a program on Darwin and that should also run on OS/400. If
strcasestr(3) isn't in the libraries there it might make some sense to
not make it available in this strict compatibility mode (expose no less
but also no more environment). A sort of combination of '-pedantic' with
'-Werror' as it were. Note that I do not defend it, just trying to find
some sense of logic in it. ;-)

> > On Apple compiling git works fine both with and without
> > _XOPEN_SOURCES_EXTENDED. But looking in the headers, in contrast to the
> > _XOPEN_SOURCE define which restricts functionality to some predefined
> > set, the _XOPEN_SOURCES_EXTENDED only adds functionality and doesn't
> > remove it. So I thought it might be best to keep as much symbols as
> > possible to be the same for all platforms for future expandibility.
> >
> > Probably FreeBSD behaves the same with respect to
> > _XOPEN_SOURCE_EXTENDED. Will check later today.
> 
> Ok, thanks.

Checking for compilation with FreeBSD as target should have the macro
"__FreeBSD__" as value. No other value, as already pointed out by Rocco
Rutte.

The behaviour of _XOPEN_SOURCE_EXTENDED on FreeBSD is exactly like on
Apple. This means for git we can either include it or not, it won't make
a difference.

There is a subtle and interesting difference with respect to
the usage of _XOPEN_SOURCE on FreeBSD as compared to Darwin. The only
thing that I see on FreeBSD is that it (indirectly through yet another
macro __XSI_VISIBLE) influences some functions (amongst which
strcasestr(3) in daemon.c) to be declared in the system header
<strings.h> instead of in <string.h>. The FreeBSD header claim that this
should be the POSIX behaviour for _XOPEN_SOURCE. As we do not include
<strings.h> the compilation fails on FreeBSD.

In fact on FreeBSD the problem seems to be only that when _XOPEN_SOURCE
is defined, than the macro __BSD_VISIBLE is unset or 0. Adding just

#ifdef __FreeBSD__
#define __BSD_VISIBLE   1
#endif

before setting _XOPEN_SOURCE in also results in git compiling perfectly
on FreeBSD. In that case for example <string.h> automatically includes
<strings.h>.

So on top of Terjes patch in "master":

diff --git a/git-compat-util.h b/git-compat-util.h
index 41fa7f6..2303951 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -11,6 +11,10 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+#ifdef __FreeBSD__
+#define __BSD_VISIBLE	1	/* needed in combination with _XOPEN_SOURCE */
+#endif
+
 #ifndef __APPLE_CC__
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
-- 
Marco Roeland
