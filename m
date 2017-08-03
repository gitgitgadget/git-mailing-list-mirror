Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F3A020899
	for <e@80x24.org>; Thu,  3 Aug 2017 01:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbdHCBus (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 21:50:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50249 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751188AbdHCBur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 21:50:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2360986F4;
        Wed,  2 Aug 2017 21:50:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9uT5DPPyjZ2QdONC+tJ/23Wk0NM=; b=lfOp+X
        C9pFu8MT2eiNBdUJZMIv5uCuGGyyX9ZbtdtjqILXv/PVmA3Vj7ozeUcRYkLt45ok
        JcV8MwByQUFk2n91IY41/N3cAHCPwUWrCBwXHaHu5J+pc7/A24puI3UgCx3vwgpC
        tclbDpVX1k8pCf5/PbqwbJsbR/fWvzMhTfLj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BInxS0/4FXuO8bamldBcsHBMWR2eNjzL
        PelUh5gR64DFrkHj7LGhBawc4GXw/QsLvgqA34dTT3IrdUW9Gjo8uYuzLkxJXIPz
        MBermOqSq1+osHhpsDzhEcF0iXSZmtX74XqctOOb1TApEs9BvKvUy34HsikmZP5P
        R7z5s0EhRhM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A163986F3;
        Wed,  2 Aug 2017 21:50:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00E64986F2;
        Wed,  2 Aug 2017 21:50:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>
Subject: Re: reftable [v4]: new ref storage format
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
        <xmqqh8xpsq9c.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 02 Aug 2017 18:50:37 -0700
In-Reply-To: <xmqqh8xpsq9c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 02 Aug 2017 12:50:39 -0700")
Message-ID: <xmqqd18dqv0y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 268D373E-77EE-11E7-B5AA-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I like the general idea, what the file format can represent and how
> it does so, but I am a bit uneasy about how well this "stacked" part
> would work for desktop clients.

Two more random things before I forget.

 * I understand that you would want to allow both a ref "ref/D" and
   "ref/D/F" to appear in the same reftable file.  A refname is an
   uninterpreted sequence of bytes and refnames are sorted in the
   table.

   Would it benefit us if we define the sort order of bytes slightly
   different from the ASCII order, so that a slash '/' sorts between
   NUL '\000' and SOH '\001', which is the order we should have used
   when storing the entries in the index?

 * Even though readers can continue accessing, starting from the
   $GIT_DIR/refs, without locking and get consistent views, any
   transaction that groups one or more ref updates would need to
   take a global lock on $GIT_DIR/refs file.  

   Would it become a problem in a busy repository?
