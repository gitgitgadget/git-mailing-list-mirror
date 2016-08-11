Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB8C20193
	for <e@80x24.org>; Thu, 11 Aug 2016 18:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbcHKSwX (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:52:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751307AbcHKSwV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:52:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 503C733019;
	Thu, 11 Aug 2016 14:52:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w/mDsGlNBYuuDaDHNKmX7dsGavA=; b=XcbfHw
	inbRtFa8V+3GG9NxJ2JofahbUzi+9+vTGLJrExVmGi4xVbAviU90jB/py9L3H8cm
	Kr2iYUCbZq9WihutjHvfnG4JAqbtswGCbUQ82BVxP/hEtnxnhwXMeMcI79WYjbvn
	pcNMmipTHWjgziQ+p9dkv65w//ScfpqBabQn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OP1ffYyflX2oaQXIYnt8vSbUsXKBVdy+
	FSoP2mQTQSlMvYDu2ge+8Ooc7BB5nXK80HdnUqmK5CDYpUivTEfo/sWQCfcE7gVV
	R/ESvRUEJoBYsIJ2J6zXM14EwDrUTFbu8wgnrqXjmGV3uMy6oITz4mHWOKmiQf45
	yLy5s84ZXII=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4911533018;
	Thu, 11 Aug 2016 14:52:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A774E33016;
	Thu, 11 Aug 2016 14:52:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] gc: default aggressive depth to 50
References: <20160811161309.ecmebaafcz6rkg6o@sigill.intra.peff.net>
	<20160811172050.44abuvwcn6gmcgk7@sigill.intra.peff.net>
Date:	Thu, 11 Aug 2016 11:52:15 -0700
In-Reply-To: <20160811172050.44abuvwcn6gmcgk7@sigill.intra.peff.net> (Jeff
	King's message of "Thu, 11 Aug 2016 13:20:50 -0400")
Message-ID: <xmqqmvkj16lc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB18276E-5FF4-11E6-9D7D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 11, 2016 at 12:13:09PM -0400, Jeff King wrote:
>
>> Here are the numbers for linux.git:
>> 
>>    depth |  size |  %    | rev-list |  %     | log -Sfoo |   %
>>   -------+-------+-------+----------+--------+-----------+-------
>>     250  | 967MB |  n/a  | 48.159s  |   n/a  | 378.088   |   n/a
>>     100  | 971MB | +0.4% | 41.471s  | -13.9% | 342.060   |  -9.5%
>>      50  | 979MB | +1.2% | 37.778s  | -21.6% | 311.040s  | -17.7%
>>      10  | 1.1GB | +6.6% | 32.518s  | -32.5% | 279.890s  | -25.9%
>> [...]
>> 
>> You can see that that the CPU savings for regular operations improves as we
>> decrease the depth. The savings are less for "rev-list" on a smaller repository
>> than they are for blob-accessing operations, or even rev-list on a larger
>> repository. This may mean that a larger delta cache would help (though setting
>> core.deltaBaseCacheLimit by itself doesn't).
>
> The problem with deltaBaseCacheLimit is that it only changes the memory
> parameter, but there are a fixed number of slots in the data structure.
> Bumping it like this:
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 02940f1..ca79703 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2073,7 +2073,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
>  	return buffer;
>  }
>  
> -#define MAX_DELTA_CACHE (256)
> +#define MAX_DELTA_CACHE (1024)
>  
>  static size_t delta_base_cached;
>
> along with the cache size does help (this was discussed a year or two
> ago, but nobody ever followed up with numbers or patches).

Yeah, and I also think Linus's "--depth=250 is just a sample; it
will not perform well" already cited the number of delta-cache
entries being the limiting factor.

> I don't think bumping MAX_DELTA_CACHE naively is a good idea, though. I
> seem to recall that it has scaling problems as it grows, so we may want
> a better data structure (but I haven't looked at it recently enough to
> say anything intelligent).

Me neither.  In any case, I do think reducing the aggressive depth
down to 50 is a very sensible move.  I also suspect that window size
may want to be a bit increased (or even made dynamic; the first time
we need the window size determined is after to_pack.objects[] array
is fully populated, so we could use the number of commits as one of
the hint, for example), but that can be treated as a separate topic.


