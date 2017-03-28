Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27BD1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 20:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755914AbdC1Uqi (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 16:46:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54711 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755908AbdC1Uqh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 16:46:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F31472C27;
        Tue, 28 Mar 2017 16:46:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FRgJTo86qeXvSYRoU/ETmHMoeVs=; b=WHB28F
        +sR9QfZSeKeQMr/uBTW9gyeJjtEQUB6Gl0ya19L/OSeL5bFJMz7XXIYBydg6symu
        XdnjdKf94JeQh35+9DPhUn1ha9N8aSjUvD4c+eJVlDjdT5BYFuCgNK5wW1c0QnWx
        Jgf2yNCmYABm/PwZbJcWRPrzbyPeeYht9Y8NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T4WR+ptOr2mxKN3ACD/Z+NZGOuVJqip4
        M3V25cRgltS560/4NkoT6UnF8e7RNHymTmIyK+CvpCMueEHGP83Bg09+SLq6sR5d
        7gQpFrHUL6CCqfRJTcxQ47/9UmAkiG1D/ElXmkcZ/ZNJ+LRhS1NPooF1VShK5khd
        KTL9twgez1k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36ED072C26;
        Tue, 28 Mar 2017 16:46:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA37C72C23;
        Tue, 28 Mar 2017 16:46:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] diff: teach diff to expand tabs in output
References: <20170328122209.4861-1-jacob.e.keller@intel.com>
        <20170328122209.4861-2-jacob.e.keller@intel.com>
        <xmqqk279cjfs.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xqA9ZOfaeVg0wjgXVs=N=OJUZjjY1pahUn2xbvSQohfUQ@mail.gmail.com>
        <20170328203814.36aiocj53wtfcjz5@sigill.intra.peff.net>
Date:   Tue, 28 Mar 2017 13:46:19 -0700
In-Reply-To: <20170328203814.36aiocj53wtfcjz5@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Mar 2017 16:38:14 -0400")
Message-ID: <xmqqbmslcep0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B14A430-13F7-11E7-B51C-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That also means an option to something like "expand" is tough, because
> "first character" really means "first non-ANSI-code character".

That is true, but once you commit to the mindset that you are
extending "expand", then that becomes a mere part of what must be
done, i.e. if you want your "expand" to be able to handle coloured
input, you'd need to know how wide each segment of the input is.
For that matter, you would also want your "expand" to pay attention
to the differences between display- vs byte-widths of a string,
perhaps reusing utf8_strwidth() or something.

Also "the first character is special" does not have to be a "diff
specific hack".  Your extended "expand" can take a list of
tab-widths and the special case for highlighting diff output happens
to take 9,8 as the "list of tab-widths" parameter (whose semantics
is that each number in the list tells how wide the tab is, and the
last number repeats forever, so 9,8 really means 9,8,8,8,8,...).
