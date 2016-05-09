From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 2/6] convert.c: stream and early out
Date: Mon, 09 May 2016 13:29:52 -0700
Message-ID: <xmqqtwi7t1of.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1462601460-23543-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon May 09 22:30:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azroX-0000Ol-Ax
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbcEIU35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:29:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750993AbcEIU34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:29:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFBE41AD50;
	Mon,  9 May 2016 16:29:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LKZNHuXFOXPykvUs3sdAq0oHH90=; b=lgGxV0
	5pSs8XXxedYKDRn5vrj7hAyuq5JBSdG6lNHhgwiWsd48kLKf1GL2l98CWQ58tGXh
	iE44GVWlSpJ9Wr6/BahHHLhP7wpb7Z9EgNDy/g/+jqiJ+9SHp7t9Rge97F2hkFGS
	mOvVwPxAY9uZWUsDE/BO//C6Mlsr11MYpzBYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ARTrPCovj4+El/z6fqT8ssUq6arf9Dvs
	9g4+XayFdH73Sm8f4usp56nnncKe6VJuFgAWw5lO/lNLEjeC125iDsJfHER2rLZM
	k5m1bxhhToo0ZlpOX92xVM3gjf+invUPCI5bFiei+SvSK9ofvo7m91ZnLRHq7BTu
	DmA+gwnzaaI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7D881AD4F;
	Mon,  9 May 2016 16:29:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3076F1AD4E;
	Mon,  9 May 2016 16:29:54 -0400 (EDT)
In-Reply-To: <1462601460-23543-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Sat, 7 May 2016 08:11:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C9D4071A-1624-11E6-9C37-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294048>

tboegi@web.de writes:

> +		if (stats->stat_bits & earlyout)
> +			break; /* We found what we have been searching for */

Are we sure if our callers are only interested in just one bit at a
time?  Otherwise, if we want to ensure all of the given bits are
set,

	if ((stats->stat_bits & earlyout) == earlyout)
        	break;

would be necessary.  Otherwise, the "only one bit" assumption on the
"earlyout" parameter somehow needs to be documented in the code.

> +		ssize_t readlen = read(fd, buf, sizeof(buf));

xread() to automatically retry an interrupted read?

> @@ -309,11 +354,13 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
>  {
>  	char *to_free = NULL;
>  	struct text_stat stats;
> +	unsigned earlyout = CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS_BIN;
> +
>  
>  	if (!len || output_eol(crlf_action) != EOL_CRLF)
>  		return 0;
>  
> -	gather_stats(src, len, &stats);
> +	gather_stats(src, len, &stats, earlyout);

Oops, this answers my earlier question, no?
