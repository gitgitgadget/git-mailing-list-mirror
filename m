Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DCE720133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932473AbdCFVxp (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:53:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55730 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932466AbdCFVxn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:53:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADEA7708F3;
        Mon,  6 Mar 2017 16:53:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q1tjvFS1CjrGOm5Y275pKKzTSb4=; b=J+umJt
        VjlV9zm3pC6I2tzghEwPFIPj6NNedcr3ytFW2bpA/CuP2UZ4yAgZjiNpA+6En6aL
        +Enfg0CXsTBQ6WsFkzlMhK9Iy0lhXvVeCn4hSNiYlCdrWsFNzCi4WYQtrp/JPib5
        o6O9UlI7O3l3Cbx0/Ik+EHqvr2mrRa94y07UE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q+MIpnED+0Q+UJUU4t0YOMxAUgchlMaM
        eBj0UVtQGLoCjmn0XWttCQjMsH8PRrZkJ6v9Zu4uYA5YgZGloN9BF5pU4iTHQG2O
        rmm0aeWeZ5p6eDTWUmjGMVZ10XoQoloH0nCL5gR+vFZe42IHFQeu/Pxq1qSOjd8l
        f4M7Lpj9Ivg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A69AC708F2;
        Mon,  6 Mar 2017 16:53:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13619708F1;
        Mon,  6 Mar 2017 16:53:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com
Subject: Re: RFC: Another proposed hash function transition plan
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net>
        <cdd7779a-acdb-99fd-a685-89b36df65393@google.com>
        <CA+55aFxj7Vtwac64RfAz_u=U4tob4Xg+2pDBDFNpJdmgaTCmxA@mail.gmail.com>
Date:   Mon, 06 Mar 2017 13:53:39 -0800
In-Reply-To: <CA+55aFxj7Vtwac64RfAz_u=U4tob4Xg+2pDBDFNpJdmgaTCmxA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 6 Mar 2017 11:22:17 -0800")
Message-ID: <xmqqwpc2m5r0.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C6BE42E-02B7-11E7-9C06-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So *if* the new object format uses a git header line like
>
>     "blob <size> <sha1>\0"
>
> then it would inherently contain that mapping from 256-bit hash to the
> SHA1, but it would actually also protect against attacks on the new
> hash.

This is easy for blobs as you only need to hash twice.  I am not
sure if you can do the same for trees, though.  For that <sha1> to
be useful, the hash needs to be over the tree contents whose
references are expressed in <sha1>, which in turn would mean...

... ah, you would read these <sha1> off of the object header in the
new world and you do not need to expand the whole thing.  OK, I see
how it could work.

> In fact, in particular for objects with internal format that
> differs between the two hashing models (ie trees and commits which to
> some degree are higher-value targets), it would make attacks really
> quite complicated, I suspect.
>
> And you wouldn't need those "hash" or "nohash" things at all. The old
> SHA1 would simply always be there, and cheap to look up (ie you
> wouldn't have to unpack the whole object).
