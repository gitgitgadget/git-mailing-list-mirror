Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A49C3DA66
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 23:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbjHWX1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbjHWX1E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 19:27:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D93FE68
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 16:27:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A87A29A1E;
        Wed, 23 Aug 2023 19:27:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qMUssPgxTtzWwz16KcXaHHUWSL4BEkhyZCDTRO
        RQLrg=; b=RnnIwcMFie6wgZz6rVFIs4P97qNcNtSNkE/Qn1nZNaUjGHHDJpto62
        LWg2pRHFFHZMqXM6RJvwPIBIrULShumM3/kN79HS0+pzqA744XO6/5STcXDLGdl1
        7HJ3TN4sCljsQVJxtBiAyEdbVF5bo2avwEKrDibTgWA71L2qh5xVg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22F2829A1D;
        Wed, 23 Aug 2023 19:27:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B270329A1B;
        Wed, 23 Aug 2023 19:26:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        calvinwan@google.com, glencbz@gmail.com
Subject: Re: [PATCH v2 1/4] config: split out config_parse_options
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
        <cover.1692827403.git.steadmon@google.com>
        <5c676fbac370a2ba9d499ae2ef003e75b1d70081.1692827403.git.steadmon@google.com>
Date:   Wed, 23 Aug 2023 16:26:57 -0700
In-Reply-To: <5c676fbac370a2ba9d499ae2ef003e75b1d70081.1692827403.git.steadmon@google.com>
        (Josh Steadmon's message of "Wed, 23 Aug 2023 14:53:48 -0700")
Message-ID: <xmqq4jkpe3we.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E2DCDB0-420C-11EE-BC44-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> "struct config_options" is a disjoint set of options options used by the
> config parser (e.g. event listners) and options used by
> config_with_options() (e.g. to handle includes, choose which config
> files to parse).

There is some punctuation missing on the first line.  Perhaps an em-dash
between "options---options" or something like that?

> Split parser-only options into config_parse_options.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  bundle-uri.c |  2 +-
>  config.c     | 14 +++++++-------
>  config.h     | 37 ++++++++++++++++++++-----------------
>  fsck.c       |  2 +-
>  4 files changed, 29 insertions(+), 26 deletions(-)

> diff --git a/bundle-uri.c b/bundle-uri.c
> index 4b5c49b93d..f93ca6a486 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -237,7 +237,7 @@ int bundle_uri_parse_config_format(const char *uri,
>  				   struct bundle_list *list)
>  {
>  	int result;
> -	struct config_options opts = {
> +	struct config_parse_options opts = {
>  		.error_action = CONFIG_ERROR_ERROR,
>  	};

OK, and this one only needs the parse_options half, and presumably
all hunks (other than the one that splits the struct into two in
config.h) are about turning the users of config_options that only
need config_parse_options half.

As we do not see any funny casts in the patch text, compilers should
catch all questionable conversion in this step, if there were any.

OK.
