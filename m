From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 2/2] fetch: Speed up fetch of large numbers of refs
Date: Sun, 25 Oct 2009 21:28:12 +0000
Message-ID: <20091025212813.48498.87676.julian@quantumfyre.co.uk>
References: <20091025212449.48498.23208.julian@quantumfyre.co.uk>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 22:34:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Aj0-0000J6-Ro
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 22:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbZJYVd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 17:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754206AbZJYVd4
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 17:33:56 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:52688 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754159AbZJYVd4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 17:33:56 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 3711D34BFA1
	for <git@vger.kernel.org>; Sun, 25 Oct 2009 21:33:59 +0000 (GMT)
Received: (qmail 11308 invoked by uid 103); 25 Oct 2009 21:28:25 +0000
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9936. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.026318 secs); 25 Oct 2009 21:28:25 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 25 Oct 2009 21:28:25 +0000
X-git-sha1: ccbf4a1f8608ad74d81e9eb760e1edfe168fd7a5 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20091025212449.48498.23208.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131239>

When there are large numbers of refs, calling read_ref for each ref is
inefficent (and infact downright slow) - so instead use for_each_ref
to build up a string list of all the refs that we currently have,
which significantly improves the volume.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin-fetch.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index acb08e4..0f53cbd 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -489,7 +489,8 @@ static int add_existing(const char *refname, const unsigned char *sha1,
 			int flag, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
-	string_list_insert(refname, list);
+	struct string_list_item *item = string_list_insert(refname, list);
+	item->util = (void *)sha1;
 	return 0;
 }
 
@@ -606,9 +607,14 @@ static void check_not_current_branch(struct ref *ref_map)
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
+	struct string_list existing_refs = { NULL, 0, 0, 0 };
+	struct string_list_item *peer_item = NULL;
 	struct ref *ref_map;
 	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
+
+	for_each_ref(add_existing, &existing_refs);
+
 	if (transport->remote->fetch_tags == 2 && tags != TAGS_UNSET)
 		tags = TAGS_SET;
 	if (transport->remote->fetch_tags == -1)
@@ -631,8 +637,13 @@ static int do_fetch(struct transport *transport,
 		check_not_current_branch(ref_map);
 
 	for (rm = ref_map; rm; rm = rm->next) {
-		if (rm->peer_ref)
-			read_ref(rm->peer_ref->name, rm->peer_ref->old_sha1);
+		if (rm->peer_ref) {
+			peer_item = string_list_lookup(rm->peer_ref->name,
+						       &existing_refs);
+			if (peer_item)
+				hashcpy(rm->peer_ref->old_sha1,
+					peer_item->util);
+		}
 	}
 
 	if (tags == TAGS_DEFAULT && autotags)
-- 
1.6.5.rc2
