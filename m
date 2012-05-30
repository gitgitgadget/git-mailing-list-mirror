From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] improve no-op push output
Date: Wed, 30 May 2012 10:52:28 -0700
Message-ID: <7vr4u1zhcz.fsf@alter.siamese.dyndns.org>
References: <20120530120804.GA3501@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 30 19:52:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZn4X-0001yN-5i
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 19:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859Ab2E3Rwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 13:52:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756281Ab2E3Rwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 13:52:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE4F786D5;
	Wed, 30 May 2012 13:52:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JDSrNKYIG7uX/Mqeaxfhmer+sHE=; b=D9BERh
	Wd1SupBvDCiuGT5d7S3VZFJRQmE7fW7qdA6Vr8wf5iMs3oYzQC+8/uwFleI/KJvW
	DaIsIxzB+X+EwlE2qIyumXiMg3akUY6u2fJyGsZY7Clo+YJWNMUxk55ZKpy3NNdf
	bfoH1hf2eHR3ad1vsdF5V6GcFRIZgmXm1+xSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=plQjtT20I5206W5vTxKprRDnfIJs6Dd9
	eAkt773km8oayVUWpA7Ika+bd54TcVT0daHHgu/qdNSH/FG12hIUaTy1ydKF9ewU
	nJAIszSvSePsyETqTZXQqimlhMivLMCK9FNKN+D5OXe2nIUzCXCMta8ZBmlYK0OB
	8FCDPO5QLIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B532686D4;
	Wed, 30 May 2012 13:52:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45FF186D3; Wed, 30 May 2012
 13:52:30 -0400 (EDT)
In-Reply-To: <20120530120804.GA3501@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 May 2012 08:08:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39F8E372-AA80-11E1-A151-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198826>

Jeff King <peff@peff.net> writes:

> I noticed the mention of the "Everything up-to-date" message in a nearby
> thread. This patch doesn't help with the case there, but it made me
> think about how vague that message is.
>
> -- >8 --
> When a push is a no-op because all refs are up-to-date, we print
> "Everything up-to-date". That is reasonable when push.default is
> "matching" (or when a wildcard refspec is given), because "Everything"
> pretty obviously means "everything you asked git to push".
>
> But when one of the single-ref push.default modes is used, the
> "Everything" is slightly misleading; we only tried to push one thing,
> and we should not give the user the impression that the remote is
> completely in sync with what is in their local repo.
>
> Instead, let's detect the case that we attempted to push a single ref,
> and if so, just show the verbose status table (which includes the
> up-to-date ref). We don't want to show it if we tried to push many refs,
> because it could be quite long (e.g., in the case of "matching").
>
> ---
> So before, running:
>
>   git init -q --bare parent &&
>   git clone -q parent child 2>/dev/null &&
>   cd child &&
>   echo one >one && git add one && git commit -q -m one &&
>   git branch other &&
>   git -c push.default=simple push
>
> would just print:
>
>   Everything up-to-date
>
> and now you get:
>
>   To /tmp/push-message/parent
>    = [up to date]      master -> master
>
> which is much more informative.

I think a more interesting case is to do this in the child:

	git checkout other
        git -c push.default=matching push

after the above sequence.  It will try to push master to master (and
the most important part is 'other' is not involved in this push at
all) and would give you the same updated message, which would make
it more clear that 'other' is not involved.  Although it by itself
is good, but unless you are paying attention, you may not catch that
your current branch is *not* listed in the output, so it might not
help people that much, even if they weren't on a detached HEAD.

Somebody who is unaware that she has been working on detached HEAD
is by definition very unlikely to notice that the 'master' in the
output is different from her current branch, as she is not paying
attention to what branch she is working on.

It might be a better approach to check if the set of pushed refs
include the current branch and rephrase the message only in that
case, perhaps

	Everything up-to-date (the current branch not pushed)

or something.
