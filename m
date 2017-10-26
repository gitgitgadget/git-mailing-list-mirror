Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E8F1FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 06:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbdJZGqG (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 02:46:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62535 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750974AbdJZGqG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 02:46:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D6539CC01;
        Thu, 26 Oct 2017 02:46:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FCwS/mkNur3Rus8CUlZRrEszDWU=; b=UPEB2K
        TruaKvJcCDVDvN4RG65H4hXlNTnjBolb2gLOlGmLo8kH0YTMe/3mv+2USBJorBLp
        bmllhXSi/mH/in3jCYhoq1xaxpKVMSu6Zcb1xBBvpd0huIh9Ee2T3jCRaOt1sFwW
        W31P4BJbJw8VJ9NHBKxUyZdjDllQL0+rWDHck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C5bVlahrRkDX6uAGzlwc5yRJiWMcpOnZ
        EAb5c3QNCK8LHTZd0B49EJ91xF//DpAJq/6oIrzSa+wQQ0vpeDXKkUKu2KTG8iNd
        5w2EPbZYtRdkis1HvmWLzyZyD/ruu4yEMJLGKxPUtkirC8wnHXrgZnn3rNdZYCJV
        8s23oHd49CM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 157439CC00;
        Thu, 26 Oct 2017 02:46:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D3D09CBFE;
        Thu, 26 Oct 2017 02:46:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] files-backend: don't rewrite the `packed-refs` file unnecessarily
References: <cover.1508924577.git.mhagger@alum.mit.edu>
        <4c03fc458f619a5f02dd4cae38da8b9b139b850b.1508924577.git.mhagger@alum.mit.edu>
Date:   Thu, 26 Oct 2017 15:46:03 +0900
In-Reply-To: <4c03fc458f619a5f02dd4cae38da8b9b139b850b.1508924577.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Wed, 25 Oct 2017 11:53:21 +0200")
Message-ID: <xmqqpo9ae79w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 567AAA9A-BA19-11E7-81A2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Even when we are deleting references, we needn't overwrite the
> `packed-refs` file if the references that we are deleting are not
> present in that file. Implement this optimization as follows:

This goal I can understand.  files-transaction-prepare may see a
deletion and in order to avoid a deletion of a ref from the
file-backend to expose a stale entry in the packed-refs file, it
prepares a transaction to remove the same ref that might exist in
it.  If it turns out that there is no such ref in the packed-refs
file, then we can leave the packed-refs file as-is without
rewriting.

> * Add a function `is_packed_transaction_noop()`, which checks whether
>   a given packed-refs transaction doesn't actually have to do
>   anything. This function must be called while holding the
>   `packed-refs` lock to avoid races.

This checks three things only to cover the most trivial case (I am
perfectly happy that it punts on more complex cases).  If an update

 - checks the old value,

 - sets a new value, or

 - deletes a ref that is not on the filesystem,

it is not a trivial case.  I can understand the latter two (i.e. We
are special casing the deletion, and an update with a new value is
not.  If removing a file from the filesystem is not sufficient to
delete, we may have to rewrite the packed-refs), but not the first
one.  Is it because currently we do not say "delete this ref only
when its current value is X"?

Also it is not immediately obvious how the "is this noop" helper is
checking the absence of the same-named ref in the current
packed-refs file, which is what matters for the correctness of the
optimization.

