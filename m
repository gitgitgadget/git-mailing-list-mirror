Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145EAC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0511207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oXqsn92d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgEUSoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:44:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61262 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgEUSoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:44:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DB6869817;
        Thu, 21 May 2020 14:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OUhesDqwBzOwXuCDumQGRLq7IeE=; b=oXqsn9
        2dB9YqL1skdI4SGDRKp6D1ilkb9UxRlJ7irFisBMQnrVOUqZL4QCyuMQVs8KyizN
        KdPE3t5YGB+XwpBZST/yKQJ8vFmJ/ni5czyeOEX21wGSaLOCDl/RyPjlvEwi3Zqc
        TDrNxCUkAXQsFsJS+vge/QRbXIhTSIGxJETUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TvaYoo3SUx4g2CWnqNmJSkHg2zYUn+UJ
        7EA0wgrgB1XTReSRvrN4m5h3+kTymLchR9k7TLaHVwQ4C2xhK6LHcyiptQ1+RD7V
        bN/tvPOZWz95ExURHstYOinxFl82KTnDLNLxhI08c1j+Al+w/oiXuD7rKLXuER8x
        BQRrmgIoOug=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53FC969816;
        Thu, 21 May 2020 14:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D64A269814;
        Thu, 21 May 2020 14:44:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        congdanhqx@gmail.com, sunshine@sunshineco.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] submodule: port subcommand 'set-branch' from shell to C
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
Date:   Thu, 21 May 2020 11:44:22 -0700
In-Reply-To: <20200521163819.12544-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Thu, 21 May 2020 22:08:19 +0530")
Message-ID: <xmqqk115ruux.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 168B741A-9B93-11EA-9A54-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Convert submodule subcommand 'set-branch' to a builtin and call it via
> 'git-submodule.sh'.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Helped-by: Denton Liu <liu.denton@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> Thank you for the review Eric. I have changed the commit message,
> and the error prompts. Also, I have added a brief comment about
> the `quiet` option.

Sorry, I may have missed the previous rounds of discussion, but the
comment adds more puzzles than it helps readers.  "is currently not
used" can be seen from the code, but it is totally unclear why it is
not used.  Is that a design decision to always keep quiet or always
talkative (if so, "suppress output..." is not a good description)?
Is that that this is a WIP patch that the behaviour the option aims
to achieve hasn't been implemented?  Is it that no existing callers
pass "-q" to the scripted version, so there is no need to support
it (if so, why do we even accept it in the first place)?  Is it that
all existing callers pass "-q" so we need to accept it, but there is
nothing we need to make verbose so the variable is not passed around
in the codepath?




