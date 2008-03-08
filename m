From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 07/11] Have a constant extern refspec for "--tags"
Date: Sat, 8 Mar 2008 18:04:15 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081804140.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY86w-0008Dx-Mf
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYCHXEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYCHXEU
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:04:20 -0500
Received: from iabervon.org ([66.92.72.58]:42231 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbYCHXES (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:04:18 -0500
Received: (qmail 18598 invoked by uid 1000); 8 Mar 2008 23:04:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:04:15 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76606>

The refspec refs/tags/*:refs/tags/* is sufficiently common and generic
to merit having a constant instead of generating it as needed.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-fetch.c |   10 ++--------
 remote.c        |    9 +++++++++
 remote.h        |    2 ++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 55f611e..5196688 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -125,14 +125,8 @@ static struct ref *get_ref_map(struct transport *transport,
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
index f3f7375..6bd7502 100644
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
index f1dedf1..6ab6a71 100644
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
1.5.4.3.327.g614d7.dirty

