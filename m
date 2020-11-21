Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70234C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 20:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC3E22201
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 20:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KrCsCIAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgKUUSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 15:18:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54299 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUUSw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 15:18:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B66980B2B;
        Sat, 21 Nov 2020 15:18:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KbacnUL8VXXmXobJf2JLIBcOXR0=; b=KrCsCI
        AjsGn6glABzPr3dGSqOfsefTAreU92RGqpy6vvKRlgyLaUhyDIcp561erlWThz/m
        HRfor+Qj2UAFGneOMyAKuNkMWizuRHAV1V0yxjO8X0UNStZjstphK0CSH1jmU4Gk
        bQ4LWWWKbXQzFYBUOhXElF7WIya44P02rqUic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r38v1SMLU5sRqRZU6CnPSwVnj+H09Iy6
        RZJC6wMH302IC8bm4qRyY77tkde9VD+eAMtsgpSNTGB3Qt57/xzLi4Ktdmlm0Sca
        +VUp1MbBltz1MrzltU6H+qrN0DEDC969dB+Xiq4FiebnOnCuYs3Wi1nIcRD1Mysz
        dZq4wj0x4kY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6300880B2A;
        Sat, 21 Nov 2020 15:18:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E760180B29;
        Sat, 21 Nov 2020 15:18:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Stevens <patrick@patrickstevens.co.uk>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: git apply --cached --reject
References: <31599b45-cf4e-be77-22bb-8fa03f0a52d6@patrickstevens.co.uk>
Date:   Sat, 21 Nov 2020 12:18:47 -0800
In-Reply-To: <31599b45-cf4e-be77-22bb-8fa03f0a52d6@patrickstevens.co.uk>
        (Patrick Stevens's message of "Fri, 20 Nov 2020 14:21:38 +0000")
Message-ID: <xmqqlfeusbtk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3322572-2C36-11EB-A4D1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Stevens <patrick@patrickstevens.co.uk> writes:

> I don't think this behaviour is intended; in the report I give a couple
> of variations which correctly do what I expected, and this one breaks
> the semantics I expect, given the behaviour of those variations. I have
> not tried to find the source of the bug.

I do not think this is intended, either.  It certainly is not
something I would expect to see as an end user.  I somehow suspect
that when we added "--reject", we didn't even mean to make it work
with "--cached" in the first place.

A more plain-vanilla case like below, where an existing file sees a
two-hunk patch, but only one of the hunks apply cleanly,
demonstrates that the command, with an option to touch the index,
does not want to take any ...

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---

seq 1 10 >file && git add file && git commit -m "1 to 10"
seq 1 10 | sed -e '/1/s/$/+/' >file
git diff --stat -p >patch

seq 1 10 | sed -e '/9/s/$/+/' >file
git commit -m "9 plus" file

rm -f file.rej
git reset --hard
git apply --reject patch
# inspect the index and working tree to see what happened here
# this one, that does not touch the index, works as expected.

rm -f file.rej
git reset --hard
git apply --cached --reject patch
# inspect the index and working tree to see what happened here

rm -f file.rej
git reset --hard
git apply --index --reject patch
# inspect the index and working tree to see what happened here

--- 8< ------ 8< ------ 8< ------ 8< ------ 8< ------ 8< ---

... half-baked changes.  The above prepares a 10-line file and a
patch that touches its first and the last line.  It then makes a
modification that textually conflicts the second last line to the
target file, and tries to apply the patch.

We do get .rej file in all cases, but in the mode that would touch
the index, the command refuses to put the result of an incomplete
patch application to the index, even though it updates the working
tree files with partial application.

The log message of 8938045a (git-apply --reject: finishing touches.,
2006-08-27) does mention that with "--index", it is the designed
behaviour to update the index for paths to which the patches were
cleanly applied, with a reasonable justification.  Even though it
also implies at the same time that it is also the designed behaviour
to leave the index untouched for paths that got .rej files, I do not
offhand see it explains the reason behind the design very well.  I
suspect that it was to avoid committing a half-resolved state by
mistake, but then it does not prevent the user from committing a
no-modification by mistake, and that is why I say "not ... very well"
here.  In any case, it does not even mention what ought to happen in
the "--cached" case, so...

