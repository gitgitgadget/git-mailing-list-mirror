Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4CF020899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbdHHTBw (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:01:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62878 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752163AbdHHTBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:01:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B768D937AF;
        Tue,  8 Aug 2017 15:01:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y9B2GLYcIwsOgphieZ33DOT1i5o=; b=MrxZqa
        f7ON5FkduMKUWvSIYTEWpGLw+v0GfTF+y57QcL2NFc0nxxwFxCDz8luhEEEUnvOz
        +zY9/+82RXTbYewwuWza+5np+rsIwS/jp8/x/joKs28pNMWQVN2o1Oyd1D0Hp/T6
        baIKY3Z5XY/JJnrCpPmy8Ht7Ul3ennXMFrZ8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ufa5MSm3vaCqDCRcMkeVVREdmuMrQxE6
        kzIvI9K4Tavaf01ZZZN5kh/mzAcFLsT+h2c5iiJ/ieCjWsRKasJJL19KNs1oCUGG
        j/xBbaIm10DuDEeBKNha1LYNnHLkXCkZZCYWNZDJpdCu8BuNieN5hC8aSAq/UnNz
        wn0meUADxuA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF940937AE;
        Tue,  8 Aug 2017 15:01:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15811937AD;
        Tue,  8 Aug 2017 15:01:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: reftable [v6]: new ref storage format
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
Date:   Tue, 08 Aug 2017 12:01:48 -0700
In-Reply-To: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
        (Shawn Pearce's message of "Sun, 6 Aug 2017 18:47:06 -0700")
Message-ID: <xmqqtw1hc28z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 089EC274-7C6C-11E7-B1A2-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I notice that you raised the location of restart table within a
block in this iteration (or maybe it happened in v5).  

This forces you to hold all contents in core before the first byte
is written out.  You start from the first entry (which will become
the first restart entry), emit a handful as prefix compressed
entries, emit a full entry (which will become the next restart
entry), ... until you have enough to fill both the data and the
restart table, then start writing from the header (which needs the
length of the block), restart table and then data.

I think it is OK to do so for the blocks whose size is limited to
16M, but I wonder if it is sensible to do the same for the index
block whose limit is 2G.  If you keep the restart table after the
data, then you could stream out the entries as you emit, write the
restart table, and then seek back to fix the length in the header,
without holding the 2G in core, no?

