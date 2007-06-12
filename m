From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/3] Add refspec search for push destinations
Date: Mon, 11 Jun 2007 23:10:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706112306340.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 05:11:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxwmg-0005uE-IA
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 05:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbXFLDKw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 23:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbXFLDKw
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 23:10:52 -0400
Received: from iabervon.org ([66.92.72.58]:3096 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbXFLDKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 23:10:52 -0400
Received: (qmail 1960 invoked by uid 1000); 12 Jun 2007 03:10:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2007 03:10:50 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49911>

Also clarifies the comment for tracking refs, and shares the implementation.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |   17 ++++++++++++++---
 remote.h |    9 ++++++++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 1fbceeb..b6d6fd6 100644
--- a/remote.c
+++ b/remote.c
@@ -339,11 +339,12 @@ int remote_has_uri(struct remote *remote, const char *uri)
 	return 0;
 }
 
-int remote_find_tracking(struct remote *remote, struct refspec *refspec)
+static int find_refspec(struct refspec *refspecs, int refspec_nr,
+			struct refspec *refspec)
 {
 	int i;
-	for (i = 0; i < remote->fetch_refspec_nr; i++) {
-		struct refspec *fetch = &remote->fetch[i];
+	for (i = 0; i < refspec_nr; i++) {
+		struct refspec *fetch = &refspecs[i];
 		if (!fetch->dst)
 			continue;
 		if (fetch->pattern) {
@@ -370,6 +371,16 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 	return -1;
 }
 
+int remote_find_tracking(struct remote *remote, struct refspec *refspec)
+{
+	return find_refspec(remote->fetch, remote->fetch_refspec_nr, refspec);
+}
+
+int remote_find_push(struct remote *remote, struct refspec *refspec)
+{
+	return find_refspec(remote->push, remote->push_refspec_nr, refspec);
+}
+
 static int count_refspec_match(const char *pattern,
 			       struct ref *refs,
 			       struct ref **matched_ref)
diff --git a/remote.h b/remote.h
index 14615e8..01f83b7 100644
--- a/remote.h
+++ b/remote.h
@@ -34,10 +34,17 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, char **refspec, int all);
 
 /*
- * For the given remote, reads the refspec's src and sets the other fields.
+ * For the given remote, reads the refspec's src and sets the other
+ * fields for a fetch refspec.
  */
 int remote_find_tracking(struct remote *remote, struct refspec *refspec);
 
+/*
+ * For the given remote, reads the refspec's src and sets the other
+ * fields for a push refspec.
+ */
+int remote_find_push(struct remote *remote, struct refspec *refspec);
+
 struct branch {
 	const char *name;
 	const char *refname;
-- 
1.5.2.901.g27ad4-dirty
