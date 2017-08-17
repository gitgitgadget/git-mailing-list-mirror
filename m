Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036A220899
	for <e@80x24.org>; Thu, 17 Aug 2017 19:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbdHQTId (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 15:08:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57134 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753929AbdHQTIc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 15:08:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACF92A9779;
        Thu, 17 Aug 2017 15:08:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GVR6beRRMJqXrAUlsGc5SPm3FK0=; b=kEm4cV
        p2WqvuPfKK7zHfXOaq0Zxlfa10Z/KVa2sreXyRo87YjN1FNnEtPOoEiNQ/X41UZg
        iZS0XV9R9XNDFugCxfOaZ53+TmWXhpRCrpS2hfR7TuTJDbvIaZp3O8mdFje01mKY
        0MZIfkYTb5liZHGs7Q/ei0Ug1Kz5l115WcGKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JY0vvgBKEjaCMM1CNH1045ohtrxVZ0tT
        kQP3HgOOFoSjICnlpsm2/QlwR+3XiYujaTYPrC2Hm5jRDsNWGAoRAO1U/uzKwvel
        HP7bPjALU/xffQQdg2O2Vvk0H3GoSe1wsxodJbxlh5QzUs0UKAoN/fUUNcv4d8si
        nH58d/uqiS0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3B59A9778;
        Thu, 17 Aug 2017 15:08:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1499A9775;
        Thu, 17 Aug 2017 15:08:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Simon Ruderich <simon@ruderich.org>, git@vger.kernel.org
Subject: Re: git add -p breaks after split on change at the top of the file
References: <20170816202442.aumzwa443spqgyul@ruderich.org>
        <20170817084109.ba7g2hnymtwqeclw@sigill.intra.peff.net>
Date:   Thu, 17 Aug 2017 12:08:22 -0700
In-Reply-To: <20170817084109.ba7g2hnymtwqeclw@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 17 Aug 2017 04:41:09 -0400")
Message-ID: <xmqqa82ygggp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 711EF962-837F-11E7-867B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> [+cc Junio, as this gets deep into git-apply innards]

I've written off --recount and --allow-overlap as ugly workaround
that happens to work some of the time but cannot be trusted long
time ago.

IIRC, before the "(e)dit" thing was added to "add -p", we counted
the line numbers correctly and merged the adjacent hunks before
applying and neither of these two kluge was necessary.

These threads may give us a bit more background:

  https://public-inbox.org/git/7viqk1ndlk.fsf@alter.siamese.dyndns.org/
  https://public-inbox.org/git/1304117373-592-1-git-send-email-gitster@pobox.com/

The original that introduced the "(e)dit" thing was in this thread:

  https://public-inbox.org/git/200805232221.45406.trast@student.ethz.ch/

As you can see, I was very much against it, as it cannot
fundamentally sanely implemented (which I think is the same
conclusion you reached at the end of the current thread).

I think there should be a better failure mode, though.
