Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80FCA20133
	for <e@80x24.org>; Tue,  7 Mar 2017 05:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdCGFO4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 00:14:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60484 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750739AbdCGFOy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 00:14:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85A577574D;
        Tue,  7 Mar 2017 00:13:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nQ+ANb+g3wRvL0y3B6eKSsLRYmw=; b=A7RyR/
        DaTWCvOtmIPy6oMdYfen7dbfQF/VwNq5rf7WsHqaFX7R40ZcFfHM1W1gokuYachg
        TaIfc1ZhBvKYkbY9AxOjvBfgNUnBnwOWsIXlwuR2/y3/yvLdLGQmjpvGwriZAhF/
        +bqXHqiQp08WzJ/BxYhpPaUqArkdG3tY1ib5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DOBWAOBbrJBjzSqn2c5Tix9cdg2/DUo8
        uLPh2X1J1Y3+UpHS8U3KeOnU3OjuYx3iTpnz+Y72lbMGd/7rts/iz5iTf2LwdjJz
        F0aDelgU35s06SnnlMAXthB/YqU397oHq7gWtj4fkQ7gf/uz95EB8q1zuT/VLCpL
        ZNYQaDrDsOU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F1407574C;
        Tue,  7 Mar 2017 00:13:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9A737574B;
        Tue,  7 Mar 2017 00:13:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Subject: Re: [RFC PATCH] rev-parse: add --show-superproject-working-tree
References: <CAGZ79kZv=LoP+nG0GVtU_Zi+_SX8_98AXFqzXNh=xM6ASy+=Gw@mail.gmail.com>
        <20170307034553.10770-1-sbeller@google.com>
Date:   Mon, 06 Mar 2017 21:13:40 -0800
In-Reply-To: <20170307034553.10770-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 6 Mar 2017 19:45:53 -0800")
Message-ID: <xmqqvarly8hn.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D491E70E-02F4-11E7-885D-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/submodule.c b/submodule.c
> index 3b98766a6b..a63aef2c6b 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1514,3 +1514,90 @@ void absorb_git_dir_into_superproject(const char *prefix,
>  		strbuf_release(&sb);
>  	}
>  }

Please have a comment here what this function expects (e.g. it is
called after we ran repository discovery and $cwd is at the root of
the working tree of the current project, we _know_ we have a working
tree, etc.).

> +
> +static int superproject_exists(void)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *one_up = real_path_if_valid("../");
> +	const char *dirname;
> +	int code, has_superproject = 0;
> +
> +	if (!one_up)
> +		/* At the root of the file system. */
> +		return 0;

Hmph.  I would have expected that "/../" would be the same as "/".

> +	dirname = relative_path(xgetcwd(), one_up, &sb);

So, the idea is we start at the root level of the current project's
working tree, and we go up one level, then we know the last component
of the path our submodule is bound at in the superproject.

> +	prepare_submodule_repo_env(&cp.env_array);
> +	argv_array_pop(&cp.env_array);
> +	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
> +			"ls-tree", "HEAD", "--", dirname, NULL);

This would ask our superproject what is at the "dirname" in its
HEAD.  Two possible issues:

 - Shouldn't that be looking at its index instead?  It would be more
   correct for unborn branch case, and new or moved submodule case.

 - If our submodule is bound at path sub/dir in the superproject,
   the relative-path thing above would get "dir" and this ls-tree
   ends up asking what is at "dir", but the question you really want
   to ask is what is at "sub/dir", isn't it?

> +const char *get_superproject_working_tree()

const char *get_superproject_working_tree(void)
