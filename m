Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE48E2023D
	for <e@80x24.org>; Fri,  3 Mar 2017 11:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbdCCLm5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 06:42:57 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55147 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbdCCLlW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 06:41:22 -0500
Received: from evilbit.green-communications.fr ([82.228.44.140]) by
 mrelayeu.kundenserver.de (mreue101 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 0LiCmZ-1bxnfR2jbP-00nRNZ; Fri, 03 Mar 2017 12:33:42 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC 2/2] merge-recursive: Handle rename/rename/delete/delete conflicts.
Date:   Fri,  3 Mar 2017 12:33:17 +0100
Message-Id: <20170303113317.18575-2-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170303113317.18575-1-nicolas.cavallari@green-communications.fr>
References: <20170303113317.18575-1-nicolas.cavallari@green-communications.fr>
X-Provags-ID: V03:K0:Pv/O4tQZ932wVtmiJQMQGltZDxC70bG44St9kTWbtNS7k3LVc4K
 3roD7QFuxKHIzhAWC/E3jWrca27SHYS7vajq8PGZnBgJjsKa8uC3ZoJBVL/s9/k7ccHHYHg
 on07/TI6+Cs5ICMQep3NxlsJhwUTgVyaSmwhKsBN+NjxYNomRF6AftodydqGJiNPoo5PYD8
 C2RZefEaCBRVMt0FOl40g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2JUzqa+Uvdg=:PPz6KRLuNTPv+HyUIlIe2X
 FCVkSoUVTolYWanQkPKz4T0bjvZ/xc7VY+EW+Me0yurZUT6SSuXVtQfhlMRVcCs1JkE2kCYQt
 HqQwp8ySeBGpFhjWCE/Vy6UhGlHMfTUHNo+bWBhgKz3036QkWejNuqS1KMk05sd4NuhRCWKHa
 it3NqAPOazI3Pbsr0KcfbyHOOcCC0or0B1L3pWW1ixOjuJmETtufoElycJvGYJEviKOlzsf8r
 coOSedTR8mJucwqmXHiAqMajuyx2DWWgEo5jv6GZjOmLVNLfUjmHIRfE40cZiNh0NZHQx+d2p
 xVfErBG6TR1b4VdYA4VcXQF4Uic4xzpjwr1vcDgyhukY/115UzK2s25r5ylWazBQRxGS+gxIB
 rdJ8OyiRoTbjdzD5rSPswdAKnTfNanNaDndiGqH6/8gm+ozbQX89M7nFLpxgz2JepIXcFQ/md
 ItJsLOHOjBcEtNYf0AZLaBnlkOcdLV9FbPaIuLdOTF4lh/f++4fBT4ClUk5rIIkLcs7O6fS3m
 odNZh0Eo7NOLfRLLNBB80xrNjSzXx+WhvONUTmIVTE/TzOov6iL/Y+rji8mkMc+ggh/mz1g/A
 AZnfzJHAoPh3kfrmFQvsui+/lR8e7nT1LZ55Gy9esyCMafcs5WXuDvuDc51ceIlodVEyNLpWR
 Y61ajzWLhxXFu6ATPI8ecqAqo6J3n5lWEY/7z7nbkvQ/zJjHEs/bvrY6P1FVXfBg8izU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On a rename 2to1 conflict, where both a and b are renamed to c,
the other branch may have deleted a or b.  This currently luckily
works for files but fails for symlinks.

Fix conflict_rename_rename_2to1 to not merge_file_special_markers()
with diff_filespecs where mode == 0.  The alternative would be to make
merge_file_1() handle it.

Mark the corresponding testcase in t6042 as fixed.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 merge-recursive.c                    | 28 ++++++++++++++++++++++------
 t/t6042-merge-rename-corner-cases.sh |  2 +-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b7ff1ada3..0e5a3e3ed 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1305,13 +1305,29 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
 	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
 
-	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
-				       o->branch1, c1->path,
-				       o->branch2, ci->ren1_other.path, &mfi_c1) ||
-	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
-				       o->branch1, ci->ren2_other.path,
-				       o->branch2, c2->path, &mfi_c2))
+	// The other branch may have deleted a, as indicated by mode == 0.
+	if (ci->ren1_other.mode == 0) {
+		mfi_c1.clean = 0;
+		mfi_c1.merge = 0;
+		mfi_c1.mode = c1->mode;
+		oidcpy(&mfi_c1.oid, &c1->oid);
+	} else if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
+					      o->branch1, c1->path,
+					      o->branch2, ci->ren1_other.path,
+					      &mfi_c1)) {
 		return -1;
+	}
+
+	if (ci->ren2_other.mode == 0) {
+		mfi_c2.clean = 0;
+		mfi_c2.merge = 0;
+		mfi_c2.mode = c2->mode;
+		oidcpy(&mfi_c2.oid, &c2->oid);
+	} else if (merge_file_special_markers(o, b, &ci->ren2_other, c2,
+					      o->branch1, ci->ren2_other.path,
+					      o->branch2, c2->path, &mfi_c2)) {
+		return -1;
+	}
 
 	if (o->call_depth) {
 		/*
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index ea4e14cbd..34b16d5d7 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -605,7 +605,7 @@ test_expect_success 'setup rename/rename/delete/delete conflict' '
 	git commit -m C
 '
 
-test_expect_failure 'rename/rename/delete/delete leaves at least one file' '
+test_expect_success 'rename/rename/delete/delete leaves at least one file' '
 	git checkout B^0 &&
 	test_must_fail git merge -s recursive C^0 &&
 
-- 
2.11.0

