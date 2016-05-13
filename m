From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 3/3] Add a perf test for rebase -i
Date: Fri, 13 May 2016 15:26:03 +0200 (CEST)
Message-ID: <d5d1a6251a2e80700bd295bcdb48a99ab976493f.1463145936.git.johannes.schindelin@gmx.de>
References: <cover.1462955446.git.johannes.schindelin@gmx.de> <cover.1463145936.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:26:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1D6t-0000W7-Gv
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 15:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbcEMN0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 09:26:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:58505 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480AbcEMN0V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 09:26:21 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LjuR3-1bcCbx45u5-00brfe; Fri, 13 May 2016 15:26:01
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1463145936.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gQmMT2rnruXxV/9FVSnoY9T/BXXn6kvQsC7W5zNtx4ItsyINlF9
 lA1iHtP1DMsJGhCdRGamqPvYlVuE130qotj6zqof5CLqR2sVa+rv60Co/dvRX2kTKwhfipb
 QcHxwgB4cBATSKcw1kBIGwaJeh+SXJVVWMxWucQHqogWGMRfuX/xknB47mdH+EebeNYBejl
 SNh9VG6w1Q2j3ZZs2swKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5GaWtVqaCpc=:iTuEzlDY1kAThtIp3KskJs
 vQa6L9xbLVu+suInuTmvKi2DYa3HUm/u0SNaNo+xjjmUjN8Vhevxmx0AWAZI/wdkn4XzY88Qg
 2gQ68+Knp7q4L5BfZsa+XOAm9DwFHXviNslUH0TTqk2zcwRMg+XYTVUDM4hzV35W/wjFjLUf/
 lqsSUiiqdY9ZCf6MoewT5xMHA9BAzDc9MqFWRgYhHeFEypbPMQ87rdL/QgWpEqD9MO3a7hDkv
 zs+SHkiSeDZHCg6XijVQ6qEUn019I6zKGBeFAJJYKb5uNnZa5FQqNLWLuznh8yZcgMZO1X75B
 +ljW+F333QdQAk4FBkbA5DmkcybYajEtM95uZZ9XLAjHn8BNRT1yBmaP6VF3yjstwPWQ0bg8K
 zI8B1OdXy87Ok+PLTeeCu/hhlmwHK9sCBtbgWeSu4T+d91hzZSyjhUmL+1V+Ui+gllWsW+D1r
 Dpp/xGkuVZNG25EppENc6n+G6ybwuqu/1g6JtUK6VsDjaNSZaHgQA+smb6xij8LgS1Yd1r+S6
 PIZKAiLlXZupf/Ie/wvYP5F2bgfeZl38kll4/d5TId3QsESLfb7GqPWkq4Ti5+keLrpLg8V1o
 svSfIaJAnepZM6qvTSyUjBBcw/uFy0oHBRBzQL/MebqtZsDBsKp+NsdrcX3ODJa7KE08oZeIT
 du3qaJ6eiMl73494z7u8VJufYMBGX7mXYkMS/CT2FcBVOYsvH/wludW8d4wI+SS1aBVpNt8Ne
 JjZz6hNe4xIEMb6LkhugyWxYTwrgh8gX5FOeOkNc+uXjss6byd0JH3ljv4VZxyRA1cgm9NpR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294536>

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
 t/perf/p3404-rebase-interactive.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100755 t/perf/p3404-rebase-interactive.sh

diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
new file mode 100755
index 0000000..88f47de
--- /dev/null
+++ b/t/perf/p3404-rebase-interactive.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='Tests rebase -i performance'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+# This commit merges a sufficiently long topic branch for reasonable
+# performance testing
+branch_merge=ba5312da19c6fdb6c6747d479f58932aae6e900c^{commit}
+export branch_merge
+
+git rev-parse --verify $branch_merge >/dev/null 2>&1 || {
+	skip_all='skipping because $branch_merge was not found'
+	test_done
+}
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
