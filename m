From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] optionally deny all pushes
Date: Sat, 21 Jan 2012 14:02:52 -0800
Message-ID: <7vhazobto3.fsf@alter.siamese.dyndns.org>
References: <20120121174927.GA7128@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jan 21 23:03:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Roj1a-0001aJ-Fm
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 23:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629Ab2AUWC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 17:02:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586Ab2AUWCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 17:02:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 643A073D3;
	Sat, 21 Jan 2012 17:02:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KnYBzc9scQ/JszWLOic8S7g23l4=; b=M/moWS
	9DcQ7stZxpRE1hFPP5y6Tt+lhCLi2Sg7VfzIAvqV8L/V68zHZ51HUm2vIATJolTt
	WtMV6m0RX2X5zN7tRfdPpZHw/8DEKWXV3amMHLCuXXc0lRLw1Veyw4p+SJbmrAdk
	2c37yHrLM7o238l2nCSY5fv2ipVkKfXdcO+x0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GZxYaUY787GDeu3OqRQzbtnAIoCHVX34
	bvs0zWiD59qnbipCtglbPlV/lbUtACeCsWQmLnTTjIjfqRwc0AbtAYsWZujM/zYq
	k7pa0zcsJV9aV7HDxPLjqrlLZ2+KCBOHFwNsXl6DQCpmDJ1lL1GjVTamnwyCqPSQ
	5BTIZdDGm/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AF2273D2;
	Sat, 21 Jan 2012 17:02:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3ED973CE; Sat, 21 Jan 2012
 17:02:53 -0500 (EST)
In-Reply-To: <20120121174927.GA7128@ecki> (Clemens Buchacher's message of
 "Sat, 21 Jan 2012 18:49:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAE7E9E0-447B-11E1-A638-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188933>

Clemens Buchacher <drizzd@aon.at> writes:

> For a mirror repository which is updated only by pulling from upstream,
> it is convenient to disallow all pushes. An accidental push from a
> downstream repository would mess up the mirror's state as well as future
> updates.
>
> Add a boolean configuration variable receive.denyAll. If enabled,
> receive-pack will deny all ref updates.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---

I do not like this at all.

Especially given that this seems equivalent to:

	$ echo exit 1 >.git/hooks/pre-receive
        $ chmod +x .git/hooks/pre-receive

this is a mere configuration bloat, isn't it?

Your patch however raises an interesting point. Our pre-receive rejection
infrastructure does have a room for improvement.

A typical "push" exchange goes like this:

    receiver: Here are the refs I have.
    sender:   I want to update your refs with these.
    sender:   Here is the object data to complete the updated refs.
    receiver: Let's see what you are trying to do... I may say:
              - I refuse your proposal to update/delete this branch,
                as it is the current branch.
              - My hook tells me to refuse your proposal to update this
                ref, as it does not fast-forward.

We can see that we could decide to reject the push to update the current
branch even before receiving the bulk of transfer. I suspect it might need
a protocol extension to give the receiver a chance to speak after hearing
the proposed set of updates before receiving the bulk of the data to add a
clean error codepath, but at the worset case, we could immediately close
the connection after hearing what the sender proposes to do tries to touch
the current branch in a way we do not like. In other words, the exchange
could become:

    receiver: Here are the refs I have.
    sender:   I want to update your refs with these.
    receiver: Let's see what you are trying to do... I may say:
              - I can tell you without actually looking at the commits you
                are proposing to place at the tips of my refs that I won't
                like this branch to be updated/deleted. Go away.
    sender:   Here is the object data to complete the updated refs.
    receiver: Let's see what you are trying to do...
              - My hook tells me to refuse your proposal to update this
                ref, as it does not fast-forward.

Your "reject any and all" better fits into that new rejection
codepath. Just like the configuration that rejects updates to the current
branch, the decision your patch wants to make can be made before we see
any object data from the sender.

Another thing to consider is that you do not have to be limited to "all".

Often people want to run "git fetch" on their mothership box receiving
data from their notebook, i.e.

    mothership$ git fetch notebook master:refs/remotes/notebook/master
    mothership$ git merge notebook/master

but are prevented from doing so due to networking issues (e.g. your
notebook may not allow incoming connections).  The right way to emulate
this is to initiate the connection in the reverse direction, running "git
push" on their notebook sending data into their mothership box, i.e.

    notebook$ git push mothership master:refs/remotes/notebook/master
    mothership$ git merge notebook/master

In such a situation, you may want to configure your mothership repository
to reject any push outside refs/remotes/ hierarchy to prevent mistakes.
We could add "receive.allowed = refs/remotes/*" or something to support
this use case.  It might turn out that we may even want to make this the
default for non-bare repositories.

Once that happens, you can naturally say "receive.allowed = none" to do
what your patch wants to do as a narrow special case. Wouldn't that be a
much better approach than a "reject any and all" that can only serve a
single narrow case that can already be done with a simple hook?
