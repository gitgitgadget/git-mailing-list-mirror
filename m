Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738D2CDB482
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 21:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjJKV17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJKV16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 17:27:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F1490
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 14:27:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43FA131AF0;
        Wed, 11 Oct 2023 17:27:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=HLO8YQvc3CcainMxAz9yM1ZzQEyqA17IQtG3Dv
        SPmxw=; b=cGlFdD3lkwGRsGxiofBRnTU/oCnT+tEgedv641DPqOUpO8g+Kr6FzU
        gHlzOp4g3DYgEIZ02wKAZwdKq/HgSjTFbxAPHZ2ooDfSQG1Mf6aNRADV7Dv6J3rk
        LnNX3iEw/MOdd9xmZg7fAYkj3vR6oDNgyT0Ce5IRO/4LGxG7vMPns=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BCA331AEF;
        Wed, 11 Oct 2023 17:27:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F11131AEE;
        Wed, 11 Oct 2023 17:27:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: move process_address_list earlier to avoid,
 uninitialized address error
In-Reply-To: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com> (Michael
        Strawbridge's message of "Wed, 11 Oct 2023 16:22:18 -0400")
References: <ZQ1eGzqfyoeeTBUq@debian.me>
        <20230924033625.GA1492190@coredump.intra.peff.net>
        <ZRE6q8dHPFRIQezX@debian.me>
        <20230925080010.GA1534025@coredump.intra.peff.net>
        <ZRGdvRQuj4zllGnm@pobox.com>
        <20230925161748.GA2149383@coredump.intra.peff.net>
        <ZSal-mQIZAUBaq6g@debian.me>
        <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
        <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
Date:   Wed, 11 Oct 2023 14:27:49 -0700
Message-ID: <xmqq1qe0lui2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 084FE038-687D-11EE-A8E0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Strawbridge <michael.strawbridge@amd.com> writes:

> @@ -799,6 +799,10 @@ sub is_format_patch_arg {
>  
>  $time = time - scalar $#files;
>  
> +@initial_to = process_address_list(@initial_to);
> +@initial_cc = process_address_list(@initial_cc);
> +@initial_bcc = process_address_list(@initial_bcc);
> +

This does not look OK.  If we trace how @initial_to gets its value,

 - it first gets its value from @getopt_to and @config_to

 - if that is empty, and there is no $to_cmd, the end-user is
   interactively asked.

 - then process_address_list() is applied.

But this patch just swapped the second one and the third one, so
process_address_list() does not process what the end-user gave
interactively, no?

>  if ($validate) {
>         # FIFOs can only be read once, exclude them from validation.
>         my @real_files = ();

It almost feels like what need to move is not the setting of these
address lists, but the code that calls int validation callchain that
needs access to these address lists---the block that begins with the
above "if ($validate) {" needs to move below ...

> @@ -1099,10 +1103,6 @@ sub expand_one_alias {
>         return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
>  }
>  
> -@initial_to = process_address_list(@initial_to);
> -@initial_cc = process_address_list(@initial_cc);
> -@initial_bcc = process_address_list(@initial_bcc);
> -

... this point, or something, perhaps?

>  if ($thread && !defined $initial_in_reply_to && $prompting) {
>         $initial_in_reply_to = ask(
>                 __("Message-ID to be used as In-Reply-To for the first email (if any)? "),
