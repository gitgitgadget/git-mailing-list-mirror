From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] date.c: Support iso8601 timezone formats
Date: Fri, 09 Sep 2011 13:46:49 -0700
Message-ID: <7vipp1tpdy.fsf@alter.siamese.dyndns.org>
References: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
 <1315563033-9476-1-git-send-email-lihaitao@gmail.com>
 <7vhb4lvflb.fsf@alter.siamese.dyndns.org>
 <7vd3f9ve9m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Haitao Li <lihaitao@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 22:46:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R27yT-0005Kt-GC
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 22:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759925Ab1IIUqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 16:46:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62036 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759922Ab1IIUqv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 16:46:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 153175F32;
	Fri,  9 Sep 2011 16:46:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=weKu+TXGQQXYOn5Wt2fgNGrIoqk=; b=xtDlis
	OfGqmFhcVM8FAdgytu4UvuknRgCzDTK45ZKG0ZJvddsaJmlXJ89/+H8BkI/253MM
	GryIpS0AwJeNwAhB9YZf7EbAv58MbCcjdMoOVyAVMTNtxtL9Ng4jmtUYeOWRH1oG
	77NO0lOVTnZrZRij6nw2P0R2kSRDCFlf5GdJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EOGmnqmARupAB21eGbGgSkNtS9Yx5DSU
	QaKIYVY2JCZVo/sgQYxLfDGJofrKk3K7KpKOWn//kIXju86uLTqktfABZprIatN1
	cCues1yemmfbjJwrgk9Yff05O9a+bF0mQ7fvDTk4CZFOdJpF4fQ6KnJCC/ujbtNe
	jiGV477lIb4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DA3E5F31;
	Fri,  9 Sep 2011 16:46:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A7BC5F30; Fri,  9 Sep 2011
 16:46:50 -0400 (EDT)
In-Reply-To: <7vd3f9ve9m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 09 Sep 2011 10:04:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7A71322-DB24-11E0-9173-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181123>

Junio C Hamano <gitster@pobox.com> writes:

> Also, I do not quite understand why the match_tz() logic needs to be that
> long.
>
> Wouldn't something like this patch (on top of yours) easier to follow?
>
>  date.c |   50 +++++++++++++++++++++-----------------------------
>  1 files changed, 21 insertions(+), 29 deletions(-)
>
> diff --git a/date.c b/date.c
> index f8722c1..6079b1a 100644
> --- a/date.c
> +++ b/date.c
> @@ -551,44 +551,36 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
>  
>  static int match_tz(const char *date, int *offp)
>  {
> +	int min;

Micronit; this should be "int min = 0", as parsing of "hh" form relies on
the if/elseif/else cascade to parse only the hour part and leaving min to
the original value.

>  	char *end;
> +	int hour = strtoul(date + 1, &end, 10);
> +	int n = end - (date + 1);
>  
> +	if (n == 4) {
> +		/* hhmm */
> +		min = hour % 100;
> +		hour = hour / 100;
> +	} else if (n != 2) {
> +		min = 99; /* random crap */
> +	} else if (*end == ':') {
> +		/* hh:mm? */
> +		min = strtoul(end + 1, &end, 10);
> +		if (end - (date + 1) != 5)
> +			min = 99; /* random crap */
>  	}
