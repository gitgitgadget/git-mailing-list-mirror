Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B549BCDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 16:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379242AbjJLQKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbjJLQJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 12:09:59 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E4ACC
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 09:09:56 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DBC125B07A;
        Thu, 12 Oct 2023 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1697126995;
        bh=02IkAfF+AiRi3RSe2NJNJznPC1z0MTyip/gErqnEC9k=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=p1ZU9i2S/SlP+9gF83VRG5+fCGXX+7ElhXZw3hdmV+rqbevJz8sXg0q3dycx+DmXJ
         +N7Bm9p+/+UVLrOIi4Ee78NDM3KkUQedYW7Xw1Yzf697p1rPV5uj8xJ9gCHWCzLp6s
         oP6qMlUS4UhyM3sQZvlweuk2AOHPnR7T5x9FoCBdx6I+JbwBFt68AF+GUg2pGpp6HR
         VqGHr0uH72MOXbrsq1ek+dlS+9ahWFRkBQJpL23BHacIBw7yzWWn75Ron8yyn5cgZd
         oCq6z6QTdWrlV83IqH1DvaUsOu2tap2Aq4E6Ohnr79f1ufA2Z+SgiANq0csMlLMjxj
         5E8fsGEK+9DeJSFmL8C/UcAAzezBoQk5SV0aNW9j8T4XoPWYppv7lHVQvRvtozn4HF
         UAtfyGgD/lK7qULLc0V8hWrh68q2TvWaO+jD6hBYb6Bkk+HERIFkpWcReUKhGBBvPw
         zXNVu8UT1BHIdTSuE/51NrawSG/JfikeuT82Yb43C7jFMuE4J+z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jason Hatton <jhatton@globalfinishing.com>
Subject: [PATCH v2 0/2] Prevent re-reading 4 GiB files on every status
Date:   Thu, 12 Oct 2023 16:09:28 +0000
Message-ID: <20231012160930.330618-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several people have noticed that Git continually re-reads and re-hashes
files that are an exact multiple of 4 GiB every time the index is
refreshed (for example, when "git status" is called).  This is slow and
expensive, especially with SHA-1 DC, and it also causes performance
problems when these files are used with Git LFS (because the same issue
occurs, just with Git LFS hashing the data instead of Git).

Jason Hatton sent a patch previously to fix this, but it lacked tests
and didn't get picked up.  I've adopted their patch, making some minor
changes to the commit message and including some tests, and also
including a suitable test helper to make the tests possible.  All credit
should be directed to Jason, and I'll accept all the responsibility for
any problems.

I don't anticipate this being in any way controversial, so I'm not
expecting a huge number of rerolls, but of course one or two might be
necessary.

Jason Hatton (1):
  Prevent git from rehashing 4GiB files

brian m. carlson (1):
  t: add a test helper to truncate files

 Makefile                 |  1 +
 statinfo.c               | 20 ++++++++++++++++++--
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 t/helper/test-truncate.c | 27 +++++++++++++++++++++++++++
 t/t7508-status.sh        | 16 ++++++++++++++++
 6 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-truncate.c

