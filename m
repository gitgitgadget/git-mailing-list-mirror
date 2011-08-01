From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] test ls-files with relative paths
Date: Mon, 1 Aug 2011 20:03:20 +0200
Message-ID: <20110801180320.GA17556@toss>
References: <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
 <b535c21e1becdf8aeeb1d3f8ddaa7f5415830844.1311767679.git.git@drmicha.warpmail.net>
 <20110729130330.GA31941@toss.lan>
 <7vipqiknjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	rrt@sc3d.org, john@szakmeister.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:03:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwpt-0000bT-HG
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114Ab1HASDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:03:25 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:51320 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752923Ab1HASDY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:03:24 -0400
Received: from localhost (p5B22CD28.dip.t-dialin.net [91.34.205.40])
	by bsmtp.bon.at (Postfix) with ESMTP id AE68BA7EB3;
	Mon,  1 Aug 2011 20:03:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vipqiknjh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178370>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
On Sun, Jul 31, 2011 at 05:01:22PM -0700, Junio C Hamano wrote:
> 
> Sounds sane; tests?

Certainly. I'm not testing partial commit since it uses the same
codepath as ls-files --error-unmatch anyways.

 t/t3005-ls-files-relative.sh |   74 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100755 t/t3005-ls-files-relative.sh

diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
new file mode 100755
index 0000000..e9a2f75
--- /dev/null
+++ b/t/t3005-ls-files-relative.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='ls-files tests with relative paths
+
+This test runs git ls-files with various relative path arguments.
+'
+
+. ./test-lib.sh
+
+new_line='
+'
+sq=\'
+
+test_expect_success 'prepare' '
+	: >never-mind-me &&
+	git add never-mind-me &&
+	mkdir top &&
+	(
+		cd top &&
+		mkdir sub &&
+		x="x xa xbc xdef xghij xklmno" &&
+		y=$(echo "$x" | tr x y) &&
+		touch $x &&
+		touch $y &&
+		cd sub &&
+		git add ../x*
+	)
+'
+
+test_expect_success 'ls-files with mixed levels' '
+	(
+		cd top/sub &&
+		f=$(cat <<-EOF
+		../../never-mind-me
+		../x
+		EOF
+		) &&
+		echo "$f" >expect &&
+		git ls-files $f >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ls-files -c' '
+	(
+		cd top/sub &&
+		for f in ../y*
+		do
+			echo "error: pathspec ${sq}${f}${sq} did not match any file(s) known to git."
+		done >expect &&
+		echo "Did you forget to ${sq}git add${sq}?" >>expect &&
+		set ../x* &&
+		IFS="$new_line" && echo "$*" >>expect && unset IFS &&
+		(git ls-files -c --error-unmatch ../[xy]* || true) >actual 2>&1 &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ls-files -o' '
+	(
+		cd top/sub &&
+		for f in ../x*
+		do
+			echo "error: pathspec ${sq}${f}${sq} did not match any file(s) known to git."
+		done >expect &&
+		echo "Did you forget to ${sq}git add${sq}?" >>expect &&
+		set ../y* &&
+		IFS="$new_line" && echo "$*" >>expect && unset IFS &&
+		(git ls-files -o --error-unmatch ../[xy]* || true) >actual 2>&1 &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
1.7.3.1.105.g84915
