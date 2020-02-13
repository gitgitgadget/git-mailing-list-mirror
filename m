Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2938C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 23:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF3E2168B
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 23:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hnPoGfY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgBMXRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:17:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57451 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMXRO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 18:17:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA67855B43;
        Thu, 13 Feb 2020 18:17:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RCKNhXtRDWfpde4dmGl1L51J4iU=; b=hnPoGf
        Y2KOn3taqBD/5B3Eqc6QMkddQg0lNCBspfnPTrPLq8zJt4PwRd2lQt8wVWrQkgKa
        VYvhxtnZK8ZC8Lm9RlMZnFJ0hiBBv3U+MEpoexxlk3owSS0OTlaZcR1qD3hc7i5Y
        O8FmjN2aTOjBizLt20uzCD+/RugOUxqlTXVwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mO9P1XmwmsDyf+O8y5dksSsTkx1iZ7ff
        W8KpWMZpu5FNm8Ugnz22OHT2Hbkk7OF4PkYtMXZSNbkmKhiYd0jeY7uagyCJo4P7
        VMEGslLZsLI0cQUYlLw8n7+JIEEvcjkqaSGxfROTlqko3cp2i838GxmaPy1hfYIV
        8J+EcaUhdhI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2BF955B42;
        Thu, 13 Feb 2020 18:17:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5035155B41;
        Thu, 13 Feb 2020 18:17:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/13] pack-bitmap: implement BLOB_LIMIT filtering
References: <20200213021506.GA1124607@coredump.intra.peff.net>
        <20200213022523.GL1126038@coredump.intra.peff.net>
Date:   Thu, 13 Feb 2020 15:17:10 -0800
In-Reply-To: <20200213022523.GL1126038@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 12 Feb 2020 21:25:23 -0500")
Message-ID: <xmqq7e0qqdqh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F703D53E-4EB6-11EA-9977-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Just as the previous commit implemented BLOB_NONE, we can support
> BLOB_LIMIT filters by looking at the sizes of any blobs in the result
> and unsetting their bits as appropriate. This is slightly more expensive
> than BLOB_NONE, but still produces a noticeable speedup (these results
> are on git.git):
>
>   Test                                        HEAD~2            HEAD
>   ------------------------------------------------------------------------------------
>   5310.7: rev-list count with blob:none       1.80(1.77+0.02)   0.22(0.20+0.02) -87.8%
>   5310.8: rev-list count with blob:limit=1k   1.99(1.96+0.03)   0.29(0.25+0.03) -85.4%

That's respectable improvement.  packed_object_info() that asks only
for the inflated size is quite cheap when the object is a delta, and
hopefully we have more deltified blobs than deflated ones.

> +static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
> +				     uint32_t pos)
> +{
> +	struct packed_git *pack = bitmap_git->pack;
> +	unsigned long size;
> +	struct object_info oi = OBJECT_INFO_INIT;
> +
> +	oi.sizep = &size;
> +
> +	if (pos < pack->num_objects) {
> +		struct revindex_entry *entry = &pack->revindex[pos];
> +		if (packed_object_info(the_repository, pack,
> +				       entry->offset, &oi) < 0) {
> +			struct object_id oid;
> +			nth_packed_object_oid(&oid, pack, entry->nr);
> +			die(_("unable to get size of %s"), oid_to_hex(&oid));
> +		}
> +	} else {
> +		struct eindex *eindex = &bitmap_git->ext_index;
> +		struct object *obj = eindex->objects[pos - pack->num_objects];
> +		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
> +			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
> +	}
> +
> +	return size;
> +}

