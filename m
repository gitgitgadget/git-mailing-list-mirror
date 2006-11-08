X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Return non-zero status from pull if merge fails.
Date: Wed, 8 Nov 2006 00:10:35 -0500
Message-ID: <20061108051035.GA28498@spearce.org>
References: <20061107181053.GA26856@spearce.org> <7vy7qmzttk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 05:10:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vy7qmzttk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31114>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghfi3-0000Vk-0a for gcvg-git@gmane.org; Wed, 08 Nov
 2006 06:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754272AbWKHFKk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 00:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbWKHFKk
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 00:10:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34494 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754272AbWKHFKj
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 00:10:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ghfhh-0006O1-TU; Wed, 08 Nov 2006 00:10:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 2BDB420E487; Wed,  8 Nov 2006 00:10:36 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > diff --git a/git-merge.sh b/git-merge.sh
> > index cb09438..7725908 100755
> > --- a/git-merge.sh
> > +++ b/git-merge.sh
> > @@ -203,7 +203,7 @@ f,*)
> >  	git-update-index --refresh 2>/dev/null
> >  	new_head=$(git-rev-parse --verify "$1^0") &&
> >  	git-read-tree -u -v -m $head "$new_head" &&
> > -	finish "$new_head" "Fast forward"
> > +	finish "$new_head" "Fast forward" || exit 1
> >  	dropsave
> >  	exit 0
> >  	;;
> 
> The shell function "finish" itself exits when there is an error;
> is this needed?

Yes.  Without it:

  $ git checkout -b 931233bc666b^
  $ echo broken >builtin-pickaxe.c
  $ git pull . next && echo good merge
  Updating c2e525d..522da27
  builtin-pickaxe.c: needs update
  fatal: Entry 'builtin-pickaxe.c' not uptodate. Cannot merge.
  good merge

Say what?  There's no way that fast forward was good!  Granted this
use case is horrible but that fast forward went very, very badly,
but the caller now thinks it was good.
 
> > @@ -214,7 +214,7 @@ f,*)
> > +	git var GIT_COMMITTER_IDENT >/dev/null || exit 1
> > @@ -225,7 +225,7 @@ f,*)
> > +	    ) || exit 1
> > @@ -253,7 +253,7 @@ f,*)
> > +git var GIT_COMMITTER_IDENT >/dev/null || exit 1
> > @@ -327,7 +327,7 @@ done
> > +    result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents) || exit 1
> 
> Are these needed?  Wouldn't "something || exit" already exit non-zero
> when something exits non-zero?

Hmm; apparently you are correct.  But that seems like magic shell
voodoo to me.  I honestly didn't expect exit to behave like that.
Please delete these 4 hunks and apply my patch without them.

-- 
