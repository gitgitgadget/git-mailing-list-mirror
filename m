From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 12:51:46 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908181226160.7195@iabervon.org>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org,
	kusmabite@googlemail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRv2-0001qf-R0
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbZHRQvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759399AbZHRQvq
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:51:46 -0400
Received: from iabervon.org ([66.92.72.58]:34845 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759345AbZHRQvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:51:45 -0400
Received: (qmail 16932 invoked by uid 1000); 18 Aug 2009 16:51:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Aug 2009 16:51:46 -0000
In-Reply-To: <1250600335-8642-1-git-send-email-mstormo@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126418>

On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:

> From: Marius Storm-Olsen <mstormo@gmail.com>
> 
> By using GNU Make we can also compile with the MSVC toolchain.
> This is a rudementary patch, only meant as an RFC for now!!
> 
> !! DO NOT COMMIT THIS UPSTREAM !!
> ---
>  So, instead of rely on these vcproj files which *will* go stale, we can
>  simply use the same Makefile system which everyone else is using. :)
>  After all, we're just compiling with a different compiler. The end result
>  will still rely on the *msysGit environment* to function, so we already
>  require it. Thus, GNU Make is present, and we can use it.
> 
>  This implementation is a quick hack to make it compile (hence the RFC
>  subject), so please don't even consider basing anything ontop of it ;)
> 
>  But, do point out all the do's and don'ts, and I'll try to polish it up
>  to something which we can add to Frank's series..
>  
> 
>  Makefile      |   97 +++++++++++++++++++++++++++++++++++++++++++++++---------
>  compat/msvc.h |   77 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 158 insertions(+), 16 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index daf4296..2e14976 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -214,9 +214,13 @@ uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
>  
>  CFLAGS = -g -O2 -Wall
>  LDFLAGS =
> +ARFLAGS = rcs\ # whitespace intentional
>  ALL_CFLAGS = $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
> +COMPFLAG = -c
> +COBJFLAG = -o\ # whitespace intended
> +LOBJFLAG = -o\ # whitespace intended

I think it's nicer to write the significant whitespace with non-whitespace 
text using something like:

empty=
space=$(empty) $(empty)

(...)

ARFLAGS = rcs$(space)

COBJFLAG = -o$(space)

On the other hand, I think it would be clearer to put the "rcs" in the 
default version of $(AR), and have a $(AROBJFLAG) set to nothing there, 
since the "rcs" isn't actually at all like the "-OUT:" with respect to 
what it's doing there.

Possibly also to have two variables for the output of the toolchain 
wrapper, one that is before the name of the file and one that's attached 
to the name of the file.

	-Daniel
*This .sig left intentionally blank*
