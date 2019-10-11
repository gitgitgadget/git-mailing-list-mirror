Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30A71F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 01:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfJKBmZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 21:42:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64528 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfJKBmY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 21:42:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39C39215AB;
        Thu, 10 Oct 2019 21:42:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0/oGK0w2kwhqI4RMWXN2KQzLuo8=; b=xutRNn
        OasaIuVafknN0sp/Ym653SElLnJi5fyrDbrS4Ec9vhdNqP22cj8oxMtf/Xs2+WJW
        f+cC3/mto7iqqSAyWH81iGwUExHtDs8T2Vkzcay8YfD8dqSUP+NMPbImnXDJcadI
        n6lyweYwrDsak5SKWRCVCFj9UhfbZC07vN7o0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LKrSUi2V7docHm7cuxdAT+VOSODqFjh8
        PmarLsZf/C4ENuuHM3tFnc8rFrB8PDDAFeDwOrEl41PZZMrsWw6kHfw3PqC/KSL1
        ujlATJdBYglnGmEI9yxTJUWu7Egr3ToFtQBipOhadAD69m49NatrFVj7DChaxwmx
        z+gKE1o39Io=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31336215AA;
        Thu, 10 Oct 2019 21:42:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95387215A8;
        Thu, 10 Oct 2019 21:42:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH 01/11] graph: automatically track visible width of `strbuf`
References: <pull.383.git.gitgitgadget@gmail.com>
        <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
        <20191010230550.GA42541@generichostname>
Date:   Fri, 11 Oct 2019 10:42:20 +0900
In-Reply-To: <20191010230550.GA42541@generichostname> (Denton Liu's message of
        "Thu, 10 Oct 2019 16:05:50 -0700")
Message-ID: <xmqq7e5cjbwj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E1A7112-EBC8-11E9-A328-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> 	static int calculate_width(const struct strbuf *row)
> 	{
> 		int in_termcode = 0;
> 		int width = 0;
> 		int i;
>
> 		for (i = 0; i < row.len; i++) {
> 			if (row.buf[i] == '\033')
> 				in_termcode = 1;
>
> 			if (!in_termcode)
> 				width++;
> 			else if (row.buf[i] == 'm')
> 				in_termcode = 0;
> 		}
> 	}

Not every byte that is outside the escape sequence contributes to
one display columns.  You would want to take a look at utf8_width()
for inspiration.

