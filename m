From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] t7510: check %G* pretty-format output
Date: Mon, 16 Jun 2014 20:06:24 -0400
Message-ID: <20140617000623.GD17110@sigill.intra.peff.net>
References: <20140616235917.GA19499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 02:06:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwguy-0000wS-K3
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 02:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbaFQAGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 20:06:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:45649 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751668AbaFQAGY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 20:06:24 -0400
Received: (qmail 27198 invoked by uid 102); 17 Jun 2014 00:06:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 19:06:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 20:06:24 -0400
Content-Disposition: inline
In-Reply-To: <20140616235917.GA19499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251835>

We do not check these along with the other pretty-format
placeholders in t6006, because we need signed commits to
make them interesting. t7510 has such commits, and can
easily exercise them in addition to the regular
--show-signature code path.

Signed-off-by: Jeff King <peff@peff.net>
---
Similar to before, but with the 'U' test added in.

 t/t7510-signed-commit.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 04fc2c5..e97477a 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -107,4 +107,44 @@ test_expect_success GPG 'amending already signed commit' '
 	! grep "BAD signature from" actual
 '
 
+test_expect_success GPG 'show good signature with custom format' '
+	cat >expect <<-\EOF &&
+	G
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS" sixth-signed >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show bad signature with custom format' '
+	cat >expect <<-\EOF &&
+	B
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS" $(cat forged1.commit) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show unknown signature with custom format' '
+	cat >expect <<-\EOF &&
+	U
+	61092E85B7227189
+	Eris Discordia <discord@example.net>
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS" eighth-signed-alt >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show lack of signature with custom format' '
+	cat >expect <<-\EOF &&
+	N
+
+
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS" seventh-unsigned >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.0.0.566.gfe3e6b2
