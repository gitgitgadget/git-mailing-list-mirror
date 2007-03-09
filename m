From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] git-bundle: prevent overwriting existing bundles
Date: Fri, 9 Mar 2007 03:50:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703090348480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 03:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPVBN-0003h3-TC
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 03:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992905AbXCICuJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 21:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992906AbXCICuJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 21:50:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:60702 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992905AbXCICuI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 21:50:08 -0500
Received: (qmail invoked by alias); 09 Mar 2007 02:50:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 09 Mar 2007 03:50:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AUXh/CrYAvbH5tB6DdCLAct+cAldS4yinWY8t6v
	t5faDGCqhFuO9B
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41782>


Not only does it prevent accidentally losing older bundles, but it
also fixes a subtle bug: when writing into an existing bundle,
git-pack-objects would not truncate the bundle. Therefore,
fetching from the bundle would trigger an error in unpack-objects:
"fatal: pack has junk at the end".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Alternatively, we could use O_TRUNC instead of O_EXCL, but
	I think it makes sense to refuse to overwrite existing
	bundles.

	Mark, I guess this is what triggered the bug you were reporting.

 builtin-bundle.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index ca3de60..5ebba0b 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -268,9 +268,9 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	struct rev_info revs;
 
 	bundle_fd = (!strcmp(path, "-") ? 1 :
-			open(path, O_CREAT | O_WRONLY, 0666));
+			open(path, O_CREAT | O_EXCL | O_WRONLY, 0666));
 	if (bundle_fd < 0)
-		return error("Could not write to '%s'", path);
+		return error("Could not create '%s'", path);
 
 	/* write signature */
 	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
-- 
1.5.0.3.2601.gc1e5-dirty
