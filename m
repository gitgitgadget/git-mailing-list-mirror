From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 13:33:22 -0800
Message-ID: <7vmy2as319.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 22:33:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDPUX-0000ba-3X
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 22:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759118AbZKYVd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 16:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759051AbZKYVdZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 16:33:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759013AbZKYVdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 16:33:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A850E827B5;
	Wed, 25 Nov 2009 16:33:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tFq7UzAFHKr/NmBxykKdlzXzsH0=; b=FeDinf
	Li2qXrTM2DJmgIHRm/y2J+QbIqmAKxGA7f0KO6rmHxjzVdAZzNeAmEKDFfSmqyv7
	x6tOBoSLnYmScoSORq+Aew+CHrqqMt17WUREpYJofYOwVYaYPrKabIY58bPZqOar
	hCHZ02MPBYejESiXAz9MUNxKVU8wbBpJSDuy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ckQKGosSGWjqqdhKVCrmEqNOZgOVtGaa
	GSl/Xhsm+inVqHHPHbiw68vQDHinKwnLpWgFKlWac6SWAPSdqplHLEyje/tK3GM1
	0FDnqqaKebj0Ck2vIM8dYryJRwDK9oClsppcHqmcPjBYEOnfFVZhVEqa2I9zzba2
	aAqBk1mnwUI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74A15827B0;
	Wed, 25 Nov 2009 16:33:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59D51827AE; Wed, 25 Nov
 2009 16:33:24 -0500 (EST)
In-Reply-To: <20091125210034.GC18487@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 25 Nov 2009 16\:00\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B0CD97A-DA0A-11DE-9FC4-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133677>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 25, 2009 at 12:52:11PM -0800, Junio C Hamano wrote:
>
>> So I think the posted patch alone without changing anything else would be
>> the approach to give the most benefit with the least impact to existing
>> users, at least for now.
>
> Yes, I meant to say in my original message but forgot to: I think
> --full-tree is an important first step, no matter what happens next. It
> gives people a way to do what they want without typing the right number
> of ".."s, and it opens up --no-full-tree if the default changes later.
>
> But I do worry about it being a command-line option. You are asking the
> user to remember to type --full-tree every time.

We could redefine get_pathspec() to treat a pathspec that begins with a
slash to be anchored at the top, i.e.

	$ git grep -e frotz /

would be a nicer way to spell

	$ git grep --full-tree -e frotz

and allows you more than what you can do with --full-tree, e.g.

	$ cd linux/subtree/some/very/deep/subdir/you/do/not/remember/exactly
	$ git grep -e frotz /linux/subtree

If we do that, it will not be limited to "grep" but would bring uniformity
to the command set [*1*].  Of course, you can keep doing

	$ cd t
	$ git grep -e frotz .

to look inside only the current directory, and once this new convention is
accepted and widely used, it would become possible to flip the default
without causing too much pain (yes, I am agreeing with you that this is an
important first step).

Once there is a convenient and uniform way to ask for either behaviour, no
matter what the default is, the scripts that want specific behaviour can
be updated to choose whichever they want, given enough time (say, 2.0.0).

> Certainly I think that would be an improvement. But again, it suffers
> from the "you must remember to do this" as above. I really want "git
> grep" to Do What I Mean.

And /this-is-absolute is one way to tell "grep" What You Mean.  I do not
claim it would be the _best_ way (I just concocted it up a few minutes ago
without giving it deep thought).  Do you have a better alternative in
mind?

> I have to wonder: is "git grep" really plumbing or porcelain? It is
> really just a wrapper for
>
>   git ls-files | xargs grep
>
> Do people actually use it in their scripts? Should they be?

The issue is not necessarily "scripts", but "what people use the output
for".

My earlier "push is excusable" was primarily because "push" tends to be
the _final_ action in the chain of events, as opposed to "ls-files" and
"grep" output that are meant to be used by the user to _decide_ what to
do next depending on what they find, and as such, the latter has more
problem if they changed behaviour based on the configuration.


[Footnote]

*1* It won't be only get_pathspec(), but we would also need to teach
verify_filename() and verify_non_filename() about the new convention.
