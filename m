Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5814FC433FE
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 00:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiCRAwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCRAwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 20:52:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87766179436
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:50:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A5BF12C8B8;
        Thu, 17 Mar 2022 20:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vaNAH8xYsfLCJMJmmRETQaXlZFzSirSdj+jYeO
        Efnxw=; b=Yt+yfSV5a6eNzTfX8rzM1yjZC+eOQy+nrXbKh7uYSRoc1t2jvwgt5d
        AV8d2VqssOjSt77wUCEglX/kmHiaS/XeX+ghze1iImgD/tnF6/ghleKNdJCpa73+
        uzX3F6Ej948RolT/v1u7/ox3CXEHbNvB6ewkFLvdOxpo4bgHLciL0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7234B12C8B7;
        Thu, 17 Mar 2022 20:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B828312C8B6;
        Thu, 17 Mar 2022 20:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com
Subject: Re: [PATCH] shallow: reset commit grafts when shallow is reset
References: <20220317182448.1633847-1-jonathantanmy@google.com>
Date:   Thu, 17 Mar 2022 17:50:52 -0700
In-Reply-To: <20220317182448.1633847-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 17 Mar 2022 11:24:47 -0700")
Message-ID: <xmqqsfrgcccz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76D44BAC-A655-11EC-A8A2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When reset_repository_shallow() is called, Git clears its cache of
> shallow information, so that if shallow information is re-requested, Git
> will read fresh data from disk instead of reusing its stale cached data.
> However, the cache of commit grafts is not likewise cleared, even though
> there are commit grafts created from shallow information.
>
> This means that if on-disk shallow information were to be updated and
> then a commit-graft-using codepath were run (for example, a revision
> walk), Git would be using stale commit graft information. This can be
> seen from the test in this patch, in which Git performs a revision walk
> (to check for changed submodules) after a fetch with --update-shallow.
>
> Therefore, clear the cache of commit grafts whenever
> reset_repository_shallow() is called.

Because this helper function resets not just grafts_nr, but
commit_graft_prepared member, the next time prepare_commit_graft()
is called, we'd recover the grafts (not derived from shallows, but
read locally from "info/grafts") from the file, too, which makes it
sound right ;-)

And the implementation looks quite straight-forward.

Will queue.  Thanks.
