Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1805C11D19
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84877208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o4W1y41M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgBTScr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:32:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61113 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTScr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 13:32:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24E97A8B89;
        Thu, 20 Feb 2020 13:32:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=srH9tEN9YRegfbJXFKKs2jJ+jlk=; b=o4W1y4
        1MUY6E6KK9ZD5G1SXL1G3geUdjgMmyyIqf1213duXonjFyYE5vfHEF1GtpM1tdS7
        8EQIh+5fHLv/NGZzieGdxGuaA6iG7aqlEoE3m1++CwpCM7CFF2LKM0f7wLsCeFAD
        r8O96J3by2Dse/8eFLUCzukaoEemhs6Lbp4hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jYimjZi0FPh5KtlQFwQ9rDtqPKTvqhXk
        SF1CZ+ZNFaFA7sTRO7udx71K4voP3/a+0wXf57+YqISi938R+XOmDS9bCTw5SNg4
        esotvVXHe5Gxvm6hDbqa8V4Gucad/sok9oH9bloQBIVonHbXSbwEtN/VNAD+S5ru
        sCclB5ZTKjg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C845A8B87;
        Thu, 20 Feb 2020 13:32:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73D08A8B86;
        Thu, 20 Feb 2020 13:32:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG: git clean -d cannot remove files from read-only directories
References: <BL0PR2101MB10898F2F84B06B1A6B23228380130@BL0PR2101MB1089.namprd21.prod.outlook.com>
Date:   Thu, 20 Feb 2020 10:32:42 -0800
In-Reply-To: <BL0PR2101MB10898F2F84B06B1A6B23228380130@BL0PR2101MB1089.namprd21.prod.outlook.com>
        (Adam Milazzo's message of "Thu, 20 Feb 2020 18:27:22 +0000")
Message-ID: <xmqqo8ttaz3p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62ABA138-540F-11EA-B085-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Milazzo <Adam.Milazzo@microsoft.com> writes:

> Repro steps:
> 1. git init 
> 2. mkdir d
> 3. touch d/a
> 4. chmod -w d
> 5. git clean -fd
>
> Actual result:
> Git doesn't remove anything, saying "warning: failed to remove d/a".
>
> Expected result:
> Git should remove the subdirectory 'd' along with its
> contents. Note that git can remove a read-only file (touch b;
> chmod -w b; git clean -f) with no problem.

It is how UNIX-like filesystem works, isn't it?

As long as a directory D is writable/executable, any regular file
inside it can be removed regardless of the perm-bits of the file.

	mkdir d
	touch d/a
	chmod -w d
	rm d/a

would not let you remove the file d/a from d/, exactly because you
cannot modify d/ (it is not writable).
