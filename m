Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF17FC3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 21:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B5E21D56
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 21:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S57S0Sp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCBVEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:04:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61530 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgCBVEA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 16:04:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEE39C1EBB;
        Mon,  2 Mar 2020 16:03:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UekUHmo6gXLhupx4FvPRyu9suhc=; b=S57S0S
        p6pNRJN7IbsG+J9e1D3sx6sFLk564UWqugTjQ+runcbPiOSwY8T8yNLKEnz5RbDg
        BRxsnbzUwhm3bR6EBOYci0GrSQTvwYJMHtZWkKHk7cMTpmZ7/xD4zeKOhhNL8VU+
        8uV8zZP1fu5bH+bVcfr+4wEYC/u+u3dReea5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SemFmytNoZc6oCzCPJFLnzGAe6Wbqf9p
        NY+dQ3B8hhoiBTuu6jjXL+0z6l8MmwQ4RJjUeFTYra2IV3lAFbtaq8TReMNjJHdM
        WZHuV3dnCc4Up8vOnWJHVNx+bFMfo6kZF+vMTSJKmYD7OQH8YMkvglKCarupdN2f
        a+vmuP4nu1Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E76D6C1EBA;
        Mon,  2 Mar 2020 16:03:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1FC2FC1EB9;
        Mon,  2 Mar 2020 16:03:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v7 3/4] advice: revamp advise API
References: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
        <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
        <a4673803eaf881f7caa25d97e432c0ff0d065060.1583179320.git.gitgitgadget@gmail.com>
Date:   Mon, 02 Mar 2020 13:03:53 -0800
In-Reply-To: <a4673803eaf881f7caa25d97e432c0ff0d065060.1583179320.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Mon, 02 Mar 2020 20:01:59
        +0000")
Message-ID: <xmqqblpebhae.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54F03942-5CC9-11EA-9D27-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static struct {
> +	const char *key;
> +	int enabled;
> +} advice_setting[] = {
> +	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },

It would be nicer to future developers to flip the polarity, as we
do not have to write 1 all over the place, especially if we plan to
extend the structure over time and to use designated initializers
for only certain fields:

	static struct {
		const char *key;
		int disabled;
	} advice_setting[] = {
		[ADDVICE_ADD_EMBEDDED_REPO] = { .key = "addEmbeddedRepo" },

> @@ -149,6 +218,13 @@ int git_default_advice_config(const char *var, const char *value)
>  		if (strcasecmp(k, advice_config[i].name))
>  			continue;
>  		*advice_config[i].preference = git_config_bool(var, value);
> +		break;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
> +		if (strcasecmp(k, advice_setting[i].key))
> +			continue;
> +		advice_setting[i].enabled = git_config_bool(var, value);
>  		return 0;

Turning this into "break;" would make it similar to the loop before
this one, and will allow other people to add more code after this
loop later.

> +int cmd__advise_if_enabled(int argc, const char **argv)
> +{
> +	if (!argv[1])
> +	die("usage: %s <advice>", argv[0]);
> +
> +	setup_git_directory();
> +	git_config(git_default_config, NULL);
> +
> +	/*
> +	  Any advice type can be used for testing, but NESTED_TAG was selected
> +	  here and in t0018 where this command is being executed.
> +	 */

Style (will fix up locally).

Thanks.  I think this is reasonable with or without the suggested
fixes.
