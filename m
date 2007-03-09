From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] git-bundle: die if the bundle is empty.
Date: Thu, 08 Mar 2007 22:51:56 -0500
Message-ID: <11734123161927-git-send-email-mdl123@verizon.net>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Cc: junkio@cox.net, git@vger.kernel.org,
	Mark Levedahl <mdl123@verizon.net>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Mar 09 04:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPW9f-0001iz-BA
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 04:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbXCIDwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 22:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXCIDwS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 22:52:18 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:35532 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbXCIDwS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 22:52:18 -0500
Received: from fal-l07294-lp.us.ray.com ([206.166.206.34])
 by vms046.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JEM00HQDAQFJ7N2@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 08 Mar 2007 21:51:54 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: git-send-email 1.5.0.3.927.g2432c-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41786>

A common use of bundle is to schedule nightly emailed updates to a remote
system containing all updates made over a given period. We want bundle
to complain only if the resulting bundle would be empty, but not if at
least one of the given refs has an update resulting in a non-empty bundle.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 builtin-bundle.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index c85f996..b888a9f 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -261,6 +261,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv)
 {
 	int bundle_fd = -1;
+	int isempty = 1;
 	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
 	const char **argv_pack = xmalloc(5 * sizeof(const char *));
 	int pid, in, out, i, status;
@@ -328,17 +329,17 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		 * other limiting options could have prevented all the tips
 		 * from getting output.
 		 */
-		if (!(e->item->flags & SHOWN)) {
-			warn("ref '%s' is excluded by the rev-list options",
-				e->name);
-			continue;
+		if ((e->item->flags & SHOWN)) {
+			isempty = 0;
+			write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
+			write_or_die(bundle_fd, " ", 1);
+			write_or_die(bundle_fd, ref, strlen(ref));
+			write_or_die(bundle_fd, "\n", 1);
 		}
-		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
-		write_or_die(bundle_fd, " ", 1);
-		write_or_die(bundle_fd, ref, strlen(ref));
-		write_or_die(bundle_fd, "\n", 1);
 		free(ref);
 	}
+	if (isempty)
+		die("Bundle is empty");
 
 	/* end header */
 	write_or_die(bundle_fd, "\n", 1);
-- 
1.5.0.3.927.g2432c-dirty
