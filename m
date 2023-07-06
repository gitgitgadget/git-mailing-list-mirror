Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A3BEB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 20:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjGFUkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 16:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjGFUkO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 16:40:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73079113
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 13:40:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1041D1C832;
        Thu,  6 Jul 2023 16:40:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5B1xIn+wDvix3laSv1VgvP6LPWoA8IJi/g+rM4
        uM8X0=; b=vH11xvUd1K6/B4j8OxP09EPwqcFTEKvFwQbqTBTXdcLAznYU21Rqia
        AueD/LxL++hAHpp023uc0Z7TwpLSWqx67T3gg28GdhIXlaC2yf3icq5P8i0rODF8
        Gmt/wW30q+d2s+RopM1GMsJkD3lCldetHxBTwIKVbW0/TPFolVfWk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 095CF1C831;
        Thu,  6 Jul 2023 16:40:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99DDE1C82E;
        Thu,  6 Jul 2023 16:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
        <20230706040111.81110-1-alexhenrie24@gmail.com>
        <20230706040111.81110-2-alexhenrie24@gmail.com>
        <xmqqttugbxds.fsf@gitster.g>
Date:   Thu, 06 Jul 2023 13:40:08 -0700
In-Reply-To: <xmqqttugbxds.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        06 Jul 2023 13:25:35 -0700")
Message-ID: <xmqqo7kobwpj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C75E582-1C3D-11EE-9658-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/remote.c b/remote.c
>> index a81f2e2f17..1fe86f8b23 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -2323,7 +2323,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>>  			base, ours, theirs);
>>  		if (advice_enabled(ADVICE_STATUS_HINTS))
>>  			strbuf_addstr(sb,
>> -				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
>> +				_("  (To reconcile your local changes with the work at the remote, you can\n"
>> +				  "  use 'git pull' and then 'git push'. To discard the work at the remote\n"
>> +				  "  and replace it with what you did (alone), you can use\n"
>> +				  "  'git push --force'.)\n"));
>>  	}
>
> Since wt-status.c:wt_longstatus_print_tracking() calls this
> function, I would expect that this change would manifest as test
> breakage in "git status" (or "git commit" whose commit log edit
> buffer is examined) tests.  Are we lacking test coverage?

The other callsite of format_tracking_info() is "git checkout".
When you start working on your own topic forked from upstream by
switching to it, if Git notices that your topic's base has become
behind (so that you would later need to merge or rebase to avoid
losing others' work), the "git pull" message is given to tell you
that it is OK if you want to catch up first before working on it.

But the new message does not fit well in the workflow.  It is
primarily targetted for the users who are about to push out.  They
are at the point where they are way before being ready to "discard
the work at the remote".

I guess the updated message in the context of "git status" has
exactly the same issue.  The user is about to make a commit, which
will later be pushed out.

So, while I agree that new users may need to be made aware of
situations where they should not afraid of overwriting the remote
repository by forcing a non-ff push, I am not sure if this is a good
advice message to convey it.

