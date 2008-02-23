From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] checkout: error out when index is unmerged even with -m
Date: Sat, 23 Feb 2008 15:45:19 -0800
Message-ID: <7voda7xmnk.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802231323590.21332@woody.linux-foundation.org>
 <7v8x1b1fiu.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802231430100.21332@woody.linux-foundation.org>
 <7vzltrz4cl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT44H-00080v-Lg
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbYBWXpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbYBWXpd
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:45:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbYBWXpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:45:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 674101813;
	Sat, 23 Feb 2008 18:45:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 82E0C1812; Sat, 23 Feb 2008 18:45:22 -0500 (EST)
In-Reply-To: <7vzltrz4cl.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 23 Feb 2008 14:37:46 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74884>

Even when -m is given to allow fallilng back to 3-way merge
while switching branches, we should refuse if the original index
is unmerged.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I think this bug was inherited from the scripted version.
   Fixing it is much easier here.

 builtin-checkout.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 283831e..e028270 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -226,8 +226,8 @@ static int merge_working_tree(struct checkout_opts *opts,
 		refresh_cache(REFRESH_QUIET);
 
 		if (unmerged_cache()) {
-			ret = opts->merge ? -1 :
-				error("you need to resolve your current index first");
+			error("you need to resolve your current index first");
+			return 1;
 		} else {
 			topts.update = 1;
 			topts.merge = 1;
