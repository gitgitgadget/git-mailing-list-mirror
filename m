From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 3/4] pack-objects: use --objects-edge-aggressive only for shallow repos
Date: Tue, 23 Dec 2014 12:01:21 +0000
Message-ID: <1419336082-283091-4-git-send-email-sandals@crustytoothpaste.net>
References: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 13:01:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3O9o-0002sg-Qx
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 13:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbaLWMBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 07:01:34 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55912 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755845AbaLWMBd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2014 07:01:33 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C585328093;
	Tue, 23 Dec 2014 12:01:30 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261724>

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
