Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7248C433E6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 20:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678232255F
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 20:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbhAYTuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:50:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51415 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbhAYTsz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:48:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99A0D109128;
        Mon, 25 Jan 2021 14:48:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=311EwuuORsdIBb6/siX0PC52o6s=; b=AxUfCt
        MtpmPZNPKcZepD3GBU2fLRw2sM+sUTfxSAabyVhiOOrmOp9jPq8R7+mOmw6Orqeu
        4dBsfmISB9lKY4SJd985NFNIODLjgU2+0acS15E906iiL/u8Yg1HeX/c2Ti1NaCK
        hcrMMmmANdkOgvjHEh2gEhtqYDZpnC03mlnaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wp5Eh143I8IoVdYPLXjiN3l5NvS+E4bB
        cTCmnf9ZYaHUBDd0eGPivPNVdOZMpetkpWKAjObf4XHCiRO0NFA9v9+4iuSO8gFF
        HsGv4UvH54DijOapLMReoQhSmtbG17rMZLUsZ5GC2/G1bsdlgCDNstgc74iVmz8U
        Q5g9EO5Fmw4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87017109127;
        Mon, 25 Jan 2021 14:48:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BCD70109125;
        Mon, 25 Jan 2021 14:48:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org, peff@peff.net, jeffhost@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2] upload-pack.c: fix filter spec quoting bug
References: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
        <20210125170921.14291-1-jacob@gitlab.com>
Date:   Mon, 25 Jan 2021 11:48:07 -0800
In-Reply-To: <20210125170921.14291-1-jacob@gitlab.com> (Jacob Vosmaer's
        message of "Mon, 25 Jan 2021 18:09:21 +0100")
Message-ID: <xmqqlfcgyf0o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4069107C-5F46-11EB-BC98-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Vosmaer <jacob@gitlab.com> writes:

> This fixes a bug that occurs when you combine partial clone and
> uploadpack.packobjectshook. You can reproduce it as follows:
>
> git clone -u 'git -c uploadpack.allowfilter '\
> '-c uploadpack.packobjectshook=env '\
> 'upload-pack' --filter=blob:none --no-local \
> src.git dst.git
>
> Be careful with the line endings because this has a long quoted string
> as the -u argument.
>
> The error I get when I run this is:
>
> Cloning into '/tmp/broken'...
> remote: fatal: invalid filter-spec ''blob:none''
> error: git upload-pack: git-pack-objects died with error.
> fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
> remote: aborting due to possible repository corruption on the remote side.
> fatal: early EOF
> fatal: index-pack failed
>
> The problem is an unnecessary and harmful layer of quoting. I tried
> digging through the history of this function and I think this quoting
> was there from the start.

Meaning that 10ac85c7 (upload-pack: add object filtering for partial
clone, 2017-12-08) that added:

        if (filter_options.filter_spec) {
                struct strbuf buf = STRBUF_INIT;
                sq_quote_buf(&buf, filter_options.filter_spec);
                argv_array_pushf(&pack_objects.args, "--filter=%s", buf.buf);
                strbuf_release(&buf);
        }

> My best guess is that it stems from a
> misunderstanding what use_shell=1 means. The code seems to assume it
> means "arguments get joined into one big string, then fed to /bin/sh".
> But that is not what it means: use_shell=1 means that the first
> argument in the arguments array may be a shell script and if so should
> be passed to /bin/sh. All other arguments are passed as normal
> arguments.

I noticed another thing that hasn't changed since that commit, which
is that the setting of .use_shell is conditional.  In today's code,
at the beginning of create_pack_file(), we have

        if (!pack_data->pack_objects_hook)
                pack_objects.git_cmd = 1;
        else {
                strvec_push(&pack_objects.args, pack_data->pack_objects_hook);
                strvec_push(&pack_objects.args, "git");
                pack_objects.use_shell = 1;
        }

I suspect that 0b6069fe (fetch-pack: test support excluding large
blobs, 2017-12-08) sort-of fixed half of the problem (i.e. the half
when there is no hook used) while leaving the other half still
broken as before.

But because .use_shell does not affect if we should or should not
quote, we can unconditionally drop the use of sq_quote_buf().

> The solution is simple: never quote the filter spec.

Which makes sense.

> This commit removes the conditional quoting and adds a test for
> partial clone in t5544.
> ---

Thanks.  Missing sign-off.

>  	if (pack_data->filter_options.choice) {
>  		const char *spec =
>  			expand_list_objects_filter_spec(&pack_data->filter_options);
> -		if (pack_objects.use_shell) {
> -			struct strbuf buf = STRBUF_INIT;
> -			sq_quote_buf(&buf, spec);
> -			strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);
> -			strbuf_release(&buf);
> -		} else {
> -			strvec_pushf(&pack_objects.args, "--filter=%s", spec);
> -		}
> +		strvec_pushf(&pack_objects.args, "--filter=%s", spec);
>  	}
>  	if (uri_protocols) {
>  		for (i = 0; i < uri_protocols->nr; i++)
