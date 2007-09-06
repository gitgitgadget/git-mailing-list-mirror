From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 22:52:24 -0400
Message-ID: <20070906025224.GK18160@spearce.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <loom.20070906T044017-727@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Russ Dill <Russ.Dill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:52:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT7Tx-0003Ah-SO
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbXIFCwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbXIFCwd
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:52:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36407 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290AbXIFCwc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:52:32 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT7Ta-0006vH-Sm; Wed, 05 Sep 2007 22:52:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 28DE520FBAE; Wed,  5 Sep 2007 22:52:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <loom.20070906T044017-727@post.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57808>

Russ Dill <Russ.Dill@gmail.com> wrote:
> > Ok, how about doing something like this?
> 
> git add? merge? rebase? No, I have a sneakier place to invoke gc.
> 
> Whenever $EDITOR gets invoked. Heck, whenever git is waiting for any user input,
> do some gc in the background, it'd just have to be incremental so that we could
> pick up where we left off.

Heh.  That is a really good idea.  I've been thinking about doing
some automatic generational style GC type repacking controls in
git-gui, and doing them when git-gui is sitting idle and has not
been used in the past couple of minutes.

This is along the same vein of thought.  I like it.  Often it
takes me a while to come up with a good commit message even if
I am using command line commit.

But git-rebase/git-am can cause a huge number of objects to be
created, especially if you are pushing a large stack of patches
around.  So it may still be a good idea to trigger `gc --auto`
at the end of those operations.
 
> Similarly, you could mix it in with git pull/push so that while we are waiting
> on the network, we can do some packing.

Here's a better thought:

If we are pushing somewhere, and the push size is "large-ish" and
we aren't pushing a thin pack (its currently considered not nice
to the remote end so it doesn't happen by default) and the objects
we are packing are mostly all loose maybe we should also save a
copy of that packfile locally, then prune *only* those loose objects
back.

Not every git user pushes their work.  But many do.  And those
that push usually will do so in bursts, are already expecting to
wait for the network latency, and usually are pushing the majority
of the things that are loose.  Such users will probably never see
the `gc --auto` trip in places like commit/am/merge as they would
already be clearing their ODB with the push.

-- 
Shawn.
