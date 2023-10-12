Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199EDCDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 17:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442040AbjJLR7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379688AbjJLR6w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 13:58:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7F4BB
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:58:50 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E32DD3917A;
        Thu, 12 Oct 2023 13:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=g8XnqeLro+04ZpLECjeBf7nNWfmA0HZCvE0Q+l
        ljQ4k=; b=iJhKlc1J0OBAXFczk2dCEAMnWPa5ITfexg8YzI1Accbqmrdf3cZCQn
        laTeJ0+Exb7fK9cgJf4O6K0BuTKsYEKalRSOC+TBgB+15Y9JONlrVTHbepBov5gA
        jDUlDzarvHqjgQQNqCzTJakrRB4KTMZNuJQAVz8ZtfX7yUtNVaVdw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB0A739179;
        Thu, 12 Oct 2023 13:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 75BAD39178;
        Thu, 12 Oct 2023 13:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jason Hatton <jhatton@globalfinishing.com>
Subject: Re: [PATCH v2 2/2] Prevent git from rehashing 4GiB files
In-Reply-To: <20231012160930.330618-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 12 Oct 2023 16:09:30 +0000")
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
        <20231012160930.330618-3-sandals@crustytoothpaste.net>
Date:   Thu, 12 Oct 2023 10:58:42 -0700
Message-ID: <xmqqpm1jn2nh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC25845A-6928-11EE-9B2E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> An example would be to have a 2^32 sized file in the index of
> patched git. Patched git would save the file as 2^31 in the cache.
> An unpatched git would very much see the file has changed in size
> and force it to rehash the file, which is safe.

The reason why this is "safe" is because an older Git will would
keep rehashing whether 2^31 or 0 is stored as its sd_size, so the
change is not making things worse?  With older git, "git diff-files"
will report that such a file is not up to date, and then the user
will refresh the index, which will store 0 as its sd_file, so
tentatively "git status" may give a wrong information, but we
probalby do not care?  Is that how the reasoning goes?

> +/*
> + * Munge st_size into an unsigned int.
> + */
> +static unsigned int munge_st_size(off_t st_size) {
> +	unsigned int sd_size = st_size;
> +
> +	/*
> +	 * If the file is an exact multiple of 4 GiB, modify the value so it
> +	 * doesn't get marked as racily clean (zero).
> +	 */
> +	if (!sd_size && st_size)
> +		return 0x80000000;
> +	else
> +		return sd_size;
> +}

This assumes typeof(sd_size) aka "unsigned int" is always 32-bit,
which does not sound reasonable.  Reference to 4GiB, 2^32 and 2^31
in the code and the proposed commit log message need to be qualified
with "on a platform whose uint is 32-bit" or something, or better
yet, phrased in a way that is agnostic to the integer size.  At
the very least, the hardcoded 0x80000000 needs to be rethought, I
am afraid.

Other than that, the workaround for the racy-git avoidance code does
sound good.  I actually wonder if we should always use 1 regardless
of integer size.

