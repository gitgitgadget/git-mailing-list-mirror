Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56AAD1F859
	for <e@80x24.org>; Tue, 30 Aug 2016 09:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758051AbcH3J4Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 05:56:24 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33109 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757541AbcH3J4X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 05:56:23 -0400
Received: by mail-lf0-f50.google.com with SMTP id b199so9739425lfe.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KbgbOxp47oymp0kzcCHVU8joBVppZAgctCj+PfUeMl4=;
        b=KIE1t9xZHELtMWJTb50RIZPNmQTOc5mdsf+sfqcRrZIigPvAarpVYrEyHjgmiTXKg2
         bCdQZkxKMSxSg7RG3saSDN49goQflrnO+60dnB5wVzos6IawjmMPpgl0LzBHvpLOsqHk
         +rSIDr2ly4qhgV39SPYfe3VykGZR9rWCZAuJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KbgbOxp47oymp0kzcCHVU8joBVppZAgctCj+PfUeMl4=;
        b=DXwnBSkz1KNxl/Ue78VlKyxwrnTiKWGTiKiE7UHdQbd75a3CTOKVHegTgAtQyFBHyR
         wT2eJ/kv5Zrenpk4FdSWETu2aN3PKXrab+836Z4DmYxRM+uMUdoIdqfPE2ndGO7GBM97
         Hfsgc+744eXNJY1n1qAJ1GvGC0t5QCqjGQeOhBbAlaLRcI0Ry/jNMvvpEvPjhivUBC4O
         6CowQ/az8sp58U6K3eovMxl4svo5zveTKXTLT2KIXa923VnADq9b+FWBsAA7h5CjIXr0
         uSyq1BC0Senr9dJSeD8WjyGbREpw+OHjt5ZTVfOrgp6FaPoH2nK3dHwNInEPowEOFD3E
         /YnA==
X-Gm-Message-State: AE9vXwNRExFCvf/GHnj8kgjHQIeOuvFcbz2g6YUO85flAoMeZd33ABFch/LRBghL7HmQIQ==
X-Received: by 10.25.160.139 with SMTP id j133mr662523lfe.227.1472550980923;
        Tue, 30 Aug 2016 02:56:20 -0700 (PDT)
Received: from localhost.localdomain (starbucks.starlink.ru. [77.50.56.50])
        by smtp.gmail.com with ESMTPSA id c125sm7417921lfe.10.2016.08.30.02.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Aug 2016 02:56:20 -0700 (PDT)
From:   Ivan Shapovalov <intelfx@intelfx.name>
To:     git@vger.kernel.org
Cc:     Ivan Shapovalov <intelfx@intelfx.name>
Subject: [PATCH RFC] subtree: support subtree -P /path/to/file split
Date:   Tue, 30 Aug 2016 12:55:26 +0300
Message-Id: <20160830095526.15286-1-intelfx@intelfx.name>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm missing `git subtree split` functionality for the case when prefix
is a single file. Looking at git-subtree, pretty few changes are needed
to handle this. The attached patch works for me in the common case
(no rejoins). As such, I'm looking for comments :)

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>

---
 contrib/subtree/git-subtree.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dec085a..464dcf7 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -485,8 +485,12 @@ subtree_for_commit () {
 	while read mode type tree name
 	do
 		assert test "$name" = "$dir"
-		assert test "$type" = "tree" -o "$type" = "commit"
+		assert test "$type" = "tree" -o "$type" = "commit" -o "$type" = "blob"
 		test "$type" = "commit" && continue  # ignore submodules
+		test "$type" = "blob" && { # handle if $dir is a file
+			printf "%s %s %s\t%s\0" "$mode" "$type" "$tree" "${file##*/}" | git mktree
+			break
+		}
 		echo $tree
 		break
 	done
-- 
2.9.3

