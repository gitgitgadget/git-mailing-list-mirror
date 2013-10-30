From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/23] ref_remove_duplicates(): avoid redundant bisection
Date: Wed, 30 Oct 2013 06:33:07 +0100
Message-ID: <1383111192-23780-19-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:42:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXX-0007VK-1b
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab3J3Fly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:54 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49294 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753196Ab3J3Flx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:53 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 01:41:53 EDT
X-AuditID: 12074411-b7f426d000005455-67-52709a6adbe2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.CA.21589.A6A90725; Wed, 30 Oct 2013 01:34:34 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIT014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:32 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqJs1qyDI4M5COYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7Y9ONgIImvoo1/U9ZGhincXcxcnJICJhInPnzlQ3CFpO4cG89kM3FISRwmVHi++W3jBDO
	FSaJfy2dzCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBSYySxyfvogFJCEs4CPxYdcZsAYWAVWJ
	2193soLYvAKuEgfu9UGtU5C40TwVLM4JFP+06yY7iC0k4CLR1P6ZfQIj7wJGhlWMcok5pbm6
	uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsYIWEruINxxkm5Q4wCHIxKPLwGD/KDhFgTy4or
	cw8xSnIwKYnypk0pCBLiS8pPqcxILM6ILyrNSS0+xCjBwawkwjv9OFA5b0piZVVqUT5MSpqD
	RUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mCV3km0FDBotT01Iq0zJwShDQTByeI4ALZwAO0
	gQekkLe4IDG3ODMdougUo6KUOK8CSEIAJJFRmgc3AJZgXjGKA/0jDNHOA0xOcN2vgAYzAQ3e
	w5IHMrgkESEl1cAoa5Hkun36TqGGq9/2f9xx2qknaTf7b+n3v89uszoRvyGl8WAwB1tVmAKz
	zqSpX4tjQnc9nJja4eX8/ML/Pwfm5fNds9/Ifm1x5mYjnpeMH1haT5p7aFx88mr5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236976>

The old code called string_list_lookup(), and if that failed called
string_list_insert(), thus doing the bisection search through the
string list twice in the latter code path.

Instead, just call string_list_insert() right away.  If an entry for
that peer reference name already existed, then its util pointer is
always non-NULL.

Of course this doesn't change the fact that the repeated
string_list_insert() calls make the function scale like O(N^2) if the
input reference list is not already approximately sorted.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index a5e6c7f..15f3dc5 100644
--- a/remote.c
+++ b/remote.c
@@ -750,13 +750,15 @@ void ref_remove_duplicates(struct ref *ref_map)
 	struct string_list refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item = NULL;
 	struct ref *prev = NULL, *next = NULL;
+
 	for (; ref_map; prev = ref_map, ref_map = next) {
 		next = ref_map->next;
 		if (!ref_map->peer_ref)
 			continue;
 
-		item = string_list_lookup(&refs, ref_map->peer_ref->name);
-		if (item) {
+		item = string_list_insert(&refs, ref_map->peer_ref->name);
+		if (item->util) {
+			/* Entry already existed */
 			if (strcmp(((struct ref *)item->util)->name,
 				   ref_map->name))
 				die("%s tracks both %s and %s",
@@ -767,11 +769,9 @@ void ref_remove_duplicates(struct ref *ref_map)
 			free(ref_map->peer_ref);
 			free(ref_map);
 			ref_map = prev; /* skip this; we freed it */
-			continue;
+		} else {
+			item->util = ref_map;
 		}
-
-		item = string_list_insert(&refs, ref_map->peer_ref->name);
-		item->util = ref_map;
 	}
 	string_list_clear(&refs, 0);
 }
-- 
1.8.4.1
