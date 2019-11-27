Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E077C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F4320715
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="N6Xa6zOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfK0TBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:01:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50958 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726593AbfK0TBy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Nov 2019 14:01:54 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F05CF60458
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1574881314;
        bh=nXyCy7ixCkcXby6HzUOyqtgLQKEQSI3x1mm0VQMu4aw=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=N6Xa6zOObwJJriSWUANUdK7ADWRKnmukvyUD11WW6pfgES+INOEkmCXUECdvrmHuj
         cnsCO6hELz/Gh1DiswALTYYFddS3JpkqOWa55u9xw/FcmumYwa8H27+poB6cM+l0s3
         PJlXab5xSJlaaMF4QO/VdXWZqBJ85BZOd4SddAw4KhrTUFnn5LkeLHZW/xWd/RH3l7
         cE8ROcusky9QMmThmISPAFR1qooGbkuXcnN5GFkdt4KhYs2UX7q5PvoUR3r8iowAOz
         T5Eeii0uN0/NX12aaxDUvumdNWd7YLFdGQ+2hr/qYqzEclQBCw8GtSwT/ES42WPzYz
         2q57L0+hM6IlcN3vJjpXQj50ygUWaDVvF/SUoZy+e0z8zq+ki+y1hXTmmVvSOk4LrM
         7NnEv/NOKBQxMu+ZPBwrXClkJ+luvcp3wIudP4evlxpDlOPsM0iNe2Cqr0CYef2I2e
         eBXCC9oD+DzVBBcRYznFX/sIfcwEG6Ph93/qm5L2b86aXa698M0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH 0/1] Fix broken test with zsh as /bin/sh
Date:   Wed, 27 Nov 2019 19:01:41 +0000
Message-Id: <20191127190142.64271-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

macOS Catalina provides zsh as one of the three options for /bin/sh (the
other two being bash and dash).  Therefore, it's possible that people
will use zsh as /bin/sh and expect it to work when running Git and the
testsuite.

There are two things required for this to happen.  One is a patch to zsh
to make it run all items in a pipeline in a subshell in sh mode, just as
POSIX requires.  I've sent a patch[0] upstream to make that happen;
without that patch, multiple tests fail.

The other is this patch, which addresses a difference in behavior
between bash and dash, which strip out NUL bytes from the output of a
command substitution, and zsh, which does not.  Both behaviors are
permitted by POSIX, so this patch makes the test work in either case.

[0] https://www.zsh.org/mla/workers/2019/msg00960.html

brian m. carlson (1):
  t9001: avoid including non-trailing NUL bytes in variables

 t/t9001-send-email.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

