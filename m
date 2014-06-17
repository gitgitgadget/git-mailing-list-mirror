From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] pretty: avoid reading past end-of-string with "%G"
Date: Mon, 16 Jun 2014 20:07:07 -0400
Message-ID: <20140617000707.GE17110@sigill.intra.peff.net>
References: <20140616235917.GA19499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 02:07:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwgvi-0001vK-Nj
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 02:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbaFQAHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 20:07:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:45658 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751517AbaFQAHI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 20:07:08 -0400
Received: (qmail 27273 invoked by uid 102); 17 Jun 2014 00:07:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 19:07:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 20:07:07 -0400
Content-Disposition: inline
In-Reply-To: <20140616235917.GA19499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251837>

If the user asks for --format=%G with nothing else, we
correctly realize that "%G" is not a valid placeholder (it
should be "%G?", "%GK", etc). But we still tell the
strbuf_expand code that we consumed 2 characters, causing it
to jump over the trailing NUL and output garbage.

This also fixes the case where "%GX" would be consumed (and
produce no output). In other cases, we pass unrecognized
placeholders through to the final string.

Signed-off-by: Jeff King <peff@peff.net>
---
Same as before, but with the test included along with the fix, rather
than in another commit.

 pretty.c                 | 2 ++
 t/t7510-signed-commit.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/pretty.c b/pretty.c
index e1e2cad..70d8776 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1267,6 +1267,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			if (c->signature_check.key)
 				strbuf_addstr(sb, c->signature_check.key);
 			break;
+		default:
+			return 0;
 		}
 		return 2;
 	}
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index e97477a..9810242 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -147,4 +147,10 @@ test_expect_success GPG 'show lack of signature with custom format' '
 	test_cmp expect actual
 '
 
+test_expect_success 'unused %G placeholders are passed through' '
+	echo "%GX %G" >expect &&
+	git log -1 --format="%GX %G" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.0.0.566.gfe3e6b2
