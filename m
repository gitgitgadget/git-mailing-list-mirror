From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 1/2] remote: Make ref_remove_duplicates faster for large
	numbers of refs
Date: Sun, 25 Oct 2009 21:28:11 +0000
Message-ID: <20091025212813.48498.51868.julian@quantumfyre.co.uk>
References: <20091025212449.48498.23208.julian@quantumfyre.co.uk>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 22:32:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Ahm-0008I3-4O
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 22:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbZJYVck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 17:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbZJYVck
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 17:32:40 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:52685 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754143AbZJYVck (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 17:32:40 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 6E8A1360CB5
	for <git@vger.kernel.org>; Sun, 25 Oct 2009 21:32:44 +0000 (GMT)
Received: (qmail 11298 invoked by uid 103); 25 Oct 2009 21:28:25 +0000
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9936. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025193 secs); 25 Oct 2009 21:28:25 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 25 Oct 2009 21:28:25 +0000
X-git-sha1: 5d69b7601f96152ceefb826726402c01f71436b3 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20091025212449.48498.23208.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131238>

The ref_remove_duplicates function was very slow at dealing with very
large numbers of refs.  This is because it was using a linear search
through all remaining refs to find any duplicates of the current ref.

Rewriting it to use a string list to keep track of which refs have
already been seen and removing duplicates when they are found is much
more efficient.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 remote.c |   42 +++++++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/remote.c b/remote.c
index 73d33f2..1380b20 100644
--- a/remote.c
+++ b/remote.c
@@ -6,6 +6,7 @@
 #include "revision.h"
 #include "dir.h"
 #include "tag.h"
+#include "string-list.h"
 
 static struct refspec s_tag_refspec = {
 	0,
@@ -734,29 +735,32 @@ int for_each_remote(each_remote_fn fn, void *priv)
 
 void ref_remove_duplicates(struct ref *ref_map)
 {
-	struct ref **posn;
-	struct ref *next;
-	for (; ref_map; ref_map = ref_map->next) {
+	struct string_list refs = { NULL, 0, 0, 0 };
+	struct string_list_item *item = NULL;
+	struct ref *prev = NULL, *next = NULL;
+	for (; ref_map; ref_map = next) {
+		next = ref_map->next;
 		if (!ref_map->peer_ref)
 			continue;
-		posn = &ref_map->next;
-		while (*posn) {
-			if ((*posn)->peer_ref &&
-			    !strcmp((*posn)->peer_ref->name,
-				    ref_map->peer_ref->name)) {
-				if (strcmp((*posn)->name, ref_map->name))
-					die("%s tracks both %s and %s",
-					    ref_map->peer_ref->name,
-					    (*posn)->name, ref_map->name);
-				next = (*posn)->next;
-				free((*posn)->peer_ref);
-				free(*posn);
-				*posn = next;
-			} else {
-				posn = &(*posn)->next;
-			}
+
+		item = string_list_lookup(ref_map->peer_ref->name, &refs);
+		if (item) {
+			if (strcmp(((struct ref *)item->util)->name,
+				   ref_map->name))
+				die("%s tracks both %s and %s",
+				    ref_map->peer_ref->name,
+				    ((struct ref *)item->util)->name,
+				    ref_map->name);
+			prev->next = ref_map->next;
+			free(ref_map->peer_ref);
+			free(ref_map);
 		}
+
+		item = string_list_insert(ref_map->peer_ref->name, &refs);
+		item->util = ref_map;
+		prev = ref_map;
 	}
+	string_list_clear(&refs, 0);
 }
 
 int remote_has_url(struct remote *remote, const char *url)
-- 
1.6.5.rc2
