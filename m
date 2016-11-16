Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840D92042F
	for <e@80x24.org>; Wed, 16 Nov 2016 18:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbcKPSPF (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 13:15:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56379 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752809AbcKPSPE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 13:15:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 990024D994;
        Wed, 16 Nov 2016 13:15:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rQRGsKVEbXUQST++4YozRt19iws=; b=jND9d9
        tHdZnOGOorf9F/EtPEanqAbTzksIDAynieSbwZxd4rNbG+EUY6bg3yd6t97eGHyW
        gueBHdgO4dTkgRqvufDUcXUAr1yKv5O0r6KutP3L4z71U9kMLKzBGg9D7OpFRw5D
        0U0iGnCamJUB1KRiZmarfurgbZSsGWcsyyW5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C535tAA3fTagD8vmti5t7c4tsVd0c9Ko
        qpO6rHystLnOne6Wa/y5xejuLj3iNjdwG6SRoePP0LcjKBXmTCpE3BxvMEUVIQKy
        ybUm8RTnWRR6auvKFo3fxE/No0hZhUbvtoe4V+zGsixH6J5rTdX+JBonZLpI7/z/
        fpE3ZXZ/8t0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FD034D993;
        Wed, 16 Nov 2016 13:15:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E90DD4D991;
        Wed, 16 Nov 2016 13:15:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
        <20161115010356.GA29602@starla>
        <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com>
        <xmqqvavotych.fsf@gitster.mtv.corp.google.com>
        <17709AFF-3C2D-4EC0-97DC-BD750F514D0B@gmail.com>
Date:   Wed, 16 Nov 2016 10:15:01 -0800
In-Reply-To: <17709AFF-3C2D-4EC0-97DC-BD750F514D0B@gmail.com> (Lars
        Schneider's message of "Wed, 16 Nov 2016 10:53:17 +0100")
Message-ID: <xmqqpolvqoka.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97F8FFA8-AC28-11E6-8C26-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> * You'd need to rein in the maximum parallelism somehow, as you do
>>   not want to see hundreds of competing filter processes starting
>>   only to tell the main loop over an index with hundreds of entries
>>   that they are delayed checkouts.
>
> I intend to implement this feature only for the new long running filter
> process protocol. OK with you?

Do you mean that a long-running filter process interacting with
convert_to_worktree() called from checkout_entry() will be the only
codepath that will spawn multiple processes or threads?  

That is fine, but it does not change the fact that you still need to
limit the maximum parallelism there.
