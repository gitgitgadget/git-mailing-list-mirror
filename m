From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Tue, 11 Jan 2011 09:02:18 -0800
Message-ID: <7vvd1v4bmt.fsf@alter.siamese.dyndns.org>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
 <7vsjx449bv.fsf@alter.siamese.dyndns.org>
 <7vipy0483h.fsf@alter.siamese.dyndns.org>
 <20110111065207.GF10094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 18:02:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PchcY-0001U0-5D
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 18:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353Ab1AKRCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 12:02:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282Ab1AKRCv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 12:02:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B9A143039;
	Tue, 11 Jan 2011 12:03:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NsVbYeQoHpifP3JQPDg45uOPvnw=; b=Cxx7Ve
	LKfI9oCdX4suZGI82tiDJQ8POD+PLlFWBQ+X3sksHGA+VYS2/3sirBKAHVQfHqUL
	5jgYx9soPZ+OymG45Hfj7t2UB9zReSMTVN38+ztx78KkxmlsV4wQKB7HIYCAOyrH
	x/Dj6eILAlzJN+90ech2MviuhcevftRTGW45A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OIsGIAePYVZF7hr4Fef9lzkQC7pUzoQk
	Gf9KiEdr+WFydWKoVj/peUL8hvnjEdKUcmwY2zJ59rmlZKzO0XojSJk9z35ZKokS
	Nxhw+QSArRi1qmjxd6iHluUm6w+eEPYglBb9LGiNp9tgh2NJPzT4S8jDN0wrOiPI
	b6z1lwQl9Us=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 892C03038;
	Tue, 11 Jan 2011 12:03:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 017093037; Tue, 11 Jan 2011
 12:03:21 -0500 (EST)
In-Reply-To: <20110111065207.GF10094@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 11 Jan 2011 01\:52\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B55577D4-1DA4-11E0-894C-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164956>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 07, 2011 at 03:17:22PM -0800, Junio C Hamano wrote:
>
>> ... And this comes on top (should probably be squashed into one) to really
>> favor a branch over a tag.
>> 
>>  builtin/checkout.c               |   26 ++++++++++----------------
>>  t/t2019-checkout-amiguous-ref.sh |    2 +-
>>  2 files changed, 11 insertions(+), 17 deletions(-)
>
> Yeah, that looks sane to me (assuming all three patches squashed
> together). It took me a minute to figure out one subtlety, though:
>
>> +		if ((check_ref_format(new.path) != CHECK_REF_FORMAT_OK) ||
>> +		    !resolve_ref(new.path, rev, 1, NULL))
>> +			new.path = NULL; /* not an existing branch */
>> +
>> +		if (!(new.commit = lookup_commit_reference_gently(rev, 1))) {
>
> We are relying on the fact that resolve_ref leaves "rev" alone in the
> case that it does not find anything. Which is mostly true (the only
> exception seems to be if you have a ref with non-hex garbage in it, in
> which case you will get some bogus sha1 in the output). I dunno if it is
> worth making it more explicit, like:

I've thought about it when I sent the patch.  I think this is safe as that
particular resolve is done on a full ref "refs/heads/$something" and upon
seeing the first 'r' get_sha1_hex() would give up without touching rev[],
but I agree it is too subtle.

> Also, one other question while we are on the subject. I think we all
> agree that "git checkout $foo" should prefer $foo as a branch. But what
> about "git checkout -b $branch $start_point"?

That has always been defined as a synonym for

	git branch $branch $start_point && git checkout $branch

so $start_point is just a random extended SHA-1 expression.

> I was surprised to find that the current behavior is to die(), due to an
> explicit case in branch.c:create_branch.

Good eyes.  At that point, "refname <start> is ambiguous."  warning has
already been issued, and there is no sane reason to die there.  I'd call
it a bug.
