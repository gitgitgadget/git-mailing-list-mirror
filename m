From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Mon, 02 May 2016 11:59:14 -0700
Message-ID: <xmqq60uwthfh.fsf@gitster.mtv.corp.google.com>
References: <20160502142813.50868-1-gitter.spiros@gmail.com>
	<20160502142813.50868-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:59:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJ3y-0002mC-Qh
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbcEBS7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:59:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754821AbcEBS7S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:59:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1EEB1592B;
	Mon,  2 May 2016 14:59:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UXOn6W7rujFm3XoCdWSIbi4DyiU=; b=MPCXJh
	Y56XGr/vHjh/J30n5dwab4HWDJoHAXL0UCihwwVo43wGietgGqO3yfYePafZD5wa
	ryzxVTDVzhkWWPX4r2xsi42OxCiYwpBk5khHQFuxnYtiC1gstMlJsZ2R/7RAZQhf
	K2dFBSRN4n446cIYseIhPgM+cwMO0MLQuxt7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LF5TkgwxMh3QRAwlFmYxOpbOUfstquG/
	RNAyGBzmLC6exTZhp4eKM7Hu/XHCbUJglqvUTMVUHmUF1d0Oe0i4nJ65GmD/f4ql
	OFl8vlxqQvmXxdfyF6twxOBgWsOpy968Cff0vvQXartuE8uxQIMVpilJcN7hY8Wk
	W3+jPuMV1LY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97D251592A;
	Mon,  2 May 2016 14:59:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E163E15929;
	Mon,  2 May 2016 14:59:15 -0400 (EDT)
In-Reply-To: <20160502142813.50868-2-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Mon, 2 May 2016 14:28:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F78274F4-1097-11E6-B3F5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293269>

Elia Pinto <gitter.spiros@gmail.com> writes:

> +static void curl_dump(const char *text, unsigned char *ptr, size_t size, int nopriv)
> +{
> +	size_t i;
> +	struct strbuf out = STRBUF_INIT;
> +	unsigned int width = 80;
> +
> +	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
> +		text, (long)size, (long)size);
> +	trace_strbuf(&trace_curl, &out);
> +
> +	for (i = 0; i < size; i += width) {
> +		...
> +		for (w = 0; (w < width) && (i + w < size); w++) {
> +			if ((i + w + 1 < size) && ptr[i + w] == '\r'
> +			    && ptr[i + w + 1] == '\n') {
> +				i += (w + 2 - width);
> +				break;
> +			}
> +			strbuf_addch(&out, (ptr[i + w] >= 0x20)
> +				&& (ptr[i + w] < 0x80) ? ptr[i + w] : '.');
> +			if ((i + w + 2 < size)
> +			    && ptr[i + w + 1] == '\r'
> +			    && ptr[i + w + 2] == '\n') {
> +				i += (w + 3 - width);
> +				break;
> +			}
> +		}
> +		...
> +	}
> +	strbuf_release(&out);
> +}

There is no change in this hard-to-read double-loop since the
previous round?

> +int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp)
> +{
> +	const char *text;
> +	(void)handle;		/* prevent compiler unused parameter warning if checked */
> +	(void)userp;		/* prevent compiler unused parameter warning if checked */

I really do not want to see these casts.  Unused parameters are
perfectly normal in a codebase with callback functions, no?  I do
not think these are the first occurrences of unused parameters in
our codebase, and I do not think we have such cast to void to them.
Why add this ugliness only to here?
