From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] fsck: fix broken loose object check.
Date: Mon, 05 Mar 2007 00:21:24 -0800
Message-ID: <7v3b4k2j97.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 09:21:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8Rk-0007cA-UN
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbXCEIV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 03:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbXCEIV0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:21:26 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59964 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbXCEIVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 03:21:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305082125.IWYX24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 03:21:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WwMQ1W00J1kojtg0000000; Mon, 05 Mar 2007 03:21:24 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41412>

When "git fsck" without --full found a loose object missing
because it was broken, it mistakenly thought it was not parsed
because we found it in one of the packs.  Back when this code
was written, we did not have a way to explicitly check if we
have the object in pack, but we do now.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-fsck.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 6abf498..abdd0f2 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -67,7 +67,7 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!obj->parsed) {
-		if (has_sha1_file(obj->sha1))
+		if (has_sha1_pack(obj->sha1, NULL))
 			return; /* it is in pack - forget about it */
 		printf("missing %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
 		return;
-- 
1.5.0.3.855.ga3b2
