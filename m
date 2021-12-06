Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C00C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 23:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377320AbhLFXcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 18:32:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63218 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377312AbhLFXcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 18:32:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1B12103AC9;
        Mon,  6 Dec 2021 18:28:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UeOD32JAUkpIOx2a8VvTBkIgEZb8luQ9ahI6/+
        t2eVs=; b=yVNmSz70mt2WH/RWNdAUuSVbjR+Z0rG08kbHqIPMSiAicMTbdnnd/Y
        e7Y5TEJdzcDUBZ8BixyKRO86bGbuM1DGVgrvD5vQMEqog6M4AM4K2DnF59vGGSG5
        gEc1Cd2RJH+qDy18YiAGcn4zVMSqURricF8DAloajt6ZkZjiQknTM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98C91103AC8;
        Mon,  6 Dec 2021 18:28:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C210103AC7;
        Mon,  6 Dec 2021 18:28:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 1/3] branch: move --set-upstream-to behavior to
 setup_tracking()
References: <20211122223252.19922-1-chooglen@google.com>
        <20211206215528.97050-1-chooglen@google.com>
        <20211206215528.97050-2-chooglen@google.com>
Date:   Mon, 06 Dec 2021 15:28:39 -0800
In-Reply-To: <20211206215528.97050-2-chooglen@google.com> (Glen Choo's message
        of "Mon, 6 Dec 2021 13:55:26 -0800")
Message-ID: <xmqq1r2pcnyw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EFCB89E-56EC-11EC-B422-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> +void setup_tracking(const char *new_ref, const char *orig_ref,
> +			   enum branch_track track, int quiet, int expand_orig)
> +{
> +	struct tracking tracking;
> +	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> +	char *full_orig_ref;
> +	struct object_id unused_oid;
> +
> +	memset(&tracking, 0, sizeof(tracking));
> +	if (expand_orig)
> +		validate_branch_start(the_repository, orig_ref, track, &unused_oid, &full_orig_ref);
> +	else
> +		full_orig_ref = xstrdup(orig_ref);
> +
> +	tracking.spec.dst = full_orig_ref;
> +	if (for_each_remote(find_tracked_branch, &tracking))
> +		goto cleanup;
> +
> +	if (!tracking.matches)
> +		switch (track) {
> +		case BRANCH_TRACK_ALWAYS:
> +		case BRANCH_TRACK_EXPLICIT:
> +		case BRANCH_TRACK_OVERRIDE:
> +			break;

This heavily conflicts with what another topic "inherit tracking
info from the other branch" wants to do to this function.  What's 
the status of that topic, by the way?  Should we block this one
waiting for the other, or the other way around?

Thanks.



