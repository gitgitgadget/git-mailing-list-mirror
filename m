From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH 3/3] Add shortcut in refresh_cache_ent() for marked entries.
Date: Fri, 30 May 2008 14:38:35 +0200
Message-ID: <c581c03d8d8bfc76753018d4399a79b02a057186.1212152269.git.marius@trolltech.com>
References: <3088e5a9507aa55ee55f512fb3bd554f1658d2e3.1212152269.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 30 15:09:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K24MX-00082U-AK
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 15:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbYE3NIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 09:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbYE3NIs
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 09:08:48 -0400
Received: from hoat.troll.no ([62.70.27.150]:46295 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbYE3NIr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 09:08:47 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id C8FAE20C34;
	Fri, 30 May 2008 15:08:46 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id BAF0220C0C;
	Fri, 30 May 2008 15:08:46 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83296>

When a cache entry has been marked as CE_VALID, the user has
promised us that any change in the work tree does not matter.
Just mark the entry as up-to-date, and continue.

Done-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 read-cache.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index ac9a8e7..8e5fbb6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -893,6 +893,15 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	if (ce_uptodate(ce))
 		return ce;
 
+	/*
+	 * CE_VALID means the user promised us that the change to
+	 * the work tree does not matter and told us not to worry.
+	 */
+	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
+		ce_mark_uptodate(ce);
+		return ce;
+	}
+
 	if (lstat(ce->name, &st) < 0) {
 		if (err)
 			*err = errno;
-- 
1.5.5.GIT
