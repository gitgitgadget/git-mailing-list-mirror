From: Jeff King <peff@peff.net>
Subject: [PATCH 8/9] grep: load file data after checking binary-ness
Date: Thu, 2 Feb 2012 03:21:11 -0500
Message-ID: <20120202082111.GH6786@sigill.intra.peff.net>
References: <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:21:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsrux-0000uy-S9
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab2BBIVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:21:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52892
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789Ab2BBIVO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:21:14 -0500
Received: (qmail 17991 invoked by uid 107); 2 Feb 2012 08:28:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:28:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:21:11 -0500
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189600>

Usually we load each file to grep into memory, check whether
it's binary, and then either grep it (the default) or not
(if "-I" was given).

In the "-I" case, we can skip loading the file entirely if
it is marked as binary via gitattributes. On my giant
3-gigabyte media repository, doing "git grep -I foo" went
from:

  real    0m0.712s
  user    0m0.044s
  sys     0m4.780s

to:

  real    0m0.026s
  user    0m0.016s
  sys     0m0.020s

Obviously this is an extreme example. The repo is almost
entirely binary files, and you can see that we spent all of
our time asking the kernel to read() the data. However, with
a cold disk cache, even avoiding a few binary files can have
an impact.

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index a50d161..3821400 100644
--- a/grep.c
+++ b/grep.c
@@ -1019,9 +1019,6 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	}
 	opt->last_shown = 0;
 
-	if (grep_source_load(gs) < 0)
-		return 0;
-
 	switch (opt->binary) {
 	case GREP_BINARY_DEFAULT:
 		if (grep_source_is_binary(gs))
@@ -1042,6 +1039,9 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 
 	try_lookahead = should_lookahead(opt);
 
+	if (grep_source_load(gs) < 0)
+		return 0;
+
 	bol = gs->buf;
 	left = gs->size;
 	while (left) {
-- 
1.7.9.3.gc3fce1.dirty
