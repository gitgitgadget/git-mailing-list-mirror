From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Wed, 26 Mar 2014 11:58:49 -0700
Message-ID: <xmqqvbv0iy6u.fsf@gitster.dls.corp.google.com>
References: <20140224073348.GA20221@sigill.intra.peff.net>
	<20140224074905.GE9969@sigill.intra.peff.net>
	<20140326110559.GA32625@hashpling.org>
	<20140326182103.GB7087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:59:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSt2T-0002od-NT
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 19:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbaCZS65 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 14:58:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756052AbaCZS64 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 14:58:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A851778E2;
	Wed, 26 Mar 2014 14:58:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Iow6Cp3f6b1v
	DNDUvf3esZV4Bbo=; b=IEyl78th5qjV53bnTQYbNVkeqQHfk8zAFHJh5PfI/ah8
	RNX25ko8wv9LNRhpJlzQHvAXNqL/e6RjNWKQdVgsvDHJ1yQvjgGxdLUAfJKHepP4
	tdN2NgW9GK77beRGE7REJCzGtBtCqBVmCDozLqrTEDYyc7MMqMrjhCVwicwSKaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pBsHgm
	79L3kr61kNwzqD+vMHJLysKt931Hwhi7LttG6z+auwuyxd+1SMAnQTDvD4jcEy2w
	byyAG7Fa7AZZANqWWSAopVoPmFN3io6M9GmBprnwZsxl64wFiIQyXcS1zYEm3DZz
	yAcWI9lmMyM5HbA5Qa65mnxHd4jL/jCe6+OHo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8431A778E1;
	Wed, 26 Mar 2014 14:58:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD032778D6;
	Wed, 26 Mar 2014 14:58:54 -0400 (EDT)
In-Reply-To: <20140326182103.GB7087@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 26 Mar 2014 14:21:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ADA6FE36-B518-11E3-B709-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245209>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 26, 2014 at 11:05:59AM +0000, Charles Bailey wrote:
>
>> On Mon, Feb 24, 2014 at 02:49:05AM -0500, Jeff King wrote:
>> > +# date is within 2^63-1, but enough to choke glibc's gmtime
>> > +test_expect_success 'absurdly far-in-future dates produce sentine=
l' '
>> > +	commit=3D$(munge_author_date HEAD 999999999999999999) &&
>> > +	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
>> > +	git log -1 --format=3D%ad $commit >actual &&
>> > +	test_cmp expect actual
>> > +'
>>=20
>> Git on AIX seems happy to convert this to Thu Oct 24 18:46:39
>> 162396404 -0700. I don't know if this is correct for the given input
>> but the test fails.
>
> Ick. I am not sure that dates at that range are even meaningful (will
> October really exist in the year 162396404? Did they account for all =
the
> leap-seconds between then and now?). But at the same time, I cannot
> fault their gmtime for just extrapolating the current rules out as fa=
r
> as we ask them to.
>
> Unlike the FreeBSD thing that Ren=C3=A9 brought up, this is not a pro=
blem in
> the code, but just in the test. So I think our options are basically:
>
>   1. Scrap the test as unportable.
>
>   2. Hard-code a few expected values. I'd be unsurprised if some othe=
r
>      system comes up with a slightly different date in 162396404, so =
we
>      may end up needing several of these.
>
> I think I'd lean towards (2), just because it is testing an actual
> feature of the code, and I'd like to continue doing so. And while we =
may
> end up with a handful of values, there's probably not _that_ many
> independent implementations of gmtime in the wild.

Or "3. Just make sure that 'git log' does not segfault"?
