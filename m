Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120111F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 05:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfJDFvW (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 01:51:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54181 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbfJDFvW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 01:51:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EDB390C51;
        Fri,  4 Oct 2019 01:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FjU+q4b+lEV/
        T2Ex9m9qP3/OIVM=; b=J75IJKivII7ZuTvLtgT1n9q244X/yI4IL9E0LM+/Kgn6
        4BF+hBvmOZdZIEGsfciH8+sFjTUg4BfSK2L0fGhqvnBzCcxmazQyJPcvVFy+bIr7
        Iok3DJh3HeeXtNF6dNo7hPKJG27FCkHDv0cSVPGGVnxoQ8zO7gKm2BprBzbAjE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=C1u5HL
        nff2+PKJG3w6TJ6tLsPgXFcxVhKbQY5PlIwupjF235faWTv1EotH2WE7LShCMNgc
        Eq8sGEV0J8siyjw6FyiqNIevWYs0/1CN+IRpmtmSvDzZQicxie571kSkrvgNxMF+
        RH9CJDN7tPC+St0ep/OPrqHLKgJSj576gNysk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 582D090C50;
        Fri,  4 Oct 2019 01:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 83EC590C4F;
        Fri,  4 Oct 2019 01:51:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH -v3 0/8] fast export/import: handle nested tags, improve incremental exports
References: <20190930211018.23633-1-newren@gmail.com>
        <20191003202709.26279-1-newren@gmail.com>
Date:   Fri, 04 Oct 2019 14:51:15 +0900
In-Reply-To: <20191003202709.26279-1-newren@gmail.com> (Elijah Newren's
        message of "Thu, 3 Oct 2019 13:27:01 -0700")
Message-ID: <xmqq7e5l83e4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FBB7BC6C-E66A-11E9-895A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This series improves the incremental export story for fast-export and
> fast-import (--export-marks and --import-marks fell a bit short),
> fixes a couple small export/import bugs, and enables handling nested
> tags.  In particular, the nested tags handling makes it so that
> fast-export and fast-import can finally handle the git.git repo.
>
> Changes since v2 (full range-diff below):
>   - Code cleanup of patch 2 suggested by Ren=C3=A9
>
> Elijah Newren (8):
>   fast-export: fix exporting a tag and nothing else
>   fast-import: fix handling of deleted tags
>   fast-import: allow tags to be identified by mark labels
>   fast-import: add support for new 'alias' command
>   fast-export: add support for --import-marks-if-exists
>   fast-export: allow user to request tags be marked with --mark-tags
>   t9350: add tests for tags of things other than a commit
>   fast-export: handle nested tags

Thanks, both.  Replaced.
