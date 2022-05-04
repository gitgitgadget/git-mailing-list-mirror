Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82BDC433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352659AbiEDPqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352627AbiEDPpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:45:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7401BE86
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:42:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32F3311C127;
        Wed,  4 May 2022 11:42:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XpWarGiFBXcJCQ1hCRLBCRNbWO5w4u+WcAWzCG
        1Ib4c=; b=Rdvde3QrqoJFEsNuIYPnnb9x6wlW0ZuwUW/ydP2GfQyjF8dn903wBa
        t4adfzOmT/cNwB43XJAOP5c1VQGti59IT/ETbRChS0t/QHQFIFp3eXvEhsnaTBFH
        e+srdtUD7g6EZdqs5AX+IRn2k0tHzqG5qwe4VALp5Lx88qnCCEFHc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A690C11C126;
        Wed,  4 May 2022 11:42:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6A9C11C123;
        Wed,  4 May 2022 11:42:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 5/8] transport: add client side capability to request
 object-info
References: <20220328191112.3092139-1-calvinwan@google.com>
        <20220502170904.2770649-1-calvinwan@google.com>
        <20220502170904.2770649-6-calvinwan@google.com>
        <xmqqilqnsaep.fsf@gitster.g>
        <CAFySSZBuxMdO-TNUeXcHijmG8hmrSs6LDvJ=O4ZePiyZAcJaeA@mail.gmail.com>
Date:   Wed, 04 May 2022 08:42:11 -0700
In-Reply-To: <CAFySSZBuxMdO-TNUeXcHijmG8hmrSs6LDvJ=O4ZePiyZAcJaeA@mail.gmail.com>
        (Calvin Wan's message of "Tue, 3 May 2022 11:58:46 -0700")
Message-ID: <xmqqee19nw30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C44A6F7A-CBC0-11EC-B4F1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> It seems that the result of applying 1-5/8 does not compile.
>
> I'll check why this is the case. I should get in the habit of compiling
> all of my patches individually.

For a 8-patch series, we should make sure that all 8 states resuting
from applying patches 1-thru-N for each N (1 <= N <= 8) builds and
tests OK for bisectability.

I often do not check that due to lack of time on the receiving end,
but for this series, I didn't understand the sudden appearance of
the object_info_options member in the code that didn't even seem to
be populated anywhere, and I noticed that the series was organized
incorrectly.  Perhaps a simple rebase misordering?

>> size_index was initialized to -1 and I was expecting we can tell the
>> attribute is not used by checking (size_index < 0), but this seems
>> to make size_index 1 based, not 0 based.  Intended?
>
> Yes the server returns the packet as "object_id SP size" so the first
> value is always the object_id.

I think this is to skip the object name that comes as the first item
in the response, but it would be more "pure" to keep foo_index
0-based and add the offset by whatever constant number of things
that come in front (currently, 1 for object name) near a lot closer
to where we parse and read the data, i.e. in the while() loop below.

IOW, the code that sets size_index based on the attribute query
response should not have to know how many fixed elements will come
before these attributes on the response lines.  That knowledge
belongs to the code below:

> +     i = 0;
> +     while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
> +             struct string_list object_info_values = STRING_LIST_INIT_DUP;
> +
> +             string_list_split(&object_info_values, reader.line, ' ', -1);
> +             if (size_index > 0) {
> +                     if (!strcmp(object_info_values.items[size_index].string, ""))

And here the code that uses size_index should be like

		if (0 <= size_index &&
		    !strcmp(object_info_values.items[1 + size_index].string, ""))
			...

if we wanted the logic to be more "pure" and keep foo_index 0-based.
