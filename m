From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/3] Teach "git clone" to pack refs
Date: Sat, 22 Mar 2008 02:13:54 +0100
Message-ID: <200803220213.54923.johan@herland.net>
References: <200803220210.30957.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 02:15:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcsKP-0005tv-D4
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 02:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbYCVBOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 21:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbYCVBOl
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 21:14:41 -0400
Received: from smtp.getmail.no ([84.208.20.33]:36909 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125AbYCVBOk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 21:14:40 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JY30070BY4GTL00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:14:40 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY3000ULY378Q30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:13:55 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY3001ZBY36JS30@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:13:55 +0100 (CET)
In-reply-to: <200803220210.30957.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77783>

In repos with many refs, it is unlikely that most refs will ever change.
This fact is already exploited by "git gc" by executing "git pack-refs"
to consolidate all refs into a single file.

When cloning a repo with many refs, it does not make sense to create the
loose refs in the first place, just to have the next "git gc" consolidate
them into one file. Instead, make "git clone" create the packed refs file
immediately, and forego the loose refs completely.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-clone.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 0a9c873..01c595e 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -18,6 +18,7 @@
 #include "transport.h"
 #include "strbuf.h"
 #include "dir.h"
+#include "pack-refs.h"
 
 /*
  * Overall FIXMEs:
@@ -313,8 +314,11 @@ static struct ref *write_remote_refs(const struct ref *refs, struct refspec *ref
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
1.5.5.rc0.117.ga5237
