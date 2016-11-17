Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D061FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 19:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbcKQTvB (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 14:51:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61733 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752905AbcKQTvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 14:51:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D08394D136;
        Thu, 17 Nov 2016 14:50:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+umBbUsYmcrvmkqw9q4Jf8ukbF8=; b=VlICht
        rswRr8PUvi+GXuO3rozXRD3gbWeF0W3GLLsiI+AfOcSbZhm5393JkuG9ZtJb7WYW
        Q9QsKqNrQWHmmt7pl4XlZaCoFvI3LFXzsrMYGnjTnlo+zc3GsidiFzyTrfMywDXS
        I2uED+4gSDc68PXfNs15W2cLoUuc47xoWzW7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E3uMgaZ1CP1JJ9DPP2JukalD7eVw5DVj
        rArrHaoulnXBd7xUjkQuUag+sHcVLfkxKvt/5q2iiKOGSqIa0t5NSR4hwqljYoV1
        pqpOR7CZDl4TY+JVykg2owjFaLjDBkvpgEyMJUt0xLiq1yuSoBLs7gfEiAsFKoPW
        k9/wt48tyM0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C744C4D135;
        Thu, 17 Nov 2016 14:50:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4438D4D134;
        Thu, 17 Nov 2016 14:50:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH v7 16/17] branch: use ref-filter printing APIs
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-17-Karthik.188@gmail.com>
Date:   Thu, 17 Nov 2016 11:50:57 -0800
In-Reply-To: <20161108201211.25213-17-Karthik.188@gmail.com> (Karthik Nayak's
        message of "Wed, 9 Nov 2016 01:42:10 +0530")
Message-ID: <xmqqinrlopge.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28D2FC50-ACFF-11E6-BE17-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> +static char *build_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
> +{

I understand that the return value of this function is used as if
the value given via --format=... option to for-each-ref.

> +	struct strbuf fmt = STRBUF_INIT;
> +	struct strbuf local = STRBUF_INIT;
> +	struct strbuf remote = STRBUF_INIT;
> +
> +	strbuf_addf(&fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)", branch_get_color(BRANCH_COLOR_CURRENT));

This switches between "* " and "  " prefixed for each line of output
in "git branch --list" output, where an asterisk is used to mark the
branch that is currently checked out.  OK.

> +	if (filter->verbose) {
> +		strbuf_addf(&local, "%%(align:%d,left)%%(refname:strip=2)%%(end)", maxwidth);
> +		strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
> +		strbuf_addf(&local, " %%(objectname:short=7) ");
> +
> +		if (filter->verbose > 1)
> +			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
> +				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
> +				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
> +		else
> +			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
> +
> +		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:strip=2)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
> +			    "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
> +			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
> +			    remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
> +	} else {
> +		strbuf_addf(&local, "%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
> +			    branch_get_color(BRANCH_COLOR_RESET));
> +		strbuf_addf(&remote, "%s%s%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
> +			    branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
> +	}

This block prepares "local" and "remote", two formats that are used
for local and remote branches.

> +	strbuf_addf(&fmt, "%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)", local.buf, remote.buf);

And this uses the %(if)...%(then)...%(else)...%(end) construct to
switch between these formats.

Sounds good.  

One worry that I have is if the strings embedded in this function to
the final format are safe.  As far as I can tell, the pieces of
strings that are literally inserted into the resulting format string
by this function are maxwidth, remote_prefix, and return values from
branch_get_color() calls.

The maxwidth is inserted via "%d" and made into decimal constant,
and there is no risk for it being in the resulting format.  Are
the return values of branch_get_color() calls safe?  I do not think
they can have '%' in them, but if they do, they need to be quoted.
The same worry exists for remote_prefix.  Currently it can either be
an empty string or "remotes/", and is safe to be embedded in a
format string.
