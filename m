Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA2620259
	for <e@80x24.org>; Thu,  8 Dec 2016 16:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbcLHQyc (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 11:54:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61163 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752618AbcLHQyb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 11:54:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D38E547CF;
        Thu,  8 Dec 2016 11:54:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p8kaZL8vpAKW5P//HUFrZ+lsGU8=; b=lA45va
        PFwbtvF3CQ2+/8g96hlMy9Ex7a/FBHNyF9wOeUY+bxUHhFgn8NI7Nw+utQLkd9Hc
        dR97mtxXU5ASbwWiUBO4lU46xgIGdh9u66ilEQ4FSCmATFp65dIv1hbeMzI6hoEE
        D2tMNyWQmqAuua2n9DFrE0MywbnEpkn7U28Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JrjIhs2uYgRfdHmELQVVfG3Fy035zzpO
        Snf4Q7QRhBcgcX6uNrZfCCWn7BP6QxEJWaSxxlIhCFF7Y9EM2dnCQmNzrNjVQ23j
        rx8c/DTQCjiA+nDnlgrwhSKdoyC+hFM9kJk25I6/QUzMl3v/DntWOX4zvvxGSwJv
        P68B8Tkaz8o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9592A547CE;
        Thu,  8 Dec 2016 11:54:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 118A6547CD;
        Thu,  8 Dec 2016 11:54:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, peff@peff.net, jacob.keller@gmail.com
Subject: Re: [PATCH] real_path: make real_path thread-safe
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
        <1480964316-99305-2-git-send-email-bmwill@google.com>
        <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
        <20161207001018.GD103573@google.com>
        <7d968fd8-a92d-efd3-ce67-7de6049b6d56@kdbg.org>
        <20161207222927.GB116201@google.com>
        <1767f01a-4125-d99b-37db-3f4a56aaa28a@kdbg.org>
Date:   Thu, 08 Dec 2016 08:54:29 -0800
In-Reply-To: <1767f01a-4125-d99b-37db-3f4a56aaa28a@kdbg.org> (Johannes Sixt's
        message of "Thu, 8 Dec 2016 12:32:46 +0100")
Message-ID: <xmqqwpfatl8a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC7A28FE-BD66-11E6-B38A-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 07.12.2016 um 23:29 schrieb Brandon Williams:
>> Instead of assuming root is "/"
>> I'll need to extract what root is from an absolute path.  Aside from
>> what root looks like, do most other path constructs behave similarly in
>> unix and windows? (like ".." and "." as examples)
>
> Yes, .. and . work the same way, except that they cannot appear in the
> \\server\share part. I also think that .. does not cancel these parts.
>
> As long as you use is_absolute_path() and do not simplify path
> components before offset_1st_component(), you should be on the safe
> side.
>
>> Since I don't really have a windows machine to test things it might be
>> slightly difficult to get everything correct quickly but hopefully we can
>> get this working :)
>
> I'll lend a hand, of course, as time permits.

Thanks, as always, for working well together ;-).
