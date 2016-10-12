Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2E36215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 22:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbcJLWpo (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 18:45:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58289 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932872AbcJLWpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 18:45:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABC1447593;
        Wed, 12 Oct 2016 18:45:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NGXXFh6YypTvASSQ1YIZ7dzM/Sk=; b=UCVPL3
        57RrckDsoD07zv/w8lH19EhFU1DnZglKnFn1XBr5LPh3ij0lC3IQy7lOfCGM1Xw3
        qmxUYa5BGO0woh/BOJJgjon/u7iDYQqrqeev+5or1Cv6MDNz+LaVi7fOU/LfqWBk
        dNhUWYkger6cGLbj0YuMuPHcnpUbRkkeQJv9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iceIu502YvnSPLDKYR2i9z7JcP2o0MEh
        LrhdJp8NcnZ9cVtPQcbDnjK2TBFJX7cogZfN4IG12c21/f6+sy1030H814dRX7SL
        EuBk5BIvkCOnV4l6s8gYIZHf4wilIXtcBAnkVpAYc1JsLlQHMgkglthHKFdNjGTR
        aFtmzWsuzrw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A410C47592;
        Wed, 12 Oct 2016 18:45:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2011547591;
        Wed, 12 Oct 2016 18:45:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Huge performance bottleneck reading packs
References: <ea8db41f-2ea4-b37b-e6f8-1f1d428aea5d@oracle.com>
Date:   Wed, 12 Oct 2016 15:45:39 -0700
In-Reply-To: <ea8db41f-2ea4-b37b-e6f8-1f1d428aea5d@oracle.com> (Vegard
        Nossum's message of "Thu, 13 Oct 2016 00:30:52 +0200")
Message-ID: <xmqqpon5190s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A41E502-90CD-11E6-BC01-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> A closer inspection reveals the problem to really be that this is an
> extremely hot path with more than -- holy cow -- 4,106,756,451
> iterations on the 'packed_git' list for a single 'git fetch' on my
> repository. I'm guessing the patch above just made the inner loop
> ever so slightly slower.

Very plausible, and this ...

> My .git/objects/pack/ has ~2088 files (1042 idx files, 1042 pack files,
> and 4 tmp_pack_* files).

... may explain why nobody else has seen a difference.  

Is there a reason why your repository has that many pack files?  Is
automatic GC not working for some reason?

"gc" would try to make sure that you have reasonably low number of
packs, as having too many packs is detrimental for performance for
multiple reasons, including:

 * All objects in a single pack expressed in delta format (i.e. only
   the difference from another object is stored) must eventually
   have another object that its difference is based on recorded in
   the full format in the same packfile.

 * A single packfile records a single object only once, but it is
   normal (and often required because of the point above) that the
   same object appears in multiple packfiles.

 * Locating of objects from a single packfile uses its .idx file by
   binary search of sorted list of object names, which is efficient,
   but this cost is multiplied linearly as the number of packs you
   have in your repository.

