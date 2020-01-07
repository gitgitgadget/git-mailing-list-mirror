Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEB5C33CA1
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5200C24672
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qnLL2qOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgAGQyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:54:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58136 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgAGQyg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 11:54:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 075612BE96;
        Tue,  7 Jan 2020 11:54:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZlDWjTAh9DZsm8D9xgEXuI/WPFA=; b=qnLL2q
        OSt66ZdgKcKfV4EaxdLY800NWsyLhgnGZFYP4rMWbfcOrl04kq/X4PRS9b0k8joa
        b/6ClK/S2Adhp1Dfrg0JKrXr3FGFefHr6+KyffdaVAkMeZXLWEPyL5j0jya7d/6q
        CeXxM56qQbdhfx4P3/7YUbtWlzsEXQnEwG08o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RxtvglXxBEw+/aBKkz+JG7g2lyoZVDfC
        5hKf2IYgNucmLA2raGH6py31LJeN5qrxaEMfKQTGqtaEx+BhiNigKJW2sXyzF8qs
        mJnKCNXNIHtpMFJJ60Wjm2X41WGMF9piJJYIoBkeyZBU68X3Kw0hlkKydZJ4z4m1
        Jh9pDKZaZm4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F26A42BE95;
        Tue,  7 Jan 2020 11:54:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E01D2BE92;
        Tue,  7 Jan 2020 11:54:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] refactor gpg-interface and add gpg verification for clones
References: <20200105135616.19102-1-hji@dyntopia.com>
        <xmqq36ctbis8.fsf@gitster-ct.c.googlers.com>
        <87lfqjnc5o.hji@dyntopia.com>
Date:   Tue, 07 Jan 2020 08:54:33 -0800
In-Reply-To: <87lfqjnc5o.hji@dyntopia.com> (Hans Jerry Illikainen's message of
        "Tue, 07 Jan 2020 04:06:11 +0000")
Message-ID: <xmqq4kx76wc6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61BAAB84-316E-11EA-9148-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

>> It almost makes me suspect that what you are trying to do with the
>> "verification upon cloning" may be much better done as a "verify the
>> tree for trustworthyness before checking it out to the working tree"
>> mechanism, where the trustworthyness of a tree-ish object may be
>> defined (and possibly made customizable by the policy of the project
>> the user is working on) like so:
>>
>>  - A tree is trustworthy if it is the tree of a trustworthy commit.
>>
>>  - A commit is trustworthy if
>>
>>    . it carries a trusted signature, or
>>    . it is pointed by a tag that carries a trusted signature, or
>>    . it is reachable from a trustworthy commit.
>>
>> Now, it is prohibitively expensive to compute the trusttworthiness
>> of a tree, defined like the above, when checking it out, UNLESS you
>> force each and every commit to carry a trusted signature, which is
>> not necessarily practical in the real world.
>
> Even though you mention that it's computationally expensive, I kind of
> like this approach.  It seems generalized enough that it doesn't need to
> be tied to a single operation like 'clone'.

Well, I don't ;-)  But even if you are not signing each and every
commit, it may be possible that the reachability information kept in
the commit-graph may help reduce the cost of the computation.  We'd
probably need a way to memoise which tags and commits have already
been verified earlier for trustworthiness for the scheme to work.

> Wouldn't that still forgo signature verification when doing something
> like:
>
>     $ git fetch
>     $ git checkout -b foo origin/branch-with-previously-unseen-commits
>
> unless either fetch or checkout is equipped with signature verification?

Yes, but I was assuming that "fetch", as an underlying mechanism for
"pull" would be what you'd teach the verification.

> Also, in case of a revoked key, this approach would require that tags
> signed with that key be deleted on origin.  

I am not sure if I follow.  An object that was signed back when a
key was OK and then the key gets revoked later---what should happen
to the trustworthiness of that object?  Another object that was
obtained from elsewhere was verified to be trustworthy, but later we
found out that the key we thought was trusted was already revoked---
what should happen to the trustworthiness of that object?

In either case, I think it is an unrelated matter if the tag object
should be removed either here or at the origin.  When spread *now*,
the key that was used to sign that tag object is known to have been
revoked, so while it is of no use to convey trustworthiness, if the
upstream project chooses to keep the tag (perhaps while re-issuing
a new version of the tag that points at the same object but signed
with a different key), that is perfectly fine, I would say.

> Maybe that's to be
> considered best practice anyway, but distro maintainers might not
> appreciate disappearing release tags.

I think that is best left as a policy decision for each project, and
we are not in the business of removing objects---we just should give
them tools to determine what key was used to sign an object, GPG or
whatever signing and key management infrastructure the projects
chooses to use gives them tools to decide if the key is what the
project trusts, and we give them tools to remove tags the project
finds unwanted.  Combining the tools according to the policy decision
the project makes is outside the scope of what we do here.
