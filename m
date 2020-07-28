Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39088C433EA
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 01:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8E220714
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 01:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WsAZaZK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgG1BTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:19:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54980 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG1BTl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 21:19:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 934237B33B;
        Mon, 27 Jul 2020 21:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=94AUT6GZF2RTPAsEvLh03+NIxkg=; b=WsAZaZ
        K8BMNgbzopMo0Ta8bA+lT+7fb3onV/1Rq44Lz/n7RL5RwTfdgrPUXBRneXoMfmq1
        j2dAmgzeHrhaZk0lGwW+aS7IUeOZK3SV8YoSKVghMaStcJYHHajq2B05xmvxbE0X
        n4C+VxnulwS3Y8FubGVQWzO2yh4eIhFMvHOyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TUu0LhaTN9Y+JDkQkILJDd3YDZHJWL4J
        YtCdq/Q1CK4+Qn5JAznY9vyIe/xbko7BWb51B2rvffW1hWl4UsJSdeRY4vakKzRV
        mbHYPvJqcHasfNgvH+RndqJi7d/ZZ+SERnp9V1AfnqVcdxlnUr+7Liu1kchmzSwO
        zeURTN1lEQY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78FE97B33A;
        Mon, 27 Jul 2020 21:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE88D7B338;
        Mon, 27 Jul 2020 21:19:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: do not fetch when checking object existence
References: <20200728010403.95142-1-jonathantanmy@google.com>
Date:   Mon, 27 Jul 2020 18:19:38 -0700
In-Reply-To: <20200728010403.95142-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 27 Jul 2020 18:04:03 -0700")
Message-ID: <xmqqwo2oe8r9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 681DA78C-D070-11EA-BF8F-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> There have been a few bugs wherein Git fetches missing objects whenever
> the existence of an object is checked, even though it does not need to
> perform such a fetch. To resolve these bugs, we could look at all the
> places that has_object_file() (or a similar function) is used. As a
> first step, introduce a new function has_object() that checks for the
> existence of an object, with a default behavior of not fetching if the
> object is missing and the repository is a partial clone. As we verify
> each has_object_file() (or similar) usage, we can replace it with
> has_object(), and we will know that we are done when we can delete
> has_object_file() (and the other similar functions).

I wonder if we want to name the two (i.e. one variant that refuses
to go to network because it is trying to see if a lazy fetch is
needed, and the other that goes to network behind caller's back for
ease of use in a lazy clone) a bit more distinctly so that which one
could potentially go outside.

Depending on one's view which one is _normal_ access pattern, giving
an explicit adverb to one variant while leaving the other one bland
might be sufficient.  For example, I _think_ most of the places do
not want to handle the details of lazily fetching themselves, and I
suspect that the traditional has_object_file() semantics without "do
not trigger lazy fetch" option would be the normal access pattern.

In which case, renaming your new "has_object" to something like
"has_object_locally()" would be a good name for a special case
codepath that wants to care---if the object does not exist locally
and needs to be obtained lazily from elsewhere, the function would
say "no".

And all the other names like has_object_file() that by default gives
callers a transparent access to lazily fetched objects can stay the
same.

> I mentioned the idea for this change here:
> https://lore.kernel.org/git/20200721225020.1352772-1-jonathantanmy@google.com/

Yup, I think that is going in a good direction.  I suspect that
apply will not be the only remaining case we need to "fix", and
using the new helper function, codepaths that have already been
"fixed" by passing "do not lazily fetch" option to the traditional
API functions would become easier to read.  And if that is the case,
let's have the introduction of the helper function as a separate
patch, with each of [PATCH 2-N/N] be a fix for separate codepaths.

Thanks.
