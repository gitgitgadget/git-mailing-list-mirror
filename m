From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Teach git-checkout-index to use file suffixes.
Date: Thu, 2 Mar 2006 12:10:09 -0500
Message-ID: <20060302171009.GD18929@spearce.org>
References: <20060301044132.GF22894@spearce.org> <20060301150629.GB3456@spearce.org> <slrne0bh1p.fr9.mdw@metalzone.distorted.org.uk> <20060302065136.GA6377@spearce.org> <7vbqwp6zvg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 18:11:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FErK1-0002T8-4X
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 18:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbWCBRKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 12:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWCBRKO
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 12:10:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47567 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1752018AbWCBRKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 12:10:12 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FErJV-000203-FK; Thu, 02 Mar 2006 12:10:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2D0EC20FBBF; Thu,  2 Mar 2006 12:10:09 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqwp6zvg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17096>

Junio C Hamano <junkio@cox.net> wrote:
[...]
> However, --stage=all with --suffix would introduce name clashes
> between repeated conflicted merge runs, which requires Porcelain
> to be extra careful.  Your last merge run might have involved
> three conflicting stages (leaving a.c~1, a.c~2, and a.c~3 in
> your working tree) and this time it may be "we removed it while
> they modified it" situation (needing to extract a.c~1, a.c~3 but
> not a.c~2).  The Porcelain needs to make sure not to get
> confused by leftover a.c~2 file in the working tree from the
> previous run.

Clearly.  pg was trying to delete all of those files before doing its
merge work but failed because of the --ignored bug in git-ls-files;
but this is now fixed.  Still a possibility for confusion does exist.

But in at least one case my Porcelain is Eclipse and a Cygwin
prompt.  In this case I want to view and edit everything in Eclipse.
Having all of the files in the same directory just makes it easier
to view.  Random temporary names in the same directory as the tracked
file would be OK except if I had multiple conflicts in the same
directory, in which case I need some easy way to tell them apart.
At which point we're starting to derive off the tracked file name
and might as well always use well-known names.
 
> If what you are trying is to reduce the number of checkout-index
> calls by your Porcelain to extract conflicted stages, it _might_
> make more sense to do something like this instead (I am thinking
> aloud, so take this with a big grain of salt -- it may not make
> sense at all):
> 
>     checkout-index --stage=all checks out higher-order stages in
>     made-up temporary filenames, just like git-merge-one-file
>     does using git-unpack-file one-by-one, with a single
>     invocation.
> 
>     It reports the following to its standard output, one record
>     per pathname in the index:
> 
> 	tmp1 <SP> tmp2 <SP> tmp3 <TAB> pathname <RS>
[...]

That's not a bad idea.  The only thing I don't like about that
is that git-checkout-index won't build the directory tree for me;
the Porcelain must still be responsible for doing that before it
can rename the temporary files (if available) into the correct
subdirectory.

My plan with git-checkout-index though was originally to just have
it fail if the file already exists, unless -f is given.  So if
a left-over foo.c#2 was still on disk and git-checkout-index was
going to write to that name it would fail.


I see a lot of benefit from the checkout to temporary file names
and let the Porcelian rename (if it desires).

So I'm going to ask you to withdraw the --suffix patch from pu.
I'll write up a new patch using the ideas you suggest above and
submit that instead.

-- 
Shawn.
