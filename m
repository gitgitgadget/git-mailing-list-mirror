Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5C4C433DF
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 22:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7605020656
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 22:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sbTMsr+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGOWzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:55:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59762 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgGOWzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 18:55:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6703DE030A;
        Wed, 15 Jul 2020 18:55:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j/mSFL8E73LcNSuRcd+twPmPmso=; b=sbTMsr
        +31lJjG1vNknKlPVDkUEwkLPPgZP3TccqcP95CuV7ENuotBk1tNmtX8MdMMoPWkm
        MWSyBDOvtd/cnBUOXiLMVRXzXOvKNogFKUcVOI51Jy7ASjzhDzbERXFtym0JT+n7
        jKA0PpIFokumyGDvJcLE4cdPT9wB5efprh+Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aBsKuxXijCacl6Tm/Q2xxoqLIo4wCvau
        3cbYxlKif/cBW07NHdXZfWgDT/OYBfkbhAasRZ+BMs4+BrSTyD+wzO77/tH4c6Xk
        pEUDOCBws/SdWUcsRgg9zi6nKF/qCeB+AyUZk5j3SkmcrF847RVZPQAviGBaYsjI
        AOsEqxcDBFw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DF24E0309;
        Wed, 15 Jul 2020 18:55:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A792E0306;
        Wed, 15 Jul 2020 18:55:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] upload-pack: do not lazy-fetch "have" objects
References: <20200715223112.2018556-1-jonathantanmy@google.com>
Date:   Wed, 15 Jul 2020 15:55:18 -0700
In-Reply-To: <20200715223112.2018556-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 15 Jul 2020 15:31:12 -0700")
Message-ID: <xmqqpn8wie21.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42586130-C6EE-11EA-B886-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When upload-pack receives a request containing "have" hashes, it (among
> other things) checks if the served repository has the corresponding
> objects. However, it does not do so with the
> OBJECT_INFO_SKIP_FETCH_OBJECT flag, so if serving a partial clone, a
> lazy fetch will be triggered first.

OK.  

Fixing issues hit by real users reactively is a necessary and good
thing, but this is not the first time we patch callers of
has_object_file() for this kind of "we are merely trying to
determine the boundary of what we have, so that we know what we need
to add to this repository" queries, I am afraid.

Perhaps it is a good idea to sweep all the hits from "git grep -e
has_object_file \*.c" and audit the codebase to see if there are
other problematic ones?

For example, list-objects.c::process_blob() tries to if the object
exists when --exclude-promisor-objects is in effect so that it can
return early if the object is missing and it is a promisor object.
I would imagine that we would not want to lazy-fetch the object in
this case.

Thanks.  Will queue.

