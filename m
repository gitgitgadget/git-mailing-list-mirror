From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 26/33] refs: use same lock_file object for both ref-packing functions
Date: Sun, 14 Apr 2013 14:54:41 +0200
Message-ID: <1365944088-10588-27-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTX-0004hh-PA
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094Ab3DNM4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:56:01 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:43740 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752040Ab3DNMz5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:57 -0400
X-AuditID: 12074411-b7f286d0000008e8-75-516aa75d95cd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 72.8C.02280.D57AA615; Sun, 14 Apr 2013 08:55:57 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkN007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:56 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqBu7PCvQ4MJJCYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M7ou7SdveA0d8Xy6d8YGxhXcXYxcnJICJhI3H/Xwwhhi0lcuLeerYuRi0NI4DKjxKYN
	t9hAEkICZ5kklrVzg9hsAroSi3qamboYOThEBLIldq+VBwkzCzhIbP7cCDZHWCBU4v7ujywg
	NouAqsTL/yuZQWxeAVeJ5g1/WCB2KUgc374NrJ4TKD79+TF2iFUuErM2z2adwMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIQAnuYJxxUu4QowAHoxIP7wvGrEAh
	1sSy4srcQ4ySHExKorwLlwKF+JLyUyozEosz4otKc1KLDzFKcDArifA6tgLleFMSK6tSi/Jh
	UtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvBrLgBoFi1LTUyvSMnNKENJMHJwgggtk
	Aw/Qhrcg23mLCxJzizPTIYpOMSpKifN+BEkIgCQySvPgBsBi/xWjONA/wrxPQap4gGkDrvsV
	0GAmoME+e9NBBpckIqSkGhidW/2F1G2vuE3asj5CWeZA/xrZBR+ExYXNNwe1hlYVrtridVqo
	5k430/8Pr1bpasq8v9/dZWIyf7PAtjfXr8w6zXhRXnT+3kUH3buzxTUY/7/VrbF+2zLf+VfK
	Q7sFws5PUi8fcPjcrBWzeuJaxdr5Wy5WbotKKLnFkHI5xup+en/vssp+xu1KLMUZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221112>

Use a single struct lock_file for both pack_refs() and
repack_without_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 16c237c..e0411c5 100644
--- a/refs.c
+++ b/refs.c
@@ -2089,7 +2089,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-static struct lock_file packed;
+static struct lock_file packlock;
 
 int pack_refs(unsigned int flags)
 {
@@ -2099,7 +2099,7 @@ int pack_refs(unsigned int flags)
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"),
+	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"),
 				       LOCK_DIE_ON_ERROR);
 	cbdata.refs_file = fdopen(fd, "w");
 	if (!cbdata.refs_file)
@@ -2118,8 +2118,8 @@ int pack_refs(unsigned int flags)
 	 * assign -1 to the lock file descriptor so that commit_lock_file()
 	 * won't try to close() it.
 	 */
-	packed.fd = -1;
-	if (commit_lock_file(&packed) < 0)
+	packlock.fd = -1;
+	if (commit_lock_file(&packlock) < 0)
 		die_errno("unable to overwrite old ref-pack file");
 	prune_refs(cbdata.ref_to_prune);
 	return 0;
@@ -2141,8 +2141,6 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-static struct lock_file packlock;
-
 static int repack_without_ref(const char *refname)
 {
 	int fd;
-- 
1.8.2.1
