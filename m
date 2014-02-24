From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] log: handle integer overflow in timestamps
Date: Mon, 24 Feb 2014 11:50:00 -0800
Message-ID: <xmqqsir88f4n.fsf@gitster.dls.corp.google.com>
References: <20140224073348.GA20221@sigill.intra.peff.net>
	<20140224074637.GD9969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 20:50:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI1Xp-0000Rt-8S
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 20:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbaBXTuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 14:50:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057AbaBXTuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 14:50:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CDBC6D1D3;
	Mon, 24 Feb 2014 14:50:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=szQieU8QhLOLT5a58DCYU3pHFUs=; b=PRqjQB
	OOihvDfmti09tYT31zEM0iJRjXHkcNavHeP/+uXhSk/d+S7dF5iI5B5Ova6Gs48K
	gn13FEfrT+KV5cMBsNyX4lKd2Ux2xetADLkQSXxx8FWdqtEaF+Q43fQ0OEtHpDju
	JJrO/djC7imhK7DY7RAFR+y5A2TScYh3WcCXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WgXiWTL+mu9a1mBmOBZ2FtANMfYiCEW3
	0aRhHOnYNTGHbgKbWcQoVg6U3lyA1cUs1DQ1jxe6PHpOpuji+Sn2BZbe6n7bc9Wg
	bwYNUn9qzE7TxSxzvcrtxAB95EoOqhfo4RpxEH8TfMpI3W3DozvUAshcnLSykbbe
	9iBV7QTYLcM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA0AF6D1D2;
	Mon, 24 Feb 2014 14:50:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A36DF6D1CF;
	Mon, 24 Feb 2014 14:50:09 -0500 (EST)
In-Reply-To: <20140224074637.GD9969@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Feb 2014 02:46:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DE004A90-9D8C-11E3-8F2D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242633>

Jeff King <peff@peff.net> writes:

> If an ident line has a ridiculous date value like (2^64)+1,
> we currently just pass ULONG_MAX along to the date code,
> which can produce nonsensical dates.
>
> On systems with a signed long time_t (e.g., 64-bit glibc
> systems), this actually doesn't end up too bad. The
> ULONG_MAX is converted to -1, we apply the timezone field to
> that, and the result ends up somewhere between Dec 31, 1969
> and Jan 1, 1970.
> ...
> We also recognize overflow in the timezone field, which
> could produce nonsensical results. In this case we show the
> parsed date, but in UTC.

Both are good measures to fallback to sanity, but why is that
if/else?  In other words...

> +	if (date_overflows(date))
> +		date = 0;
> +	else {
> +		if (ident->tz_begin && ident->tz_end)
> +			tz = strtol(ident->tz_begin, NULL, 10);
> +		if (tz == LONG_MAX || tz == LONG_MIN)
> +			tz = 0;
> +	}

... don't we want to fix an input having a bogus timestamp and also
a bogus tz recorded in it?

>  	return show_date(date, tz, mode);
>  }
>  
> diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
> index 83de981..ba25a2e 100755
> --- a/t/t4212-log-corrupt.sh
> +++ b/t/t4212-log-corrupt.sh
> @@ -65,4 +65,20 @@ test_expect_success 'unparsable dates produce sentinel value (%ad)' '
>  	test_cmp expect actual
>  '
>  
> +# date is 2^64 + 1
> +test_expect_success 'date parser recognizes integer overflow' '
> +	commit=$(munge_author_date HEAD 18446744073709551617) &&
> +	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
> +	git log -1 --format=%ad $commit >actual &&
> +	test_cmp expect actual
> +'
> +
> +# date is 2^64 - 2
> +test_expect_success 'date parser recognizes time_t overflow' '
> +	commit=$(munge_author_date HEAD 18446744073709551614) &&
> +	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
> +	git log -1 --format=%ad $commit >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
