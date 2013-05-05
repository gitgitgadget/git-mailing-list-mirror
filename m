From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Sat, 04 May 2013 21:28:39 -0700
Message-ID: <7vr4hmuk20.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun May 05 06:29:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYqZJ-0005qw-26
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 06:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225Ab3EEE2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 00:28:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab3EEE2o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 00:28:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD37D108C5;
	Sun,  5 May 2013 04:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bW+U/VTzHvwywEe2dxgUqFHMHKk=; b=oW6TMr
	OqWeK4HdBImq8Q2ylK4ta9V/Gp6IFVTXrW3e8PQg6Dzz/jL/WbMGuvgDrK9dkSId
	HFRBGQ8LRPJRp8Fk9t18fK6UkLyAmBkgOL1IWgqXNeVklSn9bJXJAzhTQ0PTMOnV
	kLyaSt3FFeA5bSE6F5kUenyvJwDxnf3ZRya3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LR5DBGkbmP6tt0itaNbdAS0Zib87jRHL
	/HS1cr9uvaRAJ/7aDgGPow+tl4nXXUOvfx0yawD5lJx6Cmu2SN0XIG5dNRNzwmkf
	XWYfdTR2IdMWwC61Ts4yNch3YbJmlCFCyLvf0ZhifNbRsZf6RPQHNjPdnjFZr5Ec
	Q8uh2UqeHXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A25E5108C4;
	Sun,  5 May 2013 04:28:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA5D4108BA;
	Sun,  5 May 2013 04:28:40 +0000 (UTC)
In-Reply-To: <1367711749-8812-1-git-send-email-johan@herland.net> (Johan
	Herland's message of "Sun, 5 May 2013 01:55:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4376BE52-B53C-11E2-9DE9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223391>

Johan Herland <johan@herland.net> writes:

> The "$remote/$branch" syntax can be interpreted in two subtly different
> ways:
>
>  1. A shorthand name for the remote-tracking branch corresponding to a
>     specific $branch from a specific $remote.
>
>  2. A refname fragment, which - when appended to "refs/remotes/" -
>     yields the remote-tracking branch corresponding to a specific
>     $branch from a specific $remote.

I think both of the above are somewhat distorted views and they go
against all the documentation we have so far.  The real definition
is:

   3. $string (which may happen to have one or more slashes) is used
      by prepending a few common prefixes to see if the result forms
      a full refname, and refs/remotes/ is one of the prefixes.
      origin/master ends up referring refs/remotes/origin/master
      because of this.

> However, when configuring non-default refspecs
> (such as the +refs/heads/*:refs/remotes/origin/heads/*), it becomes
> obvious that the current code follows the latter interpretation: The
> "$remote/$branch" shorthand will no longer work, and you are forced to
> use "$remote/heads/$branch" instead.

While I do _not_ think it is _wrong_ to use remotes/origin/heads/*
as a namespace for branches you copy from the 'origin' remote, my
gut feeling is that it is myopic to redefine that origin/master
resolves to refs/remotes/origin/heads/master [*1*].

Step back a bit.

There must be a reason why somebody wants remotes/origin/heads/*
instead of the traditional remotes/origin/* to keep the copies of
branches taken from the origin.

It is because she wants to use the parts of remotes/origin/ that are
outside remote/origin/heads/ to store other things taken from that
remote, no?  They may be "changes", "pull-requests", "notes", etc.

If origin/master were to map to refs/remotes/origin/heads/master and
origin/jh/rtrack were to map to refs/remotes/origin/heads/jh/rtrack,
[*2*] what short-hands hierarchies in refs/remotes/origin/ other
than "heads/" would have?

If you do not special case "heads/",

    $ git merge origin/pull-requests/4

is very straightforward to understand and explain when you use the
definition #3 above.  But if you do, then the above may refer to
origin/heads/pull-requests/4, or perhaps there is no pull-requests/4
branch in the origin and the resolution may have to error out.

While I do not reject refs/remotes/origin/heads/* layout as a
possibility, I am somewhat skeptical that any "solution" that starts
from the "two interpretations" above (both of which are flawed, that
only consider what happens to the branches) will yield a generally
useful result.

If the final end result you are shooting for is to introduce an
extra level between the remote name and the branch names, i.e.
"heads/", any solution needs to at least have a plan (not necessarily
a detailed design or implementation) for the other hierarchies.  The
possibility to have these other hierarchies per remote is the true
progress that the "heads/" at that level can give us; there is not
much point to have heads/ after refs/remotes/origin/, if heads/ is
the only thing that can come there.


[Footnotes]

*1* Unlike the usual cautions from me, this does not have anything
    to do with backward compatibility; it is more about forward
    thinking.

*2* Wait.
    Does origin/jh/rtrack map to refs/remotes/origin/jh/heads/rtrack
    which is rtrack branch taken from the origin/jh remote?
