From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/4] Teach "git clone" to pack refs
Date: Sun, 15 Jun 2008 16:06:16 +0200
Message-ID: <200806151606.16380.johan@herland.net>
References: <200806151602.03445.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 16:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7stK-00014w-BH
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 16:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758240AbYFOOG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 10:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758041AbYFOOG2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 10:06:28 -0400
Received: from smtp.getmail.no ([84.208.20.33]:56914 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757571AbYFOOG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 10:06:27 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I0090LCIR2Q00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:06:27 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I006X5CIG9V50@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:06:16 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I009RVCIGTZ30@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:06:16 +0200 (CEST)
In-reply-to: <200806151602.03445.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85098>

In repos with many refs, it is unlikely that most refs will ever change.
This fact is already exploited by "git gc" by executing "git pack-refs"
to consolidate all refs into a single file.

When cloning a repo with many refs, it does not make sense to create the
loose refs in the first place, just to have the next "git gc" consolidate
them into one file. Instead, make "git clone" create the packed refs file
immediately, and forego the loose refs completely.

Signed-off-by: Johan Herland <johan@herland.net>
Acked-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-clone.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 7190952..5c5acb4 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -18,6 +18,7 @@
 #include "transport.h"
 #include "strbuf.h"
 #include "dir.h"
+#include "pack-refs.h"
 
 /*
  * Overall FIXMEs:
@@ -321,8 +322,11 @@ static struct ref *write_remote_refs(const struct ref *refs,
 	get_fetch_map(refs, tag_refspec, &tail, 0);
 
 	for (r = local_refs; r; r = r->next)
-		update_ref(reflog,
-			   r->peer_ref->name, r->old_sha1, NULL, 0, DIE_ON_ERR);
+		add_extra_ref(r->peer_ref->name, r->old_sha1, 0);
+
+	pack_refs(PACK_REFS_ALL);
+	clear_extra_refs();
+
 	return local_refs;
 }
 
-- 
1.5.6.rc2.128.gf64ae
