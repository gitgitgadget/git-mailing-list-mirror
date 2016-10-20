Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FDDD1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 20:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbcJTU0W (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:26:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56817 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752476AbcJTU0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:26:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38E2246530;
        Thu, 20 Oct 2016 16:26:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sBCP9K24nVPuLmxPNAS2P+g3/ds=; b=RvFm05
        FUu6bUDnqviKzgbJ1dLf7MccXxLxQ1hNxeKx1GSIx56WWPOoN41B5lEm5IX7HXIj
        vNSnJhMPfBmC5qQ/KjAo0YUnTr6Tx4T2GJxl6itncFqUZx78ovKKpw9yGVaYUuPi
        NxsGB785D5jDekV/isp1fvbpo8PdgGhEaypsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FKMsip+3ha5tWIwH+vqku23oF0dUdK+6
        3NNH+9o1cUyoI7ysZFARBNVmfarqBi1DPjC6yal5sIwJIT0jIe5K6qbPNqJksLC8
        HhNo675mrVwGY/5unn7n5VfxePJfbNlGRO+GcIr7UhoECQfIxJsP990h2swU7vo4
        iM/8IdQih0Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F5E74652F;
        Thu, 20 Oct 2016 16:26:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7AD04652D;
        Thu, 20 Oct 2016 16:26:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 20/25] sequencer: refactor write_message()
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
        <9a66d53ebd86d35136597e534be03605bb1346bc.1476450940.git.johannes.schindelin@gmx.de>
        <xmqqh986g49i.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 20 Oct 2016 13:26:16 -0700
In-Reply-To: <xmqqh986g49i.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 20 Oct 2016 13:22:01 -0700")
Message-ID: <xmqqd1iug42f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 751EEE28-9703-11E6-B054-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If I were doing this, I would make this into three separate steps:
>
>     - move the strbuf_release(msgbuf) to the caller in
>       do_pick_commit();
>
>     - add the missing rollback_lock_file(), which is a bugfix; and
>       then finally
>
>     - allow the helper to take not a strbuf but <buf, len> pair as
>       parameters.
>
> The end result of this patch achieves two thirds of the above, but
> especially given that write_message() only has two call sites in a
> single function, I think it is OK and preferrable even to do all
> three.

Ah, make that four steps.  The final one is:

    - add append_eol parameter that nobody uses at this step in the
      series.

This is a new feature to the helper.  While it is OK to have it as a
preparatory step in this series, it is easier to understand if it
kept as a separate step.  It is even more preferrable if it is made
as a preparatory step in a series that adds a caller that passes
true to append_eol to this helper, or if that real change is small
enough, part of that patch that adds such a caller, not as a
separate step.


