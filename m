From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Sun, 10 Apr 2011 15:33:17 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1104101445460.14365@iabervon.org>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 21:33:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90Nw-0002Y2-C7
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab1DJTdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 15:33:19 -0400
Received: from iabervon.org ([66.92.72.58]:56056 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754242Ab1DJTdS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:33:18 -0400
Received: (qmail 26141 invoked by uid 1000); 10 Apr 2011 19:33:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Apr 2011 19:33:17 -0000
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171273>

On Sun, 10 Apr 2011, Ramkumar Ramachandra wrote:

> Hi,
> 
> I've started working on building a sequencer for Git.  While the
> outline is described in [1], I'd like some additional clarifications.
> A big thanks to Christian's series [2] for the valuable roadmap.
> 
> Please note that 10/11 is not related to this series, but seems to be
> a minor nit that's required to make all existing tests pass.

That looks like an actual bug that only doesn't matter currently because 
the function is never called with enough junk on the stack.

> 0. Is the general flow alright?

I suspect it would be easier to review some of this with certain things 
squashed together; one patch that changes all of the variable references 
to what you want them to be is easier to understand than one that moves 
statics to function arguments, one that moves statics to struct fields, 
etc. Likewise, when you're converting some of the die() calls to error(), 
it's easier to review the patch if all of the die() calls that aren't 
changed in that patch don't get changed later in the series.

> 1. Is it okay to use this kind of adaptive error handling (calling
> 'die' in some places and returning error in other places), or should
> it be more uniform?

I think it should be systematic but not necessarily uniform. You should be 
able to give a guideline as to how to decide which to use (and you should 
probably actually give the guideline, so future developers make consistent 
choices). I think of "die" as being ideally for situations where the 
program can't understand what has happened well enough to know what to do 
about it.

> 2. In 11/11, I've used cmd_revert and cmd_rerere.  This is highly
> inelegant, mainly because of the command-line argument parsing
> overhead.  Re-implementing it using more low-level functions doesn't
> seem to be the way to go either: for example, 'reset --hard' has some
> additional logic of writing HEAD and ORIG_HEAD, which I don't want to
> duplicate.  Should I work on reworking parts of 'rerere.c' and
> 'revert.c', or is there some other way?

(ITYM cmd_reset here)

I think rerere.c should get a rerere_clear(). I think it would make sense 
to implement the reset locally; the abort ought to be undoing exactly 
those things that you did, and I'm not actually sure the ORIG_HEAD is 
entirely appropriate. You ought to be able to use cleanup functions that 
correspond to the functions you used to make the mess in the first place.

> 3. From the format of the TODO and DONE files, one more thing should
> be clear- I'm trying to stick to a slight variation of the 'rebase -i'
> format.  This part will go into the sequencer.  Then I'll use a
> cherry-pick specific file to keep the command-line options.  Yes, I'm
> trying to work on Daniel's idea [3] from the very start.  Is this a
> good idea?

I certainly like it. :)

> Thanks for reading.

You're welcome. :)

	-Daniel
*This .sig left intentionally blank*
