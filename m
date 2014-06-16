From: Jeff King <peff@peff.net>
Subject: [PATCH] t7510: check %G* pretty-format output
Date: Mon, 16 Jun 2014 16:26:11 -0400
Message-ID: <20140616202611.GA29716@sigill.intra.peff.net>
References: <20140616201311.GA26829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:26:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwdTw-0001IA-8n
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbaFPU0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:26:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:45490 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750953AbaFPU0M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 16:26:12 -0400
Received: (qmail 14830 invoked by uid 102); 16 Jun 2014 20:26:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 15:26:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 16:26:11 -0400
Content-Disposition: inline
In-Reply-To: <20140616201311.GA26829@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251819>

On Mon, Jun 16, 2014 at 04:13:11PM -0400, Jeff King wrote:

> It doesn't look like we have any tests of "%G*" and friends at all. :(

Maybe we can add this:

-- >8 --
Subject: t7510: check %G* pretty-format output

We do not check these along with the other pretty-format
placeholders in t6006, because we need signed commits to
make them interesting. t7510 has such commits, and can
easily exercise them in addition to the regular
--show-signature code path.

Signed-off-by: Jeff King <peff@peff.net>
---
I explicitly avoided "%GG" here, as its exact format is dependent on
gpg (and the current date). I don't know that it is worth the
complexity to test, as the interesting parts are already parsed from it
and exposed in the other placeholders.

 t/t7510-signed-commit.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 5ddac1a..2f96937 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -76,6 +76,42 @@ test_expect_success GPG 'detect fudged signature' '
 	! grep "Good signature from" actual1
 '
 
+test_expect_success GPG 'show good signature with custom format' '
+	cat >expect <<-\EOF
+	G
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS" master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show bad signature with custom format' '
+	cat >expect <<-\EOF
+	B
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS" $(cat forged1.commit) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show lack of signature with custom format' '
+	cat >expect <<-\EOF
+	N
+
+
+	EOF
+	git log -1 --format="%G?%n%GK%n%GS" seventh-unsigned >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unused %G placeholders are passed through' '
+	echo "%GX %G" >expect &&
+	git log -1 --format="%GX %G" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'detect fudged signature with NUL' '
 	git cat-file commit master >raw &&
 	cat raw >forged2 &&
-- 
2.0.0.566.gfe3e6b2
