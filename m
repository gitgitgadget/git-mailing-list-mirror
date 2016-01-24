From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Sun, 24 Jan 2016 14:19:52 -0800
Message-ID: <xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
	<20160124071234.GA24084@sigill.intra.peff.net>
	<20160124071815.GB24084@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 24 23:20:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNT1D-0006IG-CD
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 23:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbcAXWUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 17:20:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932235AbcAXWTy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 17:19:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C447B3E6A9;
	Sun, 24 Jan 2016 17:19:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N83BbD4TO0Qr0KjUoFJ4x2LjvuA=; b=Oicp1O
	cPx6xG9AcM5tBy1GZ85ES2/eZ3JCb/s9GgdNeVd/1/QrciXn9fOQzTqW4Yb2Gpvq
	KQ7KQhwE89Bp+Ra5LwbwD/efFBwgp+5VLTkEfGYzNS6Cy1px5rqC0SZBXJWRpyRw
	txOjilqS0l49Jqd45inzdaWSuEif4Dl2WDHO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hg8xK5S1c/6UNeEgXZHSB4FJUHf9YBM8
	JwELnkfPFsh4qjapTDS1MaYtYufCkWLxFKFpjLuklFOyUqmsXJE7hAtzXMdwYjfz
	AURlaI1BnvN/KrJIPB+a5+uPLpgyQaIgKcxE3AUC5Wnxa3vNqSFW6Nrw0bMlb1e2
	r6wsis9fpR4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A516F3E6A8;
	Sun, 24 Jan 2016 17:19:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 272883E6A5;
	Sun, 24 Jan 2016 17:19:53 -0500 (EST)
In-Reply-To: <20160124071815.GB24084@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 24 Jan 2016 02:18:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 97547DCC-C2E8-11E5-896E-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284699>

Jeff King <peff@peff.net> writes:

> On Sun, Jan 24, 2016 at 02:12:35AM -0500, Jeff King wrote:
>
>> In theory, the ref-filter code could figure this out by us
>> passing FILTER_REFS_TAGS. But there are two complications
>> there:
>> 
>>   1. The handling of refname:short is deep in formatting
>>      code that does not even have our ref_filter struct, let
>>      alone the arguments to the filter_ref struct.
>> 
>>   2. In git v2.7.0, we expose the formatting language to the
>>      user. If we follow this path, it will mean that
>>      "%(refname:short)" behaves differently for "tag" versus
>>      "for-each-ref" (including "for-each-ref refs/tags/"),
>>      which can lead to confusion.
>> 
>> Instead, let's extend the "short" modifier in the formatting
>> language to handle a specific prefix. This fixes "git tag",
>> and lets users invoke the same behavior from their own
>> custom formats (for "tag" or "for-each-ref") while leaving
>> ":short" with its same consistent meaning in all places.

Yeah, I do agree with the analysis.

I however wonder if short=$prefix is a good end-user interface,
though, as strip=$prefix may be more intuitive to them, I suspect.

> I think the patch I posted is a reasonable way to go. But I also don't
> think that having "%(refname:short)" behave specially for "git-tag" is
> all that unreasonable, either. But I'm open to argument.
>
> Here are a few more considerations I had.
>
>  - I'm not sure if the "special" behavior works as well for git-branch,
>    which may want to shorten both "refs/heads/" and "refs/remotes/",
>    depending on the type of ref.
>
>    My solution may not extend there naturally, either, depending on how
>    it is implemented.
>
>  - To let users get the same behavior out of for-each-ref, we could
>    perhaps auto-infer that looking at "refs/tags/" means shortening and
>    disambiguation should only happen with respect to the "refs/tags/"
>    hierarchy.
>
>    But I'm uncomfortable changing the meaning of ":short" without at
>    least a new option. And what would it mean for "git for-each-ref
>    refs/heads/foo/"? Would it shorten "refs/heads/foo/bar" to just
>    "bar", or would it still be "foo/bar"?

Also there is "what happens if the expected prefix is not there?"
question.  Perhaps strip=2 can be defined to "strip 2 levels of
hierarchy prefix no matter what that is", and strip refs/tags/foo,
refs/heads/foo and refs/remotes/origin/foo to foo, foo, origin/foo,
respectively?  The filtering natively done by the listing mode of
"branch" and "tags" would ensure the prefixes are always what we
implicitly expect, so the case we need to worry about how we should
signal errors becomes "what if there are not enough levels".  That
may be simpler to handle.
