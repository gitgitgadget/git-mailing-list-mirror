From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] add tests for various blame formats
Date: Mon, 9 May 2011 09:33:30 -0400
Message-ID: <20110509133330.GA11022@sigill.intra.peff.net>
References: <20110509133153.GA10998@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 15:33:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJQaf-0001RW-UF
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 15:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab1EINdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 09:33:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39679
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab1EINdc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 09:33:32 -0400
Received: (qmail 9065 invoked by uid 107); 9 May 2011 13:35:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 09:35:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 09:33:30 -0400
Content-Disposition: inline
In-Reply-To: <20110509133153.GA10998@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173230>

We don't seem to have any tests for "blame --porcelain".
Let's at least do a trivial test on a simple example.

Signed-off-by: Jeff King <peff@peff.net>
---
I always feel funny putting human-readable output in a test. Maybe it is
not worth including the "normal" output test below, but I assume it's
going to remain pretty stable.

 t/t8008-blame-formats.sh |   71 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100755 t/t8008-blame-formats.sh

diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
new file mode 100755
index 0000000..387d1a6
--- /dev/null
+++ b/t/t8008-blame-formats.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+test_description='blame output in various formats on a simple case'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo a >file &&
+	git add file
+	test_tick &&
+	git commit -m one &&
+	echo b >>file &&
+	echo c >>file &&
+	echo d >>file &&
+	test_tick &&
+	git commit -a -m two
+'
+
+cat >expect <<'EOF'
+^baf5e0b (A U Thor 2005-04-07 15:13:13 -0700 1) a
+8825379d (A U Thor 2005-04-07 15:14:13 -0700 2) b
+8825379d (A U Thor 2005-04-07 15:14:13 -0700 3) c
+8825379d (A U Thor 2005-04-07 15:14:13 -0700 4) d
+EOF
+test_expect_success 'normal blame output' '
+	git blame file >actual &&
+	test_cmp expect actual
+'
+
+ID1=baf5e0b3869e0b2b2beb395a3720c7b51eac94fc
+COMMIT1='author A U Thor
+author-mail <author@example.com>
+author-time 1112911993
+author-tz -0700
+committer C O Mitter
+committer-mail <committer@example.com>
+committer-time 1112911993
+committer-tz -0700
+summary one
+boundary
+filename file'
+ID2=8825379dfb8a1267b58e8e5bcf69eec838f685ec
+COMMIT2='author A U Thor
+author-mail <author@example.com>
+author-time 1112912053
+author-tz -0700
+committer C O Mitter
+committer-mail <committer@example.com>
+committer-time 1112912053
+committer-tz -0700
+summary two
+previous baf5e0b3869e0b2b2beb395a3720c7b51eac94fc file
+filename file'
+
+cat >expect <<EOF
+$ID1 1 1 1
+$COMMIT1
+	a
+$ID2 2 2 3
+$COMMIT2
+	b
+$ID2 3 3
+	c
+$ID2 4 4
+	d
+EOF
+test_expect_success 'blame --porcelain output' '
+	git blame --porcelain file >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.5.rc2.8.gc085
