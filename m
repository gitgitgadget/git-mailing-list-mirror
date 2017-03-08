Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0840E1FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 06:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756715AbdCHGII (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 01:08:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64110 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751532AbdCHGII (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 01:08:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CF05857E3;
        Wed,  8 Mar 2017 01:01:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d01SivVoZVnvW2OHNFZbTi9swt4=; b=wEOISY
        jsiUJ4V+9kbBxNYwM7W4ZnMF37leZORUumyqT8Nv2tNS1mDRHMuFSxKlW+0k5xiI
        gpSC0cp3kV/uqWjgRIUPIox51Mbd4adq/3XLhelwjZ9QYgf/psrtajy/g2TIdIJx
        6PIffOt9aFouvJyIQYglQHsjJaNrTJ8Lut5W4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AVUulq4/RWrMZHVVl+oiuRQs+iKfZu9h
        1lYq1awK3Q38XWD1hlM8am5iEz6Z/7E+wssHsNKTatXDnLaukz2aY3M7YOOqU/Z8
        Vo9Bg+Y8oP8zwamyPrr7nvyG+QiT2CwZKgdOjjWQEPBUkk8l1BIAUClglWtv0QQU
        hfqGiOwp+qM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55036857E2;
        Wed,  8 Mar 2017 01:01:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC03C857E1;
        Wed,  8 Mar 2017 01:01:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Subject: Re: [PATCHv2] rev-parse: add --show-superproject-working-tree
References: <xmqq7f4066t9.fsf@gitster.mtv.corp.google.com>
        <20170308005615.20321-1-sbeller@google.com>
Date:   Tue, 07 Mar 2017 22:01:36 -0800
In-Reply-To: <20170308005615.20321-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 7 Mar 2017 16:56:15 -0800")
Message-ID: <xmqq60jk488v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1199B3E-03C4-11E7-8B9F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +			if (!strcmp(arg, "--show-superproject-working-tree")) {
> +				const char *superproject = get_superproject_working_tree();
> +				if (superproject)
> +					puts(superproject);
> +				continue;
> +			}

Returning the exact string of the path from the API function is
absolutely the right thing. I however have to wonder if rev-parse
need to do the c-quoting unless it is told to show pathnames in its
output without quoting (perhaps with "-z").  Paths from "rev-parse"
(like "--git-dir", "--show-toplevel", etc.) already are excempt from
the usual quoting rules, so doing puts() and nothing else is fine to
be consistent with the existing practice, but in the longer term, I
am sure we would need to revisit so that scripts can handle paths
with funny characters sensibly, but that would be a different topic
if existing ones like "--git-dir" are already unsafe.

>  			if (!strcmp(arg, "--show-prefix")) {
>  				if (prefix)
>  					puts(prefix);
> diff --git a/submodule.c b/submodule.c
> index 3b98766a6b..06473d3646 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1514,3 +1514,86 @@ void absorb_git_dir_into_superproject(const char *prefix,
>  		strbuf_release(&sb);
>  	}
>  }
> +
> +const char *get_superproject_working_tree(void)
> +{
> +...
> +	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
> +			"ls-files", "--stage", "--full-name", "--", subpath, NULL);
> +	strbuf_reset(&sb);
> +...
> +	if (starts_with(sb.buf, "160000")) {
> +		int super_sub_len;
> +		int cwd_len = strlen(cwd);
> +		char *super_sub, *super_wt;
> +
> +		/*
> +		 * There is a superproject having this repo as a submodule.
> +		 * The format is <mode> SP <hash> SP <stage> TAB <full name> LF,
> +		 * First remove LF, then skip up to \t.
> +		 */

Looks more or less right but invoke "ls-files -z" and reading the \0
delimited output would be easier; otherwise you would have to worry
about c-unquoting the pathname when the submodule is bound at a path
with funny character (like a double-quote) in it.
