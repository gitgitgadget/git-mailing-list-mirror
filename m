Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B7120899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbdHHTZV (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:25:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53639 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752364AbdHHTZT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:25:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9AAF941A4;
        Tue,  8 Aug 2017 15:25:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hS27GwjHie5CCy3+MsWnyOjrQ00=; b=WvD/yQ
        qEcAh8TiaNterGXKTS18R+SKD/WkNYI0w7xNTbwi28ePoppfafmMwDJRaw+Yw27H
        fBgCQJsq9UlyofvfIX9MRK9Tirdwa20AWLVbQ9ed08NDYz2poQTIigqbLILde+S8
        5KNsYhslTD3IweJH31DTBjUTIypWXYnbd3l1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=geCXtEItFcnCO3kXy4gIg6VSG8UUwoaC
        TWYrPIVdioxiz847+G/qrCe0tPcwqJpkaVydVhX9NNRzfEm5AZWwF+oTos0q1n4c
        Tlz0jHeOXP3xmVL6KncdCVLRZzdSE/u8b09WdPzcJv3gTre2sRWJ0+K0/V5A7tUg
        vSL1bS1Apc8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99747941A3;
        Tue,  8 Aug 2017 15:25:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E940F941A2;
        Tue,  8 Aug 2017 15:25:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: reftable [v6]: new ref storage format
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
Date:   Tue, 08 Aug 2017 12:25:16 -0700
In-Reply-To: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
        (Shawn Pearce's message of "Sun, 6 Aug 2017 18:47:06 -0700")
Message-ID: <xmqqpoc5c15v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FCFE80A-7C6F-11E7-8AC7-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> For `log_type = 0x4..0x7` the `log_chained` section is used instead to
> compress information that already appeared in a prior log record.  The
> `log_chained` always includes `old_id` for this record, as `new_id` is
> implied by the prior (by file order, more recent) record's `old_id`.
>
> The `not_same_committer` block appears if `log_type & 0x1` is true,
> `not_same_message` block appears if `log_type & 0x2` is true.  When
> one of these blocks is missing, its values are implied by the prior
> (more recent) log record.

Two comments.

 * not-same-committer would be what I would use when I switch
   timezones, even if I stay to be me, right?  I am just wondering
   if it is clear to everybody that "committer" in that phrase is a
   short-hand for "committer information other than the timestamp".

 * Should the set of entries that are allowed to use of "chained"
   log be related to the set of entries that appear in the restart
   table in any way?  For a reader that scans starting at a restart
   point, it would be very cumbersome if the entry were chained from
   the previous entry, as it would force it to backtrack entries to
   find the first non-chained log entry.  A simple "log_chained must
   not be used for an entry that appear in the restart table" rule
   would solve that, but I didn't see it in the document.



