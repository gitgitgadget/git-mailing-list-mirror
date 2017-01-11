Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A2C20ABE
	for <e@80x24.org>; Wed, 11 Jan 2017 21:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761399AbdAKVeH (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 16:34:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56665 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755929AbdAKVeA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 16:34:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B6A75F780;
        Wed, 11 Jan 2017 16:32:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PL3Aa8ZkTLIrGjXj1EQTVHjX7XM=; b=o7L+Wg
        rHI0Ivu9iCkqoVekl2Dl4hw+MRFStiTyKI/lDnIOnYH3IqzLpX9A3BBPyMARW95O
        ety+pQ5fN4kB8cMIHRGSBgJDipjNwEYimsfpiv0eyJEc3LjPu3xhqrORYYEP/Qri
        0ERMg1K0gaKsaVQtZpl1EI2rIHpxZql1Fm6uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SoGdpWCeVQhfViFaVZtWv7lNjwHVrffl
        RZLZVyXH/zUCBMy6tzMI21pEDeTazLBsXu3k2QfqFOrR8C1xgtlh9UwIh7G0sAg4
        3dkS9kmVMYIfpq9RePf573cENsBzNhVAVSCQ+MXA3THOqpnMA/NgnjfuP6oaF4wa
        X5iJ1GI52+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 835B75F77F;
        Wed, 11 Jan 2017 16:32:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCD065F77D;
        Wed, 11 Jan 2017 16:32:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, novalis@novalis.org, git@vger.kernel.org
Subject: Re: [PATCH 4/4] unpack-trees: support super-prefix option
References: <20170110014542.19352-1-sbeller@google.com>
        <20170110014542.19352-5-sbeller@google.com>
Date:   Wed, 11 Jan 2017 13:32:53 -0800
In-Reply-To: <20170110014542.19352-5-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Jan 2017 17:45:42 -0800")
Message-ID: <xmqq37gpnuyi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 834CBD94-D845-11E6-A579-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Add support for the super-prefix option for commands that unpack trees.
> For testing purposes enable it in read-tree, which has no other path
> related output.

"path related output"?  I am not sure I understand this.

When read-tree reads N trees, or unpack_trees() is asked to "merge"
N trees, how does --super-prefix supposed to interact with the paths
in these trees?  Does the prefix added to paths in all trees?

Did you mean that read-tree (and unpack_trees() in general) is a
whole-tree operation and there is no path related input (i.e.
pathspec limiting), but if another command that started in the
superproject is running us in its submodule, it wants us to prefix
the path to the submodule when we report errors?

If that is what is going on, I think it makes sense, but it may be
asking too much from the readers to guess that from "Add support for
the super-prefix option".

> --- a/t/t1001-read-tree-m-2way.sh
> +++ b/t/t1001-read-tree-m-2way.sh
> @@ -363,6 +363,15 @@ test_expect_success 'a/b (untracked) vs a, plus c/d case test.' '
>  	test -f a/b
>  '
>  
> +cat <<-EOF >expect &&
> +	error: Updating 'fictional/a' would lose untracked files in it
> +EOF
> +
> +test_expect_success 'read-tree supports the super-prefix' '
> +	test_must_fail git --super-prefix fictional/ read-tree -u -m "$treeH" "$treeM" 2>actual &&
> +	test_cmp expect actual
> +'
> +

Preparing the expected output "expect" outside test_expect_success
block is also old-school.  Move it inside the new test?

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 7a6df99d10..bc56195e27 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -52,6 +52,37 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
>  	  ? ((o)->msgs[(type)])      \
>  	  : (unpack_plumbing_errors[(type)]) )
>  
> +static const char *super_prefixed(const char *path)
> +{
> +	/*
> +	 * This is used for the error messages above.
> +	 * We need to have exactly two buffer spaces.
> +	 */
> +	static struct strbuf buf[2] = {STRBUF_INIT, STRBUF_INIT};
> +	static int super_prefix_len = -1;
> +	static unsigned idx = 0;
> +
> +	if (!get_super_prefix())
> +		return path;
> +
> +	if (super_prefix_len < 0) {
> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(buf); i++)
> +			strbuf_addstr(&buf[i], get_super_prefix());
> +
> +		super_prefix_len = strlen(get_super_prefix());
> +	}
> +
> +	if (++idx >= ARRAY_SIZE(buf))
> +		idx = 0;
> +
> +	strbuf_setlen(&buf[idx], super_prefix_len);
> +	strbuf_addstr(&buf[idx], path);
> +
> +	return buf[idx].buf;
> +}

Hmph, as a reader of the code, I do not even want to wonder how
expensive get_super_prefix() is.  If the executable part of the
above were written like this, it would have been easier to
understand:

	if (super_prefix_len < 0) {
		if (!get_super_prefix())
			super_prefix_len = 0;
		else {
			int i;
			... prepare buf[] and set super_prefix_len ...;
                }
	}

        if (!super_prefix_len)
		return path;

	... use buf[] to do the prefixing and return it ...

