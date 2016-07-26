Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3C5203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757844AbcGZUix (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:38:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757934AbcGZUiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:38:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB82C2F90B;
	Tue, 26 Jul 2016 16:38:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=twsUWajkAEnHooUCnamUhmsTZfg=; b=SI0U7L
	VG7+5FdGDD5ykr0ehHwn1Yb8K4SpMRa4Un98uOEmDhQ51yuxpjUq3t7oOnhqHerj
	5yWd66Zs58bxE6Azkbu18IElODxHUjdcsPQ7giKT5BJEinOGF/t3DimQaSMy2Wem
	uRfl8Scfz0Qvi6l7Af/lVMiPlIQjnTz6r/FjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P5xjVd+7Ja8/doRDIXsuecOhNLWrggDh
	0kcxWNxsTWbBbVGPIBVOJabF3IQYRPf0VF7r+bdcp7iFOBcOgKpYoqNA1+VKj9tA
	i13CwBVE8f+Bh+Tji3LeYlcT4NR7iRq7JA0aOEJtxkdmWLAIRKpWU2PyzdH2IgVw
	DpEWE7esspc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B32012F90A;
	Tue, 26 Jul 2016 16:38:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BBBA2F909;
	Tue, 26 Jul 2016 16:38:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: break out of want_object loop early
References: <20160725184938.GA12871@sigill.intra.peff.net>
	<20160725185010.GA12974@sigill.intra.peff.net>
	<xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com>
	<20160725214113.GA13589@sigill.intra.peff.net>
	<xmqqbn1l4c87.fsf@gitster.mtv.corp.google.com>
	<20160725221411.GA14131@sigill.intra.peff.net>
Date:	Tue, 26 Jul 2016 13:38:47 -0700
In-Reply-To: <20160725221411.GA14131@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 25 Jul 2016 18:14:11 -0400")
Message-ID: <xmqqshuwyw14.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5843306-5370-11E6-8111-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I do not mind too much about having to check two bools twice.  But
>> given that the reason why I was confused was because I didn't see
>> why we need to pass the two "return 0" conditions at least once
>> before we decide that we do not need the "return 0" thing at all,
>> and started constructing a case where this might break by writing
>> "Suppose you have two packs, one remote and one local in packed_git
>> list in this order, and ..." before I realized that the new "early
>> break" can be hoisted up like the above, I definitely feel that "we
>> found one, and we aren't conditionally pretending that this thing
>> does not need to be packed at all, so return early and say we want
>> to pack it" is easier to understand before the two existing "if"
>> statements.
>
> Ah, right. Now you had me second-guessing for a moment that there might
> be a bad case in hoisting it up where we would want to return 0 but
> would break out early to the "return 1".
>
> But it cannot be the case, because the break is mutually exclusive with
> the two conditions.

Here is what I amended looks like (with s/local/non-local/ in the
log message).

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a2f8cfd..a46bf5b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -977,6 +977,21 @@ static int want_object_in_pack(const unsigned char *sha1,
 				return 1;
 			if (incremental)
 				return 0;
+
+			/*
+			 * When asked to do --local (do not include an
+			 * object that appears in a pack we borrow
+			 * from elsewhere) or --honor-pack-keep (do not
+			 * include an object that appears in a pack marked
+			 * with .keep), we need to make sure no copy of this
+			 * object come from in _any_ pack that causes us to
+			 * omit it, and need to complete this loop.  When
+			 * neither option is in effect, we know the object
+			 * we just found is going to be packed, so break
+			 * out of the loop to return 1 now.
+			 */
+			if (!ignore_packed_keep && !local)
+				break;
 			if (local && !p->pack_local)
 				return 0;
 			if (ignore_packed_keep && p->pack_local && p->pack_keep)
