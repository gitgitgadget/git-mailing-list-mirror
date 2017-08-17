Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C04920899
	for <e@80x24.org>; Thu, 17 Aug 2017 22:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753475AbdHQWf6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 18:35:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55117 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753402AbdHQWf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 18:35:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05C4494455;
        Thu, 17 Aug 2017 18:35:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qCQ9jVNSxsyMr2xNKEcRGLVoNzc=; b=oQEVYa
        58U99X3AW6HmpgNq6zt7JPcziGpHxrMdzD81ssFS0c63Z3QopYdpFEiu+X90gpGD
        WB3Osk/BNV9vjPP98srk7EpmCygw8Vasf+w4oO1vTS8kMVq/GtsmBKOJt+qQv6ua
        uRPyliRq+PjCQZAqaLJC8f6E5duv9M2eQyHmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CFxuie6kCOBAGWtkYTzldIcgg+xzBPAn
        BxTd7BFY9YvwBiGNSg15VuEXG44GkSHGFv9tFiZClA5eNiRrGHlsHEZ/SBKsdKvZ
        N2f9bMFWOeqjgcWf9SpBz9KKRKmqCzFI6QkSS6SMH6/CTHJ8Gwtlp4wV4cky3rvc
        pNMcM0Jni5c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F21D294453;
        Thu, 17 Aug 2017 18:35:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CFD394450;
        Thu, 17 Aug 2017 18:35:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH v3 2/2] File commited with CRLF should roundtrip diff and apply
References: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
        <20170817214308.10727-1-tboegi@web.de>
Date:   Thu, 17 Aug 2017 15:35:48 -0700
In-Reply-To: <20170817214308.10727-1-tboegi@web.de> (tboegi@web.de's message
        of "Thu, 17 Aug 2017 23:43:08 +0200")
Message-ID: <xmqqh8x5esaj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B276676-839C-11E7-8D24-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> @@ -1712,11 +1726,15 @@ static int parse_fragment(struct apply_state *state,
>  			if (!deleted && !added)
>  				leading++;
>  			trailing++;
> +			if (!state->apply_in_reverse)
> +				check_old_for_crlf(patch, line, len);
>  			if (!state->apply_in_reverse &&
>  			    state->ws_error_action == correct_ws_error)
>  				check_whitespace(state, line, len, patch->ws_rule);
>  			break;

This one is wrong.  You are looking at " " (common context) and you
should unconditionally call check_old for them.


>  		case '-':
> +			if (!state->apply_in_reverse)
> +				check_old_for_crlf(patch, line, len);

This is correct.

There is "case '+':" below here you did not touch.  There should be

		case '+':
	+		if (state->apply_in_reverse)
	+			check_old_for_crlf(...);

there.  Note that we call check_old() only when applying in reverse.

> @@ -2268,8 +2286,11 @@ static void show_stats(struct apply_state *state, struct patch *patch)
>  		add, pluses, del, minuses);
>  }
>  
> -static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
> +static int read_old_data(struct stat *st, struct patch *patch,
> +			 const char *path, struct strbuf *buf)

The order of argument to have the patch structure earlier is
different from my version; what we see here looks much better to me.

>  {
> +	enum safe_crlf safe_crlf = patch->crlf_in_old ?
> +		SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_RENORMALIZE;
>  	switch (st->st_mode & S_IFMT) {
>  	case S_IFLNK:
>  		if (strbuf_readlink(buf, path, st->st_size) < 0)
> @@ -2278,7 +2299,15 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
>  	case S_IFREG:
>  		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
>  			return error(_("unable to open or read %s"), path);
> -		convert_to_git(&the_index, path, buf->buf, buf->len, buf, 0);
> +	       /*
> +		* "git apply" without "--index/--cached" should never look
> +		* at the index; the target file may not have been added to
> +		* the index yet, and we may not even be in any Git repository.
> +		* Pass NULL to convert_to_git() to stress this; the function
> +		* should never look at the index when explicit crlf option
> +		* is given.
> +		*/
> +		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf);

This comment is somewhat strangly indented.  I thought opening "/*"
alighs with the usual tab stop.

Thanks.
