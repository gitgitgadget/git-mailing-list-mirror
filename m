Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7211F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbdLKXRe (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:17:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55747 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751274AbdLKXRd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:17:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 266FBB293A;
        Mon, 11 Dec 2017 18:17:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZpxCELY/6i2MdW5akFxaQiaNLCs=; b=sg5us+
        zdea+IcbeGOoG1H2ixs0WlBIv3v5h+QvyN4lHFkScfqUO18tF8ZVYZb9SE0zu3fD
        +RthnBMzwzQ1HPnsfgDihoqx/+glTz1eSMrypXVUabh8jW4VkqO9aWfZ3+3AtkHz
        MUq02JmLaCE9LRLDx6fYEICSinS5Fqtslt28E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PwlexLCD9NfKZlybkCM4NLnyfoIXHVpg
        fWTbBCcbrQm/llNNp0cgW1O27XxGbR0Ca+qgkmbDVBLTdjihnz7kIQcX8x2Gdylk
        sqeptsEcQNGtGenXvs96KD8kSY4TiaLwKcU37GaXdPEEnsg8nU9sgGcYGvTBuzC8
        jyQHVpzFl9o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E533B2939;
        Mon, 11 Dec 2017 18:17:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F948B2938;
        Mon, 11 Dec 2017 18:17:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
References: <20171208002447.20261-1-sbeller@google.com>
        <20171211195835.57057-1-sbeller@google.com>
        <20171211195835.57057-2-sbeller@google.com>
Date:   Mon, 11 Dec 2017 15:17:31 -0800
In-Reply-To: <20171211195835.57057-2-sbeller@google.com> (Stefan Beller's
        message of "Mon, 11 Dec 2017 11:58:35 -0800")
Message-ID: <xmqqr2s04zxw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7719725C-DEC9-11E7-AB92-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> the information to what is shown. For example:
>
>   $ ./git log --oneline --blobfind=v2.0.0:Makefile
>   b2feb64309 Revert the whole "ask curl-config" topic for now
>   47fbfded53 i18n: only extract comments marked with "TRANSLATORS:"

This part is a bit stale???

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index dd0dba5b1d..67a99e522b 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -500,6 +500,12 @@ information.
>  --pickaxe-regex::
>  	Treat the <string> given to `-S` as an extended POSIX regular
>  	expression to match.
> +
> +--find-object=<object-id>::
> +	Restrict the output such that one side of the diff
> +	matches the given object id. The object can be a blob,
> +	or gitlink entry.

OK.  In principle you should also be able to find a tree, but I do
not now how useful it would be.  Extending it to gitlink, which is
another kind of leaf node in the reachability DAG, does make tons of
sense---it's a no brainer that I feel ashamed not to have thought of
myself ;-)

> +LIB_OBJS += diffcore-oidfind.o

Just to nitpick, but "blobfind" was to find "blob", and if you are
extending it to find any "object", then that should be "objfind".
"oid" is _A_ way to refer to an object (i.e. the _name_ of it), and
name is *not* the same as the thing the name refers to, so...

> +static int parse_oidfind_opt(struct diff_options *opt, const char *arg)
> +{
> +	struct object_id oid;
> +
> +	/* We don't even need to have the object, any oid works. */
> +	if (get_oid_blob(arg, &oid))
> +		return error("unable to resolve '%s'", arg);

Should this still be get_oid_blob(), or should it be less specific
to blobs?

> +test_expect_success 'find the greeting blob' '
> +	cat >expect <<-EOF &&
> +	Revert "add the greeting blob"
> +	add the greeting blob
> +	EOF
> +
> +	git log --format=%s --find-object=greeting^{blob} >actual &&
> +
> +	test_cmp expect actual
> +'

Makes sense.

> +
> +test_expect_success 'setup a submodule' '
> +	test_create_repo sub &&
> +	test_commit -C sub sub &&
> +	git submodule add ./sub sub &&
> +	git commit -a -m "add sub"
> +'
> +
> +test_expect_success 'find a submodule' '
> +	cat >expect <<-EOF &&
> +	add sub
> +	EOF
> +
> +	git log --format=%s --find-object=HEAD:sub >actual &&
> +
> +	test_cmp expect actual
> +'

Nice (and cute).

> +test_done

Looking good.  Thanks.
