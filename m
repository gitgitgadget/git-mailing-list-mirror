From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/1] http: Add Accept-Language header if possible
Date: Wed, 21 Jan 2015 23:54:45 -0800
Message-ID: <xmqq7fwfuu62.fsf@gitster.dls.corp.google.com>
References: <1421583806-3563-1-git-send-email-eungjun.yi@navercorp.com>
	<1421583995-3663-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 08:54:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YECbL-00070p-Ph
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 08:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbbAVHyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 02:54:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752377AbbAVHyr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 02:54:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B42629571;
	Thu, 22 Jan 2015 02:54:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qiyhc3r4ADcuCArJP6myc2dmQdc=; b=MjDCLi
	3XtDNTRKp1SO933RuJ635xOLR+f0Nv6lFBWNbPB6z9ZR2AWEuvzM9Ustf5rVfrxY
	89rNlYVVVEXA9qGVPzhACtNwB+cqZ2cFaG3yNm3GGvlwvW9oGiZvUJb3K3K40g/e
	RGuKGHG5J2skeNHkEzJW+SjB0BS83eFI0MHfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jpkcrfkTr6QGDdu6jTgkGXKpdJGe4fvw
	p9qURNtnZchdTLXJElNIMi8/tf94Eh6fCDDdZIt6lXmM5eYGky18bTG78A5TB23L
	8CmLN7HYaOZSPRb1GOE7AIEFE6ujhjyNrjOKXHodFVnyLj41wKzMwsRc4F6AMon0
	399jcAgnNFc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FDD229570;
	Thu, 22 Jan 2015 02:54:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 925932956F;
	Thu, 22 Jan 2015 02:54:46 -0500 (EST)
In-Reply-To: <1421583995-3663-1-git-send-email-eungjun.yi@navercorp.com> (Yi
	EungJun's message of "Sun, 18 Jan 2015 21:26:35 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF0B1E44-A20B-11E4-824C-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262805>

Yi EungJun <semtlenori@gmail.com> writes:

> +static void write_accept_language(struct strbuf *buf)
> +{
> +	/*
> +	 * MAX_DECIMAL_PLACES must not be larger than 3. If it is larger than
> +	 * that, q-value will be smaller than 0.001, the minimum q-value the
> +	 * HTTP specification allows. See
> +	 * http://tools.ietf.org/html/rfc7231#section-5.3.1 for q-value.
> +	 */
> +	const int MAX_DECIMAL_PLACES = 3;
> +	const int MAX_LANGUAGE_TAGS = 1000;
> +	const int MAX_ACCEPT_LANGUAGE_HEADER_SIZE = 4000;
> +	struct strbuf *language_tags = NULL;
> +	int num_langs;

No initial value given to this variable, but...

> +	const char *s = get_preferred_languages();
> +
> +	/* Don't add Accept-Language header if no language is preferred. */
> +	if (!s)
> +		return;
> +
> +	/*
> +	 * Split the colon-separated string of preferred languages into
> +	 * language_tags array.
> +	 */
> +	do {
> +		/* increase language_tags array to add new language tag */
> +		REALLOC_ARRAY(language_tags, num_langs + 1);

... it is nevertheless used.  I think it was meant to start at 0?

> +	/* write Accept-Language header into buf */
> +	if (num_langs >= 1) {
> +		int i;
> +		int last_buf_len;

This is uninitialized...

> +		int max_q;
> +		int decimal_places;
> +		char q_format[32];
> +
> +...
> +			if (buf->len > MAX_ACCEPT_LANGUAGE_HEADER_SIZE) {
> +				strbuf_remove(buf, last_buf_len, buf->len - last_buf_len);

... and then it is used here.
