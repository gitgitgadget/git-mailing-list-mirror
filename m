From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] t3001: test ls-files -o ignored/dir
Date: Fri,  8 Jan 2010 23:35:32 -0800
Message-ID: <1263022535-12822-1-git-send-email-gitster@pobox.com>
References: <7veilzaguf.fsf@alter.siamese.dyndns.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 08:36:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTVrc-0007BO-7y
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 08:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348Ab0AIHfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 02:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909Ab0AIHft
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 02:35:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab0AIHft (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 02:35:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 417218FB76;
	Sat,  9 Jan 2010 02:35:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; s=sasl; bh=kwyFXoZS0MgdMnC
	ohKmd3N17Xhk=; b=OKScx/siOMDH+vWItgz5uLqYyT2n26FFue5JeguPTXpA2DH
	sys1xcG2e1tfnwn9ph8b2DBXWH+WVpg5TDCmaK7+SpYxVt4HOUqhkbzPcoSolYaV
	n1PhAqrOauXfzDe3gHcjwMXZVCISSA3if8A4seos4YHdEnmbS8pavzglJzpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; q=dns; s=sasl; b=bhHNi7M6/
	Jpk5jiz4EQcdwpDlNjTZzEM4rTqsHEQRE/yS3AVglu3QXPCB3EmrzjCUJw+KUFNT
	VXPvbY5dQz1hpwS+RPF0A137FBecQXSoJWwmokRdfgZx6Bauwxo6aMCjPgSK2Jra
	18Bl1u59lov/8MThnDIrtMu1Jsw1BOY9dU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E551B8FB74;
	Sat,  9 Jan 2010 02:35:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB6C78FB73; Sat,  9 Jan
 2010 02:35:36 -0500 (EST)
X-Mailer: git-send-email 1.6.6.209.g52296.dirty
In-Reply-To: <7veilzaguf.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 97A2FD62-FCF1-11DE-B30A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136521>

When you have "t" directory that is marked as ignored in the top-level
.gitignore file (or $GIT_DIR/info/exclude), running

    $ git ls-files -o --exclude-standard

from the top-level correctly excludes files in "t" directory, but
any of the following:

    $ git ls-files -o --exclude-standard t/
    $ cd t && git ls-files -o --exclude-standard

would show untracked files in that directory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3001-ls-files-others-exclude.sh |   39 ++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index c65bca8..e3e4d71 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -153,4 +153,43 @@ test_expect_success 'negated exclude matches can override previous ones' '
 	grep "^a.1" output
 '
 
+test_expect_success 'subdirectory ignore (setup)' '
+	mkdir -p top/l1/l2 &&
+	(
+		cd top &&
+		git init &&
+		echo /.gitignore >.gitignore &&
+		echo l1 >>.gitignore &&
+		echo l2 >l1/.gitignore &&
+		>l1/l2/l1
+	)
+'
+
+test_expect_success 'subdirectory ignore (toplevel)' '
+	(
+		cd top &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'subdirectory ignore (l1/l2)' '
+	(
+		cd top/l1/l2 &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'subdirectory ignore (l1)' '
+	(
+		cd top/l1 &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.6.209.g52296.dirty
