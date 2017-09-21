Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6202020281
	for <e@80x24.org>; Thu, 21 Sep 2017 02:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdIUCAL (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 22:00:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52136 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751095AbdIUCAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 22:00:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 889B893298;
        Wed, 20 Sep 2017 22:00:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/YvdWkNpFA9noOc78q82Q+ctlmo=; b=E64zdj
        N46jmMCSdVIMr/zbB0A9qxeIJcob4PAvBKNXFS/aoit++8IfTUq1UMX6VHXuD+dc
        Au0Vvx0p7CvgjSgZsCMZ6C6eViAW0pjgrGbjy/Bu9pCH1UgB1ocIPKeCSPqFN74C
        YidcSX+sBrkOHiUQc7gw5IlfJooW3OFmssfB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kg/btGyW+9MBAj1ZY4ySpVv6HDBgQdtu
        x7RHk+SvqHVi3ixjZJlxr8WOoE3WzbQ4cefs23jhQq5jm865EnegeX2R6WHuPPgx
        qkdqtAtTTYaiN2mm5r6p1BIjyLk0e98LtA+JD7CxTZRcgmJDILgGe7FWy3GPfYsz
        vHYRdZVgrx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71ECB93297;
        Wed, 20 Sep 2017 22:00:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10E269328D;
        Wed, 20 Sep 2017 22:00:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v7 04/12] fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
References: <20170915192043.4516-1-benpeart@microsoft.com>
        <20170919192744.19224-1-benpeart@microsoft.com>
        <20170919192744.19224-5-benpeart@microsoft.com>
        <xmqqr2v2p0gn.fsf@gitster.mtv.corp.google.com>
        <3311de8b-f9df-07e0-6c5d-7f491e9bcaa8@gmail.com>
Date:   Thu, 21 Sep 2017 11:00:06 +0900
In-Reply-To: <3311de8b-f9df-07e0-6c5d-7f491e9bcaa8@gmail.com> (Ben Peart's
        message of "Wed, 20 Sep 2017 12:19:29 -0400")
Message-ID: <xmqq377gn74p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97FB8CEC-9E70-11E7-9C35-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Pretty much the same places you would also use CE_MATCH_IGNORE_VALID
> and CE_MATCH_IGNORE_SKIP_WORKTREE which serve the same role for those
> features.  That is generally when you are about to overwrite data so
> want to be *really* sure you have what you think you have.

Now that makes me worried gravely.  

IGNORE_VALID is ignored in these places because we have been burned
by end-users lying to us.  IGNORE_SKIP_WORKTREE must be ignored
because we know that the working tree state does not match the
"reality" the index wants to have.  The fact that the code treats
the status reported and kept up to date by fsmonitor the same way as
these two implies that it is merely advisory and cannot be trusted?
Is that the reason why we tell the codepath with IGNORE_FSMONITOR to
ignore the state fsmonitor reported and check the state ourselves?

Oh, wait...


> The other place I used it was in preload_index(). In that case, I
> didn't want to trigger the call to refresh_fsmonitor() as
> preload_index() is about trying to do a fast precompute of state for
> the bulk of the index entries but is not required for correctness as
> refresh_cache_ent() will ensure any "missed" by preload_index() are
> up-to-date if/when that is needed.

That is a very valid design decision.  So IGNORE_FSMONITOR is,
unlike IGNORE_VALID and IGNORE_SKIP_WORKTREE, to tell us "do not
bother asking fsmonitor to refresh the state of this entry--it is OK
for us to use a slightly stale information"?  That would make sense
as an optimization, but that does not mesh well with the previous
"we need to be really really sure" usecase.  That one wants "we do
not trust fsmonitor, so do not bother asking to refresh; we will do
so ourselves", which would not help the "we can use slightly stale
one and that is OK" usecase.

Puzzled...
