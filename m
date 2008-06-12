From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 16:27:50 -0500
Message-ID: <tTKBrUhaELJElLgsC8Wvr60D-bMFtfyvc87q5ZYW35M@cipher.nrlssc.navy.mil>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 23:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6uM3-0001My-4T
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 23:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbYFLV2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 17:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbYFLV2R
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 17:28:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54920 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbYFLV2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 17:28:16 -0400
Received: by mail.nrlssc.navy.mil id m5CLRo5P028877; Thu, 12 Jun 2008 16:27:50 -0500
In-Reply-To: <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Jun 2008 21:27:50.0461 (UTC) FILETIME=[2A94A6D0:01C8CCD3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84799>

Junio C Hamano wrote:
> Wincent Colaiuta <win@wincent.com> writes:
> 
>> So yes, branches _are_ better and more appropriate for long term  
>> storage than stashes, but even so I don't think it's right for us to  
>> risk throwing away information that the user explicitly stashed and  
>> expected Git to look after for them.
> 
> Yes, but for a limited amount of time.

The fact that this caveat is not mentioned anywhere in the stash
documentation or anywhere in the commit log related to git-stash.sh makes
me think that this idea of 'a limited amount of time' was possibly not a
design decision but merely a side effect of stashes being implemented using the
reflog. Of course I didn't pay any attention to the discussions about stash
back when it was implemented, so I may definitely be wrong.

I'm not sure what the drawback is for persistent stashes though. This is
what I can think of:

  - enlarges repository size by retaining cruft referenced by old stashes
  - encourages bad workflows
  - behaves in a way that is not expected or preferred by the user
  - overly complicates code

The first item I think is somewhat irrelevant. There are many ways that a user
could cause repository size growth, and as Wincent suggested, the increase in
size of the list of stashes is an incentive to clean it up. And in the case of
user generated data, the definition of cruft should be left to the user.

I don't think the second item is true. I don't think any particular work flow
is being encouraged here.

The third item is the one I think is the most important. I think this is a user
interface issue. "Does git do what the user _expects_ git to do?". I offered one
example where the current behavior would produce a result that was likely not
expected by the user and possibly not desired by the user. I think a counter
example (one that would argue against the suggested change in behavior), is if
it were true that if I were to create a stash today, and then be surprised 30
days from now when I do a 'stash list' and find the stash is still there.
Something along the lines of:

   $ git stash save my work
   # wait 30 days
   $ git stash list
   stash@{0}: WIP on master: my work

   # and if my reaction were something like:
   # hmm, that's strange, what is that stash still doing there? It's been 30 days,
   # it should be gone.

btw, that _is_ the current behavior if 'reflog expire' hasn't been run yet for
some reason. Someone who only allows the auto gc to clean their repository would'nt
know any difference.

-brandon
