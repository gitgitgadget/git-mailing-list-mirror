Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA12AC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E19603E8
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhJUWg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:36:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57563 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUWg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:36:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16EAAED75B;
        Thu, 21 Oct 2021 18:34:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=4o7Yq+M2v7rdyeknrS/dwy69H
        MIet06eJeNmwGcqC6Q=; b=DETPYNphtCx+nVWr1AC+0bLT3Z4B0ySnAEDnONef7
        UUUjRf+dvg9SWXP4IYym/kWzMyTAAPuXtarThcDQol1si+vTJ3Rei9GFXmMFI14a
        DMyAQ3epEAG1+YTVdbQPEusvqAE9caPK0lCMOg8gx2muxzExYYkTzthVL72HmVYJ
        SA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C4FCED758;
        Thu, 21 Oct 2021 18:34:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73A24ED751;
        Thu, 21 Oct 2021 18:34:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     git@vger.kernel.org
Subject: Re: git format-patch --signoff
References: <YXHaAu2G51vy5H8z@qmqm.qmqm.pl>
Date:   Thu, 21 Oct 2021 15:34:39 -0700
Message-ID: <xmqqo87ihurk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 14734CD8-32BF-11EC-B22D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> writes:

> I just noticed that `git format-patch --signoff` adds the 'Signed-off-b=
y'
> line even if the exact same line is already present in the commit messa=
ge.
> Could this be avoided in the tool?
>
> git version 2.30.2
>
> Best Regards
> Micha=C5=82 Miros=C5=82aw

The rule should be "avoid adding the same sign-off as the one at the
end".  In other words, as a record of the flow of patch custody,

    Signed-off-by: original author
    Signed-off-by: contributing editor
    Signed-off-by: original author

is perfectly reasonable for a patch originally authored, tweaked by
an editor and sent back to the author, and further improved by the
original author, while

    Signed-off-by: original author
    Signed-off-by: contributing editor
    Signed-off-by: contributing editor

sent back to the original author by the editor would not be sane, as
there is no need to repeat the same s-o-b to signal whatever it
might imply (e.g.  the editor edited the patch twice before sending
it back).

The test in t4014

  https://github.com/git/git/blob/master/t/t4014-format-patch.sh#L1561

    test_expect_success 'signoff: the same signoff at the end' '
            append_signoff <<-\EOF >actual &&
            subject

            body

            Signed-off-by: C O Mitter <committer@example.com>
            EOF
            cat >expect <<-\EOF &&
            4:Subject: [PATCH] subject
            8:
            10:
            11:Signed-off-by: C O Mitter <committer@example.com>
            EOF
            test_cmp expect actual
    '

It creates a commit with an existing S-o-b by the same person as the
one running the "format-patch --signoff" command (the append-signoff
test helper used there (1) creates a commit with the log message fed
from the standard input, (2) runs format-patch --signoff to show the
commit and emits the Subject and S-o-b lines in it.  As we can see,
we expect that the existing signoff is not followed by another copy
of the same signoff.=20

This test hasn't changed since it was written in Feb 2013, and I
think 2.30.2 is recent enough to conform to the rule to pass this
test.

