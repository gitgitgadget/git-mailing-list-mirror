From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 3/3] pack-objects: use --objects-edge-aggressive only for shallow repos
Date: Sat, 20 Dec 2014 22:51:13 +0000
Message-ID: <1419115873-166686-4-git-send-email-sandals@crustytoothpaste.net>
References: <1419115873-166686-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 23:51:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2Ss8-0001Kp-7M
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 23:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbaLTWv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2014 17:51:29 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55867 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752672AbaLTWvY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Dec 2014 17:51:24 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 187AF28093;
	Sat, 20 Dec 2014 22:51:22 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1419115873-166686-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261609>

Using --objects-edge-aggressive is important for shallow repos, as it
can result in a much smaller pack (in some cases, 10% of the size).
However, it performs poorly on large non-shallow repositories with many
refs.  Since shallow repositories are less likely to have many refs (due
to having less history), the smaller pack size is advantageous there.
Adjust pack-objects to use --objects-edge-aggressive only for shallow
repositories.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/rev-list-options.txt | 3 ++-
 builtin/pack-objects.c             | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 8cb6f92..2984f40 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -659,7 +659,8 @@ These options are mostly targeted for packing of Git repositories.
 
 --objects-edge-aggressive::
 	Similar to `--objects-edge`, but it tries harder to find excluded
-	commits at the cost of increased time.
+	commits at the cost of increased time.  This is used instead of
+	`--objects-edge` to build ``thin'' packs for shallow repositories.
 
 --unpacked::
 	Only useful with `--objects`; print the object IDs that are not
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3f9f5c7..f3ba861 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2711,7 +2711,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
-		argv_array_push(&rp, "--objects-edge");
+		argv_array_push(&rp, is_repository_shallow()
+				? "--objects-edge-aggressive"
+				: "--objects-edge");
 	} else
 		argv_array_push(&rp, "--objects");
 
-- 
2.2.1.209.g41e5f3a
