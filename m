From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Fri, 15 Jun 2012 15:13:53 -0400
Message-ID: <20120615191353.GA26473@sigill.intra.peff.net>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
 <20120615184030.GC14843@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 21:14:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfby6-0005C2-Rr
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 21:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab2FOTN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 15:13:57 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57696
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757460Ab2FOTN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 15:13:57 -0400
Received: (qmail 2619 invoked by uid 107); 15 Jun 2012 19:13:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 15:13:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 15:13:53 -0400
Content-Disposition: inline
In-Reply-To: <20120615184030.GC14843@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200082>

On Fri, Jun 15, 2012 at 02:40:30PM -0400, Jeff King wrote:

> I suspect what you actually want is to set DIFF_FROM_CONTENTS in the
> no-index case, since we by definition do not have a pair of sha1s to
> compare. But it may also be that diff.c could detect this case
> automatically. I'd have to look closer.

This works for me:

diff --git a/diff.c b/diff.c
index 77edd50..27231d2 100644
--- a/diff.c
+++ b/diff.c
@@ -3228,7 +3228,8 @@ int diff_setup_done(struct diff_options *options)
 
 	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
 	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
-	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
+	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL) ||
+	    DIFF_OPT_TST(options, NO_INDEX))
 		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
 	else
 		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);

One could also set DIFF_FROM_CONTENTS manually in diff_on_index, but
note that diff_setup_done unsets it (which seems odd; who would have set
it in the first place if they did not want to override it? I think that
else clause can simply be dropped).

-Peff

PS Your test should probably be spelled with test_expect_code, like:

diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index cdb9202..0b83235 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -77,4 +77,8 @@ test_expect_success 'git diff-index --cached HEAD' '
 	}
 '
 
+test_expect_success 'git diff <tracked file> <file outside repo>' '
+	test_expect_code 1 git diff --quiet c /dev/null
+'
+
 test_done
