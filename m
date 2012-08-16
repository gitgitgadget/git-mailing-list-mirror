From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git workflow - merging upwards
Date: Thu, 16 Aug 2012 13:43:23 -0700
Message-ID: <7vboia1sb8.fsf@alter.siamese.dyndns.org>
References: <502D4EAE.9010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Sabin <patrick.just4fun@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 22:43:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T26uj-0002p8-TY
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 22:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab2HPUn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 16:43:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792Ab2HPUn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 16:43:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A40F87BD;
	Thu, 16 Aug 2012 16:43:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3XgLXLBKEl9sGLXlet04bgkx3iU=; b=D0EWyl
	ejUW8xvp9fzNOFiY8rl0dNKHaMp8pV/vV2m7kU7BEFJxlR/qrhCiGmfqNfkqYZrT
	3WjLFJ+vrG40y8VnGOriSAp4dikn/5RwJ9f6iJAGDOc0qE8x655X5YHTPmrs64zZ
	IkOzxFn89YitiXbZgOLHRZBVTxzqhYK22b294=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UuGZuAHvS81WaLnP6sGmQQq8M9Ou4i0B
	HRydz6CAl7iQf6u6rSH8rG0unz9AC8Xx+HgjMCLvYInW+niP0JzrYm0nUd1UU+jD
	ZZpJ6b+g/WGR1nS8EULX5Aizz0b99VOvybLlBvrQaFtskgjL42T8HKShOWZXGpBH
	UYL53AaYb30=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3760087BC;
	Thu, 16 Aug 2012 16:43:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87BCB87BB; Thu, 16 Aug 2012
 16:43:24 -0400 (EDT)
In-Reply-To: <502D4EAE.9010704@gmail.com> (Patrick Sabin's message of "Thu,
 16 Aug 2012 21:49:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06364336-E7E3-11E1-9EB8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Sabin <patrick.just4fun@gmail.com> writes:

> I read through gitworkflows and want to use the Merge Upwards rule in
> my projects:
>
> "Always commit your fixes to the oldest supported branch that require
> them. Then (periodically) merge the integration branches upwards into
> each other."
>
> This looks great but I have some trouble in the case if I want to have
> a change in an older branch and don't want to propagate the change to
> the newer branches. Let's say I have a v1.1 and a v1.2 and now a have
> a bug fix/workaround which only affects version v1.1 but not v1.2. If
> I commit to v1.1 then the periodical merge would merge the change to
> v1.2 which is what I don't want.
>
> Any ideas/workarounds for that problem?

The document may describe the "upwards" in a bit too simplified way
for readability.  If you have two fixes to 1.1, one applicable only
to 1.1 and the other applicable to both, you would fork them from
tip of maint-1.1, like so:

    git checkout -b fix-1.1-only maint-1.1; do your work and commit
    git checkout -b fix-1.1-onwards maint-1.1; do your work and commit

and when they are proven to be good, you would merge both of them to
maint-1.1 branch:

    git checkout maint-1.1
    git merge fix-1.1-only
    git merge fix-1.1-onwards

But merging the resulting maint-1.1 into maint-1.2 will pull the
history and the change of fix-1.1-only that you do not want to have
in maint-1.2.  You want the history so that later merge will not
pull it to maint-1.2, but you do not want the change.

The first thing to think about is if fix-1.1-only is really a "fix
that only should go to maint-1.1".

If the change is only for 1.1.x release (e.g. update version number
from 1.1.4 to 1.1.5), you may not even want to have such a change
directly on the maint-1.1 branch in the first place.  You would
rather want to have release-1.1 branch that is forked from maint-1.1
branch, that contains the whole of maint-1.1 branch, and also
contains the "update version number from 1.1.x to 1.1.y" changes
that are not in the maint-1.1 branch [*1*].

That arrangement may be sufficient to allow you merge maint-1.1 to
maint-1.2 sanely.

Otherwise, you would fork another branch after merging fix-1.1-*
branches to maint-1.1 to merge it upwards.  After these two merges
illustrated above, while still on maint-1.1, you would do:

    git checkout -B merge-1.1-to-1.2 maint-1.1
    git revert -m 1 maint-1.1~1 ;# revert the fix-1.1-only merge

which would result in a state as if you merged fix-1.1-onwards but
not fix-1.1-only to the original maint-1.1 branch.  But the history
of this branch contains both fix-1.1-only and fix-1.1-onwards.

And merge that result to maint-1.2, i.e.

    git checkout maint-1.2
    git merge merge-1.1-to-1.2
    git branch -d merge-1.1-to-1.2

That way, future merges from maint-1.1 to maint-1.2 will not drag
the change of fix-1.1-only.


[Footnote]

*1* This principle applies not just to "release numbers". If you
want both maint-1.1 and maint-1.2 as generic two codebases, tweaks
meant only for customers of maint-1.1 track should *not* go to
maint-1.1, but customer-1.1 branch that forks from maint-1.1. That
way, you can keep the generic branches clean from "this is only for
that branch" kind of changes.
