Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22331202F2
	for <e@80x24.org>; Sat, 18 Nov 2017 01:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764082AbdKRBrt (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 20:47:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52909 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1764077AbdKRBrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 20:47:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53152AD5AE;
        Fri, 17 Nov 2017 20:47:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Tt8UN97LUNS2OMkv1kLn2zX9Nk=; b=JeAe/z
        k8edi8xcX/qzVSRRITv/VaVGQZNFrNESs5GOFpQBWkJJ6CIiQyqity/W5jKkJt9n
        qRNBm0rdoSPeRGScQqiji6ssRL+0b5NZccotV7EsoQrlVJ3S5uIZbE6f+ZP+cESH
        rKuWuad35YJR1qdVqNjBeA7hc1X/kMm51tnfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E6WI/kaHUWLoV9D+gA7l7P6PMOTYj15q
        kiD5JpvwAOZQvmWj9kKXJe4jRTCuO42L6QTO0PKrDW8XFf5LKJD04TvFTLwIfj/j
        hojk0eQejLFl8tzuJPiNjDgTu47oMkTouhHPob7TNmslJYwD2v1DAMst8yhhcOEL
        HwKX4K1/gcc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BC15AD5AD;
        Fri, 17 Nov 2017 20:47:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8AE5AD5AC;
        Fri, 17 Nov 2017 20:47:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] Introduce git add --renormalize .
References: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
        <20171116163828.14937-1-tboegi@web.de>
        <CAPig+cQocmJyoALeQeCRQPNsRgvJ5PSe=u2LN8Ec6aC86D4iQw@mail.gmail.com>
Date:   Sat, 18 Nov 2017 10:47:45 +0900
In-Reply-To: <CAPig+cQocmJyoALeQeCRQPNsRgvJ5PSe=u2LN8Ec6aC86D4iQw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 17 Nov 2017 15:44:11 -0500")
Message-ID: <xmqqd14gqrwe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A0D1006-CC02-11E7-949E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I _could_ understand if this functionality lived in, say, a new
> command git-attr:
> ...
> (I have since read the thread in which Junio's suggested[1] that
> git-add could house this functionality, but it still feels too
> high-level.)

If this were part of a hypothetical "git attr" command, I would have
a hard time understanding it.  I would view the "attr" as attributes
attached to each path, telling various things about the path, one of
which may be how contents are handled between Git and the file on
the filesystem.  In other words, "attr" is _not_ contents; it is a
set of attributes attached to path that house the contents.

What we are correcting here at this point in the expected usecase is
not an attribute.  We are correting the contents, and between the
two potential sources of "the right version" of the contents, the
user tells that the filesystem is the right one, so "add" is used
to correct mistakes in the index based on what is in the filesystem
(if we were correcting the other way, like Jonathan said in the
message in the thread you read, "checkout" would be used to correct
the filesystem version using what is in the index).


