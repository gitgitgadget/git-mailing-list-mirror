Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA831FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 02:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbdJYC3L (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 22:29:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58753 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751672AbdJYC3K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 22:29:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53DB7AAD33;
        Tue, 24 Oct 2017 22:29:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vy+MbZSDZI7MiiTA/Ick+n+8pPc=; b=ni7EOs
        gFUKKoTeX5wnPYhvVnLF1p+M2kHyVUFbKVu5/C2MafkeEQpCq/K0/q2daFSNxbLM
        /uf7Lo4IX1qExNowYoqBkreebi+eM3yD0q9mXBK7uENr6fjWI9S9DItLthbJ5BB+
        M6cyEqDdFfKk2g/DMsqLmNTD+tIRzMylxAf6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CLq5AHSa8+Igjc9oUkVEC0g/Si+ay9XS
        93Ia2AJKOzjihxepdBGOfGBv3FdL7gvKiCt3WLXTToqSXp2dzJrlx35unre8HZUA
        yAh/Dt7+4N5BU+4iHA0ZxzTxPkcyMRbcdrsK+AZTF91+1iXLFEpfK2prqrIf0llq
        TJlVFQ0W/Ec=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B2DEAAD31;
        Tue, 24 Oct 2017 22:29:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0AECAAD2F;
        Tue, 24 Oct 2017 22:29:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] files_transaction_prepare(): fix handling of ref lock failure
References: <cover.1508856679.git.mhagger@alum.mit.edu>
        <6214107e1232a7fe7ca4b7440733ff496f07e537.1508856679.git.mhagger@alum.mit.edu>
Date:   Wed, 25 Oct 2017 11:29:07 +0900
In-Reply-To: <6214107e1232a7fe7ca4b7440733ff496f07e537.1508856679.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Tue, 24 Oct 2017 17:16:25 +0200")
Message-ID: <xmqqwp3khsek.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 478AA1FE-B92C-11E7-B1F2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> ... But dc39e09942 added another blurb of code between
> the loop and the cleanup. That blurb sometimes resets `ret` to zero,
> making the cleanup code think that the locking was successful.
> ...
> The fix is simple: instead of just breaking out of the loop, jump
> directly to the cleanup code. This fixes some tests in t1404 that were
> added in the previous commit.

OK.  Now because we do not break and start packed_transaction but
instead jump over that if statement, we'll leave packed_transation
instance that we got from transaction_begin() that we called
add_update() on, but haven't called transaction_prepare() on
behind.  That instance is pointed by backend_data pointer which is
part of transaction, so presumably transaction_cleanup() called on
it in the section labelled "cleanup:" should take care of it?

Thanks for catching the issue and fixing it quickly.  Will queue.
