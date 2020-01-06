Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3013FC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6002208C4
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pvZTsdop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFTHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:07:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55840 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTHv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 14:07:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C682FA61A6;
        Mon,  6 Jan 2020 14:07:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P62YuUKFIJpYS9ljIgEHVlc2LJg=; b=pvZTsd
        opgjVzgexvxUkPD0ntDZNCMGfd6bC8IaiUuLV2hqd3fQcPrpZfsRPCvAl2TR2yv/
        iVmC8ITYV1a0iw52OZlyHR0gnYk6Z+DHY3pi6jlxv9hyi54sMHpMvghIbki02vFY
        EmQ/+OsAwsleFo6uYCkFz8PWy4yU497BcnNF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TvO7cagvQUkDlDNO9FOB4mMdQfwhch5P
        Tq0CX92W9idvqB7IzZvzdjtPtoN7H9i8ZRQIA3D4KrnmKp+MpH/Knsjdm97kfzkq
        J0si57INTRePvONnPbsbBqXEVc2ub+cY0DL1QfAJu7r13uu/k0odFAh2/MHF8RAg
        tv1em5AyWB0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF66AA61A5;
        Mon,  6 Jan 2020 14:07:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01DC5A61A4;
        Mon,  6 Jan 2020 14:07:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] gpg-interface: conditionally show the result in print_signature_buffer()
References: <20200105135616.19102-1-hji@dyntopia.com>
        <20200105135616.19102-2-hji@dyntopia.com>
Date:   Mon, 06 Jan 2020 11:07:38 -0800
In-Reply-To: <20200105135616.19102-2-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Sun, 5 Jan 2020 13:56:12 +0000")
Message-ID: <xmqq36cs9zet.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFB6EC54-30B7-11EA-B454-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> The print_signature_buffer() function in gpg-interface.c is used to
> print the result of a GPG verified payload.  It takes a 'flags'
> parameter that determines what to print.
>
> Previously, the 'flags' parameter processed 2 flags:
>
> - GPG_VERIFY_RAW: to print the raw output from GPG instead of the
>   human(ish)-readable output.  One of these outputs were always
>   shown, irregardless of any other flags.
> - GPG_VERIFY_VERBOSE: to print the payload that was verified
>
> Interestingly, there was also a third flag defined in gpg-interface.h;
> GPG_VERIFY_OMIT_STATUS.  That flag wasn't used by the print function
> itself -- instead, callers would check for the presence of
> GPG_VERIFY_OMIT_STATUS before invoking print_signature_buffer().
>
> It seems reasonable that the GPG interface should handle all flags
> related to how the result should be (or shouldn't be) shown.  This patch
> implements that behavior by removing GPG_VERIFY_OMIT_STATUS and adding
> GPG_VERIFY_FULL.  If neither GPG_VERIFY_FULL nor GPG_VERIFY_VERBOSE is
> present, then nothing is printed.  This allows callers to invoke
> print_signature_buffer() unconditionally.

So in short, VERIFY_FULL is equivalent to !OMIT_STATUS?

As the direct callers of "print" are not the ones that set up bits
in flags, I think the proposed change makes the API easier to use.

Will queue.  Thanks.

> Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
> ---
>  builtin/tag.c           | 4 ++--
>  builtin/verify-commit.c | 2 +-
>  builtin/verify-tag.c    | 4 ++--
>  gpg-interface.c         | 2 +-
>  gpg-interface.h         | 6 +++---
>  tag.c                   | 4 +---
>  6 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index e0a4c25382..8489e220e8 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -112,10 +112,10 @@ static int verify_tag(const char *name, const char *ref,
>  {
>  	int flags;
>  	const struct ref_format *format = cb_data;
> -	flags = GPG_VERIFY_VERBOSE;
> +	flags = GPG_VERIFY_FULL | GPG_VERIFY_VERBOSE;
>  
>  	if (format->format)
> -		flags = GPG_VERIFY_OMIT_STATUS;
> +		flags = 0;
>  
>  	if (gpg_verify_tag(oid, name, flags))
>  		return -1;
> diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
> index 40c69a0bed..2a099ec6ba 100644
> --- a/builtin/verify-commit.c
> +++ b/builtin/verify-commit.c
> @@ -63,7 +63,7 @@ static int git_verify_commit_config(const char *var, const char *value, void *cb
>  int cmd_verify_commit(int argc, const char **argv, const char *prefix)
>  {
>  	int i = 1, verbose = 0, had_error = 0;
> -	unsigned flags = 0;
> +	unsigned flags = GPG_VERIFY_FULL;
>  	const struct option verify_commit_options[] = {
>  		OPT__VERBOSE(&verbose, N_("print commit contents")),
>  		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index f45136a06b..bd5e99925b 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -30,7 +30,7 @@ static int git_verify_tag_config(const char *var, const char *value, void *cb)
>  int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  {
>  	int i = 1, verbose = 0, had_error = 0;
> -	unsigned flags = 0;
> +	unsigned flags = GPG_VERIFY_FULL;
>  	struct ref_format format = REF_FORMAT_INIT;
>  	const struct option verify_tag_options[] = {
>  		OPT__VERBOSE(&verbose, N_("print tag contents")),
> @@ -53,7 +53,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  		if (verify_ref_format(&format))
>  			usage_with_options(verify_tag_usage,
>  					   verify_tag_options);
> -		flags |= GPG_VERIFY_OMIT_STATUS;
> +		flags = 0;
>  	}
>  
>  	while (i < argc) {
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 2d538bcd6e..fc182d39be 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -341,7 +341,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
>  	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
>  		fputs(sigc->payload, stdout);
>  
> -	if (output)
> +	if (flags & GPG_VERIFY_FULL && output)
>  		fputs(output, stderr);
>  }
>  
> diff --git a/gpg-interface.h b/gpg-interface.h
> index f4e9b4f371..4631a91330 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -3,9 +3,9 @@
>  
>  struct strbuf;
>  
> -#define GPG_VERIFY_VERBOSE		1
> -#define GPG_VERIFY_RAW			2
> -#define GPG_VERIFY_OMIT_STATUS	4
> +#define GPG_VERIFY_VERBOSE (1 << 0)
> +#define GPG_VERIFY_RAW (1 << 1)
> +#define GPG_VERIFY_FULL (1 << 2)
>  
>  enum signature_trust_level {
>  	TRUST_UNDEFINED,
> diff --git a/tag.c b/tag.c
> index 71b544467e..b8d6da81eb 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -28,9 +28,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
>  
>  	ret = check_signature(buf, payload_size, buf + payload_size,
>  				size - payload_size, &sigc);
> -
> -	if (!(flags & GPG_VERIFY_OMIT_STATUS))
> -		print_signature_buffer(&sigc, flags);
> +	print_signature_buffer(&sigc, flags);
>  
>  	signature_check_clear(&sigc);
>  	return ret;
