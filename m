From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 03/11] Use new compress helpers in fast-import
Date: Sun, 3 Feb 2008 20:48:50 -0500
Message-ID: <20080204014849.GG24004@spearce.org>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com> <1201952156-6764-2-git-send-email-mcostalba@gmail.com> <1201952156-6764-3-git-send-email-mcostalba@gmail.com> <7v3as9slc6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 02:49:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLqSh-0004RA-9Q
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 02:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbYBDBs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 20:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754738AbYBDBs6
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 20:48:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58386 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbYBDBs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 20:48:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JLqRz-0001wd-3G; Sun, 03 Feb 2008 20:48:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E4D6320FBAE; Sun,  3 Feb 2008 20:48:50 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v3as9slc6.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72448>

Junio C Hamano <gitster@pobox.com> wrote:
> Marco Costalba <mcostalba@gmail.com> writes:
> 
> > Here is slightly more difficult, in particular
> > a xrealloc() has been substituted with a
> > free() + xmalloc() to keep the code simple.
> >
> > Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> > ---
> >  fast-import.c |   45 +++++++++++++++------------------------------
> >  1 files changed, 15 insertions(+), 30 deletions(-)
> 
> I'll let Shawn comment on this.  The realloc() does not seem to
> be using the contents in the buffer from the previous round, so
> I suspect that a free() followed by an independent alloc() would
> be an improvement when the later call uses much larger buffer
> than the previous one, but would be a waste if the later one
> needs smaller buffer.

Junio is correct, that xrealloc isn't using the contents of the
buffer from the last round, which makes any memcpy it might do
internally due to movement to a larger buffer an utter waste.

In this new version we are probably always free'ing a buffer of a
much smaller size than we are then later allocating (or in the old
version xrealloc'ing to) because we are switching from a delta to
full content.  Its most likely the delta is way smaller, so I'd
guess the malloc implementation is mostly going to another buffer.
In short, Marco's change will most likely do better.

But this is all academic wanking.  We're talking about this xrealloc
(or free/xmalloc pair) happening only when we switch packfiles,
which in fast-import is usually every 4 GiB of output.  That's a
*lot* of data to write.  Who cares how many extra microseconds we
spend to perform this buffer change; we probably hit it only once
every 15-30 minutes, depending on how fast your system is able to
transfer 4 GiB of data out of the source and into a packfile.

-- 
Shawn.
