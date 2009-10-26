From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 3/2] remote: fix poential ref_map list corruption in
	ref_remove_duplicates
Date: Mon, 26 Oct 2009 23:12:14 +0000
Message-ID: <20091026231215.91316.47162.julian@quantumfyre.co.uk>
References: <20091025212449.48498.23208.julian@quantumfyre.co.uk>
	<20091025212813.48498.51868.julian@quantumfyre.co.uk>
Cc: git@vger.kernel.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 00:17:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Yp2-0008Mn-8A
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 00:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722AbZJZXRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754702AbZJZXRo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 19:17:44 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44446 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754651AbZJZXRn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 19:17:43 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 4BAB636729C
	for <git@vger.kernel.org>; Mon, 26 Oct 2009 23:17:47 +0000 (GMT)
Received: (qmail 19472 invoked by uid 103); 26 Oct 2009 23:16:19 +0000
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9940. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025049 secs); 26 Oct 2009 23:16:19 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 26 Oct 2009 23:16:19 +0000
X-git-sha1: 53a76e18164c57c2a41ccc7b19bdac79e2075ee7 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20091025212813.48498.51868.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131283>

The prev pointer was not being updated when the peer_ref member
pointer was NULL, which means that that any items in the list with a
NULL peer_ref immediately preceeding a duplicate would be dropped
without being freed.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

Having fixed the access after free bug, I realised that there was
still a problem.  This one didn't show up in the tests - due to the
rather specific circumstances required, but may occur in real use.

 remote.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 1380b20..4f9f0cc 100644
--- a/remote.c
+++ b/remote.c
@@ -738,7 +738,7 @@ void ref_remove_duplicates(struct ref *ref_map)
 	struct string_list refs = { NULL, 0, 0, 0 };
 	struct string_list_item *item = NULL;
 	struct ref *prev = NULL, *next = NULL;
-	for (; ref_map; ref_map = next) {
+	for (; ref_map; prev = ref_map, ref_map = next) {
 		next = ref_map->next;
 		if (!ref_map->peer_ref)
 			continue;
@@ -758,7 +758,6 @@ void ref_remove_duplicates(struct ref *ref_map)
 
 		item = string_list_insert(ref_map->peer_ref->name, &refs);
 		item->util = ref_map;
-		prev = ref_map;
 	}
 	string_list_clear(&refs, 0);
 }
-- 
1.6.5.rc2
