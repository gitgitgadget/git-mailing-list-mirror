Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9088CC433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2F620678
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EkO20+x0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgHaRhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:37:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53152 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgHaRhc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 13:37:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC958F0BB3;
        Mon, 31 Aug 2020 13:37:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VS3my3ioxAtNuyJiLaUNMfz2Rzo=; b=EkO20+
        x0PkapK9xeRWiraQJaxJruzILLVbRGeXd3Etm/9y+2bRzx3+w5+JXyDD0CKpkpj7
        yxWk/CgKggRhfKBsfCGxJWnkDq2VZhoC5+YWDGZes/4BuSgeYAM4VRpXE4snLN4I
        Awk0RQ7mDJ1bKs5zd3QD+iEf+KybANQjjwmto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fSv0/W5QtuqKX80xlTBoRebgaPloZ24E
        C4Q1fDeQCb31vjEKOUrouD3VtqtuN0YndNfZ7MlI0+rvUUFXLifUxtC6dyClC12p
        pCnjCYJVqlhWepF2CU0uMx+XD4ipH67wvI+eHEqBJVD+c9ABs2YsyoSq+ZgyUZ8x
        fkKf5h+cw0c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A27AEF0BB2;
        Mon, 31 Aug 2020 13:37:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2D48F0BB0;
        Mon, 31 Aug 2020 13:37:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 2/2] wt-status: tolerate dangling marks
References: <xmqqo8mti8od.fsf@gitster.c.googlers.com>
        <20200831171732.1199755-1-jonathantanmy@google.com>
Date:   Mon, 31 Aug 2020 10:37:26 -0700
In-Reply-To: <20200831171732.1199755-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 31 Aug 2020 10:17:32 -0700")
Message-ID: <xmqqzh6ag1ih.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A38B0746-EBB0-11EA-95E0-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> For example, what is the reasoning behind making dwim_ref() unable
>> to ask the "do so gently" variant, while allowing repo_dwim_ref()
>> to?
>> 
>> I am NOT necessarily saying these two functions MUST be able to
>> access the same set of features and the only difference between them
>> MUST be kept to the current "repo_* variant can work on an arbitrary
>> repository, while the variant without repo_* would work on the
>> primary repository only".  As long as there is a good reason to make
>> their power diverge, it is OK---I just do not see why and I'd like
>> to know.
>
> Maybe add the following to the end of the last paragraph of the commit
> message:
>
>   (dwim_ref() is unchanged because I expect more and more code to use
>   repo_dwim_ref(), and to reduce the size of the diff.)

If that is the reasoning, I totally disagree.  We may be staring
problems in submodules too long to think everybody should use the
variant with repo_ prefix, but a single repository operations will
continue to exist, and when you know you only need to access the
current repository, not having to use the function with longer name
without having to pass an extra parameter is a plus.

I even wonder why dwim_ref() is not defined like so in a header:

	#define dwim_ref(s, l, o, r) \
		repo_dwim_ref(the_repository, (s), (l), (o), (r))

Which would force a change like the one we are discussing to keep
them in parallel and keep the promise that only difference between
the two is that dwim_ref() works with the_repository and the other
can take an arbitrary repository.  Perhaps that can be a preliminary
clean-up patch before these two patches ;-)

Doing so would mean that coders have to remember one fewer thing
than "dwim_ref(), not only cannot take a repository pointer, cannot
be told to report error gently".  The worst part is that we know
that the difference will GROW, because the purpose of adding the
extra option argument to the API is exactly to make it easy to do
so.

Reducing the size of the diff is a good justification only when the
end result is the same.  If it burdens future developers more, that
is "I write less at the expense of forcing others to write more",
which is not quite the same thing.

Thanks.
