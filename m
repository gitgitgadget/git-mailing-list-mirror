Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D783720281
	for <e@80x24.org>; Tue, 31 Oct 2017 06:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbdJaGHm (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 02:07:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50559 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753230AbdJaGHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 02:07:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EA4AA9648;
        Tue, 31 Oct 2017 02:07:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5dASQh+us1+p8cF9erSEeBLUZ2M=; b=qVVfF/
        LSwVXSWFzs/0+irckIGXA1/qsmZUiGCQwoJJc9Ly2d+LmAgZQ7Sdt89dwc24ptvv
        ykuNy121fMTSmWTx9ZKLK6lN0UkGYaxOWiTCAntybXigy6Ad1rUfLeJRNVEgxVrK
        Rlc1VdSG4fdqPqtaqyKmZL2r9bOq9gbDRVt/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wfbhv+wpH/6oNyND2WJ9oD08dIJFRhaa
        Zk0aUS/oeGxyyB1aOHde+JlqDrG7aX7D7WWM2/ei3U38Y22PXwxLRKxmGxfoVIpE
        0bMAuzAS50LjYQTe10B82KUEzdzoKbCch0+nvoBhFddjhxh/d3q4GhAQvUOAapyi
        LuXzz1AWXCA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 267BFA9644;
        Tue, 31 Oct 2017 02:07:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99864A9643;
        Tue, 31 Oct 2017 02:07:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/7] list-objects.c: factor out traverse_trees_and_blobs
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-2-sbeller@google.com>
Date:   Tue, 31 Oct 2017 15:07:39 +0900
In-Reply-To: <20171031003351.22341-2-sbeller@google.com> (Stefan Beller's
        message of "Mon, 30 Oct 2017 17:33:45 -0700")
Message-ID: <xmqqshdzzw7o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD48A53C-BE01-11E7-A984-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> With traverse_trees_and_blobs factored out of the main traverse function,
> the next patch can introduce an in-order revision walking with ease.
>
> The variable holding the base path is only used in the newly factored out
> function `traverse_trees_and_blobs`, however we keep its scope to
> `traverse_commit_list` to keep the number of invocations for memory
> allocations and release to one per commit traversal.

In this step, the caller is calling traverse_trees_and_blobs() only
once per traversal anyway, so the paragraph does not quite justify
this somewhat strange calling convention, unless the reader knows
more calls will be made to the same function by the caller in later
steps, potentially doubling the chance the buffer can be reused with
this arrangement.

Even after this function gains more callers, wouldn't the same
invariant that "path" recorded for trees and blobs are relative to
the root of tree recorded in the object in revs->pending.objects[]?
IOW, should base_path->len be always 0 upon entry to this function?

We may want to have an explicit _reset() or assert(->len == 0) at
the beginning of the function to ensure that.

> Rename the variable to `base_path` for clarity.

Hmph.  Inside traverse_commit_list(), which never looks at the
contents of the buffer, it could just be called with a name that
does not have any meaning (e.g. "scratch area for the callee to
use"), and such a change would make it clear why it is defined one
level above its use and the caller never looks at it.

In the callee (i.e. inside traverse_trees_and_blobs()), however, I
do not see a reason why base_path is any clearer than base.

Other than that, this looks like a straight-forward code movement
and looks good.
