From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git does the wrong thing with ambiguous names
Date: Thu, 7 Jun 2007 02:01:00 +0200
Message-ID: <20070607000100.GE3969@steel.home>
References: <4667319C.9070302@nrlssc.navy.mil> <20070606225826.GC3969@steel.home> <20070606233327.GD3969@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 02:01:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw5R6-00067O-Cd
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 02:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbXFGABF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 20:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756792AbXFGABF
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 20:01:05 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:16978 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbXFGABE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 20:01:04 -0400
Received: from tigra.home (Fa87f.f.strato-dslnet.de [195.4.168.127])
	by post.webmailer.de (mrclete mo46) (RZmta 7.2)
	with ESMTP id G05327j56NYIbn ; Thu, 7 Jun 2007 02:01:01 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 19C6C277BD;
	Thu,  7 Jun 2007 02:01:01 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id F3B8EBEA7; Thu,  7 Jun 2007 02:01:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070606233327.GD3969@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVEU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49335>

Alex Riesen, Thu, Jun 07, 2007 01:33:27 +0200:
> Alex Riesen, Thu, Jun 07, 2007 00:58:26 +0200:
> > Brandon Casey, Thu, Jun 07, 2007 00:13:48 +0200:
> > > 
> > > When a branch and tag have the same name, a git-checkout using that name 
> > > succeeds (exits zero without complaining), switches to the _branch_, but 
> > > updates the working directory contents to that specified by the _tag_. 
> > > git-status show modified files.
> > 
> > Bad. To reproduce:
> > 
> > mkdir a && cd a && git init && :> a && git add . && git commit -m1 &&
> > :>b && git add . && git commit -m2 && git tag master HEAD^ &&
> > find .git/refs/ && gco -b new && gco master && git status
> > 
> 
> git-rev-parse actually warns about ambguities:
> 
>     $ git-rev-parse --verify master
>     warning: refname 'master' is ambiguous.
>     dd5cdc387f2160bf04d02ac08dfdaf952f769357
> 
> It's just that the warning is thrown away in git-checkout.sh
> 
> A quick and _very_ messy fix could like like that:
> 

This one is much shorter and less friendly. Suggested by Junio on irc.
It makes checkout always prefer a branch.

diff --git a/git-checkout.sh b/git-checkout.sh
index 6b6facf..282c84f 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -67,6 +67,8 @@ while [ "$#" != "0" ]; do
 			new_name="$arg"
 			if git-show-ref --verify --quiet -- "refs/heads/$arg"
 			then
+				rev=$(git-rev-parse --verify "refs/heads/$arg^0" 2>/dev/null)
+				new="$rev"
 				branch="$arg"
 			fi
 		elif rev=$(git-rev-parse --verify "$arg^{tree}" 2>/dev/null)
