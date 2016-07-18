Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078512018B
	for <e@80x24.org>; Mon, 18 Jul 2016 20:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbcGRUAr (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 16:00:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751538AbcGRUAq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 16:00:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 96DDC2D3A8;
	Mon, 18 Jul 2016 16:00:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d7OVKfNZPPnzhxXaD5zzdnUfMbU=; b=tzH6bS
	VQ/JTwO38RDD7H7mPCPOpIWa0t7vWi/RRTR5lIlgKENzumLnV63QigEHpvRoto6c
	T0FcOyqqRpfiE7v0jtG0/iqHu28FbRNiml91IjHUlWNsiC7BthHsGvaOB2MqZ5kv
	O8t0JsUhiCEHVy5Gs2N0WvPgwdBymnWKor6O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pczXs/IFvm/aAe/G4p5XuMTMqsuCD2Qx
	cIPnZJSd2i8oR/kqutDiAisNY8OZ2pvuuiMT96yekQGbcyJlLNanlcieqnY/sp8G
	rRaNdgXHE5Bi1ak94mBl5zNZhUYJNe9sIz8EGkEhdkL0ziwVm7XLPk+gNMAsNeni
	YH1Odv1ZRxI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D8E32D3A7;
	Mon, 18 Jul 2016 16:00:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 136B22D3A6;
	Mon, 18 Jul 2016 16:00:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jonathan Nieder <jrnieder@gmail.com>
Cc:	Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] fetch-pack: grow stateless RPC windows exponentially
References: <1468867019-13086-1-git-send-email-jonathantanmy@google.com>
	<20160718185527.GB29326@google.com>
	<xmqq37n6kbib.fsf@gitster.mtv.corp.google.com>
	<CAGf8dgJVkkVwJ5aJCQBcYKw7F9g7u3pMsuJHedSGLG6PQk2Keg@mail.gmail.com>
	<20160718193147.GC29326@google.com>
Date:	Mon, 18 Jul 2016 13:00:41 -0700
In-Reply-To: <20160718193147.GC29326@google.com> (Jonathan Nieder's message of
	"Mon, 18 Jul 2016 12:31:47 -0700")
Message-ID: <xmqqoa5uiumu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F97E248-4D22-11E6-8644-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> You have full control of the growth function.  So how about aggressive
> growth until 1024*10?
>
> That is:
>
> Current git:
>   n < 1024: aggressive exponential
> 	16, 32, 64, 128, 256, 512, 1024
>   1024 <= n: linear
> 	2048, 3072, 4096, 5120, ...
>
> Initial proposal:
>   n < 1024: aggressive exponential
> 	16, 32, 64, 128, 256, 512, 1024
>   1024 <= n < 10240: linear
> 	2048, 307, 4096, 5120, ...
>   10240 <= n: conservative exponential
> 	11264, 12390, ...
>
> New proposal:
>   n < 10240: aggressive exponential
> 	16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384
>   10240 <= n: conservative exponential
> 	18022, 19824, ...
>
> That way, on one hand it would still never use a smaller window than
> today and on the other hand the heuristic would be easier to
> understand (only decelarating, instead of decelarating and then
> accelerating again).

That sounds more explainable (I do not know if that is a growth
curve that gives us better results, though).

So, the result would look something like this, perhaps?

 fetch-pack.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 3c5dfc4..97fe5f7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -264,12 +264,17 @@ static void insert_one_alternate_ref(const struct ref *ref, void *unused)
 
 static int next_flush(struct fetch_pack_args *args, int count)
 {
-	int flush_limit = args->stateless_rpc ? LARGE_FLUSH : PIPESAFE_FLUSH;
-
-	if (count < flush_limit)
-		count <<= 1;
-	else
-		count += flush_limit;
+	if (args->stateless_rpc) {
+		if (count < LARGE_FLUSH * 10)
+			count <<= 1;
+		else
+			count = count * 11 / 10;
+	} else {
+		if (count < PIPESAFE_FLUSH)
+			count <<= 1;
+		else
+			count += PIPESAFE_FLUSH;
+	}
 	return count;
 }
 
