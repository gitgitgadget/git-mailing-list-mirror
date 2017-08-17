Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2856620899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbdHQVRM (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:17:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62971 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752609AbdHQVRL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:17:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D52291106;
        Thu, 17 Aug 2017 17:17:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UwNWjOwgsiiVD3zw/vfcUtDlZxY=; b=BcQsGp
        A/t0Qn+lflaEr8yS5+d0SMDrinXUYKNpsxyze2epV6WJeMtaAoxR6eTpQcZ9HQyu
        lbtLPXScvz9hpl399TZ+4J9RIPnyIx20DqD5ZOxgikNFh585HKCJMlGQ8nqgBIja
        BAa/X45pn+v84NqnSYbpHQZqY9E3MhkGo1tgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XaG4xAyR5awTGPnrwm5Iwf1ds95qoSl9
        QWnjUjJyfLjZsD6AssnnjyHaU/K77oQ1h7ddyn680s1Zq5KyNrEaeXVfP8Y3rWIV
        sEJMejyXh6ApINNHhRzqBstLKXooJXw79eH+uHXVW8LIb8kKtnwDvZS6//ZivArm
        LTFE9O8hH9c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7516991105;
        Thu, 17 Aug 2017 17:17:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C928D91104;
        Thu, 17 Aug 2017 17:17:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] commit: replace the raw buffer with strbuf in read_graft_line
References: <cover.1502796628.git.patryk.obara@gmail.com>
        <b5633a5425c623f3d2204325e99332b5bb511582.1502796628.git.patryk.obara@gmail.com>
        <CAGZ79kaCtbuDEUJqJ+nVUW78ksLMyHZ2xhnbunUqzjkGRuYg+A@mail.gmail.com>
        <CAJfL8+QreNvRqVZ0t1Sw=+o4nFK6WuvuOWix_C0MNFik6Cc+rA@mail.gmail.com>
        <20170816225901.dbpzvsie2zgetunu@genre.crustytoothpaste.net>
        <20170817055516.4zz3ucvx4mgr6qus@sigill.intra.peff.net>
Date:   Thu, 17 Aug 2017 14:17:08 -0700
In-Reply-To: <20170817055516.4zz3ucvx4mgr6qus@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 17 Aug 2017 01:55:16 -0400")
Message-ID: <xmqq7ey1gai3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E1E1D6C-8391-11E7-AD58-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'd expect most of the GIT_MAX constants to eventually go away in favor
> of "struct object_id", but that will still be using the same "big enough
> to hold any hash" size under the hood.

Indeed.  It is good to see major contributors are in agreement ;-)
I'd expect that an array of "struct object_id" would be how a fixed
number of object names would be represented, i.e.

	struct object_id thing[num_elements];

instead of an array of uchar that is MAX bytes long, i.e.

	unsigned char name[GIT_MAX_RAWSZ][num_elements];

In fact, the former is already how we represent the list of fake
parents in the commit_graft structure, so I think patch 5/5 in this
series does two unrelated things, one of which is bad (i.e. use of
parse_oid_hex() is good; turning the FLEX_ARRAY at the end into a
oid_array that requires a separate allocation of the array is bad).

> Agreed. Most code should be dealing with the abstract concept of a hash
> and shouldn't have to care about the size. I really like parse_oid_hex()
> for that reason (and I think parsing is the main place we've found that
> needs to care).

Yes.
