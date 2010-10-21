From: Jeff King <peff@peff.net>
Subject: [PATCH] diff: report bogus input to -C/-M/-B
Date: Thu, 21 Oct 2010 10:49:47 -0400
Message-ID: <20101021144947.GA18210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 16:51:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8wU6-00053N-0g
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 16:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab0JUOtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 10:49:08 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55241 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178Ab0JUOtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 10:49:07 -0400
Received: (qmail 5996 invoked by uid 111); 21 Oct 2010 14:49:05 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 Oct 2010 14:49:05 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Oct 2010 10:49:47 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159511>

We already detect invalid input to these functions, but we
simply exit with an error code, never saying anything as
simple as "your input was wrong". Let's fix that.

Before:

  $ git diff -CM
  $ echo $?
  128

After:

  $ git diff -CM
  error: invalid argument to -C: M
  $ echo $?
  128

There should be no problems with having diff_opt_parse print
to stderr, as there is already precedent in complaining
about bogus --color and --output arguments.

Signed-off-by: Jeff King <peff@peff.net>
---
More old patch potpourri. Original thread:

  http://article.gmane.org/gmane.comp.version-control.git/146570

I think this one just got overlooked.

 diff.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 71efa8e..8487643 100644
--- a/diff.c
+++ b/diff.c
@@ -3142,18 +3142,18 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	/* renames options */
 	else if (!prefixcmp(arg, "-B")) {
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
-			return -1;
+			return error("invalid argument to -B: %s", arg+2);
 	}
 	else if (!prefixcmp(arg, "-M")) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-			return -1;
+			return error("invalid argument to -M: %s", arg+2);
 		options->detect_rename = DIFF_DETECT_RENAME;
 	}
 	else if (!prefixcmp(arg, "-C")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-			return -1;
+			return error("invalid argument to -C: %s", arg+2);
 		options->detect_rename = DIFF_DETECT_COPY;
 	}
 	else if (!strcmp(arg, "--no-renames"))
-- 
1.7.3.1.235.gdd6c0
