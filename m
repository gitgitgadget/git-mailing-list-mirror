Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935152042F
	for <e@80x24.org>; Wed, 16 Nov 2016 18:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbcKPSSt (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 13:18:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58410 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752282AbcKPSSs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 13:18:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 881264E65E;
        Wed, 16 Nov 2016 13:18:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6YiHqu9UOxUtaH0mwJ9VUdbbhfs=; b=d4ZzzX
        8UuTiBwXJ0HBGUmielyvIhIvfSua4GzHTtqdIkS/1eGKCvM++eZTqzYiE2TWgs5s
        K9ES6Cx6ilQfc6Um4RCZd0PxGxBpJFIie0/Y0JgbZ2fBQrf6kEkrkcD9PJdoECOs
        haSzDF5SWKdUcf2jRAfz71ac/bn5RNEe36RuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rN+pATwGnz5EZSOeSNsxsxVwgOteGeBB
        YX83PvkP+7JchrrlWxT3AAehAmVh3TEx53Il2GfnAmJBB17EsKLQr+Ot6aldMKfO
        m7Jc4o2U7DbsXMhSv0/oWlAilOtzIaJIXvnoliHF9JwxoVFl5NyjRwY/FQxO8Obh
        G2miSFZ9iWA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F2CF4E65D;
        Wed, 16 Nov 2016 13:18:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3B024E65C;
        Wed, 16 Nov 2016 13:18:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
Subject: Re: Protecting old temporary objects being reused from concurrent "git gc"?
References: <1479219194.2406.73.camel@mattmccutchen.net>
        <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
        <1479231184.2406.88.camel@mattmccutchen.net>
        <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
        <xmqqk2c4tsv4.fsf@gitster.mtv.corp.google.com>
        <20161116080753.gkn6v7vhdbifpubn@sigill.intra.peff.net>
Date:   Wed, 16 Nov 2016 10:18:45 -0800
In-Reply-To: <20161116080753.gkn6v7vhdbifpubn@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 16 Nov 2016 03:07:54 -0500")
Message-ID: <xmqqlgwjqoe2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D833756-AC29-11E6-94E7-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... I notice there is
> a return very early on in update_one() when has_sha1_file() matches, and
> it seems like that would trigger in some interesting cases, too.

Yeah, I missed that.  It says "we were asked to update one
cache_tree that corresponds to this subdirectory, found that
hashes everything below has been rolled up and still valid, and we
already have the right tree object in the object store".

It can simply become freshen(), which is "do we have it in the
object store?" with a side effect of touching iff the answer is
"yes".
