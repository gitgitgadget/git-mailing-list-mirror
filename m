Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0801F406
	for <e@80x24.org>; Fri, 22 Dec 2017 21:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756322AbdLVVgM (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 16:36:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52320 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755934AbdLVVgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 16:36:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8EF9BF4DD;
        Fri, 22 Dec 2017 16:36:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fXRrxUZV3zEiQPsv8telx/xKTlQ=; b=xB5uEM
        vTdhgioGuAO/mSCcRKorg7kBCV1c8Xq0hRtMAyFMANGERb1IsB/lnmT5WmhzBa19
        xxHOlEZvndiT/4UFHmtoFM/yPJdPArlLbf4Lvf64RohrGeHpueHWzmc1IlARzQfR
        WiUDuTWjwliFOHf79fIJTGmcZYiuynEfCcBQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N4AwaUGCH2HgdrvTEbPuQMmuWRsZiEA8
        yJcaODatUJ07Q9bxQD9I1CH5NrlAz4dBpaFBA27aXLJ6TFN9gRNy/+jQt0v2AiPs
        8FTgCtZqLb84i6+IQAmy6ML04fnXi67hBCe/PURinlH/IxF+bDD6rGLE7DicuV0F
        cFvxgAo6H0M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1932BF4DC;
        Fri, 22 Dec 2017 16:36:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E26ABF4DB;
        Fri, 22 Dec 2017 16:36:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "phillip.wood\@talktalk.net" <phillip.wood@talktalk.net>
Cc:     <johannes.schindelin@gmx.de>, <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH] sequencer: assign only free()able strings to gpg_sign
References: <f4420880aa4ee73b7c8e435de1efccf9a969fd41.1513943347.git.johannes.schindelin@gmx.de>
        <17655681.1077671513947507373.JavaMail.defaultUser@defaultHost>
Date:   Fri, 22 Dec 2017 13:36:09 -0800
In-Reply-To: <17655681.1077671513947507373.JavaMail.defaultUser@defaultHost>
        (phillip's message of "Fri, 22 Dec 2017 12:58:27 +0000 (GMT)")
Message-ID: <xmqqr2rmphrq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 205E3DAE-E760-11E7-B283-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"phillip.wood@talktalk.net" <phillip.wood@talktalk.net> writes:

>>----Original Message----
>>From: johannes.schindelin@gmx.de
>>Date: 22/12/2017 11:50 
>>To: <git@vger.kernel.org>
>>Cc: "Junio C Hamano"<gitster@pobox.com>, "Phillip Wood"<phillip.
> wood@dunelm.org.uk>, "Kaartic Sivaraam"<kaartic.sivaraam@gmail.com>
>>Subj: [PATCH] sequencer: assign only free()able strings to gpg_sign
>>
>>The gpg_sign member of the replay_opts structure is of type `char *`,
>>meaning that the sequencer deems the string to which gpg_sign points 
> to
>>be under its custody, i.e. it needs to be free()d by the sequencer.
>>
>>Therefore, let's only assign malloc()ed buffers to it.
>>
>>Reported-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>>Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>---
>>
>>	Phillip, if you want to squash these changes into your patches,
>>	I'd totally fine with that.
>>
>
> Hi Johannes, thanks for putting this together, the patch it fixes is 
> already in next so I think it'd be best to leave this one separate. I 
> wonder if it would be worth adding another test, see below.

Thanks, both.  Let's queue this on top as a fix-up.

