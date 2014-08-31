From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] fsck: check tag objects' headers
Date: Sun, 31 Aug 2014 15:46:42 -0700
Message-ID: <xmqqwq9o2s6l.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
	<xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
	<xmqqegw08fft.fsf@gitster.dls.corp.google.com>
	<20140829234641.GG24834@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 01 00:46:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XODth-0005E7-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 00:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbaHaWqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 18:46:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55754 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbaHaWqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 18:46:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 942EE34681;
	Sun, 31 Aug 2014 18:46:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OYps49Ql4vItycqlIUhfPfYrEZ8=; b=vt3xvx
	FhbGzWgCcIIdBljxz7AJiAv8oRPme/iww6c2N9OZInXJJFH396yn5HBhETjtD2hB
	6yIeXnNA6kkMBZEDexgXQ3TUT6ETBlTbYdcQ9ATGuR1cwcMY8KOWiD4VdKPef+sW
	EjjXa7/s/gEDSRjMdPKjKV3STs7AqG+fLjCjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=btqFToRCIycCvXGPKwAQ6eQhoqEaZKFa
	/J+XK1eVm0FJoi28jBEpYbDl63lOUpOUWTljFUfVFAA1Ez5HlygPvuv512o7XQ01
	tO5bdLiN98Xxz/vWve5T4MOpSUc/h76GhFkFR22BYqbXTfiO1i5ZHwAfrw95SOMS
	96T5CdEL6Ys=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C09F3467F;
	Sun, 31 Aug 2014 18:46:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C99F83467B;
	Sun, 31 Aug 2014 18:46:43 -0400 (EDT)
In-Reply-To: <20140829234641.GG24834@peff.net> (Jeff King's message of "Fri,
	29 Aug 2014 19:46:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE455AEE-3160-11E4-BB19-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256302>

Jeff King <peff@peff.net> writes:

> Hmm. But that is because "git tag" always makes one type of tag: one in
> which the "tag" field is the same as the refname in which we store it.
> So the name must be a valid refname there to meet the ref storage
> requirement, and therefore the tag name must, too.
>
> But is that something we necessarily need or want to enforce? Is it OK
> for me to have refs/tags/foo pointing to a tag object that is not
> related to "foo" (either semantically or syntactically)?
>
> I dunno. I cannot think of a reason you would want to do such a thing,
> but this seems like outlawing it because git does not generate it, not
> because it is necessarily a problematic thing to be doing.

Thanks for straightening me out.

If "git fsck" were a tool to validate that the objects and refs are
in line with how "git-core" plumbing and Porcelain toolset uses the
underlying Git data model, it makes sense to insist a tag has a name
that is suitable for a refname, and the tag is pointed by a ref in
"refs/tags/" followed by its name.  The rules such a "git fsck" should
implement would be stricter than what the underlying Git data model
could represent and existing Git tools could handle (i.e. a commit
with broken ident line may not be usable with "shortlog -e" and would
be flagged as corrupt).

But tightening rules in that direction may risk hindering future
progress in an unnecessary way.  We may want to be a bit lenient
when we see something _unusual_ but not necessarily _wrong_, and the
line between them would be blurry in places, as Git is an evolving
software.  It is good to warn about an unsual ones, but we probably
would not want to error on them.

This tightening may be too strict without a very good reason.  For
example, a tentative signed tag (e.g. "for-linus") often used in a
pull request to have it recorded in the resulting merge by the
integrator does not inherently need to be named at all; the ref is
only necessary as a means to transfer the signature from the
contributor to the integrator, and once merged, there is no need for
the tag to have any name.  When we try to improve the workflow to
integrate authenticated work done on the side branch, we may come up
with a way to do so _without_ having to actually have a tag name
(i.e. the "tag" contributor creates for such a purpose may not be
done by "git tag -s" when asking the result to be pulled but do
something different, and it may be perfectly fine for such a
tentative tag to lack the "tag " name line), but still allows us to
record the same merge-tag in the resulting merge commit.

So...
