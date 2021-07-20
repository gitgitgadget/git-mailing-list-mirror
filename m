Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27474C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9831610CC
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 15:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhGTPGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 11:06:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58807 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbhGTO47 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 10:56:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A12613881D;
        Tue, 20 Jul 2021 11:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xUexY4ENvrJueGMxLYmdPY2pVui5ZB5Iz1LTp+
        LSrPs=; b=gRkeIWAgy7TJhAuILsMf2GyyaExenjlUs3vahZ9OnnkkUPZx1SMpC7
        ZizuN9Tk8BzAJfckA1PMv/RP5cTkDbYKsntj/keUTwtejfmVa04ID35JWgXpiLP3
        soWqz25sjqamxoip3gINqbff4FK0T6WJOLeKPIqijr8+QFKXGPubk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 929AE13881B;
        Tue, 20 Jul 2021 11:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC8D913881A;
        Tue, 20 Jul 2021 11:36:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Andy Zhang <zhgdrx@gmail.com>, git@vger.kernel.org
Subject: Re: why "git rebase" searching the duplicate patches in <upstream
 branch> rather than in <new base branch>?
References: <CAJcwCMPU9EhRkqeei_LnYyTJRZUQgHCvomrBbW0Qn+Jp1yhQfQ@mail.gmail.com>
        <CAJcwCMPHFNHi5i=xRg=GAJL5HiUfKu_KUPwYwELofLLtOAK1bg@mail.gmail.com>
        <xmqqmtqij63t.fsf@gitster.g> <87a6mhgxv4.fsf@osv.gnss.ru>
Date:   Tue, 20 Jul 2021 08:36:33 -0700
In-Reply-To: <87a6mhgxv4.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        20 Jul 2021 12:04:15 +0300")
Message-ID: <xmqqczrdhu9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4476D316-E970-11EB-B536-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Similar problem should exist for explicitly specified <upstream> that
> might happen to have little in common with the current <branch>, right?

I do not think so.  Plain-vanilla rebase is to carry forward our
changes on top of updated upstream, which means that there is

            x--x--x (side)
           /
   ---o---o---o---o---o---o (upstream)
          ^
       (old upstream)

inherently ancestry relationship between the old upstream and the
current upstream when rebasing 'side' to 'upstream'.

> I don't actually like this.

You do not have to ;-) because I was not suggesting to change any
existing behaviour.  It was merely me thinking aloud, how I might
do the feature if I were designing it from scratch now.

> Overall, it seems that we should take the <newbase> rather than
> <upstream> (that is still <upstream> when --onto is not specified), and
> apply the skipping logic from there, to whatever depth the merge-base
> will give us. If it's already implemented this way, then only the manual
> page needs to be fixed.

Sounds sensible.  I didn't check what the actual code does ;-)
