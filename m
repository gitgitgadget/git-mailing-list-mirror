From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Wed, 26 Mar 2014 12:18:25 -0700
Message-ID: <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
References: <20140224073348.GA20221@sigill.intra.peff.net>
	<20140224074905.GE9969@sigill.intra.peff.net>
	<20140326110559.GA32625@hashpling.org>
	<20140326182103.GB7087@sigill.intra.peff.net>
	<20140326185153.GA12912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:18:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WStLN-0004uR-Ul
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 20:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779AbaCZTS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 15:18:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbaCZTS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 15:18:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64FA4765BB;
	Wed, 26 Mar 2014 15:18:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eIDsy/dsMIwBA+lXs9CqBkqAlcw=; b=ZnzHar
	uUdRl9sIbIecZf8iQZnBVF30LEwjBArFROHd4PMkWQJiGxuE9nspPjCKOjw1hO7/
	VXe2cd9Ls4v/lzyo+7WbN+8Cq5mdrk2T+IX5CKrqmFPWb2NEQ8JXVC/tzSIQdArW
	5xdyhPgRc4SE166/LVGe8hzANVvHNd4yJl1CY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YgTzILFQwomBbVJ/KujQ+jn5gdp0bkyq
	47l8lzoPfBlyec3dBd6/o0urkGqXql525c5BJgopNzzlNaEuCGNp8Stn4tWE9GJ/
	hdeLQ2Tpc5rzeb2W0CNpg/yFIb0gHehzp0eURbwia4pHjB+pL1OQxSwnx7KnPsib
	yxgKNgNMuX8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E7EA765BA;
	Wed, 26 Mar 2014 15:18:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8355D765B5;
	Wed, 26 Mar 2014 15:18:27 -0400 (EDT)
In-Reply-To: <20140326185153.GA12912@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 26 Mar 2014 14:51:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 68A264A8-B51B-11E3-9D2F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245213>

Jeff King <peff@peff.net> writes:

> +cmp_one_of () {
> +	for candidate in "$@"; do

Style ;-)

> +		echo "$candidate" >expect &&
> +		test_cmp expect actual &&
> +		return 0
> +	done
> +	return 1
> +}

It actually may be easier to understand if you write a trivial case
statement at the sole calling site of this helper function, though.

In any case, would it really be essential to make sure that the
output shows a phony (or a seemingly real) datestamp for this test?

The primary thing you wanted to achieve by the "gmtime gave us NULL,
let's substitute it with an arbitrary value to avoid dereferencing
the NULL" change was *not* that we see that same arbitrary value
comes out of the system, but that we do not die by attempting to
reference the NULL, I think.  Not dying is the primary thing we want
to (and we already do) test, no?

> +# date is within 2^63-1, but enough to choke glibc's gmtime.
> +# We check that either the date broke gmtime (and we return the
> +# usual epoch value), or gmtime gave us some sensible value.
> +#
> +# The sensible values are determined experimentally. The first
> +# is from AIX.
> +test_expect_success 'absurdly far-in-future dates' '
>  	commit=$(munge_author_date HEAD 999999999999999999) &&
> -	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
>  	git log -1 --format=%ad $commit >actual &&
> -	test_cmp expect actual
> +	cmp_one_of \
> +		"Thu Jan 1 00:00:00 1970 +0000" \
> +		"Thu Oct 24 18:46:39 162396404 -0700"
>  '
>  
>  test_done
