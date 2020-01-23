Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A63C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 21:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197C621835
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 21:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x+CUJW78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAWVMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:12:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56535 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgAWVMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 16:12:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88EFEB4DFF;
        Thu, 23 Jan 2020 16:12:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K15ry8co/DA0X2oCRzAowokJUxM=; b=x+CUJW
        78BOgjByHtWVtYtgyZY/tFkGU5U4ziV8/BcFxM8FBiyDt5/Q57qIz5Xqsw2i+fyX
        XTwAQk8zEb+TfzWrjxDius7W6KtuYRqFQS5oWi5HrY96KpiiiWbipu/SF9EgX+5Q
        AmkXCidkHWOuSKw9I89p0RNorju7CmbCdr5SU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FNJK4okizcjnv6kFg+KkSx170snZV083
        PZJOad6Ikfyr8KqOe5a6dPVSEzMzTR2SahWId8v60cBdDAyuhv8T5nK+hmafsOs+
        66x7BDcr2xpZNqSezKeP4S+ZuhTAlz5DAME/KH8NkcYy/3/I13LTPquN09hX/9Cy
        /i2iWBO+k6o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D147B4DFE;
        Thu, 23 Jan 2020 16:12:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0A90AB4DF9;
        Thu, 23 Jan 2020 16:12:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Kaestle <peter.kaestle@nokia.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, pc44800@gmail.com
Subject: Re: [PATCH v2] Fix status of initialized but not cloned submodules
References: <23e3d410-5271-a919-aa03-9e776cf72f7c@nokia.com>
        <1579601532-10694-1-git-send-email-peter.kaestle@nokia.com>
Date:   Thu, 23 Jan 2020 13:12:37 -0800
In-Reply-To: <1579601532-10694-1-git-send-email-peter.kaestle@nokia.com>
        (Peter Kaestle's message of "Tue, 21 Jan 2020 11:12:12 +0100")
Message-ID: <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16823C40-3E25-11EA-972A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Kaestle <peter.kaestle@nokia.com> writes:

> Original bash helper for "submodule status" was doing a check for
> initialized but not cloned submodules and prefixed the status with
> a minus sign in case no .git file or folder was found inside the
> submodule directory.
> This check was missed when the original port of the functionality
> from bash to C was done.
>
> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
> ---
>  builtin/submodule--helper.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

I wonder if this is easily protectable with an additional test.

In general, do we have a good coverage of "git status" output that
involves submodules in various states?

Thanks.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c72931e..c04241b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -782,6 +782,9 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
>  	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
>  	struct rev_info rev;
>  	int diff_files_result;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *git_dir;
> +
>  
>  	if (!submodule_from_path(the_repository, &null_oid, path))
>  		die(_("no submodule mapping found in .gitmodules for path '%s'"),
> @@ -794,10 +797,18 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
>  		goto cleanup;
>  	}
>  
> -	if (!is_submodule_active(the_repository, path)) {
> +	strbuf_addf(&buf, "%s/.git", path);
> +	git_dir = read_gitfile(buf.buf);
> +	if (!git_dir)
> +		git_dir = buf.buf;
> +
> +	if (!is_submodule_active(the_repository, path) ||
> +			!is_git_directory(git_dir)) {
>  		print_status(flags, '-', path, ce_oid, displaypath);
> +		strbuf_release(&buf);
>  		goto cleanup;
>  	}
> +	strbuf_release(&buf);
>  
>  	argv_array_pushl(&diff_files_args, "diff-files",
>  			 "--ignore-submodules=dirty", "--quiet", "--",
