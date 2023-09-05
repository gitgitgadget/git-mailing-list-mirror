Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB7DCA0FFD
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjIEQAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354841AbjIEO5X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 10:57:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BA518C
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 07:57:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5429D1B6CEC;
        Tue,  5 Sep 2023 10:57:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=1OXLlO5frn3Q9T/3Mi8SPAUucHarXLubLOaZSf
        OJzZ4=; b=q1gbeSoTOr8+azJlf+rVHW5mBQNk/bWU6jhdTPCQ249qC/Ur9dy3gs
        uOlFhMXR8erAje3pGGjXckOl6wtBBqgTs1+Qq6DFsHquU9YYbwvqWWLQY1tl3kDl
        EDPJ405fT4qLVrfWM6ys4OHR01KRbaH0bH2C5AwclCsp8wA+dBvyM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A57F1B6CEB;
        Tue,  5 Sep 2023 10:57:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B01D01B6CEA;
        Tue,  5 Sep 2023 10:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 6/7] rebase --continue: refuse to commit after failed
 command
In-Reply-To: <87fbc8c9-f42b-b374-fee1-57c58f5e8fc0@gmx.de> (Johannes
        Schindelin's message of "Tue, 5 Sep 2023 13:17:53 +0200 (CEST)")
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <2ed7cbe5fff2d104a1246783909c6c4b75c559f2.1690903412.git.gitgitgadget@gmail.com>
        <a5bfea5f-0d0d-f7ed-3f72-37e3db6f5b2c@gmx.de>
        <02c28b26-4658-43c8-b1d1-7f1e09bda609@gmail.com>
        <87fbc8c9-f42b-b374-fee1-57c58f5e8fc0@gmx.de>
Date:   Tue, 05 Sep 2023 07:57:10 -0700
Message-ID: <xmqqy1hksm61.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E450FEA-4BFC-11EE-91A8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With your patch, there are now four users of the `is_clean` value, and
> all but one of them ask for the negated value.

Excellent observation.  That strongly argues for the flipping of
polarity, i.e. many people want to know "is it unclean/dirty?".  It
is funny that the name of the helper function where the value comes
from, i.e. has_uncommitted_changes(), has the desired polarity.

> It's not really the responsibility of this patch series, but I could
> imagine that it would be nicer to future readers if a patch was added that
> would invert the meaning of that variable and rename it to
> `needs_committing`. At least to me, that would make the intention of the
> code eminently clearer.

While I agree, after reading the code, that it would make it easier
to follow to flip the polarity of the variable, I would advise
against renaming from state based naming (is it dirty?) to action
based naming (must we commit?), *if* the variable is checked to
sometimes see if we has something that we _could_ commit, while some
other times to see if we _must_ commit before we can let the user
proceed.

"Does the index hold some changes to be committed?" is better
question than "Must we commit?" or "Could we commit?" to derive the
name of this variable from if that is the case, I would think.





