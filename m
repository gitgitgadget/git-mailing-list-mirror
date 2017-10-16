Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631701FF32
	for <e@80x24.org>; Mon, 16 Oct 2017 08:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbdJPIYF (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 04:24:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62147 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750914AbdJPIYB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 04:24:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F0C09DCB1;
        Mon, 16 Oct 2017 04:23:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y7hjaBRLnxONN2A8oU9xCIvoQeY=; b=loxFjg
        p3/QW42bLUny4mmBPWSenpH7P3diMj/DC1cn/+q6ax+UQ7mvZ3ljlU8BfsPQIaTM
        T7DPN4Pp7hhTk6x2dIxEAgcuR8gSSVcheNAubk5kFTs9E5DqYqZcoz39rMmX1Lub
        xb3ccYVZ7ul+UurSDTROOmsZ+oe+jEwblq6Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DbmM/+G1R0MOoSING5m6Jul5b5Y/Zcw3
        rJqBUKEA3m+8MjgZrBncsK7BXz1Y3/c5D9oD8887wiCRa9aHRZuyT7XHBczLpIX5
        ZD9mKzj4RUM5yLCqqX1HcwEMDaCYd8A91N+17qVW11IbQaoSw4bewOy8RfuhRPmD
        91g89T7Y2zM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2560B9DCB0;
        Mon, 16 Oct 2017 04:23:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BDE49DCAF;
        Mon, 16 Oct 2017 04:23:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     noloader@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: Does Git build things during 'make install"?
References: <CAH8yC8kx9Td51=UFvLwLAQFPKxUXg0D6KKqWR+JX+-wmTAKYRQ@mail.gmail.com>
        <0ec353db-428c-bb6f-03fe-303487fde197@kdbg.org>
Date:   Mon, 16 Oct 2017 17:23:52 +0900
In-Reply-To: <0ec353db-428c-bb6f-03fe-303487fde197@kdbg.org> (Johannes Sixt's
        message of "Mon, 16 Oct 2017 07:58:05 +0200")
Message-ID: <xmqq60bfsdpj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 588B0C92-B24B-11E7-8A67-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Yes, running "sudo make install" is a nightmare. sudo clears the path,
> and the git command is not found by the make invoked with root
> permissions. This changes the version string that gets compiled into
> the executable, which finally triggers a complete rebuild under
> root. Sad...

In the meantime, would it help to intall as yourself under DESTDIR
set to where you can write into, and then limit the potential
damange done while pretending to be a privileged user to "cp -R" (or
"tar cf" in $DESTDIR piped to "tar xf" in /)?

It appears that some dependencies are screwed up around "perl"
related things, which may want to get fixed.  I agree that "make &&
make install" that runs two 'make' under the same environment and
user shouldn't (re)build anything during the latter 'make', but we
somehow seem to do so.
