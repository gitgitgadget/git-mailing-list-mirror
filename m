From: mhagger@alum.mit.edu
Subject: [PATCH 4/4] write_remote_refs(): create packed (rather than extra) refs
Date: Tue, 17 Jan 2012 06:50:34 +0100
Message-ID: <1326779434-20106-5-git-send-email-mhagger@alum.mit.edu>
References: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 06:51:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn1wq-00060x-UD
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 06:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158Ab2AQFvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 00:51:05 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50019 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab2AQFvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 00:51:03 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEDA74.dip.t-dialin.net [84.190.218.116])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0H5oam6006829;
	Tue, 17 Jan 2012 06:50:44 +0100
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188688>

From: Michael Haggerty <mhagger@alum.mit.edu>

write_remote_refs() creates new packed refs from references obtained
from the remote repository, which is "out of thin air" as far as the
local repository is concerned.  Previously it did this by creating
"extra" refs, then calling pack_refs() to bake them into the
packed-refs file.  Instead, create packed refs (in the packed
reference cache) directly, then call pack_refs().

Aside from being more logical, this is another step towards removing
extra refs entirely.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/clone.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 86db954..9413537 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -441,11 +441,10 @@ static void write_remote_refs(const struct ref *local_refs)
 	for (r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
 			continue;
-		add_extra_ref(r->peer_ref->name, r->old_sha1, 0);
+		add_packed_ref(r->peer_ref->name, r->old_sha1);
 	}
 
 	pack_refs(PACK_REFS_ALL);
-	clear_extra_refs();
 }
 
 static int write_one_config(const char *key, const char *value, void *data)
-- 
1.7.8.3
