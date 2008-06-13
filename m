From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 12:21:20 -0700
Message-ID: <7v3anhuonj.fsf@gitster.siamese.dyndns.org>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net> <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org> <bd6139dc0806130333n2cfbc564k79ed5562f14fc848@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, "Andreas Ericsson" <ae@op5.se>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Eric Raible" <raible@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Jun 13 21:22:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ErD-0006gT-OQ
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 21:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbYFMTVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 15:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbYFMTVk
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 15:21:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbYFMTVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 15:21:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF4C736C5;
	Fri, 13 Jun 2008 15:21:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C81B436C2; Fri, 13 Jun 2008 15:21:27 -0400 (EDT)
In-Reply-To: <bd6139dc0806130333n2cfbc564k79ed5562f14fc848@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri, 13 Jun 2008 12:33:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F08127C6-397D-11DD-95B2-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84933>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Fri, Jun 13, 2008 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> <big snip>
>
>> But let's not talk nor think about per-branch stash for now.  How does the
>> "keep" thing sound to people?
>
> I'm divided on this:
>  OOH: I like the idea of having a keep command to mark stashes as
> valuable, making them not expire until dropped explicitly. Such a
> feature would also encourage user to go through their stashes every
> now and then and decide which ones are valuable, and which ones were
> indeed not that valuable and may be dropped.
>
>  OTOH: I dislike the idea of 'forcing' the users to go through their
> stashes lest they lose their work.

The latter argument is somewhat misguided.

To stash is like putting something in /tmp on a system that runs a cron
job to clean out cruft from there once in a while.  Another analogy is to
spitting an information out to syslog, so that it is kept until logs are
rotated.

If you want permanent storage, you do not store it in somewhere that is
designed to have automated rotation or pruning.  Instead, you would create
a file somewhere in your $HOME or use a branch.  It is natural that you do
not have perfect foresight --- so after putting something in /tmp, you may
wish that you can somehow say retroactively that some things you placed
earlier in /tmp are more valuable than others.  "keep" was an example of
how you _could_ express that wish.  In other words, you are not _forced_
to, but you are merely given an opportunity to do so.

I do not personally care too deeply about the "keep" approach.  An easier
to explain (and perhaps easier to implement, too) alternative would be to
have a per-ref configuration variable that specifies the reflog retention
period per ref, e.g. "git config reflog.refs/stash.expire never".

I however mildly suspect that the stash configured as such would end up to
be a lot worse than the current behaviour in practice.  It would make
crufts easily accumulate in the stash, making it harder to find gems, and
as a consequence of that, encouraging you to say "stash clean" or "stash
drop" more often, risking accidental removal of what you did not intend
to (for this exact reason I earlier  -- much earlier than the current
thread -- even thought about suggesting to make the reflog expiry period
much shorter than the usual ref).

But at that point it is user shooting his foot off ;-)
