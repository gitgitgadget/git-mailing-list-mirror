From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 26 Dec 2006 11:52:56 -0800
Message-ID: <7vwt4ecu3r.fsf@assigned-by-dhcp.cox.net>
References: <7vmz5bfidj.fsf@assigned-by-dhcp.cox.net>
	<emr0bt$hcb$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 20:53:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzIM9-0002x5-88
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 20:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbWLZTw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 14:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932775AbWLZTw6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 14:52:58 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47949 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932767AbWLZTw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 14:52:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061226195256.CAAX25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Dec 2006 14:52:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3Xt91W0171kojtg0000000; Tue, 26 Dec 2006 14:53:10 -0500
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <emr0bt$hcb$2@sea.gmane.org> (Jakub Narebski's message of "Tue,
	26 Dec 2006 12:20:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35430>

Jakub Narebski <jnareb@gmail.com> writes:

> I'd still like the preserving reflogged data during pruning and
> repacking to be optional (default to on).

What does that really _mean_?

Some time after reflog was introduced, you started talking about
it on #git channel saying "you could refer to master@{yesterday}
to get it back, but only unless you pruned".

I think that behaviour was a bug, which was there only because
reflog was bolted onto the plumbing as an afterthought.  If the
data reflog keeps is integral part of git (and in v1.5.0 we are
making it so by turning it on by default), you should not have
to say "but only unless" part, which indicates loss of useful
information.

So you either keep objects that reflog entries need, or you
discard reflog entries that point at them when you discard
certain objects you do not need anymore.  Removing objects
without removing reflog entries that become stale because of
missing objects takes us back to the "bolted on, not really
integrated" situation.  It makes reflog "sometimes work but only
sometimes", and most likely it does not work when the user most
wants it to.

With the current code in 'next', you can discard unwanted reflog
entries using "reflog expire", and then do prune/repack, and can
be assured that the objects that remaining reflog entries want
are still there (modulo bugs -- at least that is the intent).
You could update prune/repack so that they do not look at reflog
data, and have them also remove reflog entries that have become
stale after they do their primary things (either pruning or
repacking), as part of the same invocation.  I will not code
that for you because I do not think it is an improvement over
what we have now (for one thing, you cannot prune selectively,
as I already said).

> But failing that I'd
> like to have option to "reflog expire" to remove only specific
> (pattern match, prefix match?) entries, for example to remove
> all the "commit --amend" and StGIT work, but leaving rebases,
> resets, merges and other stuff.

I would say "Patches welcome"; this is not from my sarcastic
side but because I suspect there might be a remote chance that
it might turn out to be useful in some situation.  It is just
that my suspicion is not strong enough to tempt me to do so
myself, because I think that even with such an elaborate
selection mechanism in place, what the users would do in
practice would boil down to what --expire-unreachable does.
