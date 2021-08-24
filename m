Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463B2C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18CA3613A7
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhHXWFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:05:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60972 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbhHXWFq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 18:05:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5399A152288;
        Tue, 24 Aug 2021 18:05:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WIR3PQXEYjaWdnkr3KHykd5DONTC4SOQGnKfBg
        K7xiI=; b=Vc2IIWSdaGxHh8Md3xS57OfGj10+joaGRfrlbcvm6ZBDZZiG2TZ57J
        vfAeE7b4qagi9rUCJYYuRGTxshpUTxsGqx6pkuSNgH/ILbtjsMjQlJbdTdFgMVzJ
        gRKAMIAOtQVfdJFcZs8J9bouf/mcOAqIXv2ncZoR/2S1qU9bfxA4E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 13823152287;
        Tue, 24 Aug 2021 18:05:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4502D152286;
        Tue, 24 Aug 2021 18:04:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <cover.1617991824.git.me@ttaylorr.com>
        <cover.1629821743.git.me@ttaylorr.com>
        <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
        <xmqqa6l6oafd.fsf@gitster.g> <YSVX18UXh9vX+Zhp@nand.local>
        <xmqqr1eimtrp.fsf@gitster.g> <YSVjnSDaBXgXvT9W@nand.local>
Date:   Tue, 24 Aug 2021 15:04:56 -0700
In-Reply-To: <YSVjnSDaBXgXvT9W@nand.local> (Taylor Blau's message of "Tue, 24
        Aug 2021 17:24:45 -0400")
Message-ID: <xmqq35qymrcn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 523903DE-0527-11EC-81E6-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Aug 24, 2021 at 02:12:42PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> >> This needs to take object_dir into account, no?
>> >
>> > Yes and no; clear_midx_files_ext() still takes a pointer to a 'struct
>> > repository' until we pick up [1].
>>
>> I was hoping that [1] will become part of this series as a trivial
>> clean-up and bugfix, perhaps in its early part.
>
> Sure, that works even better. I'll send a reroll incorporating it as
> soon as I finish re-testing.

FWIW, here is what I have somewhere in 'seen' where two topics meet.

diff --cc midx.c
index c0209751b5,4574e6d411..0000000000
--- i/midx.c
+++ w/midx.c
@@@ -1090,6 -1351,9 +1351,9 @@@ static int write_midx_internal(const ch
  
  	commit_lock_file(&lk);
  
 -	clear_midx_files_ext(the_repository, ".bitmap", midx_hash);
 -	clear_midx_files_ext(the_repository, ".rev", midx_hash);
++	clear_midx_files_ext(object_dir, ".bitmap", midx_hash);
++	clear_midx_files_ext(object_dir, ".rev", midx_hash);
+ 
  cleanup:
  	for (i = 0; i < ctx.nr; i++) {
  		if (ctx.info[i].p) {
@@@ -1165,7 -1429,8 +1429,8 @@@ void clear_midx_file(struct repository 
  	if (remove_path(midx))
  		die(_("failed to clear multi-pack-index at %s"), midx);
  
 -	clear_midx_files_ext(r, ".bitmap", NULL);
 -	clear_midx_files_ext(r, ".rev", NULL);
++	clear_midx_files_ext(r->objects->odb->path, ".bitmap", NULL);
 +	clear_midx_files_ext(r->objects->odb->path, ".rev", NULL);
  
  	free(midx);
  }
