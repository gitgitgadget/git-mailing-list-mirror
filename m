From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
	that are corrupted in a pack file
Date: Wed, 7 Jan 2009 17:46:46 -0800
Message-ID: <20090108014646.GD10790@spearce.org>
References: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain> <1231314099.8870.415.camel@starfruit> <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain> <1231376259.8870.633.camel@starfruit> <alpine.LFD.2.00.0901071702190.3283@localhost.localdomain> <alpine.LFD.2.00.0901071726020.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 02:48:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKk0K-0006gI-6E
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 02:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbZAHBqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 20:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbZAHBqs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 20:46:48 -0500
Received: from george.spearce.org ([209.20.77.23]:43582 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbZAHBqr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 20:46:47 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D19C038210; Thu,  8 Jan 2009 01:46:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901071726020.3283@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104869>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 7 Jan 2009, Linus Torvalds wrote:
> > 
> > So there's a few rules to packedgitwindowsize:
> > 
> >  - we need to be able to have at least two windows open at a time, in 
> >    addition to all the "normal" memory git needs just for objects, of 
> >    course. And quite frankly, you'd be better off with a few more windows, 
> >    even if that obviously implies smaller windows.
> 
> Btw, I'm not 100% certain of this. Somebody should double-check me. Maybe 
> there are cases where we want more than two windows alive. And maybe there 
> aren't even that, and we can always make do with just one.
> 
> So I will _not_ guarantee that "at least two pack windows" is necessarily 
> the right answer. The windowing code was mostly other people doing it. I 
> think Shawn and Nico.

I was fairly certain we needed at least two windows open at once,
but reviewing the code in sha1_file.c I don't see a reason for that
restriction anymore.

I think it used to have to do with the delta reconstruction; to
unpack a delta we would read the delta header from one window,
but we may need base data from another.  The delta unpack code
kept the delta window pinned in use, so we couldn't replace it
to access base data from elsewhere, hence we needed two windows.
Thinking about it now I don't recall how we handled the recusion
on a delta chain longer than 2.  ;-)

But looking at the code we have long since refactored it so this
isn't an issue anymore.  We release the window between reading
the delta header and reading the base, so the delta window can be
replaced if necessary.  I think the "2 window minimum" is just a
performance suggestion, not a requirement.

-- 
Shawn.
