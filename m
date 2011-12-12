From: Jeff King <peff@peff.net>
Subject: [PATCHv2 4/5] mv: improve overwrite warning
Date: Mon, 12 Dec 2011 16:54:17 -0500
Message-ID: <20111212215417.GA18310@sigill.intra.peff.net>
References: <20111212215238.GD9754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:54:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDpJ-0006KC-1n
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195Ab1LLVyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:54:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48351
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167Ab1LLVyU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:54:20 -0500
Received: (qmail 5890 invoked by uid 107); 12 Dec 2011 22:01:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 17:01:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 16:54:17 -0500
Content-Disposition: inline
In-Reply-To: <20111212215238.GD9754@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186960>

When we try to "git mv" over an existing file, the error
message is fairly informative:

  $ git mv one two
  fatal: destination exists, source=one, destination=two

When the user forces the overwrite, we give a warning:

  $ git mv -f one two
  warning: destination exists; will overwrite!

This is less informative, but still sufficient in the simple
rename case, as there is only one rename happening.

But when moving files from one directory to another, it
becomes useless:

  $ mkdir three
  $ touch one two three/one
  $ git add .
  $ git mv one two three
  fatal: destination exists, source=one, destination=three/one
  $ git mv -f one two three
  warning: destination exists; will overwrite!

The first message is helpful, but the second one gives us no
clue about what was overwritten. Let's mention the name of
the destination file:

  $ git mv -f one two three
  warning: overwriting 'three/one'

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index ae6c30c..8dd5a45 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -177,7 +177,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				 * check both source and destination
 				 */
 				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-					warning(_("%s; will overwrite!"), bad);
+					warning(_("overwriting '%s'"), dst);
 					bad = NULL;
 				} else
 					bad = _("Cannot overwrite");
-- 
1.7.8.13.g74677
