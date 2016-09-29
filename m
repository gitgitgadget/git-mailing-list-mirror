Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B2C20987
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934251AbcI2VAd (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54613 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934231AbcI2VAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2605429A1;
        Thu, 29 Sep 2016 17:00:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=t0pT
        4v2XFHB8zvznXz4A8GhPObI=; b=nj36RQSnG8eo3+Oa8xECHDBo1uZ9hBt1eKXU
        EqubxLDBmQ1LxK+BP0e6b24Q9gmfw7XZd2pHfd2SMr+DX8FWXD5+LuVij9kjZ5KZ
        wALch+aTIbnaoz93Z0Ky7Sk8DrAt3769wF7cVG9rsxhjbA9thm9bhMVAZOIuFF2V
        vuPSgPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=sv90RQ
        riXbipFiZcW0Fh9/5IgTz78Y0Gps6y6j8qUAZNVEmKvWZfQSX+s5ew3bR8yCilo1
        P+G27rvhVmZzvw0i9jpiv8TO3YmpMngXX+n5R5LjR96LW49h3Y/kh2X5p8ZbtIGf
        ZRDr14KEl7wAQp9r8S56IG1vV0GtYa5XnqW8U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C29AE429A0;
        Thu, 29 Sep 2016 17:00:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 513B54299E;
        Thu, 29 Sep 2016 17:00:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 6/9] t1300: take contents of system-wide configuration into account in "--list" test
Date:   Thu, 29 Sep 2016 14:00:11 -0700
Message-Id: <20160929210014.3874-7-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-589-g5adf4e1
In-Reply-To: <20160929210014.3874-1-gitster@pobox.com>
References: <20160929210014.3874-1-gitster@pobox.com>
X-Pobox-Relay-ID: C152240E-8687-11E6-B5F5-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the "git config" test tries to see that the command run
without a valid repository still shows non-repository specific
configuration.  As we are planning to later make the system-wide
file non-empty, prepare for the change by expecting to see the
contents from it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1300-repo-config.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 95734034e0d5..2a15cd4d150d 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -344,10 +344,11 @@ test_expect_success 'working --list' '
 	git config --list > output &&
 	test_cmp expect output
 '
-cat > expect << EOF
-EOF
 
-test_expect_success '--list without repo produces empty output' '
+test_expect_success '--list without repo shows only system-wide and global' '
+	# The global one aka $HOME/.gitconfig is missing,
+	# so we do not have to worry about it.
+	git config --system --list >expect &&
 	git --git-dir=nonexistent config --list >output &&
 	test_cmp expect output
 '
-- 
2.10.0-589-g5adf4e1

