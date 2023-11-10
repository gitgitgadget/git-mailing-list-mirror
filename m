Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9E3C69C
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="THYL3afp"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6AF125
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 15:39:02 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BE73A2C419;
	Fri, 10 Nov 2023 18:38:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pNmto5OjWXnY4TNS68AZ5syXQD4+Nf3tCIziVP
	Txvxo=; b=THYL3afpcuaWkxdyk9mAf0QcNMUD9kAHh6x79LiUlfj/FQ6nMDdwwX
	JCDLLUglNU1IqV08uqlnYaXdtVzF2ySV4rB+e6ZFOBKxGYhHVGEgjtQOBWnUfM9D
	cnwBm23rVwfn55bPbEaNr7Wxm1+DSP+UGHHIyX+mkKv/Dxlj3qZfc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B6DC72C418;
	Fri, 10 Nov 2023 18:38:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 528F62C40C;
	Fri, 10 Nov 2023 18:38:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
In-Reply-To: <ZU5Z/Z4PcdNP5U1r@nand.local> (Taylor Blau's message of "Fri, 10
	Nov 2023 11:27:41 -0500")
References: <20231109070310.GA2697602@coredump.intra.peff.net>
	<cover.1699569246.git.me@ttaylorr.com>
	<af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
	<xmqqedgyw6jv.fsf@gitster.g> <ZU5Z/Z4PcdNP5U1r@nand.local>
Date: Sat, 11 Nov 2023 08:38:54 +0900
Message-ID: <xmqqa5rluqk1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 508A23F6-8022-11EE-B90A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> But I don't think we enjoy the same benefits in the MIDX scenario. In
> this case, the num_objects field is just:
>
>     m->num_objects = ntohl(m->chunk_oid_fanout[255])
>
> so I don't think we can make the same guarantees about what is and isn't
> save to compute under size_t arithmetic.

So ..., from the correctness's point of view, if we do not mind
st_mult() dying, the "multiply-and-compare" should give us much more
robust results.  If we do mind st_mult() dying, we could pair the
"truncating-division-and-compare" you wrote with "ensure that chunk
size is a multiple of record size" to achieve the same, I would
think.  I.e.,

	if (chunk_size % pcd->record_size ||
	    chunk_size / pcd->record_size != pcd->record_nr)
		return -1;

or something like that.
