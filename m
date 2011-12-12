From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] mv: make non-directory destination error more clear
Date: Mon, 12 Dec 2011 02:51:36 -0500
Message-ID: <20111212075136.GC17532@sigill.intra.peff.net>
References: <20111212074503.GB16511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 08:51:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra0g2-0007gV-W1
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 08:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab1LLHvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 02:51:50 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48006
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab1LLHvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 02:51:38 -0500
Received: (qmail 30196 invoked by uid 107); 12 Dec 2011 07:58:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 02:58:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 02:51:36 -0500
Content-Disposition: inline
In-Reply-To: <20111212074503.GB16511@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186882>

If you try to "git mv" multiple files onto another
non-directory file, you confusingly get the "usage" message:

  $ touch one two three
  $ git add .
  $ git mv one two three
  usage: git mv [options] <source>... <destination>
  [...]

>From the user's perspective, that makes no sense. They just
gave parameters that exactly match that usage!

This behavior dates back to the original C version of "git
mv", which had a usage message like:

  usage: git mv (<source> <destination> | <source>...  <destination>)

This was slightly less confusing, because it at least
mentions that there are two ways to invoke (but it still
isn't clear why what the user provided doesn't work).

Instead, let's show an error message like:

  $ git mv one two three
  fatal: destination 'three' is not a directory

We could leave the usage message in place, too, but it
doesn't actually help here. It contains no hints that there
are two forms, nor that multi-file form requires that the
endpoint be a directory. So it just becomes useless noise
that distracts from the real error.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 11abaf5..ae6c30c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -94,7 +94,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		destination = copy_pathspec(dest_path[0], argv, argc, 1);
 	} else {
 		if (argc != 1)
-			usage_with_options(builtin_mv_usage, builtin_mv_options);
+			die("destination '%s' is not a directory", dest_path[0]);
 		destination = dest_path;
 	}
 
-- 
1.7.8.13.g74677
