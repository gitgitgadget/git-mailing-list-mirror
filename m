Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C3B1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 03:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfHVDHj (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 23:07:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53199 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbfHVDHj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 23:07:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FADD68AF6;
        Wed, 21 Aug 2019 23:07:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B3d39VHo8XUABo4JOG9ZyG7VPVc=; b=ADcFQm
        Ykm0AFAOMiK7OgMIW+nUcg+B7Xy828WeaEq2eAwyI/ecK+vOW4kZHgdUGjDS2ltp
        E4ac3OcnmOnkHpWDQdjMcNV6Kdzc1LBUvrPV+jiuFu9i4MNLINcDYa1vCAKohrG3
        AnYf951E373F/9v6hUyXVzvF2pz92OsAF1ckU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AXkxP+n2UVCV6BqD/GHzh5SLv8q2F8Ym
        igaGRPsbnLgCSZW+9CyOXIdaIjOZo0QK9RpHy+4hjrrDqZjkmQdHnFpg7xEsV/ow
        2UJCtppVV10/J8TeoY8KteIBZwtpBLOgRLtsvkBvHkbzWMdqT+VsyYt6JDQevdVa
        S/Zska8qio4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27BE268AF4;
        Wed, 21 Aug 2019 23:07:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 56AF468AF3;
        Wed, 21 Aug 2019 23:07:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Fully peel tags via for-each-ref?
References: <CAGyf7-GBx3FSCQTipmkNBtnwMANg5A0FXiiPc2az0NiRLRT+xg@mail.gmail.com>
        <xmqq8srowfkv.fsf@gitster-ct.c.googlers.com>
        <20190821230035.GA26107@sigill.intra.peff.net>
Date:   Wed, 21 Aug 2019 20:07:29 -0700
In-Reply-To: <20190821230035.GA26107@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 21 Aug 2019 19:00:36 -0400")
Message-ID: <xmqqmug1rj7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB17B53A-C489-11E9-9D01-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's this gem in ref-filter.c, which blames back to your 9f613ddd21
> (Add git-for-each-ref: helper for language bindings, 2006-09-15):
>
>           /*
>            * NEEDSWORK: This derefs tag only once, which
>            * is good to deal with chains of trust, but
>            * is not consistent with what deref_tag() does
>            * which peels the onion to the core.
>            */
>           return get_object(ref, 1, &obj, &oi_deref, err);
>
> Which isn't to say it isn't useful to be able to do a single-layer peel,
> but I can't think of another part of the system which does so (unless
> you've asked to peel to a specific type, of course).

Quite honestly, I think the "only once" behaviour outlived its
usefulness, without other "features" that may help make it more
useful.  To help a script that wants to do "chains of trust", it may
first appear to be useful to peel only one layer, revealing that the
tagged object is another tag, and that was the thinking behind the
NEEDSWORK comment.

But after we learn that a ref "refs/tags/foo" points at a tag object
that points at another tag object, what can the script do?  It
cannot feed the other tag found that way back into --format=%(*<thing>)
machinery of for-each-ref, as the command and its variants, the "--list"
mode of "branch" and "tag" commands, only work on the object at the
tip of refs.  The script must manually peel the tag one layer at a time.

And that "manually" has to be really manual.  No ^{<type>} suffix
allows scripts to peel just one layer, so inside a loop, the script
has to say "cat-file tag <object>" and parse the "object" header
from the output.

The only thing that gets affected if we changed %(*<thing>) to fully
peel tags is a tag that points at another tag, and the traditional
behaviour to peel only one layer, while it _might_ have been done as
a good first step to add more support for chain of trust, is not all
that useful for such a tag, I am not sure if the current behaviour
is defensible.
