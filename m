Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF92C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C575206E6
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M59nT6En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgEEFMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 01:12:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60760 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEFMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 01:12:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC03450FC0;
        Tue,  5 May 2020 01:12:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oJ4aBN31mapjvCRsqlEm/iRAE+k=; b=M59nT6
        En5wfTQ+HfyXbgP/y36EiS1aEn9wYtmWZQ85cr+bovduipCkESSFKIHEEevMBMG/
        /cms+gAlbHqfGE9eaf0H82heeNf/3hlhJSykPqKkxNRWt63xgDxTEmlk/53jIhIZ
        kye7+47Onvbmcw/1xXnTX9btU20wUy7algcfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fyZ+3jLH7uL+3AbIXevUl2QJpCA8rpUe
        9t3egACukFTA9R9suZECuhazBLmQtqmNkHwasEeSlWJNk+lNkH/dP15RwE2y3ZCj
        fJuf/e2t8rtYbKab3ol4wvKAE66wBVhYrHjUgqby9jCbeHq1+7wgTQFSZAJdaTjs
        Ntv3KkX7J+w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3E4450FBF;
        Tue,  5 May 2020 01:12:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6432250FBD;
        Tue,  5 May 2020 01:12:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] pack-bitmap.c: make object filtering functions generic
References: <cover.1588633810.git.me@ttaylorr.com>
        <b43a12894e7edf7d54ce2e9679f8db7dabec23e0.1588633810.git.me@ttaylorr.com>
Date:   Mon, 04 May 2020 22:12:39 -0700
In-Reply-To: <b43a12894e7edf7d54ce2e9679f8db7dabec23e0.1588633810.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 4 May 2020 17:12:31 -0600")
Message-ID: <xmqqd07jc6d4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B003D4E-8E8F-11EA-9BD2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In 4f3bd5606a (pack-bitmap: implement BLOB_NONE filtering, 2020-02-14),
> filtering support for bitmaps was added for the 'LOFC_BLOB_NONE' filter.
>
> In the future, we would like to add support for filters that behave as
> if they exclude a certain type of object, for e.g., the tree depth
> filter with depth 0.
>
> To prepare for this, make some of the functions used for filtering more
> generic, such as 'find_tip_blobs' and 'filter_bitmap_blob_none' so that
> they can work over arbitrary object types.
>
> To that end, create 'find_tip_objects' and
> 'filter_bitmap_exclude_type', and redefine the aforementioned functions
> in terms of those.

OK, so instead of blobs at the tip, we find objects of requested
type at the tip, which makes sense.

Similarly, blob_none filter used to exclude blobs at the tip, but a
more generic form is to exclude objects of requested type at the
tip.

And these "more generic" variants are named quite intuitively.

Then the blob_none filter becomes a thin wrapper of the more generic
one, with hardcoded OBJ_BLOB type.

Nicely done.
