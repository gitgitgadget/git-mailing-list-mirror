Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967D9C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhLPVta (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:49:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58319 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhLPVt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:49:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05309EE82E;
        Thu, 16 Dec 2021 16:49:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kcXeR4D9XBFVSiS4BAFLDBrNyhU8m0fqW+45mr
        YkFRs=; b=fazV2dPo9yrmeRfuYljNRetBH1Ar2TFD0/WGLyG9Uce1d+NPJAPu7D
        nBkL+NbG76U/n0JsySTr+slQ+IuI7vKSb94wGyT9uwwH7C7vL3YnWoKvd9bgQwPe
        hU7senkVLf4KtiRKG3Yc0lqXYm2L7O4linyPwhxJAwVPCFYHLJ0p8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0528EE82C;
        Thu, 16 Dec 2021 16:49:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D72AEE82B;
        Thu, 16 Dec 2021 16:49:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kashav Madan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Altmanninger <aclopte@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kashav madan <kshvmdn@gmail.com>
Subject: Re: [PATCH v3 1/4] bisect--helper: normalize format string of
 yes/no prompts
References: <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
        <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
        <e7672e70cc937ef3aaab9a36199470e01f6676a8.1639678735.git.gitgitgadget@gmail.com>
        <xmqqy24k8c0j.fsf@gitster.g>
Date:   Thu, 16 Dec 2021 13:49:27 -0800
In-Reply-To: <xmqqy24k8c0j.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        16 Dec 2021 13:39:56 -0800")
Message-ID: <xmqqlf0k8bko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B0D9F64-5EBA-11EC-B87A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Kashav Madan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Kashav Madan <kshvmdn@gmail.com>
>>
>> Both callers of git_prompt in bisect--helper.c ask the user for yes/no
>> confirmation. They both place the question mark after the choices,
>> however this is inconsistent with how most UNIX-y tools do it. Update
>> the format string to exclude the choices from the question.
>
> Is there somewhere that the claim can be confirmed?  I am not having
> much luck with queries like
>
> https://www.google.com/search?q=prompt+question+mark+and+choices
>
> that gave https://home.csulb.edu/~murdock/choice.html the most
> relevant page X-<.
>
> I personally do not think this step is worth doing, but in any case,
> NEVER touch po/* directory when you are updating code and strings in
> the code.  It is something our i18n coordinator will do at certain
> point in the release cycle.

After reading the series through, it seems all four patches share
the same problem (i.e. swapping ? and choices, and touching po/*).

I'll discard this round, and instead queue the v2 from you, using
the proposed log message to what I wrote for you during my review.

Thanks for your first contribution, and welcome to the Git
development community ;-)

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From: Kashav Madan <kshvmdn@gmail.com>
Date: Wed, 15 Dec 2021 22:58:58 +0000
Subject: [PATCH] help: make auto-correction prompt more consistent

There are three callsites of git_prompt() helper function that ask a
"yes/no" question to the end user, but one of them in help.c that
asks if the suggested auto-correction is OK, which is given when the
user makes a possible typo in a Git subcommand name, is formatted
differently from the others.

Update the format string to make the prompt string look more
consistent.

Signed-off-by: Kashav Madan <kshvmdn@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 973e47cdc3..71444906dd 100644
--- a/help.c
+++ b/help.c
@@ -643,7 +643,7 @@ const char *help_unknown_cmd(const char *cmd)
 		else if (autocorrect == AUTOCORRECT_PROMPT) {
 			char *answer;
 			struct strbuf msg = STRBUF_INIT;
-			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
+			strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
 			answer = git_prompt(msg.buf, PROMPT_ECHO);
 			strbuf_release(&msg);
 			if (!(starts_with(answer, "y") ||
-- 
2.34.1-469-g0a17e94afe

