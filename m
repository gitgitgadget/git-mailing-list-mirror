Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70021C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 20:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0123C20829
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 20:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V/H52SEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgITUgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 16:36:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61013 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITUgb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 16:36:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E163586008;
        Sun, 20 Sep 2020 16:36:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QdpUZZ0W/DhGvuP7Dpw8eoKQ/EI=; b=V/H52S
        Eu4Vh02Nep4lavK82a6nQrB8mMWqNHwdo6Vfe0ukphqeIZt3ni3vKR6BgDaaPr2H
        RwxoeD4bGi9uPAKC1J+7idAsTlEICnYeo9Ptb/Nwz8e2N8F+x0O7PbayNwA7Swlk
        RLMIU6jZb7bg4PipiQF1DV2+420RENh60CK3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XN8kTXaLO+t3xxtNFF1HBs7pVBEzK/o9
        6375MvnkbGrHS0JuOE5rShzkMHzk8XiRqTy56rmdM7tdbOOWzdzkWgDa+Yse87si
        f0oRjRIljAAKjE69M21K7Vd6kNost80GMEtygDyA7WGqo0fJV2L7rxcFo6ZTfatZ
        VCLrA9p1ZRQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D936486007;
        Sun, 20 Sep 2020 16:36:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B97686006;
        Sun, 20 Sep 2020 16:36:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca, peff@peff.net
Subject: Re: [PATCH v2] diff: Fix modified lines stats with --stat and
 --numstat
References: <20200918113256.8699-2-tguyot@gmail.com>
        <20200920130945.26399-1-tguyot@gmail.com>
        <20200920153915.GB2726066@nand.local>
        <xmqqlfh4gt5z.fsf@gitster.c.googlers.com>
Date:   Sun, 20 Sep 2020 13:36:27 -0700
In-Reply-To: <xmqqlfh4gt5z.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 20 Sep 2020 12:11:20 -0700")
Message-ID: <xmqqd02ggp84.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5B09966-FB80-11EA-A875-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Summarizing the above, I think the second best fix is this (which
> means that the posted patch is the third best):
>
> 	/*
> 	 * diff_fill_oid_info() marked one/two->oid with null_oid
> 	 * for a path whose oid is not available.  Disable early
> 	 * return optimization for them.
> 	 */
> 	if (oideq(&one->oid, &null_oid) || oideq(&two->oid, &null_oid))
> 		same_contents = 0; /* could be different */
> 	else if (oideq(&one->oid, &two->oid))
> 		same_contents = 1; /* definitely the same */
> 	else
> 		same_contents = 0; /* definitely different */

A tangent.

There is this code in diff.c::fill_metainfo() that is used to
populate the "index" header element of "diff --patch" output:

	if (one && two && !oideq(&one->oid, &two->oid)) {
		const unsigned hexsz = the_hash_algo->hexsz;
		int abbrev = o->abbrev ? o->abbrev : DEFAULT_ABBREV;

		if (o->flags.full_index)
			abbrev = hexsz;

		if (o->flags.binary) {
			mmfile_t mf;
			if ((!fill_mmfile(o->repo, &mf, one) &&
			     diff_filespec_is_binary(o->repo, one)) ||
			    (!fill_mmfile(o->repo, &mf, two) &&
			     diff_filespec_is_binary(o->repo, two)))
				abbrev = hexsz;
		}
		strbuf_addf(msg, "%s%sindex %s..%s", line_prefix, set,
			    diff_abbrev_oid(&one->oid, abbrev),
			    diff_abbrev_oid(&two->oid, abbrev));
		if (one->mode == two->mode)
			strbuf_addf(msg, " %06o", one->mode);
		strbuf_addf(msg, "%s\n", reset);
	}

Currently it is OK because there can only be one side that
diff_fill_oid_info() would mark as "oid unavailable" (e.g. reading
standard input stream).  If a new feature is introducing a situation
where both ends have null_oid, which was so far been impossible,
we'd probably need to factor out the condition used in the above
into a helper function, e.g.

    static int cannot_be_the_same(struct diff_filespec *one, struct diff_filespec *two)
    {
	if ((oideq(&one->oid, &null_oid) || oideq(&two->oid, &null_oid))
		return 1;
	else if (oideq(&one->oid, &two->oid))
		return 0;
	else
		return 1;
    }

and rewrite the conditional in fill_metainfo() to

	if (one && two && cannot_be_the_same(one, two)) {
		...

The "second best fix" could then become a single liner:

	same_contents = !cannot_be_the_same(one, two);

using the helper.

