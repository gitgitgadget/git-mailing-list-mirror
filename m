Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11361FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 23:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbdCJXns (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 18:43:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62501 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755108AbdCJXnr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 18:43:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4414E6A51B;
        Fri, 10 Mar 2017 18:43:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MVOyjK4voxfkJpbBzlONrrP3Zz8=; b=r/oyRr
        9KWs1h16j2LtR5nB1GC0IqLX56Np2DCpqgvdRje9og/j0DcmTNPDPSAFezdlZLWK
        bUhdpOjI9LYUDmGnQeq+VUgMt/FQpYRLT6d7U58u70ocOYfijZCkUL0SAWc18kdi
        0RRT188PaSY4v4USLjJep+Iokhh6S0fFmpD5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rYNgRefNKSOP5eOnbaxiuMXNHiqV2WV3
        DoTWUicr87t6P4CljMmsi9WOLpkZAHSLvoxRyFu57q/hUUK1f40413d3U77JwnWL
        pwpOsjce2Y11/ONKWcn0nPmPOdUYetBAg2KvAhOBXd3+PBjZQJ6pKaL7WK4IO8nu
        fR8EjTPEwEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D9D76A51A;
        Fri, 10 Mar 2017 18:43:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A54306A519;
        Fri, 10 Mar 2017 18:43:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     James Melvin <jmelvin@codeaurora.org>
Cc:     git@vger.kernel.org, nasserg@codeaurora.org, mfick@codeaurora.org,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v2] repack: Add option to preserve and prune old pack files
References: <20170310220020.2666-1-jmelvin@codeaurora.org>
Date:   Fri, 10 Mar 2017 15:43:43 -0800
In-Reply-To: <20170310220020.2666-1-jmelvin@codeaurora.org> (James Melvin's
        message of "Fri, 10 Mar 2017 15:00:20 -0700")
Message-ID: <xmqqmvcswvdc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 661F9A6A-05EB-11E7-B36B-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

James Melvin <jmelvin@codeaurora.org> writes:

> The new --preserve-and-prune option renames old pack files
> instead of deleting them after repacking and prunes previously
> preserved pack files.
>
> This option is designed to prevent stale file handle exceptions
> during git operations which can happen on users of NFS repos when
> repacking is done on them. The strategy is to preserve old pack files
> around until the next repack with the hopes that they will become
> unreferenced by then and not cause any exceptions to running processes
> when they are finally deleted (pruned).

This certainly is simpler than the previous one, but if you run

	git repack --preserve-and-prune 
	sleep for N minutes
	git repack --preserve-and-prune 

the second "repack" will drop the obsoleted packs that were
preserved by the first one no matter how short the value of N is,
no?

I suspect that users would be more comfortable with something based
on expiration timestamp that gives them a guaranteed grace period,
e.g. "--preserve-expire=8.hours", like how we expire reflog entries
and loose objects.

Perhaps builtin/prune.c can be a source of inspiration?
