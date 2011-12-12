From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] mv: be quiet about overwriting
Date: Mon, 12 Dec 2011 02:54:07 -0500
Message-ID: <20111212075407.GE17532@sigill.intra.peff.net>
References: <20111212074503.GB16511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 08:54:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra0iF-0008JP-Nz
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 08:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab1LLHyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 02:54:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48013
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab1LLHyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 02:54:09 -0500
Received: (qmail 30273 invoked by uid 107); 12 Dec 2011 08:00:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 03:00:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 02:54:07 -0500
Content-Disposition: inline
In-Reply-To: <20111212074503.GB16511@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186884>

When a user asks us to force a mv and overwrite the
destination, we print a warning. However, since a typical
use would be:

  $ git mv one two
  fatal: destination exists, source=one, destination=two
  $ git mv -f one two
  warning: destination exists (will overwrite), source=one, destination=two

this warning is just noise. We already know we're
overwriting; that's why we gave -f!

This patch silences the warning unless "--verbose" is given.

Signed-off-by: Jeff King <peff@peff.net>
---
You could perhaps argue that it is useful in the case of moving multiple
files into a directory (since it tells you _which_ files were
overwritten). We could turn the warning on in that case, but I'm
inclined to leave it. If the user cares about this information, they can
use "-v" along with "-f".

 builtin/mv.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index c9ecb03..b6e7e4f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -177,8 +177,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				 * check both source and destination
 				 */
 				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-					warning(_("%s (will overwrite), source=%s, destination=%s"),
-						bad, src, dst);
+					if (verbose)
+						warning(_("%s (will overwrite), source=%s, destination=%s"),
+							bad, src, dst);
 					bad = NULL;
 				} else
 					bad = _("Cannot overwrite");
-- 
1.7.8.13.g74677
