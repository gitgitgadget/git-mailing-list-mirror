Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8259D20286
	for <e@80x24.org>; Mon, 11 Sep 2017 03:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbdIKD1P (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 23:27:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65197 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752263AbdIKD1O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 23:27:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A881A1842;
        Sun, 10 Sep 2017 23:27:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1EV/eM4EMvX+EcvFSd3WREesDV0=; b=QvOl7M
        /gBwQ+beuBFdnLa1AhU59YrwbVqmxFSsPxmQK2pbl5xj3iMoui0OxGgaYcR2Dcud
        T3Uz9eYwPkvZIVOJj4bwkw38jpY0vzNZGP8g91NnSaKQrNjtcKxxhjyDN/+qh8JM
        Od4o0w9aNq1LuVBQlHvH4TPAmIos+sUSYCsJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sGlUixirI6q3OZfPynkrfVQu0bVJBTQo
        2ZcsPlbUJGKRzpdpglPmtZyd1SQamcSsFRvpH2d5r185yZh44OZNMjnwYshIOM5H
        LHnPJhJO/gHm+io6ARMKA6FVmsuPhlmjSYbXOqrH2/5ABHMNNYnYIDH5mksrv1tD
        w50kHDpfleY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8027EA1841;
        Sun, 10 Sep 2017 23:27:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C68A3A1840;
        Sun, 10 Sep 2017 23:27:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Ben Peart <peartben@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] sub-process: print the cmd when a capability is unsupported
References: <20170816124036.25236-1-chriscool@tuxfamily.org>
        <758d36a7-8066-7e1a-30d0-62baf2796520@gmail.com>
        <xmqq4lt7pir9.fsf@gitster.mtv.corp.google.com>
        <xmqqshgri3dv.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 11 Sep 2017 12:27:11 +0900
In-Reply-To: <xmqqshgri3dv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 16 Aug 2017 14:55:40 -0700")
Message-ID: <xmqqlgll5300.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A0B5D16-96A1-11E7-816E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I still think we would want to turn warning() to die(), but it
> probably is better to do so in a separate follow-up patch.  That
> will give us a good place to record the reason why the current "just
> call a warning() and pretend as if nothing bad happend" is wrong.

And here is such an update.  It seems that pretty much all comments
in the original thread were "warning is wrong--we should die here",
but nobody seems to have bothered following it through.

cf. <20170815111725.5d009b66@twelve2.svl.corp.google.com>

-- >8 --
Subject: [PATCH] subprocess: loudly die when subprocess asks for an unsupported capability

The handshake_capabilities() function first advertises the set of
capabilities it supports, so that the other side can pick and choose
which ones to use and ask us to enable in its response.  Then we
read the response that tells us what choice the other side made.  If
we saw something that we never advertised, that indicates one of two
things.  The other side, i.e. the "upgraded" filter, is not paying
attention of the capabilities advertisement, and asking something
its correct operation relies on, but we are not capable of giving
that unknown feature and operate without it, so after that point the
exchange of data is a garbage-in-garbage-out.  Or the other side
wanted to ask for one of the capabilities we advertised, but the
code has typo and their wish to enable a capability that its correct
operation relies on is not understood on this end.  The result is
the same garbage-in-garbage-out.

Instead of sweeping such a potential bug under the rug, die loudly
when we see a request for an unsupported capability in order to
force sloppily-written filter scripts to get corrected.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sub-process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index fcc4832c14..ec9a51b7b1 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -181,8 +181,8 @@ static int handshake_capabilities(struct child_process *process,
 			if (supported_capabilities)
 				*supported_capabilities |= capabilities[i].flag;
 		} else {
-			warning("subprocess '%s' requested unsupported capability '%s'",
-				process->argv[0], p);
+			die("subprocess '%s' requested unsupported capability '%s'",
+			    process->argv[0], p);
 		}
 	}
 
-- 
2.14.1-660-g2f12cdf511

