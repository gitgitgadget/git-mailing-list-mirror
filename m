Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522C420705
	for <e@80x24.org>; Thu,  8 Sep 2016 17:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965875AbcIHRJv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 13:09:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65133 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965152AbcIHRJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 13:09:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BB523B36F;
        Thu,  8 Sep 2016 13:09:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BPRKuZP3nDfeDoThd0H1bzaXsBk=; b=WfIG/G
        G4EzdPC/C3/a/4OCIUVoA7H2V4qj9brBmCUaiVzSZLCCg3rUEw+v7MrvxR3+hryi
        40aTb1aOAAZe6dqex4xeOmEeETgrjPVV09WWj4h4Li1HOkbdzP/NUr6cND9jY0tM
        PFoJXWEzvsJqhu91MDq4yIj2JN4tK8ptl1gUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IJ+1XqWNDQ7jCy6Wwd2NVJz7cnUFc1RP
        WM7WBbDtBPX2dbgmEtefELN69eTdoEVkLmDIDUKmtdqH1kmYLxCFQUE1rZkSHmX2
        KVnJevLSuxy8nD7hk47UwuCn6TaQDB3CBX0zPmBgdKm7GLKXQxgwfAEHDBMwPxxW
        JtNvawuN7ek=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 833523B36E;
        Thu,  8 Sep 2016 13:09:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 018703B36D;
        Thu,  8 Sep 2016 13:09:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] Use the newly-introduced regexec_buf() function
References: <cover.1473319844.git.johannes.schindelin@gmx.de>
        <cover.1473321437.git.johannes.schindelin@gmx.de>
        <d0537819a3676fda6928e7ad3282aa71643f0755.1473321437.git.johannes.schindelin@gmx.de>
Date:   Thu, 08 Sep 2016 10:09:44 -0700
In-Reply-To: <d0537819a3676fda6928e7ad3282aa71643f0755.1473321437.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 8 Sep 2016 09:59:06 +0200
        (CEST)")
Message-ID: <xmqq1t0ujp2f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C92BC96-75E7-11E6-A540-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -33,11 +32,8 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
>  		 * caller early.
>  		 */
>  		return;
> -	/* Yuck -- line ought to be "const char *"! */
> -	hold = line[len];
> -	line[len] = '\0';
> -	data->hit = !regexec(data->regexp, line + 1, 1, &regmatch, 0);
> -	line[len] = hold;
> +	data->hit = !regexec_buf(data->regexp, line + 1, len - 1, 1,
> +				 &regmatch, 0);

This is an unexpected happy surprise.  It really feels good to see
that "Yuck" line go.

> @@ -228,18 +227,16 @@ static long ff_regexp(const char *line, long len,
>  			len--;
>  	}
>  
> -	line_buffer = xstrndup(line, len); /* make NUL terminated */
> -
>  	for (i = 0; i < regs->nr; i++) {
>  		struct ff_reg *reg = regs->array + i;
> -		if (!regexec(&reg->re, line_buffer, 2, pmatch, 0)) {
> +		if (!regexec_buf(&reg->re, line, len, 2, pmatch, 0)) {

So is this hunk.  Removing unnecessary copying is a very good thing.

Please give these three patches a common prefix, e.g.

	regex: -G<pattern> feeds a non NUL-terminated string to	regexec() and fails
        regex: add regexec_buf() that can work on a non NUL-terminated string
	regex: use regexec_buf()

or something like that.

Also I agree with Peff that a test with an embedded NUL would be a
good thing.

This round is so close to perfect.
