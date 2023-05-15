Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58CDC77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 21:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245231AbjEOVuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 17:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjEOVui (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 17:50:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969DDE720
        for <git@vger.kernel.org>; Mon, 15 May 2023 14:50:37 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FC02196435;
        Mon, 15 May 2023 17:50:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bX/NvZoGG/So
        srw6E3AGQRQoTqxxHukiwI3wK0K9kqE=; b=E76xotEd9yEXdqLBq3h6n+5qBHbY
        uTYcc2eLTVl1dxArQCddcyVT3xNi1rHEThh2e2feIlicooXtmj+9WFrkbrlht4pD
        ShQDE8jl4mh2MG0aAqvLa8VnTP/kLw9Dsrg4w0BeqN92yTGd1WkdPkOz3J2j+ijA
        0E67tOmj1N/yz4I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5701B196434;
        Mon, 15 May 2023 17:50:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDACE196432;
        Mon, 15 May 2023 17:50:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] tag: keep the message file in case ref
 transaction fails
References: <cover.1684067644.git.code@khaugsbakk.name>
        <cover.1684181855.git.code@khaugsbakk.name>
Date:   Mon, 15 May 2023 14:50:32 -0700
In-Reply-To: <cover.1684181855.git.code@khaugsbakk.name> (Kristoffer
        Haugsbakk's message of "Mon, 15 May 2023 22:29:32 +0200")
Message-ID: <xmqq7ct98dsn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 84C4078A-F36A-11ED-950C-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

>      +	GIT_EDITOR=3D./fakeeditor git tag -a foo &&
>     -+	! test -e .git/TAG_EDITMSG
>     ++	! test_path_exists .git/TAG_EDITMSG

This is not quite right.  test_path_exists is loud when its
expectation that the path _exists_ is not met, i.e.

        test_path_exists () {
                test "$#" -ne 1 && BUG "1 param"
                if ! test -e "$1"
                then
                        echo "Path $1 doesn't exist"
                        false
                fi
        }

But this test expects that .git/TAG_EDITMSG to be missing.  When the
test is run with "-v" to make the output from this 'echo' visible,
we will keep getting the complaint when the test is happy, which is
not quite what we want.

What you want to use is test_path_is_missing, without "!".

>       ## Notes (series) ##
>     -    I tried to maintain the proper formatting by using `clang-form=
at` via Emacs on
>     -    the affected lines.
>     +    I duplicated this message (this isn=E2=80=99t obvious in the d=
iff):
>     +
>     +        fprintf(stderr,
>     +                _("The tag message has been left in %s\n"),
>     +                path);
>     +
>     +    Should this be factored into a static function instead?

When the third copy is made, we would definitely insist avoiding
copies, but until then, I am indifferent.  Others may have different
opinions, though.

