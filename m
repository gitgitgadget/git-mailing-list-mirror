Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC483C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A291261006
	for <git@archiver.kernel.org>; Thu,  6 May 2021 23:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhEFXt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 19:49:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53018 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbhEFXt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 19:49:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DE97128D86;
        Thu,  6 May 2021 19:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5aWznMy6dUeGRIPrFDRJdXmFUNHTNaQV9BHzwm
        buEN4=; b=lISu6Zt/Z3nvWTdiS5IEEJ+GJx7uYuJVql5FFIvNZ2i1EnNkjuStSG
        oViNMYsnFXYcpIQYSic2kgpRLgV+/1CImaRUm1GVXI6PEKIKEjR5AQiLGHoIeRyd
        1cTn98Q+EpfdmwZhY9A9Kbpm4neXmratSWp7MDf6Hznt12G5h9w1o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 648A1128D85;
        Thu,  6 May 2021 19:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B2CD128D82;
        Thu,  6 May 2021 19:48:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 2/8] format-patch: confirmation whenever patches exist
References: <20210506165102.123739-1-firminmartin24@gmail.com>
        <20210506165102.123739-3-firminmartin24@gmail.com>
Date:   Fri, 07 May 2021 08:48:53 +0900
In-Reply-To: <20210506165102.123739-3-firminmartin24@gmail.com> (Firmin
        Martin's message of "Thu, 6 May 2021 18:50:56 +0200")
Message-ID: <xmqqk0obwhi2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DF0CE00-AEC5-11EB-9003-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin <firminmartin24@gmail.com> writes:

> Currently, git-format-patch, along with the option --cover-letter,
> unconditionaly overwrites a cover letter with the same name (if
> present). Although this is a desired behaviour for patches which are
> auto-generated from Git commits log, it might not be the case for a
> cover letter whose the content is meticulously written manually.

True.  But if we require confirmation before overwriting patches,
that would be overall worsening the end-user experience, I am
afraid.  In a 5-patch series with a cover-letter that was formatted,
proofread, corrected with "rebase -i" and then re-formatted, unless
you rephrased the titles of the patches, you'd get prompted once for
the cover letter (which *IS* valuable) and five-times for patches
(which is annoying).

It also is unfortunate that this change does not address another
annoyance after retitling a patch---the stale output from the
previous run is not overwritten with the updated one but is left in
the same directory as the output files from the latest run.

So, while I very much do welcome the motivation, I am not onboard
with this particular design.

> diff --git a/builtin/log.c b/builtin/log.c
> index 6102893fcc..bada3db9eb 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -35,6 +35,7 @@
>  #include "repository.h"
>  #include "commit-reach.h"
>  #include "range-diff.h"
> +#include "prompt.h"
>  
>  #define MAIL_DEFAULT_WRAP 72
>  #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
> @@ -959,6 +960,10 @@ static int open_next_file(struct commit *commit, const char *subject,
>  			 struct rev_info *rev, int quiet)
>  {
>  	struct strbuf filename = STRBUF_INIT;
> +	struct strbuf file_exists_prompt = STRBUF_INIT;
> +	const char *yesno;
> +	static int not_prompted = 1;

When the API passes a structure that keeps track of state (like
"struct rev_info *rev", used to hold rev->diffopt.file which is
clearly a state), add a member to it, instead of inventing a
function local static that will hurt reuse of the API you are
touching.  This static variable will make it impossible from a
single process to format two patch series, but if it is made a part
of rev_info, you do not have to introduce such a limitation.
