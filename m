From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 02:52:19 -0700
Message-ID: <7vbo9g15po.fsf@alter.siamese.dyndns.org>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <vpq38us2oov.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:52:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URg5W-0004H4-CT
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab3DOJwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:52:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3DOJwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:52:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C582E14BBD;
	Mon, 15 Apr 2013 09:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OOr3JGNpTlm/Wp17+lkLAj2n1WE=; b=J0QMc5
	LUTmrtOTo0TK3T7myDhcnwgWjJgTyx27XK2fh6iQEW7mqZX/HmT1UXHcEGuASowJ
	mk7vzwtStm2t4cPn86F/WysuONAGqz3AS9+KjuKOk2kEJJJqJVceX4LSSfCgFY3K
	wrLLd5l9HMYI7DitOAR7CPh2xUlrga2P9XwV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J2KCkUwdzujIXjR1JKfJYgpQTu8SpNUK
	1NGdQCY4lFQBRBmiBH925FFRfHj2wopJrUMFgl6YTXka/r8fQQRdyfk17ooPYeGa
	4uPUqSJ0Yh3Ax/tnn5SaS1CqAhUi+kHJjSLA8e/GRZdbhcpfkXth1s/ySlMzN6p/
	BwCdDukCUbQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8B4D14BBC;
	Mon, 15 Apr 2013 09:52:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2325414BB9; Mon, 15 Apr
 2013 09:52:21 +0000 (UTC)
In-Reply-To: <vpq38us2oov.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 15 Apr 2013 10:17:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A928E96-A5B2-11E2-BFE6-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221216>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> +stash_required () {
>> +	! (git diff-files --quiet --ignore-submodules &&
>> +	git diff-index --quiet --cached HEAD --ignore-submodules)
>> +}
>
> Isn't this too pessimistic? If the local changes do not overlap (in
> terms of files) with the pulled changes, then autosquash is not needed.

Yes, that is why I said for pull-merge, --authsquash is neutral-to-better
and pull.autosquash is harmful.

But for pull-rebase folks, I can understand why this "working tree
must be squeakily clean" logic is appropriate, if we were to do
this. The root cause is because rebase insists to be run on such a
working tree.

And the worst part is that in order to check if local changes
overlap, you need to fetch first. But Ram's annoyance is about the
user being told the merge/rebase cannot proceed _after_ fetch is
done.

> Shouldn't this belong to "git merge" instead (i.e. implement "git merge
> --autosquash" and call it from "git pull")? Users doing "git fetch &&
> git merge" by hand should be able to use --autosquash, I think.

See my other message. I do not think autosquash would help "merge"
folks very much, and will actively hurt when it matters.

> Something should be done for "git rebase" and "git pull --rebase" too.

That I would agree. I am not sure autosquash is the best approach,
but we should be able to help them more.
