From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Thu, 24 May 2012 14:34:49 -0700
Message-ID: <7vaa0xw9dy.fsf@alter.siamese.dyndns.org>
References: <4FBAA33D.1080703@kdbg.org>
 <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com>
 <7vzk8yzq35.fsf@alter.siamese.dyndns.org>
 <CAOeW2eGvEaQYk9KODmLzZuEBu-KhKcQeL4PE-4YHwSgtP0dJfA@mail.gmail.com>
 <7vehq9xz7a.fsf@alter.siamese.dyndns.org>
 <CAOeW2eH85+qa2PXS55_xGwH+tpMDMEK76HywfpLTYrv_Dtg49Q@mail.gmail.com>
 <4FBE9AC7.3010506@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu May 24 23:35:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXfgR-0001I8-3j
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 23:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965628Ab2EXVex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 17:34:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965561Ab2EXVew (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 17:34:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A07E9D9C;
	Thu, 24 May 2012 17:34:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9wjtheW+x8UrJYArxf2EDo1WDxQ=; b=eYYpOW
	LZNDuNDMw0sxkgUas41WY3lS+g+beuvqlkyk4IO092Bl9p+zZH7qCcu86PObAOlW
	sekyenRmQ/01fNSI5wHXn0FtFb5SIWOwBm/fu8eVEP9xEpOWU6m1AJ9CpWEM8nMH
	8STR/mfHEWh04GslYLHXRDmB3StNPdpF4USYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=veD85d7zWsqK74kzuNzI2OZ/NSJmrNSe
	pjlc7ohcjMO/pgVyTarOmXD1B17otYR+oGtvu7bE697SaiBQss+7WAwOlumjorIv
	7I6wFzAPPrOZKw3HlVQayNo7Wr6BGr1uRdyyop/sY8pHiOOnNf1fwxyhM1+ZEXsR
	gS0gbs5F838=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 310EA9D9B;
	Thu, 24 May 2012 17:34:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B80519D9A; Thu, 24 May 2012
 17:34:50 -0400 (EDT)
In-Reply-To: <4FBE9AC7.3010506@kdbg.org> (Johannes Sixt's message of "Thu, 24
 May 2012 22:32:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B08298A-A5E8-11E1-BA55-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198434>

Johannes Sixt <j6t@kdbg.org> writes:

> Today I was able to use rebase -i -p in the field. I used it to rebuild
> an integration branch (akin to git's pu branch). Guess what? It did not
> work as expected:
>
> Two of the topic branches' early parts were already merged in the
> upstream. The instruction sheet had only 'pick' of merge commits for the
> topics. Except for these two; there, all commits (that were not yet in
> upstream) were offered to pick, including the merge commit.
>
> I started with this:
>
>     A--M--o--o   <- master
>    /  /
> --o--X--Y        <- side branch (partially merged in master)
>    \     \
>     R--S--N--T   <- integration (to be rebuilt on master)
>
> I wanted this:
>
>      A--M--o--o
>     /  /       \
>    /  /          R'--S'--N'--T'
> --o--X--Y---------------´

It is unclear what exact revisions you gave to rebase, but I am assuming
that you asked "rebase --onto master X^ T" (you can use R^ instead of X^;
they refer to the same commit).

It is straightforward to see what should happen to R and S; they should be
a straight replay of single parent commit on top of 'master'.  

But it is unclear what should happen to X and Y.

When you are rebasing the X^..T sub-DAG, can you say what makes S more
special than Y by looking at the original topology?  Your "I wanted this"
picture depicts S' to be rewritten but Y stays the same.  Why?  

They are both in the X^..T DAG, and neither of them is merged to 'master'.
I can sort of see why X and R would be treated differently (X is part of
master, R is not), but I cannot justify why your "I wanted this" picture
replays S' without replaying Y'.

What am I missing?

> But I got this:
>
>     A--M--o--o-------Y'
>    /  /       \       \
> --o--X--Y      R'--S'--N'--T'

Which is what I would expect, from the "Y and S play a similar role in the
sub-DAG X^..T in the original DAG, with respect to master" point of view.
