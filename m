From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 04/16] Without this patch at least IBM VisualAge C 5.0
 (I have 5.0.2) on AIX 5.1 fails to compile git.
Date: Wed, 28 Apr 2010 08:40:27 +0000
Message-ID: <20100428084027.GC36271@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135823.017417000@mlists.thewrittenword.com>
 <4BD70C1A.80709@spacetec.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed Apr 28 10:40:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O72ou-0006hw-Js
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 10:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab0D1Ikb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 04:40:31 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:51535 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab0D1Ik2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 04:40:28 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 9945E5C42;
	Wed, 28 Apr 2010 09:01:37 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 9945E5C42
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id C4F2CAC3;
	Wed, 28 Apr 2010 08:40:27 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id BDECABAB4; Wed, 28 Apr 2010 08:40:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4BD70C1A.80709@spacetec.no>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145976>

On Tue, Apr 27, 2010 at 06:08:58PM +0200, Tor Arntsen wrote:
> On Tue, Apr 27, 2010 at 15:57, Gary V. Vaughan <git@mlists.thewrittenword.com> wrote:
> > enum style is inconsistent already, with some enums declared on one
> > line, some over 3 lines with the enum values all on the middle line,
> > sometimes with 1 enum value per line... and independently of that the
> > trailing comma is sometimes present and other times absent, often
> > mixing with/without trailing comma styles in a single file, and
> > sometimes in consecutive enum declarations.
> >
> > Clearly, omitting the comma is the more portable style, and this patch
> > changes all enum declarations to use the portable omitted dangling
> > comma style consistently.
> 
> The patch is against master. Are we supposed to make patches against
> master or maint? (I thought I saw the latter somewhere. I'm pretty
> new in here though..)

No, the patch is against the latest 7.1.1 stable release (not yet shown
on the website last time I checked, however):

	http://www.kernel.org/pub/software/scm/git/git-1.7.1.tar.bz2

> I can confirm that master doesn't compile on AIX 5.1 with the IBM
> VisualAge compiler V5 (V5.0.2) without the patch above, and it does
> compile with the patch:
> 
> Tested-by: Tor Arntsen <tor@spacetec.no>

Thanks for testing.

> but with the following caveats:
> 
> 1: With the patch, it'll build with configure (and only configure),
> run like so:
> 
> ./configure --enable-pthreads=-lpthread CFLAGS=-Dinline=''

The pthread issue is taken care of by pthread.patch (later in this
series), which also adds defaults to Makefile.

The inline issue is taken care of by no-inline.patch (the last patch
in this series), for configure based builds at least.

> In other words, this system would also need an AIX version of the
> 'no-inline' patch you did for HP-UX.

This should be as simple as adding the following to the appropriate
AIX defaults section of Makefile:

        ifeq ($(shell expr "$(uname_V).$(uname_R)" : '5\.1'),3)
                INLINE=''
        endif

But, honestly (with the obvious exception of the few architectures
that don't have access to a posix shell and command line tools) I
really don't see the value of burning perfectly good development time
by trying to maintain 2 separate build systems... irrespective of what
its detractors would like you to believe, configure is specifically
designed to discover things like this empirically *on the actual build
machine* - no matter what particular combination of libc, compiler,
operating system and/or patchlevels a build host happens to be running
on the day of the build: trying to maintain an accurate database of
what quirks are present in all combinations of the above is a far more
difficult, likely impossible, undertaking.

> And without the --enable-pthreads=-lpthread above it'll try to link
> with -pthread, which won't work for this system.

Did you apply the whole series of patches?  If so, then it is a bug in
my pthread.patch if --enable-pthreads=-lpthreads is necessary.  This
configure line builds successfully on all the architectures I have
access to (note, pthread support is probed automatically by configure):

  {SHELL} ./configure CC="${CC:-gcc}" CFLAGS="${CFLAGS:--O2}" \
  CPPFLAGS="-I${SB_VAR_CURL_INC} \
  ${SB_VAR_LIBEXPAT+-I${SB_VAR_LIBEXPAT_INC}} \
  ${SB_VAR_LIBZ+-I${SB_VAR_LIBZ_INC}} ${CPPFLAGS+${CPPFLAGS}}" \
  LDFLAGS="${SB_VAR_GCC_RT+-L${SB_VAR_GCC_RT_LIB}} \
  ${SB_VAR_LIBEXPAT+-L${SB_VAR_LIBEXPAT_LIB}} \
  ${SB_VAR_LIBZ+-L${SB_VAR_LIBZ_LIB}} \
  -L${SB_VAR_CURL_LIB} \
  ${SB_VAR_GCC_RT+${CC_LD_RT}${SB_VAR_GCC_RT_LIB}} \
  ${SB_VAR_LIBEXPAT+${CC_LD_RT}${SB_VAR_LIBEXPAT_LIB}} \
  ${SB_VAR_LIBZ+${CC_LD_RT}${SB_VAR_LIBZ_LIB}} \
  ${CC_LD_RT}${SB_VAR_CURL_LIB} ${LDFLAGS+${LDFLAGS}}" \
  ${SB_VAR_LIBEXPAT+--with-expat} \
  ${SB_VAR_LIBICONV+--with-iconv=${SB_VAR_LIBICONV}} \
  --without-openssl --with-curl ${ARGS+"${ARGS}"} \
  --prefix=${SB_INSTALL_PREFIX}

where ${SB_VAR_...LIB} and ${SB_VAR_...INC} hold the paths to the
relevant libdir and includedir directories for the named packages,
${CC_LD_RT} is "-Wl,--rpath," or equivalent, and SB_VAR_GCC_RT_LIB
refers to the GCC runtime and is predicated on whether gcc is used
(i.e. on Linux).

> The const-expr patch is also useful for AIX-5.1 / XlC V5.0.2. It
> does build without, but with warnings.

IRIX6.5 however fails to compile altogether without const-expr.patch.

> 2: The compiler cannot build on AIX 5.1 without the following
> additional patch (against master. maint has similar problems but
> files have been moved):

I maintained a similar patch for our packaging of older git releases
too, but noticed that it wasn't necessary on our machines anymore...
perhaps recent compiler patches on our hosts have relaxed the
requirement for non-C++ comment syntax?

However, I do confirm that this is a problem I have encountered in the
past.

> From a8989213b4c8baa53c14c1f227b916910265c517 Mon Sep 17 00:00:00 2001
> From: Tor Arntsen <tor@spacetec.no>
> Date: Tue, 27 Apr 2010 16:05:12 +0000
> Subject: [PATCH 2/2] C99 comments changed to old-style C comments
> 
> Signed-off-by: Tor Arntsen <tor@spacetec.no>
> ---
>  builtin/blame.c        |    2 +-
>  builtin/for-each-ref.c |    4 ++--
>  remote.c               |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
