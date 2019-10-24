Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653331F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 01:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392279AbfJXBU3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 21:20:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53187 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXBU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 21:20:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72D0C1C6BD;
        Wed, 23 Oct 2019 21:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r+fDdqmU//D9v07uT/Ay/0k7h6A=; b=PZX3dn
        rLPQmccFp2S17zRiEHH0jTlMjGlQbwolQlL1Yyz+hi2RRpsFoinMj0smiedlHrk6
        yhuQEDMdz8Qmklrl08kn5hrFNuOw0rIvPYoqmInowSX+mf+ZcIut6GUz8wbm0DkL
        Mnf8fA5k2AlDc3ua8nAW3kYeBGLaj74qbUhaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qH7JnagmmToR6VxsqhZymY/kLldMikQ3
        EPgVhMrs/srceHLH2GJqyeVOHyLaa8kQbAzpw0XE1QgEOGy+8lJmgyQvVLUct7OE
        Q14P1ADtaOTT4xR7caDY8RfymcJsF61/Q4/s1WkAmsM5WXVejAhtVj8IdHwmqzZh
        qxFBcfoBrCg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69E221C6BC;
        Wed, 23 Oct 2019 21:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C17351C6BB;
        Wed, 23 Oct 2019 21:20:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] apply: respect merge.conflictStyle in --3way
References: <cover.1571832176.git.liu.denton@gmail.com>
        <56c31310db9358673af9905910e3332893d798de.1571832177.git.liu.denton@gmail.com>
Date:   Thu, 24 Oct 2019 10:20:25 +0900
In-Reply-To: <56c31310db9358673af9905910e3332893d798de.1571832177.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 23 Oct 2019 05:03:58 -0700")
Message-ID: <xmqqo8y7gcrq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75C7B8C2-F5FC-11E9-BF96-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Before, when doing a 3-way merge, the merge.conflictStyle option was not
> respected and the "merge" style was always used, even if "diff3" was
> specified.
>
> Call git_xmerge_config() at the end of git_apply_config() so that the
> merge.conflictStyle config is read.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  apply.c                   | 2 +-
>  t/t4108-apply-threeway.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Interesting.

I do not recall why I did not add this when I introduced the "diff3"
style.  If it were because I knew other parts of "git apply" were
not prepared to see the common ancestor hunk and using the "diff3"
style would have triggered breakage in them, I would remember, so
hopefully there is no subtle and hidden gotchas like it.

The implementation to trigger the "diff3" style conflict
presentation obviously is correct ;-)

Thanks.

>  test_apply_with_3way success default true
> -test_apply_with_3way failure 'merge.conflictStyle = diff3' 'test_config merge.conflictStyle diff3'
> +test_apply_with_3way success 'merge.conflictStyle = diff3' 'test_config merge.conflictStyle diff3'
>  
>  test_expect_success 'apply with --3way with rerere enabled' '
>  	test_config rerere.enabled true &&
