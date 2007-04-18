From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] refs.c: drop duplicate entries in sort_ref_list
Date: Wed, 18 Apr 2007 22:27:28 +0100
Message-ID: <20070418212749.4842.62822.julian@quantumfyre.co.uk>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
	<Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
	<7vslaymzk3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704172304380.16435@beast.quantumfyre.co.uk>
	<7vodllfpaj.fsf@assigned-by-dhcp.cox.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeHkq-0007iy-Cf
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 23:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992792AbXDRVbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 17:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992793AbXDRVbv
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 17:31:51 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:45670 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992792AbXDRVbu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 17:31:50 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 511C8C6475
	for <git@vger.kernel.org>; Wed, 18 Apr 2007 22:31:48 +0100 (BST)
Received: (qmail 15879 invoked by uid 103); 18 Apr 2007 22:31:04 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3112. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.025761 secs); 18 Apr 2007 21:31:04 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 18 Apr 2007 22:31:04 +0100
In-Reply-To: <7vodllfpaj.fsf@assigned-by-dhcp.cox.net>
X-git-sha1: 860bc50c267005da3f13114c87a21ce97cc3ca79 
X-Mailer: git-mail-commits v0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44953>

It shouldn't happen that we read duplicate entries into the same list,
but just in case make sort_ref_list drop them.  If the SHA1s don't
match then die instead, as we have no way of knowing which one is the
correct one.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Wed, 18 Apr 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> On Tue, 17 Apr 2007, Junio C Hamano wrote:
>> ...
>>> I think we would not call add_ref() to the same list with
>>> duplicate names, unless (1) filesystem is grossly corrupt, (2)
>>> somebody added a new ref while we are walking (how does
>>> readdir() behave in such a case???), or (3) packed-refs file is
>>> corrupt.
>>
>> This combined with the fact that the old code didn't check that the
>> sha1 was the same suggests to me that this behaviour may actually have
>> been a subtle bug?  Perhaps the best thing to do is die if we find two
>> entries with the same name when sorting?
>
> I am not sure what readdir() does if somebody adds a new ref
> while we are walking the directory; I am hoping we would not get
> the same thing in duplicates, but I dunno.
>
> I think the most sensible thing to do is to check for
> duplicates, discarding if the SHA-1 match and otherwise dying.
>

Something like this (on top of my previous patch)?

 refs.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 23982fc..5736a0e 100644
--- a/refs.c
+++ b/refs.c
@@ -65,7 +65,7 @@ static struct ref_list *add_ref(const char *name, const unsigned char *sha1,
 /* merge sort the ref list */
 static struct ref_list *sort_ref_list(struct ref_list *list)
 {
-	int psize, qsize, last_merge_count;
+	int psize, qsize, last_merge_count, cmp;
 	struct ref_list *p, *q, *l, *e;
 	struct ref_list *new_list = list;
 	int k = 1;
@@ -103,14 +103,32 @@ static struct ref_list *sort_ref_list(struct ref_list *list)
 					e = q;
 					q = q->next;
 					qsize--;
-				} else if (strcmp(q->name, p->name) < 0) {
-					e = q;
-					q = q->next;
-					qsize--;
 				} else {
-					e = p;
-					p = p->next;
-					psize--;
+					cmp = strcmp(q->name, p->name);
+					if (cmp < 0) {
+						e = q;
+						q = q->next;
+						qsize--;
+					} else if (cmp > 0) {
+						e = p;
+						p = p->next;
+						psize--;
+					} else {
+						if (hashcmp(q->sha1, p->sha1))
+							die("Duplicated ref, "
+							    "and SHA1s don't "
+							    "match: %s",
+							    q->name);
+						warning("Duplicated ref: %s",
+							q->name);
+						e = q;
+						q = q->next;
+						qsize--;
+						free(e);
+						e = p;
+						p = p->next;
+						psize--;
+					}
 				}
 
 				e->next = NULL;
-- 
1.5.1.1
