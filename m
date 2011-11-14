From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] refresh_index: notice typechanges in output
Date: Mon, 14 Nov 2011 17:56:51 -0500
Message-ID: <20111114225651.GD3993@sigill.intra.peff.net>
References: <20111114225056.GA27370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:56:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ5SU-0005IY-Sb
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 23:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab1KNW4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 17:56:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41342
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab1KNW4x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 17:56:53 -0500
Received: (qmail 702 invoked by uid 107); 14 Nov 2011 22:56:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 17:56:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 17:56:51 -0500
Content-Disposition: inline
In-Reply-To: <20111114225056.GA27370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185415>

If a file changes type and a porcelain updates the index, we
will print "M file". Instead, let's be more specific and
print "T file", which matches actual diff and status output.

The plumbing version remains "needs update" for historical
compatibility.

Signed-off-by: Jeff King <peff@peff.net>
---
The "changed" flag comes from refresh_cache_ent, which in turn gets it
from ie_modified_stat. The one hesitation I have is that intent-to-add
entries get the TYPE_CHANGED flag set, which means they will get a "T"
output. Whereas I actually think "M" is a little more sensible.

For "git reset", I'm not sure if it matters, since resetting the index
will always drop such an entry anyway. But you can see it with:

  git add -N file
  git add --refresh -v other

 read-cache.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 83fb19c..0e17add 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1107,14 +1107,17 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
 	const char *modified_fmt;
 	const char *deleted_fmt;
+	const char *typechange_fmt;
 	const char *unmerged_fmt;
 
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
+	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
 	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
 		int cache_errno = 0;
+		int changed = 0;
 
 		ce = istate->cache[i];
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
@@ -1135,7 +1138,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 		if (pathspec && !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
 			continue;
 
-		new = refresh_cache_ent(istate, ce, options, &cache_errno, NULL);
+		new = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
 		if (new == ce)
 			continue;
 		if (!new) {
@@ -1151,6 +1154,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			if (quiet)
 				continue;
 			show_file((cache_errno == ENOENT ? deleted_fmt :
+				   changed & TYPE_CHANGED ? typechange_fmt :
 				   modified_fmt),
 				  ce->name, in_porcelain, &first, header_msg);
 			has_errors = 1;
-- 
1.7.7.3.8.g38efa
