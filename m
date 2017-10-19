Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02ED1FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 05:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbdJSFWS (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 01:22:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56341 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750899AbdJSFWR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 01:22:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1767D94B3D;
        Thu, 19 Oct 2017 01:22:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H8rwTtzNjANPMj8AJb7xkqGOjUQ=; b=Sm2LBo
        /RGnAbmtyWUZ1LVy48MEZV9qcnu1dpyL8THxeqA5YlxKdW5SehxPngidZoMkZ62t
        Jy2YtKub9PVdFyr+f462HUFfNF8MyXcKfHrwvbIwND45i5B8fb7zpSN39GrAWx+J
        GqEbW61zwIMC250V+rDQCEUj3CnbPRAo3vVI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H5ON/sF/Q44LXaaNDFUxUngVvQmosm6I
        3rqtyicJasbCHD3jFbL9PzqjWb7PMyn+Ee6yeMVsOqxd6eNn+pBrKuzkO2ftAboZ
        CzAUz8aRw+n8UEpHmcMMUEnFQgcmT/DOeNnoT4BRcXUW/NY7bd/7bjKSGd3PE+TY
        AOgY+s3yazE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EEDA94B3C;
        Thu, 19 Oct 2017 01:22:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6BF3594B3B;
        Thu, 19 Oct 2017 01:22:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, t.gummerer@gmail.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v1] read_index_from(): Skip verification of the cache entry order to speed index loading
References: <20171018142725.10948-1-benpeart@microsoft.com>
Date:   Thu, 19 Oct 2017 14:22:13 +0900
In-Reply-To: <20171018142725.10948-1-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 18 Oct 2017 10:27:25 -0400")
Message-ID: <xmqq4lqvk8ze.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78073084-B48D-11E7-A259-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> There is code in post_read_index_from() to catch out of order entries
> when reading an index file.  This order verification is ~13% of the cost
> of every call to read_index_from().

I find this a bit over-generalized claim---wouldn't the overhead
depend on various conditions, e.g. the size of the index and if
split-index is in effect?

In general, I get very skeptical towards any change that makes the
integrity of the data less certain based only on microbenchmarks,
and prefer to see a solution that can absorb the overhead in some
other way.

When we are using split-index, the current code is not validating
the two input files from the disk. Because merge_base_index()
depends on the base to be properly sorted before the overriding
entries are added into it, if the input from disk is in a wrong
order, we are screwed already, and the order check in post
processing is pointless.  If we want to do this order validation, I
think we should be doing it in do_read_index() where it does
create_from_disk() and the set_index_entry(), instead of having it
as a separate phase that scans a potentially large index array one
more time.  And doing so will not penalize the case where we do not
use split-index, either.

So, I think I like the direction of getting rid of the order
validation in post_read_index_from(), not only during the normal
operation but also in fsck.  I think it makes more sense to do so
incrementally inside do_read_index() all the time and see how fast
we can make it do so.
