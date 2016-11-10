Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9914A2035F
	for <e@80x24.org>; Thu, 10 Nov 2016 08:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbcKJIbV (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 03:31:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:52421 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752287AbcKJIbU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 03:31:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 27F77ACDB;
        Thu, 10 Nov 2016 08:31:19 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: [PATCH v2] t6026-merge-attr: don't fail if sleep exits early
References: <mvmtwbhdhvb.fsf@hawking.suse.de>
        <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611091437280.72596@virtualbox>
        <mvmzil8btzb.fsf@hawking.suse.de>
        <20161109153128.aqm2lgdntdlycnaq@sigill.intra.peff.net>
X-Yow:  My ELBOW is a remote FRENCH OUTPOST!!
Date:   Thu, 10 Nov 2016 09:31:18 +0100
In-Reply-To: <20161109153128.aqm2lgdntdlycnaq@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 9 Nov 2016 10:31:28 -0500")
Message-ID: <mvm8tsrbusp.fsf_-_@hawking.suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 5babb5bdb3 ("t6026-merge-attr: clean up background process at end
of test case") added a kill command to clean up after the test, but this
can fail if the sleep command exits before the cleanup is executed.
Ignore the error from the kill command.

Explicitly check for the existence of the pid file to test that the merge
driver was actually called.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 t/t6026-merge-attr.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 7a6e33e673..03d13d00b5 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -187,13 +187,14 @@ test_expect_success 'custom merge does not lock index' '
 		sleep 1 &
 		echo $! >sleep.pid
 	EOF
-	test_when_finished "kill \$(cat sleep.pid)" &&
+	test_when_finished "kill \$(cat sleep.pid) || :" &&
 
 	test_write_lines >.gitattributes \
 		"* merge=ours" "text merge=sleep-one-second" &&
 	test_config merge.ours.driver true &&
 	test_config merge.sleep-one-second.driver ./sleep-one-second.sh &&
-	git merge master
+	git merge master &&
+	test -f sleep.pid
 '
 
 test_done
-- 
2.10.2


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
