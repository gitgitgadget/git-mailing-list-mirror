Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1035208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 01:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbdIFBmN (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 21:42:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59510 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754459AbdIFBmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 21:42:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71C759592B;
        Tue,  5 Sep 2017 21:42:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gF2nLQGliA7Y4CDOWlaH8izc00w=; b=gDx4nF
        qMn0yeQA8a8iDePJoCzN1pAHopThRKZqCnoUPAmxCtFTpTGFpjZiXcuenVmzLgu7
        kHm3q4cy5HCJr7snnUz6oWiP5HjZDb5vvAlCsDSNmMUpSNffpNKwRRe/Ksz0snoH
        FEgpPFUPLrsA06QA9WH166Korb8EFBOtxrhLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V4c2XsDeBH8GQYPEs2PkiivfzKOGnAE0
        cLqQoEfh1YOoorr+jZHhVn4t+nL+zzffRSjXcISuIv1c9eI30Pd+isGrbdyypcQy
        5Rv8F9LoSFS+L1nZDnbLfkyai1ZvGSsDcPtRUjigXWjHvOJp5qkGa6ZwgVqWEdkq
        Ak+fnGbIKVs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A0C09592A;
        Tue,  5 Sep 2017 21:42:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1EC695928;
        Tue,  5 Sep 2017 21:42:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/10] towards clean leak-checker output
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
        <CAN0heSrVzRPc+iVqU02qzk=DB0WT6Fscn6X-hZPFkM1TikMPVQ@mail.gmail.com>
        <20170905190212.4xx4xukx2bbtudij@sigill.intra.peff.net>
Date:   Wed, 06 Sep 2017 10:42:07 +0900
In-Reply-To: <20170905190212.4xx4xukx2bbtudij@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 5 Sep 2017 15:02:12 -0400")
Message-ID: <xmqqd174a9hs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98734CF0-92A4-11E7-B7BA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In fact, the whole extract_argv0_path thing is pointless without
> RUNTIME_PREFIX. So I think one reasonable fix is just:
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index fb94aeba9c..09f05c3bc3 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -5,7 +5,10 @@
>  #define MAX_ARGS	32
>  
>  static const char *argv_exec_path;
> +
> +#ifdef RUNTIME_PREFIX
>  static const char *argv0_path;
> +#endif
>  
>  char *system_path(const char *path)
>  {
> @@ -40,6 +43,7 @@ char *system_path(const char *path)
>  
>  void git_extract_argv0_path(const char *argv0)
>  {
> +#ifdef RUNTIME_PREFIX
>  	const char *slash;
>  
>  	if (!argv0 || !*argv0)
> @@ -49,6 +53,7 @@ void git_extract_argv0_path(const char *argv0)
>  
>  	if (slash)
>  		argv0_path = xstrndup(argv0, slash - argv0);
> +#endif
>  }
>  
>  void git_set_argv_exec_path(const char *exec_path)
>
> -Peff

Yeah, I kind of like this (I would have reduced the ifdef noise by
leaving a totally-unused argv0_path in the BSS, though).

