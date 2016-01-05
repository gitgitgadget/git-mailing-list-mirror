From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/15] strbuf: introduce strbuf_split_str_omit_term()
Date: Tue, 05 Jan 2016 11:24:12 -0800
Message-ID: <xmqq7fjnkexv.fsf@gitster.mtv.corp.google.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 20:24:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGXDQ-0000Kg-KY
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 20:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbcAETYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 14:24:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751625AbcAETYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 14:24:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E79DC3887D;
	Tue,  5 Jan 2016 14:24:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dbdvo9MQIKImKnGXYzkQ8IFkP4U=; b=egqIYw
	JXPANpR505jtr/Kirr0lIoHS14kku5s6f3Q7QfqN4vH+XRjJaWWVmpIVJkJCOoCF
	qW+FYLbGBIvpLfgIh5JGExBL9hF6cMR28suD+i9Po6J7bnPTT4RoqZ2JoMoArqJv
	5i/h0AFwrGCUxUGXIBZGlKk5tyn+isHXt1OCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TB9jfDLKJAT426VaCWduL4iwSmxDsxCQ
	RnlA2hTQr4WjRdGsIl/MEoezJhDjvKmdbHVfhRoiDGtjbOkV4kp81x/Cl6jBxYDI
	p3BkKqwQxEkiGoiDGpnBgAjkBZ1zpg+wTi0VyljSCtNOiFFd+8BUFTzc/BSMuVBS
	F/t5AxMdRvI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF0063887C;
	Tue,  5 Jan 2016 14:24:14 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F7073887B;
	Tue,  5 Jan 2016 14:24:14 -0500 (EST)
In-Reply-To: <1451980994-26865-2-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 5 Jan 2016 13:33:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E7E2316E-B3E1-11E5-A48E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283394>

Karthik Nayak <karthik.188@gmail.com> writes:

> The current implementation of 'strbuf_split_buf()' includes the
> terminator at the end of each strbuf post splitting. Add an option
> wherein we can drop the terminator if desired. In this context
> introduce a wrapper function 'strbuf_split_str_omit_term()' which
> splits a given string into strbufs without including the terminator.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  strbuf.c |  7 ++++---
>  strbuf.h | 25 ++++++++++++++++---------
>  2 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index b552a13..b62508e 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
>  }
>  
>  struct strbuf **strbuf_split_buf(const char *str, size_t slen,
> -				 int terminator, int max)
> +				 int terminator, int max, int omit_term)
>  {
>  	struct strbuf **ret = NULL;
>  	size_t nr = 0, alloc = 0;
> @@ -123,14 +123,15 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>  
>  	while (slen) {
>  		int len = slen;
> +		const char *end = NULL;
>  		if (max <= 0 || nr + 1 < max) {
> -			const char *end = memchr(str, terminator, slen);
> +			end = memchr(str, terminator, slen);
>  			if (end)
>  				len = end - str + 1;
>  		}
>  		t = xmalloc(sizeof(struct strbuf));
>  		strbuf_init(t, len);
> -		strbuf_add(t, str, len);
> +		strbuf_add(t, str, len - !!end * !!omit_term);

You initialize with "len" but sometimes copy less than that, which
looks somewhat sloppy.

Maybe I am old-fashioned, but use of a multiplication when you do
not mean to numerically multiply but merely to perform a logical
operation made me go "Huh?".

Perhaps using another variable would make it easier to follow?
Either using a boolean that tells us that the terminating byte
is to be omitted, i.e.

	int len = slen;
        int omit = 0;
        if ( ... we are still splitting ... ) {
		const char *end = memchr(...);
                if (end) {
                	len = end - str + 1;
			omit = !!omit_term;
		}
	}
	strbuf_init(t, len - omit);
        strbuf_add(t, str, len - omit);

or an integer "copylen" that tells us how many bytes to copy, which
often is the same as "len" but sometimes different by 1 byte?
