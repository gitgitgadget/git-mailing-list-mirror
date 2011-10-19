From: mhagger@alum.mit.edu
Subject: [PATCH 05/12] add_ref(): take a (struct ref_entry *) parameter
Date: Wed, 19 Oct 2011 23:44:45 +0200
Message-ID: <1319060692-27216-6-git-send-email-mhagger@alum.mit.edu>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:45:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdx5-0000Co-N9
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab1JSVpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:45:19 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33131 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab1JSVpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:45:13 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGdqr-0004K1-II; Wed, 19 Oct 2011 23:39:05 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183973>

From: Michael Haggerty <mhagger@alum.mit.edu>

Take a pointer to the ref_entry to add to the array, rather than
creating the ref_entry within the function.  This opens the way to
having multiple kinds of ref_entries.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index acb098c..ae90993 100644
--- a/refs.c
+++ b/refs.c
@@ -75,13 +75,8 @@ static struct ref_entry *create_ref_entry(const char *refname,
 }
 
 /* Add a ref_entry to the end of the ref_array (unsorted). */
-static void add_ref(const char *refname, const unsigned char *sha1,
-		    int flag, struct ref_array *refs,
-		    struct ref_entry **new_ref)
+static void add_ref(struct ref_array *refs, struct ref_entry *ref)
 {
-	struct ref_entry *ref = create_ref_entry(refname, sha1, flag);
-	if (new_ref)
-		*new_ref = ref;
 	ALLOC_GROW(refs->refs, refs->nr + 1, refs->alloc);
 	refs->refs[refs->nr++] = ref;
 }
@@ -266,7 +261,8 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
-			add_ref(refname, sha1, flag, array, &last);
+			last = create_ref_entry(refname, sha1, flag);
+			add_ref(array, last);
 			continue;
 		}
 		if (last &&
@@ -281,7 +277,7 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 
 void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 {
-	add_ref(refname, sha1, flag, &extra_refs, NULL);
+	add_ref(&extra_refs, create_ref_entry(refname, sha1, flag));
 }
 
 void clear_extra_refs(void)
@@ -368,7 +364,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 					hashclr(sha1);
 					flag |= REF_BROKEN;
 				}
-			add_ref(refname, sha1, flag, array, NULL);
+			add_ref(array, create_ref_entry(refname, sha1, flag));
 		}
 		free(refname);
 		closedir(dir);
-- 
1.7.7
