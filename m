Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E280E8FDBC
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 21:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjJCV5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjJCV5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 17:57:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C1A1
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 14:57:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD1DF1B908C;
        Tue,  3 Oct 2023 17:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=HWxtn+SYkeBbWp3RyMgI1Vfmmnq23AYCUaaLW6
        vnFuY=; b=OBthQ3qrsfagIVVZnMNAfUTE3cQIsLLmHr3oV9+JI9OSpWlYzeQEoc
        MB0Po8gfddgty5TrM3vKOnq4Wmmwht6S0kfveRFv4/sRbqLgXswua7tb310mikQZ
        0mQBvsO0PvmPNqHAqsUaf3k1ZdjYywLkLk2/ZSl3mD5pnnMBGDjLw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C538C1B908B;
        Tue,  3 Oct 2023 17:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E6261B908A;
        Tue,  3 Oct 2023 17:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make sure TEST_DIRECTORY has no trailing slash
In-Reply-To: <xmqqwmw3wgeo.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        03 Oct 2023 14:21:51 -0700")
References: <20231003082323.3002663-1-stepnem@smrk.net>
        <xmqqwmw3wgeo.fsf@gitster.g>
Date:   Tue, 03 Oct 2023 14:57:39 -0700
Message-ID: <xmqqjzs3wer0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF2D7D28-6237-11EE-AB3D-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if this would be a safer alternative, or is it doing too
> much more than what is necessary?

An alternative with much smaller blast radius would be to do this.

Hopefully, by going "$(pwd)/." before asking the value returned by
the `pwd` command, we can make sure that the trailing slash is
removed (or at least $(pwd) and $TEST_DIRECTORY should be identical
after this is done).



 t/test-lib.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git c/t/test-lib.sh w/t/test-lib.sh
index 1656c9eed0..d159358b21 100644
--- c/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -19,9 +19,13 @@
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"
 then
-	# ensure that TEST_DIRECTORY is an absolute path so that it
+	# Ensure that TEST_DIRECTORY is an absolute path so that it
 	# is valid even if the current working directory is changed
-	TEST_DIRECTORY=$(pwd)
+	# Some environments can talk the shell into keeping trailing
+	# slash in $PWD---go there and ask where we are to work it
+	# around, as we expect TEST_DIRECTORY and PWD are both
+	# canonical and can textually be compared for equality
+	TEST_DIRECTORY=$(cd "$(pwd)/." && pwd)
 else
 	# The TEST_DIRECTORY will always be the path to the "t"
 	# directory in the git.git checkout. This is overridden by
