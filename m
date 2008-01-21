From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Mon, 21 Jan 2008 00:46:34 -0800
Message-ID: <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Mon Jan 21 09:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGsJG-0003rv-Lu
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 09:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758124AbYAUIqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 03:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758071AbYAUIqp
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 03:46:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973AbYAUIqo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 03:46:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 119DC18CA;
	Mon, 21 Jan 2008 03:46:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 77AC418C9;
	Mon, 21 Jan 2008 03:46:36 -0500 (EST)
In-Reply-To: <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 21 Jan 2008 00:32:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71243>

The mtime recorded in the cache entry is not time_t anymore but
of type (unsigned int).  This casts the comparison and also adds
fuzz factor of 1 second.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With these two patches the t7501 Heisenbug seems to go away.
   I do not understand why this fuzz factor of 1 second helps,
   but it apparently does.  I do not want to commit this before
   I understand why, but it is past my bedtime.

 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9554896..745c3fe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -180,7 +180,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 static int is_racy_timestamp(struct index_state *istate, struct cache_entry *ce)
 {
 	return (istate->timestamp &&
-		istate->timestamp <= ce->ce_mtime);
+		((unsigned int) istate->timestamp) <= ce->ce_mtime + 1);
 }
 
 int ie_match_stat(struct index_state *istate,
-- 
1.5.4.rc4.5.g36a1
