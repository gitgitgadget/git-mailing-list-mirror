From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] git-web--browse: avoid the use of eval
Date: Mon, 3 Oct 2011 05:57:31 -0400
Message-ID: <20111003095731.GB16078@sigill.intra.peff.net>
References: <1317516257-24435-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 11:57:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAfHG-0000Z7-Vk
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 11:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab1JCJ5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 05:57:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51520
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434Ab1JCJ5d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 05:57:33 -0400
Received: (qmail 26798 invoked by uid 107); 3 Oct 2011 10:02:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 06:02:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 05:57:31 -0400
Content-Disposition: inline
In-Reply-To: <1317516257-24435-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182647>

On Sun, Oct 02, 2011 at 01:44:17PM +1300, Chris Packham wrote:

> Using eval causes problems when the URL contains an appropriately
> escaped ampersand (\&). Dropping eval from the built-in browser
> invocation avoids the problem.
> 
> Helped-by: Jeff King <peff@peff.net> (test case)
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> 
> ---
> The consensus from the last round of discussion [1] seemed to be to
> remove the eval from the built in browsers but quote custom browser
> commands appropriately.
> 
> I've expanded the tests a little. A semi-colon had the same error as
> the ampersand. A hash was another common character that had meaning in
> a shell and in URL.

This looks good to me. I think we may want to squash in the two tests
below, too, which make sure we treat $browser_path and $browser_cmd
appropriately (the former is a filename, and the latter is a shell
snippet).

diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
index c6f48a9..7906e5d 100755
--- a/t/t9901-git-web--browse.sh
+++ b/t/t9901-git-web--browse.sh
@@ -34,4 +34,33 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+test_expect_success \
+	'browser paths are properly quoted' '
+	echo fake: http://example.com/foo >expect &&
+	cat >"fake browser" <<-\EOF &&
+	#!/bin/sh
+	echo fake: "$@"
+	EOF
+	chmod +x "fake browser" &&
+	git config browser.w3m.path "`pwd`/fake browser" &&
+	git web--browse --browser=w3m \
+		http://example.com/foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success \
+	'browser command allows arbitrary shell code' '
+	echo "arg: http://example.com/foo" >expect &&
+	git config browser.custom.cmd "
+		f() {
+			for i in \"\$@\"; do
+				echo arg: \$i
+			done
+		}
+		f" &&
+	git web--browse --browser=custom \
+		http://example.com/foo >actual &&
+	test_cmp expect actual
+'
+
 test_done
