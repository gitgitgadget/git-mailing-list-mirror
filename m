Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5561F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 07:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbcICHA0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 03:00:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54061 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752463AbcICHAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 03:00:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17BD12F6D8;
        Sat,  3 Sep 2016 03:00:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zh83qpV5Kx9Hz9IPmk3b8SWzLc8=; b=xiuxwM
        qdxH/NDvOveR4/9kNEvF3fBgtWBStNa37d2ceoqB3Hu6Cs0j5eoB4UKqSSl5APqR
        QrLCrA4dy4GUd0ckORNsphyoZH4HMtI3sLpR60YGnj8tvwJrH8z8s6QmrvP2Mv1D
        GH1aNdHWXgLRv2BiuzUzHftKjTnF2+H6rrd6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IhNUxFOxQ84+AMfjWTv4nxnfCMn2M2sh
        xrOikARXFiRZBS2O/TLzJmTObmVQOIleLd5ffr2Xh++XyJCsouopacMhb2VqqfFU
        ox0b/CxOHH/jgtKNrwqEKM1CGSed2VrBVbQ0bSNdr3iUj1RPmhAm379NeoIJ5Zth
        Xg+h3YhENqc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FAFD2F6D6;
        Sat,  3 Sep 2016 03:00:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A2562F6D3;
        Sat,  3 Sep 2016 03:00:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 0/2] Color moved code differently
References: <20160903033120.20511-1-sbeller@google.com>
Date:   Sat, 03 Sep 2016 00:00:21 -0700
In-Reply-To: <20160903033120.20511-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 2 Sep 2016 20:31:18 -0700")
Message-ID: <xmqqtwdxqxh6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15CE16D0-71A4-11E6-A88F-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> A line is colored differently if that line and the surroundign 2 lines
> appear as-is in the opposite part of the diff.
>
> Example:
> http://i.imgur.com/ay84q0q.png
>
> Or apply these patches and 
>     git show e28eae3184b26d3cf3293e69403babb5c575342c
>     git show bc9204d4ef6e0672389fdfb0d398fa9a39dba3d5
>     git show 8465541e8ce8eaf16e66ab847086779768c18f2d

I like this as a concept.  Two quick comments are

 * On 1/2, you would also need to teach diff-color-slot the
   correspondence between the name used by configuration and the
   enum used as the index into the diff_colors[] array.  I think
   these are not "DUPLICATE", but "MOVE", so I'd suggest renaming
   dup-new and dup-old to some words or phrases that have "MOVED"
   and "TO" or "FROM" in them (e.g. "DIFF_MOVED_FROM",
   "DIFF_MOVED_TO").

 * On 2/2, doing it at xdiff.c level may be limiting this good idea
   to flourish to its full potential, as the interface is fed only
   one diff_filepair at a time.  All the examples you pointed at
   above have line movement within a single path because of this
   design limitation.  I do not think 2/2 would serve as a small but
   good first step to build on top of to enhance the feature to
   notice line movements across files and the design (not the
   implementation) needs rethinking.

The idea has a potential to help reviewing inter-file movement of
lines in 3b0c4200 ("apply: move libified code from builtin/apply.c
to apply.{c,h}", 2016-08-08).  You can see what was _changed_ in the
part that has been moved across files with "show -B -M", and
sometimes that is useful, but at the same time, you cannot see what
was moved without changing, which often is necessary to understand
the changes and notice things like "you moved this across files
without changing, but this and that you did not change need to be
adjusted".

The coloring of "these are moved verbatim" in the style this series
gives would be very helpful for reviewing such a change.

