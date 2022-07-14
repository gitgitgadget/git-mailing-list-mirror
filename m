Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA91DC433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 23:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiGNXAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 19:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNXAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 19:00:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4BF474E0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 15:59:58 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EBAC1454F3;
        Thu, 14 Jul 2022 18:59:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P8o1l6W1V6mal8t9tB0glYPsfHd19to5U/ek0m
        DHVko=; b=vW5DCwruaCF2aO7HBaAcnQjfP+RMos+5bQgRaVI+/NiVCtfO/H/4np
        WGFYkeeyhqCwG6JNNmeu4BQZ2W/p/hIjN5xyeIaF85bzVLeCA7twvtl63zw7J0gj
        pFwfnp8Tsw/8sq6x9FWm/8OvqL05IDkRoIN42UDSqexJ73v3notRk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75BF41454F2;
        Thu, 14 Jul 2022 18:59:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDDF51454F1;
        Thu, 14 Jul 2022 18:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Kinzelman <paul@kinzelman.com>
Cc:     git@vger.kernel.org
Subject: Re: moving a repository question
References: <2e592944-edb8-2d49-981a-8ad220f97e82@kinzelman.com>
Date:   Thu, 14 Jul 2022 15:59:55 -0700
In-Reply-To: <2e592944-edb8-2d49-981a-8ad220f97e82@kinzelman.com> (Paul
        Kinzelman's message of "Thu, 14 Jul 2022 16:06:34 -0600")
Message-ID: <xmqqilnz2tck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE285726-03C8-11ED-BCFB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Kinzelman <paul@kinzelman.com> writes:

> I barely qualify as a novice on git, so my apologies in advance if this is a
> stupid question.
>
> Is everything that git needs stored in the .git tree?

Depends on what you want to do with "Git".

If you only copy .git/ and no file from the working tree, your "git
status" in the new location will report "you removed all the files
and you have nothing", for example.  If you are willing to do "git
reset --hard" after making such a copy of ".git/", it may be OK.  If
you had local changes in the working tree before taking a copy of
.git/, doing "git reset --hard" in the new location may not recover
the local changes in the original, so it may not be good and you may
have to copy the working tree files as well.

If you are using multiple worktrees linked to the repository,
copying .git/ is an absolute no-no.  Locations of secondary
worktrees are recorded in .git/ somewhere and copying them literally
would mean the new copy would mistakenly think that these secondary
worktrees linked to the original repository are linked to the new
copy instead.  There may be other things that will cause confusions
when copied.

"git clone" will of course sidestep all of these problems.
