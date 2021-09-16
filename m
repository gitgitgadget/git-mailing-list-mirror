Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6A2C433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8602C61056
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbhIPPew (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 11:34:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63534 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbhIPPem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 11:34:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 899F8157AA3;
        Thu, 16 Sep 2021 11:33:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c7dvYDKE/na+WP4MTcLurghsbBZunOwLc3wGiH
        Gtq4Y=; b=Yb925FMS/rHmpMU73Z8sQSoEFvHOY+aQgnVJkn87ZW/UBXxbP6ZiTN
        HyaYDl7cQ0p0MVERGeBlXy1BCR6BbFwgf8EmLdctxYBMMvfevbrxRZDGLs2jdAef
        k/jpIsnsfEKRltmv3uGBIE0v74kCrDX0AzrvpYlmSBNtapmDXqioQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 800D9157AA2;
        Thu, 16 Sep 2021 11:33:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 675C9157AA0;
        Thu, 16 Sep 2021 11:33:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     wesley@schwengle.net
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: Possible git bug
References: <c7949156-a7e5-085f-4779-82d0538a4d72@schwengle.net>
        <20210916124709.2824551-1-wesley@schwengle.net>
Date:   Thu, 16 Sep 2021 08:33:15 -0700
In-Reply-To: <20210916124709.2824551-1-wesley@schwengle.net>
        (wesley@schwengle.net's message of "Thu, 16 Sep 2021 08:47:08 -0400")
Message-ID: <xmqqzgsctu10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A1F3B60-1703-11EC-A645-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

wesley@schwengle.net writes:

> On 9/16/21 8:07 AM, Wesley Schwengle wrote:
>  
>> New question, is there a way to tell rebase to NOT use fork-point via 
>> git-config in this situation?
>
> I seem to have found the answer in the source code: rebase.forkpoint exists.
>
> Would you accept the following patch that adds the following text to the
> documentation?

Not so fast.

Earlier you said:

> ... When you have an upstream configured and you don't specify
> it on the command line, --fork-point is used, while if you specify the 
> upstream --no-fork-point is used. `git rebase master --fork-point'
> exhibits the same as I was seeing. Although I'm now completely
> confused by this behavior. It doesn't make sense to me.
>
> This happens:
>
> We are on a branch, we merge it into another branch.
> We undo the merge because reasons.
> Now we git rebase, without the upstream, because we've set it.
> Fork-point is used now, because we haven't specified an upstream, but
> we did set it and git merge-base decides, oh, we had those commits in 
> master but these where dropped so we drop them in this branch as well.

If you feel "It doesn't make sense to me", either

 - the behaviour does not make sense because it is simply buggy, in
   which case, adding a sentence to the documentation and explaining
   how not to use it is missing the point---don't you rather want it
   to behave in a way that makes sense to you instead?

or

 - it appears as nonsense to you only because your understanding of
   the behaviour is faulty but the feature is working correctly and
   is not a bug, in which case, adding a sentence to the
   documentation and explaining how not to use it is missing the
   point---don't you rather want the existing documentation extended
   to help you and other users to understand the behaviour better
   first?

Between "buggy behaviour" and "bad documentation of a well-designed
behaviour", I offhand do not know which side "--fork-point" is for
this particular case, but I've always felt that it is a bad
heuristic that should be used with care, and my gut feeling is it
might be the third possibility: "bad heuristic that sometimes
misbehave badly and that is unfixable".  If that is the case,
perhaps the documentation should tell readers the unreliable nature
of the option and warn them to double check the result before
teaching them how to turn it off permanently.

Thanks.


