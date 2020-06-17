Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA078C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D567217A0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DDiBNLq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFQSJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:09:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57481 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgFQSJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 14:09:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02FA67180A;
        Wed, 17 Jun 2020 14:09:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sZe3LJ0wvyR35ziCyiLyFa3Jtzg=; b=DDiBNL
        q0fP8wO/iIhObqnFC3AK2WSd5o+61yTP9k7vD4oEjQOk/g/W/oM86THVnGJpCUtv
        5qCdWgQi0l3CsXNMfLz2J34atV5y4cYUILntVclA2uq2pJlzVNMXPpw0TaSikqAs
        zG21m0625qvFccZNBiOddBTLK/qYq174UQ1AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DU0IL/sKb+GwIkJQAOopxKx2ZvPWpnmR
        Md32jcmbX1fkhkNTiFl/e9g3bnP84C+Az3RJrP35ekGlb94H29UjId9UP2Oimd3A
        zMorvi3Cgx0njuhaHQ9ZhJF1oxUPjEyoAivR2KTQLkZ3myEE2SFSQWl4V/F1v8+N
        Q0iSkwCZd74=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF4B571809;
        Wed, 17 Jun 2020 14:09:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73B1371808;
        Wed, 17 Jun 2020 14:09:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] branch: don't mix --edit-description
References: <cover.1592221875.git.liu.denton@gmail.com>
        <1d0eebd1ecf24db0241801af31d904a19ad391a8.1592221875.git.liu.denton@gmail.com>
Date:   Wed, 17 Jun 2020 11:09:44 -0700
In-Reply-To: <1d0eebd1ecf24db0241801af31d904a19ad391a8.1592221875.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 15 Jun 2020 07:53:20 -0400")
Message-ID: <xmqqv9jpva1j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B977D71C-B0C5-11EA-A3BA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> `git branch` accepts `--edit-description` in conjunction with other
> arguments. However, `--edit-description` is its own mode, similar to
> `--set-upstream-to`, which is also made mutually exclusive with other
> modes. Prevent `--edit-description` from being mixed with other modes.

Makes sense.  Do we have some "these options are mutually exclusive"
test?

It makes me wonder if this can/should be switched to OPT_CMDMODE()
so that we do not have to write this if statement in the first
place.


> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index accb61b1aa..99633ad004 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -693,7 +693,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		list = 1;
>  
>  	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
> -	    list + unset_upstream > 1)
> +	    list + edit_description + unset_upstream > 1)
>  		usage_with_options(builtin_branch_usage, options);
>  
>  	if (filter.abbrev == -1)
