Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C9CA0FF6
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 20:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350664AbjIAUEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 16:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjIAUEP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 16:04:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DAA10FB
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 13:04:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 962ED26572;
        Fri,  1 Sep 2023 16:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=4Wi4NwNNeXdtun1u2Eynk/Ag1AFGyYFFNYfira
        kVc5I=; b=QSYkze9bCx4f5pGioS7deWyB6oikl7HZjapke4mFgPeCmICJJDhUu0
        577QU8NpgM43/qB6VoZTBbc3RhjYqHiMg34za92AWJ2W3bJqiTfgLyqMuMFaOWYD
        elv6NSuyhE8nydlpGTZ7Aq2LfDyHgBZ+Wzeo+xUzHK+qtg5p/Bcp4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EF8326571;
        Fri,  1 Sep 2023 16:04:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3C56926570;
        Fri,  1 Sep 2023 16:04:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: sort numerically when ":size" is used
In-Reply-To: <ZPI0e1XzZrDV2fJk@five231003> (Kousik Sanagavarapu's message of
        "Sat, 2 Sep 2023 00:29:07 +0530")
References: <20230901142624.12063-1-five231003@gmail.com>
        <xmqqa5u5rgis.fsf@gitster.g>
        <20230901174540.GB1947546@coredump.intra.peff.net>
        <xmqqr0nhpyf3.fsf@gitster.g>
        <20230901183206.GA1952051@coredump.intra.peff.net>
        <ZPI0e1XzZrDV2fJk@five231003>
Date:   Fri, 01 Sep 2023 13:04:08 -0700
Message-ID: <xmqqcyz1psnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B651B8CC-4902-11EE-A216-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> What I also find weird is the fact that we assign a "cmp_type" to the
> whole atom. Like "contents" is FIELD_STR and "objectsize" is "FIELD_ULONG"
> in "valid_atom". This seems wrong because the options of the atoms should be
> the ones deciding the "cmp_type", no?

I do not quite get where your confusion comes from.

The use of valid_atom[] purely for catalogging things like
"contents", "refname", etc., before specialization, as opposed to
used_atom[] that lists the actual specialized form of the atoms used
in the format string.  If you refer to "contents:body" and
"contents:size" in your format string, they become two entries in
used_atom[], both of which refer to the same atom_type obtained by
consulting the same entry in the valid_atom[] array.

The specialization between "contents:body" and "contents:size" must
be captured somewhere, and that happens by using two used_atom[]
entries.  There will be one "struct atom_value" for each of these
placeholders, each of which refers to its own used_atom that knows
for which variant of "contents" it was created.  Of course, these
two "struct atom_value" instances will have different content string
for the same ref (one stores the body part of the string, the other
stores the size of the contents).

> I wanted to leave the "cmp_type" field of the atom untouched because that
> would mess up this "global" setting of "contents" to be a "FIELD_STR" (or
> even "raw" for that matter).

We are not talking about futzing with valid_atom[] array.  

Because the used_atom[] array is designed to be used to capture the
differences among "contents" vs "contents:body" vs "contents:size",
what types of entities the values that uses an entry in used_atom[]
array (i.e. an instance of "struct atom_value") should be decided
using the information stored there.

I agree that Peff's "the value for 'contents:size' we know is
numeric, so only store the numeric value in atom_value and let the
output logic handle that using cmp_type information" sound very
tempting.  If we were to tackle it, however, I think it should be a
separate topic.

In any case, it was very good that you noticed we do not sort
numerically when sorting by size (I guess our sort by timestamp
weren't affected only because we have been lucky?).  Thanks for
starting this topic.


