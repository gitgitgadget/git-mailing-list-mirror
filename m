Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A311F6BA
	for <e@80x24.org>; Thu, 23 Mar 2017 02:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbdCWCMO (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 22:12:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58585 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751333AbdCWCMM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 22:12:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AD48829AF;
        Wed, 22 Mar 2017 22:12:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TyBB8KXgztZCPV3kPmQZ5V/iOOw=; b=Q01BNB
        pWS406TgWT1azDvA5P+vJHR3HjFDLFaaUtGj8x41+9AgSoj39lWnxIncEAH6ox0d
        tUP1h3iBXN/aneuWlnhDOJP4xaMBqE05zRCmgkI4KF1iO/sbeFcx7qwmTZYktH1a
        Emg5owpzZrNrAtXGGx1qyGCoMQMvyAGpRpYdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AsEiFpUQJTum92BuKBhuU6d7ta2pDL2O
        lTL2hs6al2jZBjJyh1IAvFJvvn4RRrPCMvBxw23uwXQNVZDr2rF0qCBwJBytwkN9
        d5eA/ysA10Ln2Huah2p0LnK6I6p+6jcrjr5qdWuQodr96Rr/z/tSnCke8W8N4XrR
        zttaJ6JqPEw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63BDA829AE;
        Wed, 22 Mar 2017 22:12:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C73E4829AD;
        Wed, 22 Mar 2017 22:12:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] tests: lint for run-away here-doc
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
        <20170322200805.23837-1-gitster@pobox.com>
Date:   Wed, 22 Mar 2017 19:12:08 -0700
In-Reply-To: <20170322200805.23837-1-gitster@pobox.com> (Junio C. Hamano's
        message of "Wed, 22 Mar 2017 13:08:02 -0700")
Message-ID: <xmqq7f3ghhc7.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EF50C4C-0F6E-11E7-91AD-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We found a few run-away here documents that are started with an
end-of-here-doc marker that is incorrectly spelled, e.g.

	git some command >actual &&
	cat <<EOF >expect
	...
	EOF &&
	test_cmp expect actual

which ends up slurping the entire remainder of the script as if it
were the data.  Often the command that gets misused like this exits
without failure (e.g. "cat" in the above example), which makes the
command appear to work, without eve executing the remainder of the
test.

Use a trick similar to the one used to catch the &&-chain breakage
to detect this case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This catches all the cases detected in the recent discussion, I think.

 t/test-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 86d77c16dd..97bdc91f54 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -627,6 +627,10 @@ test_run_ () {
 		test_eval_ "(exit 117) && $1"
 		if test "$?" != 117; then
 			error "bug in the test script: broken &&-chain: $1"
+		elif ! OK=$(test_eval_ "false && $1${LF}${LF}echo OK" 2>/dev/null) ||
+		   test OK != "$OK"
+		then
+			error "bug in the test script: possibly unterminated HERE-DOC"
 		fi
 		trace=$trace_tmp
 	fi
