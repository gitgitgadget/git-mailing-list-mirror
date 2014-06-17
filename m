From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] t7510: test a commit signed by an unknown key
Date: Mon, 16 Jun 2014 20:05:54 -0400
Message-ID: <20140617000554.GC17110@sigill.intra.peff.net>
References: <20140616235917.GA19499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 02:06:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwguV-0000Ln-0M
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 02:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbaFQAFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 20:05:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:45644 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751160AbaFQAFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 20:05:55 -0400
Received: (qmail 27132 invoked by uid 102); 17 Jun 2014 00:05:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 19:05:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 20:05:54 -0400
Content-Disposition: inline
In-Reply-To: <20140616235917.GA19499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251834>

We tested both good and bad signatures, but not ones made
correctly but with a key for which we have no trust.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not happy about grepping more gpg output, but perhaps this "not
certified" is no worse than the current 'Good signature from" greps we
have?

The internal code uses --status-fd, which is presumably more robust to
changes. I dunno. I'd be inclined to go with this, and if it becomes a
problem in a future gpg release, we can deal with it then.

 t/t7510-signed-commit.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index cdffcbd..04fc2c5 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -43,6 +43,9 @@ test_expect_success GPG 'create signed commits' '
 
 	test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^ &&
 	git tag seventh-signed
+
+	echo 8 >file && test_tick && git commit -a -m eighth -SB7227189 &&
+	git tag eighth-signed-alt
 '
 
 test_expect_success GPG 'show signatures' '
@@ -63,6 +66,16 @@ test_expect_success GPG 'show signatures' '
 			! grep "BAD signature from" actual &&
 			echo $commit OK || exit 1
 		done
+	) &&
+	(
+		for commit in eighth-signed-alt
+		do
+			git show --pretty=short --show-signature $commit >actual &&
+			grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			grep "not certified" actual &&
+			echo $commit OK || exit 1
+		done
 	)
 '
 
-- 
2.0.0.566.gfe3e6b2
