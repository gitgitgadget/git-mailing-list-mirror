From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recommendation for patch maintenance
Date: Fri, 21 Dec 2012 10:17:09 -0800
Message-ID: <7vip7v1d96.fsf@alter.siamese.dyndns.org>
References: <50D475EF.6060303@gmail.com>
 <7vvcbv1grr.fsf@alter.siamese.dyndns.org> <50D49C81.5060007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 19:17:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm7AC-0001Ev-FW
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 19:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab2LUSRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 13:17:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab2LUSRV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 13:17:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F2FDA221;
	Fri, 21 Dec 2012 13:17:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T7IMdoVal2T3BSxMxZew5zWhy/A=; b=Z2YGdC
	DL8DaIYb7jDaP/mk/YlB5kPqTJbiHk3luP/AvnotZxqLjCvtQovhqAapgfXJsSRT
	T+OYZBJOMNqZbDhJjXCfuoolsAa1305Sn4GqqFqToPWgVyzGEo38y4k8qu9B3s82
	JIGoMU/34wtSyIvsNYRSQmfZYEJkBa8J/5JwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KIa0KLd+yTf5BhlhnIPoNXAxmbTfFRls
	0XvIx6AFGlwee7m1VUxjfj/HYtqqeKfEIXMki1KnhG1JpmAVmyNjqbcnt994vRCp
	xcPyER1TUqy+w5FiOUISW3B66xX3CvuVlRV6IBtF4mBYwGRJ8v9xbeFo9N37sJrU
	UrVqbbvIMEs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BA34A21F;
	Fri, 21 Dec 2012 13:17:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF58AA216; Fri, 21 Dec 2012
 13:17:16 -0500 (EST)
In-Reply-To: <50D49C81.5060007@gmail.com> (Manlio Perillo's message of "Fri,
 21 Dec 2012 18:29:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6B68FD0-4B9A-11E2-930A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211997>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> I lose the history of all the changes I have made to produce the final
> version of a patch.
>
> Since for every new version of a patch I do a commit --amend, I can not
> see, as an example, the changes I have made between x and y versions of
> a patch.
>
> Of course the commits are not really lost, but I have to search them
> using the reflog.

Yeah, these days with "rebase -i" that does not leave individual
steps as separate reflog entries, for an easy series, you can do
things like:

    $ git rebase -i ;# work on polishing the series
    $ git show-branch -g ;# view where it diverged
    $ git diff HEAD~4 @{1}~4

Of course you can plan ahead (this is what I usually do when working
on a series that is not "how about this" throw-away patch I send to
this list all the time) and name the topic "topic-v1", fork the new
round "topic-v2", "topic-v3", etc. and do things like

    $ sh -c 'git diff topic-v2~$1 topic-v3~$1' - 4

(the point being that then you do ^P or whatever shell command
history mechanism to recall that line, edit "4" to "3" and rerun the
comparison for other corresponding ones).

On a related but different front, I've been thinking about improving
the "format-patch --subject-prefix" mechanism to make it even easier
to use.  With the current interface, when you prepare your reroll,
you would do:

    $ git format-patch --cover-letter \
        --subject-prefix='PATCH v4' -o ./+mp master

and end up overwriting the patches from the previous round (if their
subject did not change).  You will always overwrite the cover
because its subject never changes and that is where the filename is
taken from.

What if we added another option, say --reroll $n (or -v$n), to let
you write:

    $ git format-patch --cover-letter -v4 -o ./+mp master

that produces output files named like:

    ./+mp/v4-0000-cover-letter.txt
    ./+mp/v4-0001-git-completion.bash.add-support-for-pa.txt

with the subject '[PATCH v4]' prefix?

Then you can transplant the cover letter material from the cover
letter from the older iteration to the new cover letter in your
editor, and sending them out will become

    $ git send-email ... ./+mp/v4-*.txt

Hmm?
