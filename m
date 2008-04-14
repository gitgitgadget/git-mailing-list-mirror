From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/4] Teach "git clone" to pack refs
Date: Mon, 14 Apr 2008 10:04:16 +0200
Message-ID: <200804141004.16828.johan@herland.net>
References: <200803220210.30957.johan@herland.net>
 <alpine.LNX.1.00.0804140205040.19665@iabervon.org>
 <200804141000.09515.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 10:05:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJhK-0007g0-MA
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 10:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721AbYDNIEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 04:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756695AbYDNIEx
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 04:04:53 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35255 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbYDNIEw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 04:04:52 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZB000172G3CW00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:04:51 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZB009KQ2F5SJ40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:04:17 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZB00KTD2F4M9A0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 10:04:17 +0200 (CEST)
In-reply-to: <200804141000.09515.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79486>

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
1.5.5.159.g8c84b
