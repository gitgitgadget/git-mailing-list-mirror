Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10462ECAAA1
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 18:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIQSEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIQSEO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 14:04:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423262B250
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 11:04:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92E521C129E;
        Sat, 17 Sep 2022 14:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FT2DieJ+0rWqXzpPK5Y0BupUFBnFwpant8t/gs
        bIZks=; b=SeW2T7lHtmOYCBgCSg91m2igh/iVKw0Xbnuyq5Zqbu0GDPahP+Hem1
        RZdnCjPOIdvAjaZSUx0WmhRvrESD9qz7HJOpdnv+fBDZyAAC9Pvsy77G1zEd5DYB
        FcSxL3RIgZUKlVvzdpZ5uX3gvn7Jcgeqc0IGysqaHpPL+gphDDIXs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BC0B1C129D;
        Sat, 17 Sep 2022 14:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 369B61C129A;
        Sat, 17 Sep 2022 14:04:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] fixup commit is dropped during rebase if subject = branch
 name
References: <CA+JQ7M_Xwxa48ggu88rhA9dG6R3u820Tgu8B2Kg-uMbEVjy3Vg@mail.gmail.com>
Date:   Sat, 17 Sep 2022 11:04:07 -0700
In-Reply-To: <CA+JQ7M_Xwxa48ggu88rhA9dG6R3u820Tgu8B2Kg-uMbEVjy3Vg@mail.gmail.com>
        (Erik Cervin Edin's message of "Sat, 17 Sep 2022 16:45:17 +0200")
Message-ID: <xmqqpmftev3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20017860-36B3-11ED-AA8E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin <erik@cervined.in> writes:

>   git init --initial-branch=main
>   git commit -m init --allow-empty
>   git tag init

Thanks for a report.  Let me quickly respond with an initial
reaction without being in front of a real computer to run tests on
myself.  Others may give more useful feedback.

>   # failure
>   seq 1 3 >> bar && git add bar && git commit -m main
>   git tag -f x
>   seq 4 6 >> bar && git add bar && git commit -m bar
>   seq 7 9 >> bar && git add bar && git commit --fixup :/main
>   git -c sequence.editor=: rebase --autosquash --interactive x
>   git diff ORIG_HEAD

So near the bottom there are "init", and "x".  The commit title of
"x" is "main" and that is what the fix-up intends to amend.

But then I do not think there is any valid expectation if you say
"keep x intact and rebase everything above", which is what the
command line arguments tell the last command to do.  Perhaps we
should keep all original commits up to that "fixup" one without any
reordering or squashing?

The title of your bug report is also curious.  What happens if you
did

    git branch -m master

just before running the "rebase" command in the above sequence?  I
would have expected to see that in your "expected" section to
contrast the behaviour between "if subject = branch" vs "if subject
!= branch", and the report looks a bit puzzling.

THanks.
