From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 02:30:14 -0400
Message-ID: <20071020063014.GU14735@spearce.org>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <1192859758.13347.148.camel@g4mdd.entnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ari Entlich <lmage11@twcny.rr.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:30:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7qy-0005TQ-TR
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbXJTGaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbXJTGaT
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:30:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47281 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbXJTGaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:30:18 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ij7qg-0005cU-V9; Sat, 20 Oct 2007 02:30:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2902820FBAE; Sat, 20 Oct 2007 02:30:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192859758.13347.148.camel@g4mdd.entnet>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61791>

Ari Entlich <lmage11@twcny.rr.com> wrote:
> On Thu, 2007-10-18 at 21:54 -0400, Shawn O. Pearce wrote:
> > --index is used in Git for places were we update *both* the index
> > and the working directory (git-apply --index). So actually I should
> > have suggested "git-mv --index".  Whoops.
> 
> Alright then, I don't know about that particular convention. If this
> behavior can't be made default, git mv --index should activate it? I
> there anything else that might be more descriptive?

That's always the hard part.  I actually think the current behavior
should be called --index as it does not only the working tree
update but also stages the whole file into the index, which is what
git-apply --index does.

What about just -u for "keep unstaged"?
 
> Might it be possible to simply get the struct cache_entry for the file
> which we want to rename, change its name property (would this involve
> xreallocing it?), and change the ce_namelen field of ce_flags?

Yes.
 
> In any case, I think the ce_flags would need to be changed to reflect
> the new name length. Also, it seems that the old ce_mtime, ce_dev,
> ce_ino, ce_uid, ce_gid, and ce_size could be used too... ce_ctime would
> need to be updated...

Correct.  The ce_size shouldn't change as a result of the rename but
the other properties of a struct stat may.  I'd like to think that
ce_uid and ce_gid wouldn't change as a result of a rename but there's
probably some bastard filesystem somewhere that that won't hold true.

Just call fill_stat_cache_info() on your xrealloc'd entry and pass
it a stat buffer for the file after the rename and you should be
covered here.

> > I'm sure Junio could probably give you a better starting point
> > than I can, as he's more familiar with this sort of code, but that
> > should still get you looking in the right direction and maybe get
> > a working implementation together that you can share for discussion.
> 
> Yeah, I'd appreciate any help I can get. The people on #git were
> invoking the "the code is the documentation" ideology. :)

It really is in this case.  You are talking about hacking on
Git itself.  For the most part we believe in "the code is the
documentation" for the guts as otherwise the documentation gets
out of sync with the code when the code changes.  User level docs
are different as the user interface needs to stay stable.

> So... Ping Junio...? I actually haven't seen any messages from him since
> I subscribed to this list (I've only gotten about 300 messages so far,
> but I'd expect to see a lot from him as he's the maintainer...). Is he
> away at the moment or something?

Yes.  We run like 100 messages a day so I guess you've only joined
in the past few days.  Welcome to the list.  :-)

Junio has been away for about 2 weeks now.  He's basically off
on leave as he needed some time to take care of some things.
I'm filling in for him until he returns.

-- 
Shawn.
