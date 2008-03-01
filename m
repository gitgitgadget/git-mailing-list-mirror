From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] rename: warn user when we have turned off rename
	detection
Date: Sat, 1 Mar 2008 01:14:31 -0500
Message-ID: <20080301061431.GA27301@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 07:15:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVL0S-0004pK-Hk
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 07:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbYCAGOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 01:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbYCAGOf
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 01:14:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3606 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbYCAGOe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 01:14:34 -0500
Received: (qmail 4682 invoked by uid 111); 1 Mar 2008 06:14:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Mar 2008 01:14:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2008 01:14:31 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75624>


Signed-off-by: Jeff King <peff@peff.net>
---
This was another patch from late in the freeze period. It was in
response to a user getting confused about why rename detection wasn't
happening in a large merge. Is it appropriate to print this for every
rename we try? Or should it just be for merges?

Perhaps we should also bump the default limit from 100, which I think
was just arbitrarily chosen. I posted some numbers in:

  http://mid.gmane.org/20080211113516.GB6344@coredump.intra.peff.net

which imply that 200-400 is probably a more reasonable value. Thoughts?

 diffcore-rename.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3d37725..31941bc 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -468,10 +468,11 @@ void diffcore_rename(struct diff_options *options)
 	 */
 	if (rename_limit <= 0 || rename_limit > 32767)
 		rename_limit = 32767;
-	if (num_create > rename_limit && num_src > rename_limit)
-		goto cleanup;
-	if (num_create * num_src > rename_limit * rename_limit)
+	if ((num_create > rename_limit && num_src > rename_limit) ||
+	    (num_create * num_src > rename_limit * rename_limit)) {
+		warning("too many files, skipping inexact rename detection");
 		goto cleanup;
+	}
 
 	mx = xmalloc(sizeof(*mx) * num_create * num_src);
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
-- 
1.5.4.3.422.g55194
