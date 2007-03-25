From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sun, 25 Mar 2007 05:25:31 -0400
Message-ID: <20070325092530.GI25863@spearce.org>
References: <200703231022.00189.andyparkins@gmail.com> <200703241548.13775.andyparkins@gmail.com> <38b2ab8a0703241115q39dc298clb15357268288b49e@mail.gmail.com> <200703251011.53712.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Francis Moreau <francis.moro@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 11:25:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVOyo-0003r0-Cj
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 11:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281AbXCYJZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 05:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933283AbXCYJZf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 05:25:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44458 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933281AbXCYJZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 05:25:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVOyh-0001Fd-23; Sun, 25 Mar 2007 05:25:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9B47B20FBAE; Sun, 25 Mar 2007 05:25:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200703251011.53712.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43047>

Andy Parkins <andyparkins@gmail.com> wrote:
> On Saturday 2007, March 24, Francis Moreau wrote:
> 
> > yes that almost would do the thing. But instead of hacking the hook,
> > it would be great to have a trivial setup at the begining of the
> > script to choose this config.
> 
> I'd like Junio's permission before actually doing that; I know he is 
> worried about out-of-control growth of hook scripts and it's already 
> overly large just to do the one job it's got.

One thought I had today:

The old hooks (update, post-update) were easy to chain if you wanted
to run more than one "standard" hook in a repository.  Just pass
"$@" to each hook excutable, using a small shell-script wrapper
that is installed as the actual hook.

The new hooks (pre-receive, post-receive) are not so easy to chain,
as their input comes by way of stdin.  You'd have to copy the
data off to a temporary file, and redirect that into each hook in
turn.  Annoying.

So I'm kicking around the idea of teaching receive-pack to run
hooks in filename order if the hook is actually a subdirectory.
Then you can do:

  mkdir .git/hooks/post-receive
  ln -s \
    ~/git/contrib/email/post-receive-head \
    .git/hooks/post-receive/01-head
  ln -s \
    ~/git/contrib/email/post-receive-tag \
    .git/hooks/post-receive/02-tag
  ln -s \
    ~/git/contrib/continuous/post-receive-cinotify \
    .git/hooks/post-receive/10-cinotify

Where this applies to Andy's message that I quoted is the email
hooks could be split up to handle different types of refs in each
hook, e.g. one for heads and one for tags, and just skip refs that
don't apply to that particular hook.

-- 
Shawn.
