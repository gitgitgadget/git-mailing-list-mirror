From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with NO_MMAP
Date: Sun, 20 Jan 2008 23:10:31 -0500
Message-ID: <20080121041031.GF24004@spearce.org>
References: <20080118035700.GA3458@spearce.org> <7vtzlbirz0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 05:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGo04-0004aG-Ol
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 05:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbYAUEKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 23:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756701AbYAUEKk
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 23:10:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55290 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682AbYAUEKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 23:10:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JGnzL-0005Mb-8C; Sun, 20 Jan 2008 23:10:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 542C820FBAE; Sun, 20 Jan 2008 23:10:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vtzlbirz0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71213>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > +extern void close_pack_windows(struct packed_git *, int);
> 
> Nobody seems to pass anything but true in retain_fd parameter.
> Is it worth it?

Hmm, well, I originally wrote something like what you fixed it
to be, then thought that at some point in the future someone may
try to invoke the method and expect different semantics than it
implemented.  :-)

In short I made the implementation I gave you way too complex.
 
> So I'd prefer something much simpler like this one instead...
> 
> void close_pack_windows(struct packed_git *p)
> {
> 	while (p->windows) {
> 		struct pack_window *w = p->windows;
> 
> 		if (w->inuse_cnt)
> 			die("pack '%s' still has outstanding windows",
> 				p->pack_name)
> 		munmap(w->base, w->len);
> 		pack_mapped -= w->len;
> 		pack_open_windows--;
> 		p->windows = w->next;
> 		free(w);
> 	}
> }

Me too.  Thank you for the sanity check, and for fixing the
code to actually be somewhat sane.

-- 
Shawn.
