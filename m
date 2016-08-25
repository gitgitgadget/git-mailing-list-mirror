Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F03C1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 22:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbcHYWcD (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 18:32:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64972 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932692AbcHYWcB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 18:32:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB1F93410F;
        Thu, 25 Aug 2016 18:31:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KQx+wLg8Z2w9wiRa2owfEe+Vnsk=; b=T9I0ws
        2OLva/CN+xuR0g38WdLGhBzW4QcnZsifHQ0pe1Lrk06xhEMQd48fzKFDVLvA0u0U
        M3CvHN3h22La01mE6w6YyT+Y2TvBU9Cj79jPIc4r3DqElxbpwzlkqzSVFGA6BKER
        iB+sq+YYs71T69vM+60j1+bfwJJ8cRzf7dZ4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RG0aMxBtNs6JFNFYQvYrKAx4XUlZNaAu
        UQdgKo8FsD6BqAVhVv1xnwT5SbgsH0h51QYLY975EwtItmK+hGfCz55jjjuzvw0f
        LJWdE4Wwv4fDcx/bUt5ovyYoF4cwMQGDY1PrIA2EXvITotHS6AJ+jPYGjR15CqY4
        FQlkm7sHZ04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E44533410E;
        Thu, 25 Aug 2016 18:31:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F22F3410D;
        Thu, 25 Aug 2016 18:31:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush terminated packet streams
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-7-larsxschneider@gmail.com>
        <CAGZ79kaVg40H-LeDtFfDYqDFDDbr+um3ZYj8oAaqGu+q6k5e+A@mail.gmail.com>
Date:   Thu, 25 Aug 2016 15:31:57 -0700
In-Reply-To: <CAGZ79kaVg40H-LeDtFfDYqDFDDbr+um3ZYj8oAaqGu+q6k5e+A@mail.gmail.com>
        (Stefan Beller's message of "Thu, 25 Aug 2016 11:46:06 -0700")
Message-ID: <xmqqvayojx9e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCABC9C6-6B13-11E6-AFC0-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So the API provided by these read/write functions is intended
> to move a huge chunks of data. And as it puts the data on the wire one
> packet after the other without the possibility to intervene and e.g. send
> a side channel progress bar update, I would question the design of this.

Hmph, I didn't think about it.

But shouldn't one be able to set up sideband and channel one such
large transfer on one band, while multiplexing other payload on
other bands?

> If I understand correctly this will be specifically  used for large
> files locally,
> so e.g. a file of 5 GB (such as a virtual machine tracked in Git), would
> require about 80k packets.

What is wrong about that?  4*80k = 320kB overhead for length fields
to transfer 5GB worth of data?  I do not think it is worth worrying
about it.

But I am more surprised by seeing that "why not a single huge
packet" suggestion immediately after you talked about "without the
possibility to intervene".  They do not seem to be remotely related;
in fact, they are going into opposite directions.

Puzzled.
