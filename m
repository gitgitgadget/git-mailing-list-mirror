Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C51EC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110BD2223C
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mbh9J3vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443562AbgJ0UGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:06:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55272 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440676AbgJ0UGk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 16:06:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33EB0EF9F7;
        Tue, 27 Oct 2020 16:06:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LqLugb1biq4SJmBqDWiM5bh00bI=; b=Mbh9J3
        vmMKULzgg26njmjdbfq5INcdvkaxc+c+Z9xleQf4ApSL3FXWo4fXu1/8crSNDdp8
        ANjSaijBieoZW/DJI0fVrNEgzJnN6RFI/77thhDUtYFmmxK+LDdjUn3noD5n6kfJ
        HSCQ173CB/GwUC1dl903trp48HX96V9acvuMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z5/Be91/n1BOfVKVie31Z12xoQR8V8p9
        rFBoebinERS3gj6t90NUkwJrCnC7gcd6ae4MitUMRPbiFmQoKOm8plFSzGXwGW8F
        Bq2KCyKD2SV4j0hr/IRdWIAnNIccyODoUJytAxpWAi1cvykq+clEHLfGb2N/dHP2
        Dg4XrHxtp2k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C5A8EF9F6;
        Tue, 27 Oct 2020 16:06:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 627BDEF9F3;
        Tue, 27 Oct 2020 16:06:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Why does git diff-index show intent-to-add file as "Added"?
References: <20201017162111.gvisfz2daqvhnjmb@yadavpratyush.com>
        <xmqqimb88v35.fsf@gitster.c.googlers.com>
        <20201027120943.skmx6c3crbtu335o@yadavpratyush.com>
Date:   Tue, 27 Oct 2020 13:06:33 -0700
In-Reply-To: <20201027120943.skmx6c3crbtu335o@yadavpratyush.com> (Pratyush
        Yadav's message of "Tue, 27 Oct 2020 17:39:43 +0530")
Message-ID: <xmqqsg9zbfhy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA3CE81A-188F-11EB-85B5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> It is `git diff-index --cached HEAD`.
>  
>> What should happen in "diff-index --cached HEAD", I offhand do not
>> know.  "diff-index --cached HEAD" is a request to compare two trees,
>> i.e. the tree that _would_ be produced if you wrote the index out as
>> a tree (i.e. "git write-tree") right now, and the tree of HEAD.  So
>> I think it may be sensible for the command to behave as if the i-t-a
>> path does not even exist in the index when it is run with "--cached";
>> I may be missing some subtleties that require us to do something
>> different, but that is what I would think.
>
> This is what I think too. Can we then treat this as a bug, and work on 
> fixing it? Does any subsystem expert have any comments and/or provide 
> extra context?

I do not think Phillip considers himself an expert in this area, but
what he pointed out in the thread

    http://lore.kernel.org/git/xmqqo8kz70xv.fsf@gitster.c.googlers.com/

is worth listening to.
