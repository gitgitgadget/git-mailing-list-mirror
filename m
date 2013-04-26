From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Itches with the current rev spec
Date: Fri, 26 Apr 2013 10:49:03 -0700
Message-ID: <7v7gjpxjw0.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
	<20130426101946.433f2d12@chalon.bertin.fr>
	<517A3E47.6010606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Apr 26 19:49:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVmlk-0003wG-DV
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 19:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080Ab3DZRtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 13:49:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932073Ab3DZRtG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 13:49:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85D781A2E9;
	Fri, 26 Apr 2013 17:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=8+xH2tT3/1xoFCwfJw1ZpduE9oY=; b=LQn3hN1RYnGa0SqRuXyM
	XNjqla3aaJ+9bVb/qgxZwNS/V0cPzV5b9t5Th8e1jJdVCxxxJGSobHFIW4ehq8L6
	RG4WSy1fCEDfbtq2O1PLNqCW8eltgrQX06xUDjT+NTAEiPXkDhi3D16ulBnDqZTY
	I+7RHo6Rhy7iS3WOymogi40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VS3vMgASCkPvxj+639kK+HHX8DkOi76nfsSuS/YQFDO64r
	6VUfsTbS38KfSzusVkXEUy6idM3tbVbsFnCjkPvpX7oEP1FKgpyt6/4jEDT7Pkxl
	KUtyiZC0oWDmAYvSCgj0hcMJdBJy/9RPRR4db1taT7lHYwrnSEnAE65DdsXec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 799611A2E8;
	Fri, 26 Apr 2013 17:49:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9FFA1A2E7;
	Fri, 26 Apr 2013 17:49:04 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 964789C6-AE99-11E2-9DEE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222545>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Allow alternative spelling of
>
>    git rebase -i master topic
>
> like this:
>
>    git rebase -i master..topic
>
> (as always, the default for topic is HEAD).

I actually made this typo a few times in the past.

In a single-strand-of-pearls history, what rebase operates on is
clearly a _range_ with a defined linear order of commits, and
master..topic is a natural way to express it.

And rebase not just needs the range that defines the set of commits
to be replayed, but also needs the commit on top of which they are
replayed.  It is natural to take ^master as that commit, and it is
useful when you are trying to catch up with that branch.  

The reason you would use "rebase -i" is not for catching up [*1*],
so defaulting to replay onto ^master is not useful.  You want the
command to replay on top of the stable same base, so that you can
compare the result with the previous version in order to verify.
Often, the fork-point with master is a good choice for that.

It is tempting to say that "rebase -i" and normal catch-up "rebase"
(e.g. "pull --rebase") should have designed to behave differently.
"git rebase -i master" perhaps should have made to rebase the
current work on top of the fork-point from master, not on top of it,
and require an explict --onto master if the user does want to also
catch up.

But the above is orthogonal to the syntax "../..." issue.


[Footnote]

*1* "rebase" and "rebase -i" already behave slightly differently
with respect to $onto" in that a catch-up rebase that is already up
to date notices the situation and turns into a no-op, but it does
not turn "rebase -i" into a no-op for this exact reason.
