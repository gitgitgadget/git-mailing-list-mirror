From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] reset: add option "--keep" to "git reset"
Date: Mon, 18 Jan 2010 21:50:03 -0800
Message-ID: <7vockqbq44.fsf@alter.siamese.dyndns.org>
References: <20100119042404.4510.48855.chriscool@tuxfamily.org>
 <20100119042602.4510.24100.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Daniel Convissor <danielc@analysisandsolutions.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 06:50:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX6z8-00045t-8j
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 06:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab0ASFue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 00:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278Ab0ASFue
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 00:50:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab0ASFud (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 00:50:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BB909022C;
	Tue, 19 Jan 2010 00:50:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZDQVTCCU1OZRUBRbqNsddMY4I5Y=; b=Au4cWU6k2x618XBumzGGmaU
	doO7ZkG0dSzGCyCd9JiiQgUnJxIrX/bUs7lkQ4rf2YcnUToaHEcgI9A5PzjjcfBv
	7OYlD6mrtFrZMCOhLx2F6ohYjx+/NSk8f+k47/PHHspHG4/C7KH5ZhntPktH3V9B
	XQXIs7CJzpGKUiJQbXWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wbpfquxnfp8KoyQNs46bnX2wEWOgOZ/GQ+Y1IMc9JfxBo8aKS
	ukFzrNcvxL3yrjDD7Kh/Se/jRObByzdLgAErFFsU6FFFztMn11Gtimq9pCKk1WJI
	Pr4Etp5+q0hRnRi3uebjnCJABPfPfbODz3ClGfZgwoBDej/0iNXg1yvcPE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99CDC90223;
	Tue, 19 Jan 2010 00:50:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89FAB9021C; Tue, 19 Jan
 2010 00:50:05 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 86C779F8-04BE-11DF-B508-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137427>

Christian Couder <chriscool@tuxfamily.org> writes:

> The purpose of this new option is to discard some of the
> last commits but to keep current changes in the work tree.
>
> The use case is when you work on something and commit
> that work. And then you work on something else that touches
> other files, but you don't commit it yet. Then you realize
> that what you commited when you worked on the first thing
> is not good or belongs to another branch.
>
> So you want to get rid of the previous commits (at least in
> the current branch) but you want to make sure that you keep
> the changes you have in the work tree.

You did this:

	git checkout master
	work; git commit ; work; git commit ; work; git commit
	edit ; git add ; ... (but not commit)

and noticed the three commits should not be on master but on a new branch.

I think we currently teach users to do something like this:

	git stash
        git branch topic
        git reset --hard HEAD~3
        git stash pop

Instead you want to do this:

	git branch topic
        git reset --keep HEAD~3

Surely you halved the number of command involved, but is this really an
improvement?  At least I can visualize (and more importantly, explain to
new users) how the "stash, flip and unstash" works, why it is safe, and
how to recover when "pop" stops in conflicts, but I have no confidence in
explaining what "reset --keep" does and how to recover when it refuses to
work to new users.

Another way to accomplish the same thing might be:

	git branch -m topic
        git checkout -b master HEAD~3

and with the same number of commands, conceptually it may be easier to
understand than "reset --keep".  What you committed so far belongs to
another branch "topic", so you name the current history that way, and then
you switch branches with "checkout" that keeps your local modifications.
It also opens the possibility of retrying with "-m" after checkout refuses
to acti, to take the same mix-up risk CVS/SVN users have, if you are very
confident that your local change conflicts only minimally with the change
made on the topic and you can resolve them.

Of course, when you are not interested in keeping the topmost commits at
all, you either

	git stash ; git reset --hard HEAD~3 ; git stash pop

or

	git reset --keep HEAD~3

but even in this case, I think "stash, flip and unstash" is easier to
explain, especially when teaching what to do if things go wrong.

I dunno.  Is this really an useful addition that helps real-world
workflows and is worth a five patch series, or is this just "because we
can" patch?
