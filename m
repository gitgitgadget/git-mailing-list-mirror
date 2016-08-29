Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 762FD1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756681AbcH2Vcm (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:32:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64981 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753322AbcH2Vck (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:32:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAA8A3A563;
        Mon, 29 Aug 2016 17:32:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9jt46/9f2AfDNLXBHr4diAZNOyw=; b=H9EMph
        jd9Liu4tIpPIhLAJIOyKiNTC0vceLnPRB61KGIb+8980rAsoX2/MgBtAEteCsHdp
        S3ISsw9cfFMhlqyXPWrMIWO0kqWQRAV28GbgQTng68iHNbMTRo8YiasJvNlE8ZT0
        jnr5LpiymKLZyoolL64yAtQUBpkBdYoyKadqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=och/Wv3jrO0DUgsdrpsxLxvT5g+pXQxV
        6YobkA94xe8mzsJwvvUsHi372oc6ntmuMd0IkvRg9WVnvACyuHgbtSffD7QyLGB+
        nlxllZIB+UbQ9oGi7Pn1b20EEk07MTLb9FSOGzYhYvtb4VOdAqM8UJNPGQKwJNhw
        0WQFfSGZKmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B41133A562;
        Mon, 29 Aug 2016 17:32:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34F263A561;
        Mon, 29 Aug 2016 17:32:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/22] sequencer: prepare for rebase -i's commit functionality
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <1d83fa095c03eac9abfd1038ff7791bae8ace984.1472457609.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 14:32:36 -0700
In-Reply-To: <1d83fa095c03eac9abfd1038ff7791bae8ace984.1472457609.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 29 Aug 2016 10:06:01 +0200
        (CEST)")
Message-ID: <xmqq8tvf8dmz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B9F6AC2-6E30-11E6-8A4F-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +/* We will introduce the 'interactive rebase' mode later */
> +#define IS_REBASE_I() 0

I do not see a point in naming this all caps.  The use site would be
a lot more pleasant to read when the reader does not have to care if
this is implemented as a preprocessor macro or a helper function.

> @@ -377,20 +387,72 @@ static int is_index_unchanged(void)
>  	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
>  }
>  
> +static char **read_author_script(void)
> +{
> +	struct strbuf script = STRBUF_INIT;
> +	int i, count = 0;
> +	char *p, *p2, **env;
> +	size_t env_size;
> +
> +	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
> +		return NULL;
> +
> +	for (p = script.buf; *p; p++)
> +		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> +			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
> +		else if (*p == '\'')
> +			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
> +		else if (*p == '\n') {
> +			*p = '\0';
> +			count++;
> +		}

Hmph.  What is this loop doing?  Is it decoding a sq-quoted buffer
or something?  Don't we have a helper function to do that?

> +	env_size = (count + 1) * sizeof(*env);
> +	strbuf_grow(&script, env_size);
> +	memmove(script.buf + env_size, script.buf, script.len);
> +	p = script.buf + env_size;
> +	env = (char **)strbuf_detach(&script, NULL);
> +
> +	for (i = 0; i < count; i++) {
> +		env[i] = p;
> +		p += strlen(p) + 1;
> +	}
> +	env[count] = NULL;
> +
> +	return env;
> +}
> +
>  /*
>   * If we are cherry-pick, and if the merge did not result in
>   * hand-editing, we will hit this commit and inherit the original
>   * author date and name.
>   * If we are revert, or if our cherry-pick results in a hand merge,
> - * we had better say that the current user is responsible for that.
> + * we had better say that the current user is responsible for that
> + * (except, of course, while running an interactive rebase).
>   */

The added "(except, ...)" reads as if "even if we are reverting, if
that is done as part of an interactive rebase, the authorship rule
for a revert does not apply".

If that is not what you meant, i.e. if you did not mean to imply
that "rebase -i" doing a revert is a normal thing, this needs to be
rephrased to avoid the misinterpretation.
