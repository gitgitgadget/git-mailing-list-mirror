From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 07/11] git-fetch: Limit automated tag following to only fetched objects
Date: Sun, 11 Nov 2007 00:49:51 -0500
Message-ID: <20071111054951.GV14735@spearce.org>
References: <20071109110631.GG19368@spearce.org> <7v7ikrrr77.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 06:50:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir5hz-0005Gr-Ex
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 06:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbXKKFt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 00:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbXKKFt4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 00:49:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38892 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbXKKFtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 00:49:55 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ir5hi-0006GT-Uo; Sun, 11 Nov 2007 00:49:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1734520FBAE; Sun, 11 Nov 2007 00:49:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v7ikrrr77.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64405>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > We now redefine the rule to be: "tags are fetched if they refer
> > to an object that was just transferred; that is an object that is
> > new to your repository".  This rule is quite simple to understand,
> > you only get a tag if you just got the object it refers to.
> 
> In other words, if I do this:
> 
> 	git fetch git-gui master
> 
> (which should not follow any tags) when your master is a bit
> ahead of a new tag in git-gui I do not have, and then
> immediately afterwards if I do:
> 
> 	git fetch git-gui
> 
> I will not get the new tag followed?
> 
> If that is what the patch does, it feels like a regression.

Yeah, that's what it does, and everyone has stated its a regression
so its not the right change to make here.
 
> The intended behaviour was "when tag following is enabled, they
> are followed if they refer to an object that is reachable from
> your existing refs".
> 
> But this is quite expensive to compute.  If a tag points at a
> blob that is contained inside a commit that is reachable from a
> ref, we would need to grep "git rev-list --objects -all" output
> to find it out.  I do not offhand recall what the scripted
> version did, but I would not be surprised if as an approximation
> we did the auto-following by "does the pointee exist" check.

We just did `git cat-file -t`.  If it passed then we followed
the tag.  Which means we could just do a has_sha1_file() test and
call it a day.  If the object is already reachable from our current
refs we'll only download the tag; if it isn't really reachable but
is dangling in the ODB we'll download possibly a lot of objects.

I was trying to make tag auto-following only work if the tag's
target was already completely available and we'd only need to
download the tag object itself.
 
> What "random behaviour" are you trying to fix? 

Apparently I'm introducing even more random behavior.  It may have
just been a bug in the past.  Or a tag whose referred object wasn't
reachable from a ref but I thought it should have been.  Obviously
my patch series resolves neither.

-- 
Shawn.
