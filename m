From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] send-email: use "return;" not "return undef;" on
 error codepaths
Date: Tue, 02 Apr 2013 07:49:35 -0700
Message-ID: <7vsj39gf7k.fsf@alter.siamese.dyndns.org>
References: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
 <1364780442-6015-1-git-send-email-gitster@pobox.com>
 <CALkWK0muF2Nx=ykD6jt4pvpmp9c3R2KhXhQMjLAyMWiHu_6iPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 16:50:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN2XH-0001Qc-UK
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 16:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338Ab3DBOtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 10:49:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759790Ab3DBOtj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 10:49:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15A5312BB1;
	Tue,  2 Apr 2013 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2V7BkjtRcUNEoiwsN6Ka3wdbpiE=; b=jMv/Ra
	CtsDZxVz75JBMxt74zT1TPYRQ0MVCJztQHbJ3EOhytttlTDnEwqvXYX7kLKkTnT5
	wBaWoc/ppwzo/Mb7zPOnUJRzGrMYWCo+q7lEVdkqWEZXFhEuDrQbKSm/8bV/Kbja
	zPudTHRrLgGth7PIFploJOKAhR0Hr/mJq0688=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dU0rIyeeft3jphLR8v53dWnneQIx5Z5k
	4iL0r62KUQtEBSxQOGB4HJXgiSIg7sF3fYvNV9Uq6q7wW3rV29v45FNpJTOnncXL
	TJt/eAzRLK8oW+QlP58BAYvcMyDacRk5yX/Qlr0boMjHnObmWAhudjGEgaPG/B60
	4g0uPVAYY1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D47312BB0;
	Tue,  2 Apr 2013 14:49:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72FD712BAD; Tue,  2 Apr
 2013 14:49:37 +0000 (UTC)
In-Reply-To: <CALkWK0muF2Nx=ykD6jt4pvpmp9c3R2KhXhQMjLAyMWiHu_6iPA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 2 Apr 2013 13:29:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A7B94A0-9BA4-11E2-80D6-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219778>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Note that we leave "return undef;" in validate_address on purpose,
>> even though Perlcritic may complain.  The primary "return" site of
>> the function returns whatever is in the scaler variable $address, so
>> it is pointless to change only the other "return undef;" to "return".
>> The caller must be prepared to see an array with a single undef as
>> the return value from this subroutine anyway.
>
> The way I understood it:
> All callsites only ever call validate_address via
> validate_address_list, which in turn maps a list of addresses by
> calling validate_address on each address.  Therefore, validate_address
> returning an undef in one codepath is correct.

I think we are in agreement then.

The implication of what you just said is that anybody that calls
this subroutine _must_ be (and indeed is) prepared to see a single
'undef' returned from it, hence the use pattern,

	@foo = validate_address(...);
        if (@foo) { ... we got a valid one ... } else { ... we did not ... }

cannot be used for the subroutine _anyway_.  @foo may get an invalid
address, even with the "don't say 'return undef;' say 'return;'"
wisdom is applied to the other return site in the subroutine.

Now, the subroutine's body essentially is:

	while (!extract_valid($address)) {
		...
                if (...) {
                	return undef; # or just "return;"
		}
	}
	return $address;

You can prove that the "return $address" on the last line will never
return 'undef' by proving that extract_valid() never returns true
for 'undef' input.  With that, we can safely change the error return
to do "return;" in the loop.

When it is done, the subroutine's new interface becomes "Single
address goes in, either a single valid address comes out and that
will never be an undef, or nothing (not even an undef) comes out
upon error".

Which means the sole caller of the subroutine needs to be updated,
which currently does this:

	return grep { defined $_ } map { validate_address($_) } @_;

As the subroutine never returns an undef as "no this is not valid",
but acts more like a filter to cull bad ones from the input, the
outer grep { defined $_ } becomes unnecessary.  

And I think that change logically belongs to the same patch as the
one that inspects how validate_address behaves and updates its
"sometimes we return undef to signal a bad input" to return nothing.

That is why validate_adress was excluded from [1/3] which deals with
other simpler cases.
