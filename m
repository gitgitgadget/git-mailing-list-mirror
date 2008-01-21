From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] read-cache.c: introduce is_racy_timestamp() helper
Date: Mon, 21 Jan 2008 00:44:50 -0800
Message-ID: <7v4pd71sal.fsf_-_@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	<7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>
	<7vd4rv3ds5.fsf@gitster.siamese.dyndns.org>
	<7vtzl71x1c.fsf@gitster.siamese.dyndns.org>
	<7vprvv1wnu.fsf@gitster.siamese.dyndns.org>
	<7vlk6j1wjj.fsf@gitster.siamese.dyndns.org>
	<7vhch71vvb.fsf@gitster.siamese.dyndns.org>
	<7v8x2j1sul.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 09:45:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGsHz-0003Zo-G2
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 09:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241AbYAUIpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 03:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757973AbYAUIpH
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 03:45:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63277 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758181AbYAUIpB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 03:45:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 829CF3F4F;
	Mon, 21 Jan 2008 03:44:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C93C03F4B;
	Mon, 21 Jan 2008 03:44:56 -0500 (EST)
In-Reply-To: <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 21 Jan 2008 00:32:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71242>

This just moves a common boolean expression into a helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f5f9c3d..9554896 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -177,6 +177,12 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	return changed;
 }
 
+static int is_racy_timestamp(struct index_state *istate, struct cache_entry *ce)
+{
+	return (istate->timestamp &&
+		istate->timestamp <= ce->ce_mtime);
+}
+
 int ie_match_stat(struct index_state *istate,
 		  struct cache_entry *ce, struct stat *st,
 		  unsigned int options)
@@ -210,9 +216,7 @@ int ie_match_stat(struct index_state *istate,
 	 * whose mtime are the same as the index file timestamp more
 	 * carefully than others.
 	 */
-	if (!changed &&
-	    istate->timestamp &&
-	    istate->timestamp <= ce->ce_mtime) {
+	if (!changed && is_racy_timestamp(istate, ce)) {
 		if (assume_racy_is_modified)
 			changed |= DATA_CHANGED;
 		else
@@ -1207,8 +1211,7 @@ int write_index(struct index_state *istate, int newfd)
 		struct cache_entry *ce = cache[i];
 		if (ce->ce_flags & CE_REMOVE)
 			continue;
-		if (istate->timestamp &&
-		    istate->timestamp <= ce->ce_mtime)
+		if (is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
 		if (ce_write_entry(&c, newfd, ce) < 0)
 			return -1;
-- 
1.5.4.rc4.5.g36a1
