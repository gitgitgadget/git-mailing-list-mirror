Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00174EB64DA
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 17:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjGGRfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 13:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGGRfT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 13:35:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CAA268B
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 10:35:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1DF424726;
        Fri,  7 Jul 2023 13:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UV5i/DQixz6wan/JymfkL2lfMSjLFWKuiCWPKA
        TMtTY=; b=V6bVfTvVm+htGU4O+oXNst+kKixnJ0tM6TwRwyXLz3zxEN+aXn+wld
        tOnMJX7PeFDWBZ0YLNUfiiTYaXz15ANSZJHunNfy2Xd6oefys7Xhy/kBxr54xZR0
        YZn4rQ6/OKIxXUANcVIpB/2HxzlGVMx6omQ/FrXPeb7JKOlL9dciM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E987324725;
        Fri,  7 Jul 2023 13:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E8CF24724;
        Fri,  7 Jul 2023 13:35:04 -0400 (EDT)
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
        <xmqqttugbxds.fsf@gitster.g> <xmqqo7kobwpj.fsf@gitster.g>
        <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
Date:   Fri, 07 Jul 2023 10:35:03 -0700
In-Reply-To: <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
        (Alex Henrie's message of "Thu, 6 Jul 2023 17:23:42 -0600")
Message-ID: <xmqqttufaam0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C089338-1CEC-11EE-ADF0-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

>> When you start working on your own topic forked from upstream by
>> switching to it, if Git notices that your topic's base has become
>> behind (so that you would later need to merge or rebase to avoid
>> losing others' work), the "git pull" message is given to tell you
>> that it is OK if you want to catch up first before working on it.
>>
>> But the new message does not fit well in the workflow.  It is
>> primarily targetted for the users who are about to push out.  They
>> are at the point where they are way before being ready to "discard
>> the work at the remote".
>
> If the branch is merely behind, format_tracking_info prints "(use "git
> pull" to update your local branch)", which is perfectly reasonable.

Correct.  The message you are changing is not the "your topic has
become behind" case, and it is exactly why I said "your topic's base
has become behind", i.e. your upstream has diverged.

> The problem is only with the message that appears when the branches
> are divergent, "(use "git pull" to merge the remote branch into
> yours)", which is bad advice for the common GitHub/GitLab workflow
> that expects force-pushing.

We are in agreement in that "you must always reconcile" is not a
good message in general to give, but I do not think "git checkout"
and "git status" are good places to give the new advice "depending
on your workflow, you do not necessarily have to pay attention to
what the upstream has and just overwrite it may be good".  That is
about how to "push", but the user is a few steps before they are
ready to start thinking about how to "push" when they get this
message.

These places in "checkout" and "status", where the message is given,
were perfectly good places to say "by the way, you are divergent and
even long before you are ready to push your work out, you may want
to refresh your work to work better with the updated upstream",
which was the "use git pull to reconcile" message was all about.

