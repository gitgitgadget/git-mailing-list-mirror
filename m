Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA5EC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 00:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B66122CAF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 00:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kCr5N0D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHFARH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:17:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41356 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbgHFARA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Aug 2020 20:17:00 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 177BB60799;
        Thu,  6 Aug 2020 00:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596673017;
        bh=JZHCMU8v4sQbpU2AoyP9vZkPmgsVSdgY9svnGfXDf8I=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kCr5N0D1gJc+unBugBGykYZ59wBiYlGp686nFHs/HYHnjHTh5NG0QnCsccApTQDdl
         rumMjqf8UuNuqUCg9q1pBduh9YIQ59lvMzanpigec1ygCphYx4ersxlK0apbQBsoUH
         Abpsfv6riICr+/Lrdko7a8yFeaVTGnLMX594HGNOvmwPhDqBNTyRILzWgVvm0Tqbbn
         sZH98sQRQj/YBkJGpG7OnLAbOgJgO/Ea7zQJ80G3ZPFo3alpHXfyrDmdaoZF/5iqw7
         EcAWU7IxRMV2TuCOqDvyRrZMy3P719IR8zer2ouYw8aW/q52Iks/2IYey5Wqrz5o1x
         AEF2zEi5Bj9Llc44BHp93c9vLWvgH1yv1toBViRJHSlSK4gJHzTqKgfYUOw5bK0r/7
         1UPZ1ijtR6/nAAMW63cGKw7ecL8kord2iejcoQuuidvr4ArRT7wi+rlB99L9Ndt/nT
         Xd0jT+4nRV6eRRog3AIJyzORjgBCs3crlP2Tolyg3NZVUkhLriY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>
Subject: [PATCH] git-cvsexportcommit: support Perl before 5.10.1
Date:   Thu,  6 Aug 2020 00:16:50 +0000
Message-Id: <20200806001650.3939903-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The change in 6e9c4d408d ("git-cvsexportcommit: port to SHA-256",
2020-06-22) added the use of a temporary directory for the index.
However, the form we used doesn't work in versions of Perl before
5.10.1.  For example, version 5.10.0 contains a version of File::Temp
from 2007 that doesn't contain "newdir".

In order to make the code work with 5.8.8, which we support, let's
change to use the static method "tempdir" with the argument "CLEANUP",
which provides the same behavior.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-cvsexportcommit.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 6483d792d3..0ae8bce3fb 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -22,7 +22,7 @@
 my $repo = Git->repository();
 $opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;
 
-my $tmpdir = File::Temp->newdir;
+my $tmpdir = File::Temp::tempdir(CLEANUP => 1);
 my $hash_algo = $repo->config('extensions.objectformat') || 'sha1';
 my $hexsz = $hash_algo eq 'sha256' ? 64 : 40;
 
