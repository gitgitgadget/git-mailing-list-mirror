Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B477F1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbcHWQ2W (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:28:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56865 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752570AbcHWQ2V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:28:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2420535752;
        Tue, 23 Aug 2016 12:28:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ag14UM4ME8rF8HlZlZxriVl+S0=; b=LAeEqe
        e7Py2gmHqkTeH/VZc7NDvDD/dXlbUtUwzvr4Rs1/5linDM9iZw657NICawu1EatC
        Y+k62ry8dUpywSgndCKYyCRBQOPecYs7YMZffjocy3Ohh90+TGqIJ736aJ23b0yv
        3gX67hBoqMWlDnRiDzeq9TyDpIkx74WSYbd+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jqF93212oDk1eoQMqZZTb41PXw5s0BBd
        aQpUgOBKSQJbA8HvDvccqiBZtk/1nqpdt/dZzrdpn5FeCO4JSvnKR9Jklc4fGkRh
        mRWMJzt98/qBmzapevAV+xUSQIFg+MRqhJO8BSOwbrc+ltUnher5CTQd8ogXz6+u
        W2MObjHp6tY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B53C3574B;
        Tue, 23 Aug 2016 12:28:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 926093574A;
        Tue, 23 Aug 2016 12:28:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v8 7/8] cache: add empty_tree_oid object
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-8-jacob.e.keller@intel.com>
        <xmqqfuq01oww.fsf@gitster.mtv.corp.google.com>
        <20160819205806.vxzzgphqf4lgdor7@sigill.intra.peff.net>
Date:   Tue, 23 Aug 2016 09:28:17 -0700
In-Reply-To: <20160819205806.vxzzgphqf4lgdor7@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 19 Aug 2016 16:58:06 -0400")
Message-ID: <xmqqbn0jxxem.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A32BBDC-694E-11E6-98CA-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect we need more than just the "is_empty" query. At least for the
> blob case, we do hashcpy() it into a struct (which should eventually
> become oidcpy). The empty-tree case even more so, as we pass it to
> random functions like lookup_tree().
>
> Our EMPTY_TREE_SHA1_BIN_LITERAL effectively ends up as a singleton
> in-core, too; it's just handled transparently by the compiler, since
> it's a literal. This effectively gives us _two_ singletons. We could do:
>
>   const struct object_id empty_blob_oid = {
> 	  "\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b"
> 	  "\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
>   };
>   #define EMPTY_BLOB_SHA1_BIN (empty_blob_oid.hash)
>
> It's possible the use of an actual string literal lets the compiler do
> more optimizations, but I'd doubt it matters in practice. Probably it is
> just sticking that literal somewhere in BSS and filling in the pointer
> to it.

Makes sense; thanks.
