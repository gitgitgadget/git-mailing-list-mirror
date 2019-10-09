Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582C81F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 03:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfJIDCv (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 23:02:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63696 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJIDCv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 23:02:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48BD784CC9;
        Tue,  8 Oct 2019 23:02:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4uNH5OocFwrl6jueskcQNRi9nEY=; b=as6BU+
        nlw33fH1Fu2+TnkVmfX9U+g/NxxXT31BOQkpV3C11hshLGpqoykQrYKMBDJc3YMk
        KUDst4wxEub33EcAGNenWtekXVJp7/i85P7Q0weKT2fvIeIvPDiMveX9KOMdOFZt
        VWMI7o2SvAW89D00sdcN/vUDXGm3kV2MXPsnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ANLqjAC/T2pKznrqs5/4HaqMv/TrLYgz
        q4iX/fExAxRxY4KkSv5R9y4d2z+ktbl+Zydp7ckeo9jJf4MgjHjkJy0+OW91V2Sy
        5HL0weo450ryHr71tzLASCJzwHrYxhxwUxo+igpmXzt4B/qPLzrQnLTyL/fggglc
        WjNiBMY9a70=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40E6184CC7;
        Tue,  8 Oct 2019 23:02:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CAD884CC6;
        Tue,  8 Oct 2019 23:02:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     git@vger.kernel.org, cuifang@sugon.com
Subject: Re: How to find the commit that erase a change
References: <5e12e2d8.1ed16.16dae58d6ac.Coremail.wuzhouhui14@mails.ucas.ac.cn>
Date:   Wed, 09 Oct 2019 12:02:44 +0900
In-Reply-To: <5e12e2d8.1ed16.16dae58d6ac.Coremail.wuzhouhui14@mails.ucas.ac.cn>
        (wuzhouhui's message of "Wed, 9 Oct 2019 10:28:40 +0800 (GMT+08:00)")
Message-ID: <xmqqmuealiy3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4519B6F6-EA41-11E9-83AF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

wuzhouhui <wuzhouhui14@mails.ucas.ac.cn> writes:

> I have a file which contains complicated change history. When I use
>     git log -p file
> to see all changes made in this file, I found that a change disappeared
> for no reason.

"git log [-p] <pathspec>" is not about seeing *all* changes made to
the path(s) that match the pathspec.  Especially when your history
has merges, the command is to give you _one_ simplest explanation as
to how the contents of the path(s) came to be in the shape you see
in HEAD.

So for example, if you have a history like this (time flows from
left to right):

    O-----A-----B----M-----N
           \        /
            \      /
             X----Y

where A or B did *not* touch "file", X added a definition of func()
to "file", Y reverted the change X made to "file", M made a natural
merge between B and Y and N did not touch "file", "git log N file"
would not even show the existence of commits X or Y.  In the larger
picture, at ancient time O, the file started without func(), and
none of the commits A, B, M or N felt the need to add it and as the
result, N does not need the unwanted func().  So "file's contents
are the same since O throughout the history reaching N" is given as
_one_ simplest explanation.

The "--full-history" option may help, though.
