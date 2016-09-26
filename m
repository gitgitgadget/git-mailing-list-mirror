Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ACAE207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161240AbcIZRuy (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:50:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51007 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034469AbcIZRux (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:50:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 872EE41479;
        Mon, 26 Sep 2016 13:50:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6xylya448oCxOoHQHsXZGi2fmL8=; b=Ju0gTm
        k1uZ9zByDOO9RbQGgRV1bDt7mgvnj80GdRa+nmLJs598AFq9ZWuLC3kRgYMOqLsk
        ZrJydnjdDeXokff7fVtD7CSqwTX/jMqBWOCcxxnGx9PSFDK70e9L2MwJRBEVPfQ1
        AiXjZqNewf2bIlm5LlHAIkAM0GV4zBKFXM6Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tDiHupQPZsBjTcV06LNbCPgCcFYXKvdO
        Rqpy18xXnjChZovJy+IND9lxQ+JYtuWYrqZe3ecxRwv/dnnt6iHwgxhKHbJCWHL8
        5p5vFSRoq+l5yTN4UbXRM3Gfk0RF02em7nwqlURRGrAcH+kk5ya4uoAMsMuXBcJp
        m4WW0iw+P9Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8030E41478;
        Mon, 26 Sep 2016 13:50:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0898441477;
        Mon, 26 Sep 2016 13:50:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 01/10] get_sha1: detect buggy calls with multiple disambiguators
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
        <20160926115901.txmbr4e6xzwyfpmo@sigill.intra.peff.net>
        <xmqqbmzavcqx.fsf@gitster.mtv.corp.google.com>
        <20160926172111.sve6tsse2figcved@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 10:50:49 -0700
In-Reply-To: <20160926172111.sve6tsse2figcved@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 26 Sep 2016 13:21:12 -0400")
Message-ID: <xmqq7f9yturq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C416ADB8-8411-11E6-B1D9-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Other than your reinvention of HAS_MULTI_BITS(), which has been with
>> us since db7244bd ("parse-options new features.", 2007-11-07), this
>> looks like a reasonable thing to do.
>
> Heh, I _thought_ we had something like that but couldn't find it. I
> grepped for "[^&]& .*-", which does match it, but stupidly did it only
> in '*.c'. Definitely it should use the existing macro instead.

OK, I'll queue this on top to be squashed, so no need to resend only
for this one.

 sha1_name.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index f9812ff..0ff83a9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -310,11 +310,6 @@ static int prepare_prefixes(const char *name, int len,
 	return 0;
 }
 
-static int multiple_bits_set(unsigned flags)
-{
-	return !!(flags & (flags - 1));
-}
-
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
 {
@@ -333,7 +328,7 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 
 	memset(&ds, 0, sizeof(ds));
 
-	if (multiple_bits_set(flags & GET_SHA1_DISAMBIGUATORS))
+	if (HAS_MULTI_BITS(flags & GET_SHA1_DISAMBIGUATORS))
 		die("BUG: multiple get_short_sha1 disambiguator flags");
 
 	if (flags & GET_SHA1_COMMIT)
