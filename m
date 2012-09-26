From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t9902: add completion tests for "odd" filenames
Date: Wed, 26 Sep 2012 17:51:06 -0400
Message-ID: <20120926215106.GB18653@sigill.intra.peff.net>
References: <20120926214653.GA18628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 23:51:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGzVm-00074D-I7
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 23:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab2IZVvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 17:51:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59361 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513Ab2IZVvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 17:51:08 -0400
Received: (qmail 28061 invoked by uid 107); 26 Sep 2012 21:51:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Sep 2012 17:51:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2012 17:51:06 -0400
Content-Disposition: inline
In-Reply-To: <20120926214653.GA18628@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206450>

We correctly handle completion items with spaces just fine,
since we pass the lists around with newline delimiters.
However, we do not handle filenames with shell
metacharacters, as "compgen -W" performs expansion on the
list we give it.

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, these vectors are not strictly correct, as I think ultimately
we would like to return

  'name with spaces'

with quotes.  But this lets us test that at least the basics work, and
we can update the test vectors later.

It would be nice to test completion on a file with an embedded newline
(which will also not work), but I'm not even sure what the result is
supposed to look like, so I couldn't write a sane test case. Since I
don't plan on fixing that anytime soon anyway, I think it's sane to just
leave it until later if somebody actually cares.

 t/t9902-completion.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2fc833a..cbd0fb6 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -269,4 +269,23 @@ test_expect_success '<ref>: completes paths' '
 	EOF
 '
 
+test_expect_success 'complete tree filename with spaces' '
+	echo content >"name with spaces" &&
+	git add . &&
+	git commit -m spaces &&
+	test_completion_long "git show HEAD:nam" <<-\EOF
+	name with spaces_
+	EOF
+'
+
+test_expect_failure 'complete tree filename with metacharacters' '
+	echo content >"name with \${meta}" &&
+	git add . &&
+	git commit -m meta &&
+	test_completion_long "git show HEAD:nam" <<-\EOF
+	name with ${meta}_
+	name with spaces_
+	EOF
+'
+
 test_done
-- 
1.7.12.10.g31da6dd
