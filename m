From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 3/3] Add a perf test for rebase -i
Date: Wed, 11 May 2016 10:42:34 +0200 (CEST)
Message-ID: <96acc54c20962376d5438f8d9613dc9c8a6d5d1c.1462955446.git.johannes.schindelin@gmx.de>
References: <cover.1462894344.git.johannes.schindelin@gmx.de> <cover.1462955446.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:43:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0PkK-0008Mm-12
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbcEKInv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:43:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:56828 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbcEKInt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:43:49 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LgHvY-1bNKLj05hs-00nePT; Wed, 11 May 2016 10:43:43
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462955446.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:+XSmIJipeXRyF28hSKKM7dkbPmKYckhCBfpbrHVfIH/rBfRszta
 WlI5w2wTyeGATPZQtoMoJJ8ezk0bzl3hdEM5sDRMzdteoplY8ENAZuDhen1D7PcAddEzG8g
 A5LM4WO4+ooxH2V77wM3fubnPSYJOQm41p1MlZUkUqZQoIr60D+LdAAa46r1V6A/CHSlhKu
 5Nwk2DXZrIrPkARCTyA6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9yKZwQcsA1I=:xhBKEwxS2wGzyR14Xl7Xnm
 ji6CM3DVHBx+DgTsLjpVLXsdHyYez5bhie77ooBVA0Uoxk/9JFLSUtgyyoDb1DujLwpgI7j/v
 8AqBDZHqHQSqNohMMmU/MgBO+MJyxPLLHriwrnrHWbyiFrUG9/4N3J1yX3oaENsngAtyr7or0
 bCqigjzbso2RS9oRzRbXKLdj7+IBEbT4bRtQDaP4k5dKAuxABreHgbDAmCqP8CVGeEKF8HXOC
 kaipjRltracEOk0VrmV4hSVDdAoWqALNzgQeLxLNRuS9o2KSAdQ2LQnahNJxHKaJLe/yfOch1
 ZJBSrp8xMEpEzN/ZeP/wuHD3WCCnTYY/th9R9EVqp6tlROJSClEEfSXEETF+eRELi19/NLegy
 mi81YlCMBaaBLXtogBrUuT2Xh+TmSY5iKg5SoYzuzrEg+xIzd5HWuQ1CdlsKyu3SaYD8bM4uE
 +4zZASVoT6uvuXh4JWaqCoViiqKsIxoyYO+/xDL1DA05K2ycNV5d16q2b7nGwc/2YUuRSxhpr
 yGJxhxH2RiM0Md84iycn4YVjJmdJnlO2iV97+8mtIn4Lba5ftRC1FWKw0Mod9pnpR+GAwzdjM
 6tnkDJB359Nc3MTpA0RRIddgShEnMnMnUmDhW8B/vAYzgsmQoGZf+c4LX8sjWUQPBTqCgjOHZ
 onRx7fHmnnxGJBmkUZ7WhCAFvQLqtmMW4u4FgICTPwGpIkx0CSVuPZFI3CCVMwnKDSA2Y4boP
 /SEPwt7CXsgQHlTFaZo3S2tS8V1nhFA/azSyCgYPssta/8l7moWsM/YYvVajL4RUqVouBwz0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294241>

This developer spent a lot of time trying to speed up the interactive
rebase, in particular on Windows. And will continue to do so.

To make it easier to demonstrate the performance improvement, let's have
a reproducible performance test.

The topic branch we use to test performance was found using these shell
commands (essentially searching for a long-enough topic branch in Git's
own history that touched the same file multiple times):

	git rev-list --parents origin/master |
	grep ' .* ' |
	while read commit rest
	do
		patch_count=$(git rev-list --count $commit^..$commit^2)
		test $patch_count -gt 20 || continue

		merges="$(git rev-list --parents $commit^..$commit^2 |
			grep ' .* ')"
		test -z "$merges" || continue

		patches_per_file="$(git log --pretty=%H --name-only \
				$commit^..$commit^2 |
			grep -v '^$' |
			sort |
			uniq -c -d |
			sort -n -r)"
		test -n "$patches_per_file" &&
		test 20 -lt $(echo "$patches_per_file" |
			sed -n '1s/^ *\([0-9]*\).*/\1/p') || continue

		printf 'commit %s\n%s\n' "$commit" "$patches_per_file"
	done

Note that we can get away with *not* having to reset to the original
branch tip before rebasing: we switch the first two "pick" lines every
time, so we end up with the same patch order after two rebases, and the
complexity of both rebases is equivalent.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/perf/p3404-rebase-interactive.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 t/perf/p3404-rebase-interactive.sh

diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
new file mode 100755
index 0000000..382163c
--- /dev/null
+++ b/t/perf/p3404-rebase-interactive.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description='Tests rebase -i performance'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+# This commit merges a sufficiently long topic branch for reasonable
+# performance testing
+branch_merge=ba5312d
+export branch_merge
+
+write_script swap-first-two.sh <<\EOF
+case "$1" in
+*/COMMIT_EDITMSG)
+	mv "$1" "$1".bak &&
+	sed -e '1{h;d}' -e 2G <"$1".bak >"$1"
+	;;
+esac
+EOF
+
+test_expect_success 'setup' '
+	git config core.editor "\"$PWD"/swap-first-two.sh\" &&
+	git checkout -f $branch_merge^2
+'
+
+test_perf 'rebase -i' '
+	git rebase -i $branch_merge^
+'
+
+test_done
-- 
2.8.2.465.gb077790
