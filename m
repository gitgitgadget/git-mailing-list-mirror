Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7458FC2BA19
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 05:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEC120748
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 05:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lD+F4nUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgDYFSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 01:18:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57467 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDYFSC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 01:18:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F9C049AF2;
        Sat, 25 Apr 2020 01:18:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6tK7EHQcefDvIdieQEl14RCvJP4=; b=lD+F4n
        UuDpZ4B2oXkt5/i4uLz2o6EcnuUUPtT3by4u6tz/6Dm4GNDtH9297cr4C3tPDmOt
        BVvl/T5Js8nN3fyhsnfVz4cDO4QMTdS8y8/CwIb3WQyXmn128PRVW18l4AW/x2K1
        ImApipQia1fbpRQEdXNdRScaNWc8DfTCKn09k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tZO/8AO/xmQcGBOHp06Xn315KqTM847V
        hgdK2d/NkM1a+Mn9fRgPmTIuKrdoEOTDxNC5k2Yx0FCel8809eh/+eQPOd/8WmW+
        +fjeADW4ZakF2U2HJCYV1I8MpWXfUKqaue0+65LDXZxWl72H/ouy7zaZExl/9C0q
        +/szDrC6pl4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38BEE49AF1;
        Sat, 25 Apr 2020 01:18:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E17449AF0;
        Sat, 25 Apr 2020 01:17:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] gitweb: Recognize *-to and Closes/Fixes trailers
References: <20200425021723.16346-1-me@pluvano.com>
Date:   Fri, 24 Apr 2020 22:17:58 -0700
In-Reply-To: <20200425021723.16346-1-me@pluvano.com> (Emma Brooks's message of
        "Sat, 25 Apr 2020 02:17:23 +0000")
Message-ID: <xmqqeesc9m9l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2126A2C6-86B4-11EA-AE00-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emma Brooks <me@pluvano.com> writes:

> Commit trailers like "Thanks-to:", "Fixes:", and "Closes:" are fairly
> common, but gitweb didn't highlight them like other trailers.

Did you also sneak "cc" in without documenting/justifying?

When the re becomes this complex, it may not be a bad idea to switch
to "/ ignore most whitespaces /x" style for readability.

> -		if ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
> +		if ($line =~ m/^\s*([A-Z][-A-Za-z]*-([Bb]y|[Tt]o)|C[Cc]|(Clos|Fix)es): /) {

		if ($line =~ m/^\s*([A-Z][-A-Za-z]*-([Bb]y|[Tt]o) |
				    C[Cc] | Closes | Fixes ):\s /x) { 

Well, I am sloppy and did not make it all that easier to read.

More experienced Perl folks certainly would be able to teach us a
much better convention to format things like this more readble.

