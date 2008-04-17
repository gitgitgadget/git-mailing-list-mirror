From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 5/8] Have a constant extern refspec for "--tags"
Date: Thu, 17 Apr 2008 19:32:35 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804171931590.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 01:33:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmdbj-0003ZA-V4
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 01:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbYDQXci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 19:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755226AbYDQXch
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 19:32:37 -0400
Received: from iabervon.org ([66.92.72.58]:42461 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233AbYDQXcg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 19:32:36 -0400
Received: (qmail 6318 invoked by uid 1000); 17 Apr 2008 23:32:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2008 23:32:35 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79847>

The refspec refs/tags/*:refs/tags/* is sufficiently common and generic
to merit having a constant instead of generating it as needed.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-fetch.c |   10 ++--------
 remote.c        |    9 +++++++++
 remote.h        |    2 ++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 139a6b1..e010fef 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -127,14 +127,8 @@ static struct ref *get_ref_map(struct transport *transport,
 		/* Merge everything on the command line, but not --tags */
 		for (rm = ref_map; rm; rm = rm->next)
 			rm->merge = 1;
-		if (tags == TAGS_SET) {
-			struct refspec refspec;
-			refspec.src = "refs/tags/";
-			refspec.dst = "refs/tags/";
-			refspec.pattern = 1;
-			refspec.force = 0;
-			get_fetch_map(remote_refs, &refspec, &tail, 0);
-		}
+		if (tags == TAGS_SET)
+			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 	} else {
 		/* Use the defaults */
 		struct remote *remote = transport->remote;
diff --git a/remote.c b/remote.c
index 08af7f9..5053b5f 100644
--- a/remote.c
+++ b/remote.c
@@ -2,6 +2,15 @@
 #include "remote.h"
 #include "refs.h"
 
+static struct refspec s_tag_refspec = {
+	0,
+	1,
+	"refs/tags/",
+	"refs/tags/"
+};
+
+const struct refspec *tag_refspec = &s_tag_refspec;
+
 struct counted_string {
 	size_t len;
 	const char *s;
diff --git a/remote.h b/remote.h
index 7e9ae79..d9974fa 100644
--- a/remote.h
+++ b/remote.h
@@ -51,6 +51,8 @@ struct refspec {
 	char *dst;
 };
 
+extern const struct refspec *tag_refspec;
+
 struct ref *alloc_ref(unsigned namelen);
 
 struct ref *copy_ref_list(const struct ref *ref);
-- 
1.5.4.3.610.gea6cd
