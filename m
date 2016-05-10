From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/3] Add a perf test for rebase -i
Date: Tue, 10 May 2016 17:45:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605101744060.4092@virtualbox>
References: <cover.1462894344.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 17:45:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b09qb-0000sa-3T
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 17:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbcEJPpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 11:45:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:57834 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbcEJPpP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 11:45:15 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lt1yI-1bk3LC2N6g-012cP0; Tue, 10 May 2016 17:45:08
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462894344.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:1iCOmJsU/0DEBEv2SxCoQbwirLnhXVFZGd44SwalaBkaomdxpjj
 odmkZpcK9KE9OMO+VrvlApuQnyVQBHUf/I/ZlEhIphyOwZrfhwLs8Rt0UhL6CV01oZZEqfF
 c+t7xCUh5vgnDSm0PibNpzc8poM/3Xx6frn/CUXYwoOvM8uOlZDcu7ORT6r14G38YR+cbev
 NCXbcx/ax01LSbjl+zdjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JkpMBR20r9E=:b7YZwoHbT7Rmlvdi9D5C5E
 mbhIyRgwIRbIIVQs1CWvgqDXXxvDShAs5Pct+FmFh386XkrPfOcwRxYUp7ZzGxDU4jJTjCVt8
 5qinDDBzkMT73f125VIQvB0CqFRTGnW/8HVksgmJhdNIRsHr+fhXCU8u3yN7ZIWxsdn5+EoK2
 tXWNkLnPhw7glUSRVSXCLJfLKx0nDa0uCFX552tAx51lUftZ3b4Kh1Oed2hSPTpmAuzqdP+k2
 pL8cwBraoO0D9B05lMDCgKnrKlRu0osfddP1sZ+aXTwZ2do3WssfX8RL6MZiXF9ODz1SCTU7Y
 8o0wZ6Y/yxEd0Cgssh+iKoBinYVI/cSfDmSTk7dAKCBGEeEYt81I3d9vpjW1ZVMNmx2jbL+4i
 O3K8NBy/+0H58kKHWWNZiC3m2kvgYl0ZLqrLW0bv0XAcA/HIs4/uP8H64LnsnJEf3tnox/AG9
 h7GcAtjmL1/wfaLbBPI1epsC/i1Dg3AylkGFSZUam5PirlGOfTd9j4Z6wzb/36HCDb3szQgPb
 NFN68g0LBdDv4ZvYaaDqoUlV1muJ7y2d8kAi8rzd60Szhqt2Pl16AuybiP1pX3qhIv6NZLJ8p
 E0qCxRZtsNEdfHQdgUfDPvJyNiCWxzapmeDkdT53UKRUN9V/hS2p57jTtS7ZYoCvmCsHPSAZh
 r1b4WXfbU6HFSZKoN96cHXJeA+lSVlHBUQlJVw81HAbnjVLW7QuhoFah8pG2q/EpfDzAf/zhj
 OtfAH4BY5jjiV1JdD5XA6WhLDY3CLO5NaK7mTFRRSjiJF6DejbbAgGD9xs1Q2pD1z/GXa8c4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294152>

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
