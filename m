Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C4BC433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8238161453
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhD2Ep6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 00:45:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60019 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhD2Ep6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 00:45:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 133C712D34A;
        Thu, 29 Apr 2021 00:45:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dnkMsEBmhHpr
        l7uUcUlm/InNnDWwpWA83Oop0XOL0Is=; b=H0bARG1UM93cjBiGg37kzhkvO2Bu
        0EdupFQbeXzr8jt/2gSLCZKupFENV8l0EPxGkxeXEUCCv2DHwP/7nRJFMeQW7gQO
        DjpuxlMY43QaTLTxuTMdUpjf6i3WwH6Fu47Kr1Kj5zZrjjDwPgcluzbWct1mwqwJ
        ZWLa+YdZDjHa1Uw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C2FB12D349;
        Thu, 29 Apr 2021 00:45:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4700812D347;
        Thu, 29 Apr 2021 00:45:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 05/10] {commit,tree,blob,tag}.c: add a
 create_{commit,tree,blob,tag}()
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
        <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
        <patch-05.10-5213d500b9-20210420T124428Z-avarab@gmail.com>
Date:   Thu, 29 Apr 2021 13:45:07 +0900
In-Reply-To: <patch-05.10-5213d500b9-20210420T124428Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Apr
 2021 14:50:38 +0200")
Message-ID: <xmqqa6ph8zsc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD27C868-A8A5-11EB-A8C6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a create_*() function for our built-in types as a handy but
> trivial wrapper around their calls to create_object().
>
> This allows for slightly simplifying code added in
> 96af91d410c (commit-graph: verify objects exist, 2018-06-27). The
> remaining three functions are added for consistency for now.

"for now" puzzles me.  As file-scope static functions, they do not
hurt all that much, but on the other hand, having to say
"create_object(r, oid, alloc_blob_node(r))" is not hurting at all.

The worst part of this "consistency" is that callers cannot call
create_blob() because it is not external, even though they learn
create_commit() as a handy way to use the create_object() API, which
is not consistent at all.

And since most callers should be calling lookup_blob() etc., and
should not be calling create_blob(), we shouldn't tempt people to
push for making them externally available.

Which in turn makes me wonder if the use of create_object() added to
the commit-graph.c was a good idea to begin with.
