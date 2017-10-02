Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE95920A2C
	for <e@80x24.org>; Mon,  2 Oct 2017 01:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbdJBBIa (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 21:08:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51228 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751092AbdJBBI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 21:08:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 002FDA1577;
        Sun,  1 Oct 2017 21:08:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xn0NHJbnLFL831DdQ/bVoQtApW4=; b=d7mbnf
        R1fsz3Osk3cPvfQxCAQr92f4cvDSqSNqQHwZPDvWXNgKPjp6amhgE2a7pmBnW9b7
        YsGmMhVFVogDFsQ/OcBNeh7UclDYaTGoXmALeuK6nY5+tQlVw9lQrfrMvhfOiv8C
        16j7hHLQG8ahNLtiuU33z/DjB8pDLtZZNELiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e8fIjZ++2yY9nRYpB45AUz7sBB48qG5k
        qWVJDz4B5BQhwK3GcE5JFBJrNEkw/zeOkpFNMFji5jnuSUvf8GNswmJ52audWVzW
        9zuM/IhUTFcgEjVsopsEOxhwUAY9zhujolmQaUj2WqT0Vxudihge6H5a4G3yNKjQ
        83a23K7dIZ0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA314A1576;
        Sun,  1 Oct 2017 21:08:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63B36A1575;
        Sun,  1 Oct 2017 21:08:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sbeller@google.com
Subject: Re: [PATCH v6 3/3] submodule: port submodule subcommand 'status' from shell to C
References: <xmqq4lrrfjt9.fsf@gitster.mtv.corp.google.com>
        <20170929094453.4499-1-pc44800@gmail.com>
        <20170929094453.4499-4-pc44800@gmail.com>
Date:   Mon, 02 Oct 2017 10:08:22 +0900
In-Reply-To: <20170929094453.4499-4-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Fri, 29 Sep 2017 15:14:53 +0530")
Message-ID: <xmqqy3ouqruh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FF7D30C-A70E-11E7-9016-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

>  
>  #define CB_OPT_QUIET		(1<<0)
> +#define CB_OPT_CACHED		(1<<1)
> +#define CB_OPT_RECURSIVE	(1<<2)

Same comments on both naming and formatting.

> @@ -245,6 +250,53 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
>  	}
>  }
>  
> +static char *compute_rev_name(const char *sub_path, const char* object_id)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	const char ***d;
> +
> +	static const char *describe_bare[] = {
> +		NULL
> +	};
> +
> +	static const char *describe_tags[] = {
> +		"--tags", NULL
> +	};
> +
> +	static const char *describe_contains[] = {
> +		"--contains", NULL
> +	};
> +
> +	static const char *describe_all_always[] = {
> +		"--all", "--always", NULL
> +	};
> +
> +	static const char **describe_argv[] = {
> +		describe_bare, describe_tags, describe_contains,
> +		describe_all_always, NULL
> +	};

"make style" seems to suggest a lot more compact version to be used
for the above, and I tend to agree with its diagnosis.

> @@ -503,6 +555,160 @@ static int module_init(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +struct status_cb {
> +	const char *prefix;
> +	unsigned int cb_flags;
> +};
> +#define STATUS_CB_INIT { NULL, 0 }

Same three comments as the previous "init_cb" patch apply.

> +	argv_array_pushl(&diff_files_args, "diff-files",
> +			 "--ignore-submodules=dirty", "--quiet", "--",
> +			 path, NULL);
> +
> +	git_config(git_diff_basic_config, NULL);

Should this be called every time?  The config file is not changing,
no?

> +	init_revisions(&rev, prefix);
> +	rev.abbrev = 0;

This part looks OK.

> +	precompose_argv(diff_files_args.argc, diff_files_args.argv);

I do not think this is correct.  We certainly did not get the path
argument (i.e. args.argv) from the command line of macOS X box and
the correction for UTF-8 canonicalization should not be necessary.
Even if we did get path from the command line, I think the UTF-8
correction should have been done for us for any command (like "git
submodule--helper") that uses parse-optoins API already.

Just dropping the line should be sufficient to correct this, I think.

The remainder of the patch looked more-or-less OK, but I'd revisit
it later to make sure.

Thanks.
