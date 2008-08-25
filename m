From: Jeff King <peff@peff.net>
Subject: [PATCH] format-patch: use default diff format even with patch
	options
Date: Sun, 24 Aug 2008 22:10:29 -0400
Message-ID: <20080825021029.GA28355@coredump.intra.peff.net>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080825013837.GA17201@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 04:12:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXRYq-00085g-Mg
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 04:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbYHYCKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 22:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbYHYCKd
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 22:10:33 -0400
Received: from peff.net ([208.65.91.99]:3054 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbYHYCKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 22:10:33 -0400
Received: (qmail 15780 invoked by uid 111); 25 Aug 2008 02:10:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Aug 2008 22:10:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Aug 2008 22:10:29 -0400
Content-Disposition: inline
In-Reply-To: <20080825013837.GA17201@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93587>

On Sun, Aug 24, 2008 at 09:38:37PM -0400, Jeff King wrote:

> This was generated with -U5 to make the first hunk easier to read.

And while doing that, I detected another bug. Or maybe a feature,
depending on your perspective.

-- >8 --
format-patch: use default diff format even with patch options

Previously, running "git format-patch -U5" would cause the
low-level diff machinery to change the diff output format
from "not specified" to "patch". This meant that
format-patch thought we explicitly specified a diff output
format, and would not use the default format. The resulting
message lacked both the diffstat and the summary, as well as
the separating "---".

Now format-patch explicitly checks for this condition and
uses the default. That means that "git format-patch -p" will
now have the "-p" ignored.

Signed-off-by: Jeff King <peff@peff.net>
---
Maybe this is intentional, and that by asking for "-U" I am explicitly
saying "I really want the patch format, not the default." But I think
this more reasonably maps to what the user expects.

I am a little uncomfortable hurting anyone who thought that
"format-patch -p" was a good idea. OTOH:

  1. I have to question why they were using format-patch in the first
     place. Probably git-log --pretty=email would be a better fit.

  2. Their mails were already broken, since the presence of the diffstat
     is what triggers the "---" divider.

 builtin-log.c           |    3 ++-
 t/t4014-format-patch.sh |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 9204ffd..1d3c5cb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -932,7 +932,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
-	if (!rev.diffopt.output_format)
+	if (!rev.diffopt.output_format
+		|| rev.diffopt.output_format == DIFF_FORMAT_PATCH)
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY | DIFF_FORMAT_PATCH;
 
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7fe853c..9d99dc2 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -230,4 +230,29 @@ test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 
 '
 
+cat > expect << EOF
+---
+ file |   16 ++++++++++++++++
+ 1 files changed, 16 insertions(+), 0 deletions(-)
+
+diff --git a/file b/file
+index 40f36c6..2dc5c23 100644
+--- a/file
++++ b/file
+@@ -13,4 +13,20 @@ C
+ 10
+ D
+ E
+ F
++5
+EOF
+
+test_expect_success 'format-patch respects -U' '
+
+	git format-patch -U4 -2 &&
+	sed -e "1,/^$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
+	test_cmp expect output
+
+'
+
 test_done
-- 
1.6.0.150.gc3242.dirty
