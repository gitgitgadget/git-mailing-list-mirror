Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DE31FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 21:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764292AbdJQVDH (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 17:03:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65215 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753735AbdJQVDD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 17:03:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 156D7A0B7B;
        Tue, 17 Oct 2017 17:03:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nt2L6ZmsAUG7PWP0Az9YvJiNsV4=; b=v9zpT4
        VNxE/WF1nq0NWioWla9QSdK6qXzDSjLysuQQrDH4dcVW5gsbWxonI/RhFFoDxjvc
        g2VTVmdgqASiiJlQZvHa05aOmQaolx0ALdO21L9qjteG1yOKQzz9GMEWfpyP5+8C
        AfrFtzLv1mIEAw00bJFuFPiAddSQeyum18gxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vQWxeQkOf8pItcbAYzfx4WyG1q/kYj3r
        ng420ebIZ4UNs8mcbWdWIVE9ZRhO9gVK1dqyqoKm1fg79Cjoqwb0kJXOoHmkDu7o
        qzVdDP5J0t8pgW7t7z3f0hkHKnM0CPmQQYZMDJWTBGu6R90/eSg+mPNhG6j4T1pu
        Z9OEJsHcDfI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0149BA0B7A;
        Tue, 17 Oct 2017 17:03:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64FE1A0B79;
        Tue, 17 Oct 2017 17:03:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re* Is t5601 flaky for anybody else?
References: <xmqq376ipdpx.fsf@gitster.mtv.corp.google.com>
        <20171017171046.GA48544@google.com>
Date:   Wed, 18 Oct 2017 06:02:59 +0900
In-Reply-To: <20171017171046.GA48544@google.com> (Brandon Williams's message
        of "Tue, 17 Oct 2017 10:10:46 -0700")
Message-ID: <xmqqshehmqrg.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 902EAF9E-B37E-11E7-B154-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> I haven't noticed any issues myself but maybe this has something to do
> with my changes to this test in the 'bw/protocol-v1' topic?

As I've seen this on 'master', too, I suspect the topic has nothing
to do with it.

Here is what I have on 'pu'.


-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 17 Oct 2017 14:04:43 +0900
Subject: [PATCH] t5601: rm the target file of cp that could still be executing

"while sh t5601-clone.sh; do :; done" seems to fail sporadically at
around test #45 where fake-ssh wrapper is copied create plink.exe,
with an error message that says the "text is busy".

I have a mild suspicion that the root cause of the bug is that the
fake SSH process from the previous test is still running by the time
the next test wants to replace it with a new binary, but in the
meantime, removing the target that could still be executing before
copying something else over seems to work it around.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5601-clone.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9c56f771b6..50e40abb11 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -308,6 +308,7 @@ test_expect_success 'clone checking out a tag' '
 
 setup_ssh_wrapper () {
 	test_expect_success 'setup ssh wrapper' '
+		rm -f "$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
 			"$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper$X" &&
@@ -318,6 +319,7 @@ setup_ssh_wrapper () {
 }
 
 copy_ssh_wrapper_as () {
+	rm -f "${1%$X}$X" &&
 	cp "$TRASH_DIRECTORY/ssh-wrapper$X" "${1%$X}$X" &&
 	GIT_SSH="${1%$X}$X" &&
 	export GIT_SSH
-- 
2.15.0-rc1-178-ge1264d9eb8

