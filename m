Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3EBC04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 23:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjHJXnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 19:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHJXnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 19:43:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C12270C
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 16:43:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2870219DA5A;
        Thu, 10 Aug 2023 19:43:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HLYWL52vyr3ie0b8w6vg2CaTwmMKOVBG73ezTP
        cEnPc=; b=YMfUul2L51OMtg24B+iRvhVlnX/Isbz+cNACtPOzMDCDxX4gVKuCtX
        LVMXqq2fD3tnTtr0uPbhteTkh87H3qqLrvVL2vtq4KLq3Oq4jFa+/E1R0//yWueH
        DMnZ0/UdppypPqcsni1iA3OoIkH+uj2ko93oLSP49ux9Pik7x1/AY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FC5219DA59;
        Thu, 10 Aug 2023 19:43:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 894CE19DA58;
        Thu, 10 Aug 2023 19:43:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Subject: Re: [RFC PATCH v2 4/7] parse: create new library for parsing
 strings and env values
References: <20230810163346.274132-1-calvinwan@google.com>
        <20230810163654.275023-4-calvinwan@google.com>
        <kl6ledka8owj.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 10 Aug 2023 16:43:19 -0700
In-Reply-To: <kl6ledka8owj.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 10 Aug 2023 16:21:16 -0700")
Message-ID: <xmqqy1iipip4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B00632AE-37D7-11EE-A0A2-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I think it's reasonable to have the string value parsing logic in
> git-std-lib, e.g. this parsing snippet from diff.c seems like a good
> thing to put into a library that wants to accept user input:
>
>   static int parse_color_moved(const char *arg)
>   {
>     switch (git_parse_maybe_bool(arg)) {
>     case 0:
>       return COLOR_MOVED_NO;
>     case 1:
>       return COLOR_MOVED_DEFAULT;
>     default:
>       break;
>     }
>
>     if (!strcmp(arg, "no"))
>       return COLOR_MOVED_NO;
>     else if (!strcmp(arg, "plain"))
>       return COLOR_MOVED_PLAIN;
>     else if (!strcmp(arg, "blocks"))
>       return COLOR_MOVED_BLOCKS;
>     /* ... */
>   }
>
> But, I don't see a why a non-Git caller would want environment value
> parsing in git-std-lib.

It also is debatable why a non-Git caller wants to parse the value
to the "--color-moved" option (or a configuration variable) to begin
with.  Its vocabulary is closely tied to what the diff machinery in
Git can do, isn't it?
