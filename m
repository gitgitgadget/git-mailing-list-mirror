Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8266EB64DA
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 17:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjGGRwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjGGRwN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 13:52:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901110EC
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 10:52:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB2CC19DF23;
        Fri,  7 Jul 2023 13:52:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/OJpKmagXZJOsBsyNNLI3XbXxg8kItH1F8zfz1
        457sc=; b=O14bIeSbV8F9V7cOqUr70qpUrYesCWzyDmC2Ow88mMgUb4t4Wm0uB/
        Mm5Rz988MbhrDipcIXYnqVPUwPl2svY17cHH85Bp1FaAQaOaZjt56QZQWsru2BrF
        CQuq6pXku7Uby/+KhH8jIweGDvgJWaI/ICbCEjrE8oOxS+evfdtpc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2B2119DF22;
        Fri,  7 Jul 2023 13:52:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1CE3719DF21;
        Fri,  7 Jul 2023 13:52:11 -0400 (EDT)
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
Date:   Fri, 07 Jul 2023 10:52:09 -0700
In-Reply-To: <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
        (Alex Henrie's message of "Thu, 6 Jul 2023 17:23:42 -0600")
Message-ID: <xmqq8rbra9ti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF9CE3FC-1CEE-11EE-8D12-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> So, let's please give the user all of the
> information (two ways forward: reconcile or delete) and encourage them
> to make the most appropriate decision for their particular workflow.

It may be OK to do so in "git status".

It does not make any sense in "git checkout" to talk about "you can
force push".  That happens AFTER the work is done, and a message
that tells them BEFORE they start the work and asking them to
remember doing the right thing is an unnecessary noise.

I would rather see us toning the message down, e.g. "Your branches
have diverged. **IF** you intend to eventually reconcile the work on
the remote with yours, you could use `git pull` to do so now" is all
we should say.  If they do not want to keep the work on the remote,
at the point of seeing "you have diverged", there is nothing they
need to do.  There is no need to talk about "push --force" and force
the user to remember that they have to do so later.  When they try
"git push", an appropriate message should be given anyway, but that
is not the message you are touching in this patch.

For that matter, it does not make ANY sense to give "you can pull to
reconcile" message in the comment you are editing the log message
while running "git commit".  It would be the most inconvenient time
to do so.  So it might be necessary to first tweak the code so that
different messages depending on the codepath are shown, perhaps by
teaching format_tracking_info() who is calling.

Thanks.
