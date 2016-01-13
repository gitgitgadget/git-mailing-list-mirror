From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/4] fetch: release pack files before garbage-collecting
Date: Wed, 13 Jan 2016 18:20:11 +0100 (CET)
Message-ID: <4fd3f0c6d02ec33a832b6c1688e9f348825d074e.1452705584.git.johannes.schindelin@gmx.de>
References: <cover.1452705584.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:20:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJP5v-0004nK-T5
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbcAMRUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:20:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:55465 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932169AbcAMRUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:20:16 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MWkZL-1ahS883nBb-00Xw0k; Wed, 13 Jan 2016 18:20:11
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452705584.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:po6lBeT5P1cvKYmsYbPTpFQx53ymmHsS0ib9M5TooWDKFyJk3Q7
 4IoXZ6AZc/amWrzD0FB0x8Y+Wl8K1UBihky2i2zMZqn5pG7aebZZeiMzRpq+y7+I8cBom7l
 jBpIdxoWXiE+4Tf+jg824LD5YwOg/LnP6kRNabrqtImpvrQo2EgrTNGsbzkiavHUq3gSras
 i/sUgzjv1CB1vDHHeOoxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2OZGet0TzL8=:dRJl8Un+lnqopg6TvPoyGy
 NoysBkkQ364ftFSL5WjyQOmpYl3502rxEUD16N21ybTEFK7OTpf3JUIEO1HIfO6vf4LFbuvGe
 W+pxT7AJsA+nTD8hhondz4XBtGzjoeo+yVPZFEx+p1Ilznjt/BPoQJ4IH5XGYNUG+gEnZBgZy
 H+nB5hkcLcP99OSqsSiN2/oHIy9ycJQtwr3ZiKQSKVONULxvcd/+ZrpPHCvXtfDDDL1R+iNIQ
 /mJe9qk9a6Diz1XvFgAp9t2iyewkIDp8f7+gNvakVOYaMv5byitp3tk8tZkZoABvILYn6Ejq2
 Mc8O1TzXDAfjZ051EII5xMHyqGEoqAOohpj77nDrZy3F1MDV5GS6BccOfqADsS1doYevXNRTW
 Q+p7BKpGeaiIZ1MTVqCK/E9UZ+pO6OFEKWclHmO/0AmqBZSGiyoxnJ/EiLy/Ueo6xXRMz1rUD
 SahGPeMQ4pPR0NPFTWqYaKdIiOBNP9fh1Tgq4ggnsGgR9JzJ0qF9HGDJ+j8rbJStv8JfJ1KX/
 fqkLSkIygZtr8cvT6RKewQJ1seK+ROwNoWd6GOZ+THXWeMD+WsuQGJPHZlMgPfoEcH7IpVobb
 +UdvKhvqXvJvBSEpUBuGZhFwX/TZ0UWBSp8hCiR/98eL/hh//mzWJgtqms85sHIq5gPnp3zuP
 8bgCiSygt3GAlUKoJZfVnNekaVwEjVMGsg0wyu35H8bOwSqfmN/jROv2EHmeEbUI7280NV05M
 O6Yoknqs5xxthLQctA6o7abwOEx2iYMQRssfIaNpNCipw89xLhrmwFSpFZ4VelPiIkVMgu+q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283949>

Before auto-gc'ing, we need to make sure that the pack files are
released in case they need to be repacked and garbage-collected.

This fixes https://github.com/git-for-windows/git/issues/500

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fetch.c  |  2 ++
 t/t5510-fetch.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 33f04c1..8e74213 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1225,6 +1225,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	list.strdup_strings = 1;
 	string_list_clear(&list, 0);
 
+	close_all_packs();
+
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (verbosity < 0)
 		argv_array_push(&argv_gc_auto, "--quiet");
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0ba9db0..e3ee4bd 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -708,4 +708,17 @@ test_expect_success 'fetching a one-level ref works' '
 	)
 '
 
+test_expect_success 'fetching with auto-gc does not lock up' '
+	write_script askyesno <<-\EOF &&
+	echo "$*" &&
+	false
+	EOF
+	git clone "file://$D" auto-gc &&
+	test_commit test2 &&
+	cd auto-gc &&
+	git config gc.autoPackLimit 1 &&
+	GIT_ASK_YESNO="$D/askyesno" git fetch >fetch.out 2>&1 &&
+	! grep "Should I try again" fetch.out
+'
+
 test_done
-- 
2.6.3.windows.1.300.g1c25e49
