Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A97820988
	for <e@80x24.org>; Fri, 14 Oct 2016 22:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbcJNWiq (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 18:38:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65236 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750929AbcJNWip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 18:38:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05DDD46FC3;
        Fri, 14 Oct 2016 18:38:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=2
        OzvhkpN+tHsWe24W0oTFrcjYF8=; b=p2zN6qj0c/bsv5mrMQuxpfNgeKtZL/M3C
        OhBti8mmrVNZlHrVvYUisFNtsa+M1eNFZNYUdllwHQIadmrf8pU9gPmDkEh1HpaS
        feQajFI7IG9IJHejGAGXxbDwJX4z+55oOm1+F0ABAylMSnJjE2GfHU9bt+W7DbPp
        GrDTp37KOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=UKx
        cwpyV4ukjSPfoYVKJE/ABXojQvLyd58Mqo0DPn5QH9ZF9NydKCcVyNk2p5jGcGE1
        eOpBg7XzrjaKCCzR+7gZHnTuYj6PBT+gZX1HFFOnxD5FaU5Ki/jdA4ctNV4QsRj4
        GocFcMyk3EdNTgDtXwjM35tfnSDLgg0vIbhruELA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF0EC46FC1;
        Fri, 14 Oct 2016 18:38:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F8F846FC0;
        Fri, 14 Oct 2016 18:38:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [RFC] test-lib: detect common misuse of test_expect_failure
Date:   Fri, 14 Oct 2016 15:38:41 -0700
Message-ID: <xmqqk2day2ry.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F60DAD16-925E-11E6-8969-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is a very easy mistake to make to say test_expect_failure when
making sure a step in the test fails, which must be spelled
"test_must_fail".  By introducing a toggle $test_in_progress that is
turned on at the beginning of test_start_() and off at the end of
test_finish_() helper, we can detect this fairly easily.

Strictly speaking, writing "test_expect_success" inside another
test_expect_success (or inside test_expect_failure for that matter)
can be detected with the same mechanism if we really wanted to, but
that is a lot less likely confusion, so let's not bother.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It is somewhat embarrassing to admit that I had to stare at the
   offending code for more than 5 minutes to notice what went wrong
   to come up with <xmqqr37iy5bw.fsf@gitster.mtv.corp.google.com>;
   if we had something like this, it would have helped.

 t/test-lib-functions.sh | 4 ++++
 t/test-lib.sh           | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fdaeb3a96b..fc8c10a061 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -381,6 +381,10 @@ test_verify_prereq () {
 }
 
 test_expect_failure () {
+	if test "$test_in_progress" = 1
+	then
+		error "bug in the test script: did you mean test_must_fail instead of test_expect_failure?"
+	fi
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11562bde10..4c360216e5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -344,6 +344,7 @@ test_count=0
 test_fixed=0
 test_broken=0
 test_success=0
+test_in_progress=0
 
 test_external_has_tap=0
 
@@ -625,6 +626,7 @@ test_run_ () {
 }
 
 test_start_ () {
+	test_in_progress=1
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
@@ -634,6 +636,7 @@ test_finish_ () {
 	echo >&3 ""
 	maybe_teardown_valgrind
 	maybe_teardown_verbose
+	test_in_progress=0
 }
 
 test_skip () {
