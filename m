From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Tue, 31 Mar 2015 09:28:36 -0700
Message-ID: <xmqqh9t1rv0r.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<871tkblapv.fsf@javad.com> <55147D27.1060204@kdbg.org>
	<87lhidlebw.fsf@javad.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 18:28:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycz25-0000yR-H5
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 18:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbbCaQ2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 12:28:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754447AbbCaQ2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 12:28:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 851DC43F80;
	Tue, 31 Mar 2015 12:28:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GQ31HH/iLnoBzuRdy2sonU6BbaI=; b=aaqvDV
	Nty6V4qWlXtJaRkDWirEY3VodivssNywuV0lbcYo8mdFqNVNPB78nPPKL0eeLOLt
	TmAXOXeszfHFEwAqtw7LI1lkUSZn6jt7Dw1mSbMckdIE9n7HHOjGHEqJ1Sr1DFh1
	2zogUZUKv7IRjqhWV4twofWJxD5hKKce+yN6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tc6ueCj9BYMzZrZrihPtkEI1ynjVWWQs
	m+ogIqc2qB4RtMrqi2taEWFmiU+DQM6ASCAlrR1mbOn13o/VYwJz7ZCgo84xHckJ
	wcBiIeKvmR+qW2QPEtAZPXmO5/sM5DR6r9e1UiywufbyXNAxXPNw7GOutJANWQ9w
	EyVKRGmM8aA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CC3A43F7F;
	Tue, 31 Mar 2015 12:28:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC4A743F7E;
	Tue, 31 Mar 2015 12:28:37 -0400 (EDT)
In-Reply-To: <87lhidlebw.fsf@javad.com> (Sergey Organov's message of "Tue, 31
	Mar 2015 12:13:23 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC05DF98-D7C2-11E4-9D36-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266528>

Sergey Organov <sorganov@gmail.com> writes:

> 1. How to calculate the set of commits to rebase.
>
> 2. How to rebase merge commits.
>
> Can we leave (1) for a while at its current state and focus on (2)?

Perhaps.  You would have to be careful though, so let me think aloud
a bit...

Suppose you started from an upstream history whose tip was B, and
you worked on merging some changes X an Y you made earlier on a side
branch.

         X---Y
        /     \
   O---A---B---Z---

In the meantime, the upstream history has advance and now it looks
like this:

   O---A---B---C---D

You want to forward-port the change done by X, Y on the side branch
and its merge Z on top of D, right?

In other words, you want to have this:

         X-----------Y
        /             \
   O---A---B---C---D---Z'

In this case, replaying the difference going from B to Z on top of D
may be better than redoing a merge between Y and D, in that the
former will carry evil merges and resolution of conflict forward.

I wonder if it will be the right way to get a correct result to
apply the difference to go from B to Z on top of an old commit when
you are side-porting.

Imagine you want to backport the same X-Y history by redoing the
merge Z on top of another child of O (i.e. A's sibling).  That is,
you start from this:


         X---Y
        /     \
   O---A---B---Z---
    \
     M---N

and would want to create this:
    
    
   O           X'--Y'
    \         /     \    
     M---N---A'--B'--Z'--

As long as everything down to the merge-base of the parents of the
original merge (in this example, merge-base across Y and B that are
Z's parents, which is A) is being transplanted, "apply the
difference going from B to Z, on top of B', to obtain Z'" should
work, I would think.
