From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/5] prune-packed: don't call display_progress() for every file
Date: Wed, 31 Oct 2007 22:58:30 -0400
Message-ID: <20071101025830.GX14735@spearce.org>
References: <1193770655-20492-1-git-send-email-nico@cam.org> <1193770655-20492-2-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 03:58:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InQGl-00040T-T6
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 03:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbXKAC6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 22:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbXKAC6k
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 22:58:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44464 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbXKAC6j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 22:58:39 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1InQGD-00037N-6R; Wed, 31 Oct 2007 22:58:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 47C7020FBAE; Wed, 31 Oct 2007 22:58:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1193770655-20492-2-git-send-email-nico@cam.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62908>

Nicolas Pitre <nico@cam.org> wrote:
> The progress count is per fanout directory, so it is useless to call
> it for every file as the count doesn't change that often.

If you go back into the history and look at the commit message for
when I introduced this per-object display_progress() call we find
the following:

 commit b5d72f0a4cd3cce945ca0d37e4fa0ebbfcdcdb52
 Author: Shawn O. Pearce <spearce@spearce.org>
 Date:   Fri Oct 19 00:08:37 2007 -0400

[...snip...]
    We perform the display_progress() call from within the very innermost
    loop in case we spend more than 1 second within any single object
    directory.  This ensures that a progress_update event from the
    timer will still trigger in a timely fashion and allow the user to
    see the progress meter.

During my testing with a 40,000 loose object case (yea, I fully
unpacked a git.git clone I had laying around) my system stalled
hard in the first object directory.  A *lot* longer than 1 second.
So I got no progress meter for a long time, and then a progress
meter appeared on the second directory.

The display_progress() call already does a reasonably cheap
comparsion to see if the timer has tripped or if the percent complete
has changed.  So I figured it was more useful to get feedback to
the user that we were working, but were going to take a while,
than it was to optimize a few machine instructions out of that
inner-most per-object loop.

So I'm a little against this patch.  But I think I understand why
you think its worth doing.  I just consider the progress feedback
more important than the few machine cycles avoiding it saves.
 
-- 
Shawn.
