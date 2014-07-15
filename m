From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase: omit patch-identical commits with --fork-point
Date: Tue, 15 Jul 2014 15:06:01 -0700
Message-ID: <xmqqmwcatgza.fsf@gitster.dls.corp.google.com>
References: <20140707211456.GA2322@serenity.lan>
	<47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405451643.git.john@keeping.me.uk>
	<01d69c566e04256fb0321ab9685d1f05a80cb41d.1405451643.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ted Felix <ted@tedfelix.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jul 16 00:06:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7As2-00083X-O7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 00:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759886AbaGOWGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 18:06:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54499 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759883AbaGOWGI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 18:06:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80E352768B;
	Tue, 15 Jul 2014 18:05:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yNIGaMbhafp0xKzBeJ8lFqvwkwU=; b=Ty22f/
	W+cj4w3IVcjBfzOWiBZMZGcrInyQOh2V4O9tcKAsC04iWPod6EWQJvOVBL4DEiwB
	b+4JP/h0PyKzCooKD7jlzgBqlgH+ez40hbeCeHhu1Jckl8ibsXK3hX/rHhg/0R8K
	1tT/zfivxMpR0IUS9rS06qCRb0p2j08gzdEtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZiVt9Pn4/tmoftX4yhQtOBk70gVZb5T+
	iwmo5Gy3aCCk7Dm1Q9N3lc6fKgJgM0b1CwyYiqJXBFIol/gv7QSdGqG1UK/L+SnN
	KejiezwiHHKCD4kRK0aV4WzT+fuyP7/sc5izjfuNbQyl+ZzhTNp5WPfGARowvR76
	prjjZRBIa8k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 768672768A;
	Tue, 15 Jul 2014 18:05:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 014E62767C;
	Tue, 15 Jul 2014 18:05:44 -0400 (EDT)
In-Reply-To: <01d69c566e04256fb0321ab9685d1f05a80cb41d.1405451643.git.john@keeping.me.uk>
	(John Keeping's message of "Tue, 15 Jul 2014 20:14:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B49439E-0C6C-11E4-972A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253608>

John Keeping <john@keeping.me.uk> writes:

> When the `--fork-point` argument was added to `git rebase`, we changed
> the value of $upstream to be the fork point instead of the point from
> which we want to rebase.  When $orig_head..$upstream is empty this does
> not change the behaviour, but when there are new changes in the upstream
> we are no longer checking if any of them are patch-identical with
> changes in $upstream..$orig_head.
>
> Fix this by introducing a new variable to hold the fork point and using
> this to restrict the range as an extra (negative) revision argument so
> that the set of desired revisions becomes (in fork-point mode):
>
> 	git rev-list --cherry-pick --right-only \
> 		$upstream...$orig_head ^$fork_point
>
> This allows us to correctly handle the scenario where we have the
> following topology:
>
> 	    C --- D --- E  <- dev
> 	   /
> 	  B  <- master@{1}
> 	 /
> 	o --- B' --- C* --- D*  <- master
>
> where:
> - B' is a fixed-up version of B that is not patch-identical with B;
> - C* and D* are patch-identical to C and D respectively and conflict
>   textually if applied in the wrong order;
> - E depends textually on D.
>
> The correct result of `git rebase master dev` is that B is identified as
> the fork-point of dev and master, so that C, D, E are the commits that
> need to be replayed onto master; but C and D are patch-identical with C*
> and D* and so can be dropped, so that the end result is:
>
> 	o --- B' --- C* --- D* --- E  <- dev
>
> If the fork-point is not identified, then picking B onto a branch
> containing B' results in a conflict and if the patch-identical commits
> are not correctly identified then picking C onto a branch containing D
> (or equivalently D*) results in a conflict.
>
> This change allows us to handle both of these cases, where previously we
> either identified the fork-point (with `--fork-point`) but not the
> patch-identical commits *or* (with `--no-fork-point`) identified the
> patch-identical commits but not the fact that master had been rewritten.
>
> Reported-by: Ted Felix <ted@tedfelix.com>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  git-rebase--am.sh          | 6 ++++--
>  git-rebase--interactive.sh | 2 +-
>  git-rebase.sh              | 7 ++++---
>  3 files changed, 9 insertions(+), 6 deletions(-)

Can we have some tests, too?

The changes look correct from a cursory reading.

Thanks.
