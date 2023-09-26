Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4AAE7F14B
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 02:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjI0CkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 22:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjI0Ch7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 22:37:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012AB7AB6
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 15:13:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D90619E04A;
        Tue, 26 Sep 2023 17:37:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=6ZrbfFZjjRsdUMqoc1velM/MkSe424XVfDExfh
        Glq+k=; b=CQwaOxDG16N/yFnI7QortcWI5MlrP1XmKN23N0yKGwNVpe6KNAmadb
        jTeDYDeDQr2eQdtU9wbFbER9Dgu/YKpI2pVpQP+a/07j6JI49IGWKU0i8YLRMuZa
        +iRjWuOu2XChqMSbRdTjbeU80XibxVEQSP+Ihj40Tv7ku23C+1HVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34E7919E049;
        Tue, 26 Sep 2023 17:37:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94F2A19E048;
        Tue, 26 Sep 2023 17:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] setup: Only allow extenions.objectFormat to be
 specified once
In-Reply-To: <87h6ngapqb.fsf@gmail.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 26 Sep 2023 11:01:00 -0500")
References: <87h6ngapqb.fsf@gmail.froward.int.ebiederm.org>
Date:   Tue, 26 Sep 2023 14:37:36 -0700
Message-ID: <xmqqr0mkmx9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E97E021C-5CB4-11EE-B98A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> Today there is no sanity checking of what happens when
> extensions.objectFormat is specified multiple times.  Catch confused git
> configurations by only allowing this option to be specified once.

Hmph.  I am not sure if this is worth doing, and especially only for
"objectformat".  Do we intend to apply different rules other than
"you can give it only once" to other extensions, and if so where
will these rules be catalogued?  I do not see particular harm to let
them follow the usual "last one wins".

If the patch were about trying to make sure that extensions, which
are inherentaly per-repository, appear only in $GIT_DIR/config and
complain if the code gets confused and tried to read them from the
system or global configuration files, I would understand, and
strongly support such an effort, ithough.

The real sanity we want to enforce is that what is reported by
running "git config extensions.objectformat" must match the object
format that is used in refs and object database.  Manually futzing
the configuration file and adding an entry with a contradictory
value certainly is one way to break that sanity, and this patch may
catch such a breakage, but once we start worrying about manually
futzing the configuration file, the check added here would easily
miss if the futzing is done by replacing instead of adding, so I am
not sure if this extra code is worth its bits.

But perhaps I am missing something and not seeing why it is worth
insisting on "last one is the first one" for this particular one.

Thanks.

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  setup.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/setup.c b/setup.c
> index 18927a847b86..ef9f79b8885e 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -580,6 +580,7 @@ static enum extension_result handle_extension(const char *var,
>  	if (!strcmp(ext, "noop-v1")) {
>  		return EXTENSION_OK;
>  	} else if (!strcmp(ext, "objectformat")) {
> +		struct string_list_item *item;
>  		int format;
>  
>  		if (!value)
> @@ -588,6 +589,13 @@ static enum extension_result handle_extension(const char *var,
>  		if (format == GIT_HASH_UNKNOWN)
>  			return error(_("invalid value for '%s': '%s'"),
>  				     "extensions.objectformat", value);
> +		/* Only support objectFormat being specified once. */
> +		for_each_string_list_item(item, &data->v1_only_extensions) {
> +			if (!strcmp(item->string, "objectformat"))
> +				return error(_("'%s' already specified as '%s'"),
> +					"extensions.objectformat",
> +					hash_algos[data->hash_algo].name);
> +		}
>  		data->hash_algo = format;
>  		return EXTENSION_OK;
>  	}
