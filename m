From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 03 Jul 2013 01:49:56 -0700
Message-ID: <7vli5ogh8r.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
	<CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 03 10:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuInK-0000oP-2N
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 10:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257Ab3GCIwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 04:52:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932284Ab3GCIuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 04:50:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1954C2CC4D;
	Wed,  3 Jul 2013 08:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N9LzwY6ItKFmIoDquBMAeT1afLc=; b=UuYPeo
	JhRXvDIcF0+CYPIS3XWsIj2E6TNJ0dT43dWhxySIfSPyAka/tdqY8d7tBHt3mFzJ
	5eDNj0oCcmevq/rs4kSP39q6gODnuz9bdkAqRdvCJ++kXf4OkTIjf5fF+4TIKRWI
	KdUubKuc9KXdjzPTjRBml5lLwsgHnXDUMwOrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QbJDw524iBNiy0nJns8U76fNwkoFQsRR
	CHRn0O7CfTY/nNH7ZN1ZA+u3zX40Dw14EwNB8aNxYCyDljQ5Z2PyIaVzKWyZq5Gv
	WuqXHZooD7HqrLwUYcTv0dlyzOGixvrZPKnVxlxCQ/bnokj18CXZI758MYixgELn
	RS+bQYNrwnQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DFD02CC4A;
	Wed,  3 Jul 2013 08:50:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 448A22CC48;
	Wed,  3 Jul 2013 08:50:08 +0000 (UTC)
In-Reply-To: <CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
	(Johan Herland's message of "Wed, 3 Jul 2013 08:34:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 903EE2E6-E3BD-11E2-9408-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229469>

Johan Herland <johan@herland.net> writes:

> Overnight, it occured to me that --force-if-expected could be
> simplified by leveraging the existing --force option; for the above
> two examples, respectively:
>
>   $ git push --force --expect
>   # validate foo @ origin == @{upstream} before pushing
>
> and
>
>   $ git push --force --expect=refs/original/foo my_remote HEAD:foo
>   # validate foo @ my_remote == refs/original/foo before pushing

First, on the name.

I do not think either "--validate" or "--expect" is particularly a
good one.  The former lets this feature squat on a good name that
covers a much broader spectrum, forbidding people from adding other
kinds of validation later.  "--expect" is slightly less bad in that
sense; saying "we expect this" does imply "otherwise it is an
unexpected situation and we would fail", but the name still does not
feel ideal.

What is the essense of compare-and-swap?  Perhaps we can find a good
word by thinking that question through.  

To me, it is a way to implement a "lock" on the remote ref without
actually taking a lock (which would leave us open for a stale lock),
and this "lock"-ness is what we want in order to guarantee safety.

So we could perhaps call it "--lockref"?

I'll leave the name open but tentatively use this name in the
following, primarily to see how well it sits on the command line
examples.

Then on the semantics/substance.

I had quite a similar thought as you had while reading your initial
response.  In the most generic form, we would want to be able to
pass necessary information fully via the option, i.e.

	--lockref=theirRefName:expectedValue

but when the option is spelled without details, we could fill in the
default values by making a reasonable guess of what the user could
have meant.  If we only have --lockref without refname nor value,
then we will enable the safety for _all_ refs that we are going to
update during this push.  If we have --lockref=theirRefName without
the expected value for that ref, we will enable the safety only for
the ref (you can give more than one --lockref=theirRefName), and
guess what value we should expect.  If we have a fully specified
option, we do not have to guess the value.

And for the expected value, when we have a tracking branch for the
branch at the remote we are trying to update, its value is a very
good guess of what the user meant.

Note, however, that this is very different from @{upstream}.

You could be pushing a branch "frotz", that is configured to
integrate with "master" taken from "origin", but

 (1) to a branch different from "master" of "origin", e.g.

	$ git push --lockref origin frotz:nitfol
	$ git push --lockref origin :nitfol	;# deleting

 (2) even to a branch of a remote that is different from "origin",
     e.g.

	$ git push --lockref xyzzy frotz:nitfol
	$ git push --lockref xyzzy :nitfol	;# deleting

Even in these case, if you have a remote tracking branch for the
destination (i.e. you have refs/remotes/origin/nitfol in case (1) or
refs/remotes/xyzzy/nitfol in case (2) to be updated by fetching from
origin or xyzzy), we can and should use that value as the default.

There is no room for frotz@{upstream} (or @{upstream} of the current
branch) to get in the picture.

Except when you happen to be pushing with "push.default = upstream",
that is.  But that is a natural consequence of the more generic
check with "our remote tracking branch of the branch we are updating
at the remote" rule.
