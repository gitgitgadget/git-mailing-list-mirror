From: mhagger@alum.mit.edu
Subject: [PATCH v2 16/51] add_ref(): take a (struct ref_entry *) parameter
Date: Mon, 12 Dec 2011 06:38:23 +0100
Message-ID: <1323668338-1764-17-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyce-0000Sq-UH
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab1LLFkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:11 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34677 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1LLFkG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:06 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aT015577;
	Mon, 12 Dec 2011 06:39:47 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186840>

From: Michael Haggerty <mhagger@alum.mit.edu>

Take a pointer to the ref_entry to add to the array, rather than
creating the ref_entry within the function.  This opens the way to
having multiple kinds of ref_entries.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 442b87c..579e4c3 100644
--- a/refs.c
+++ b/refs.c
@@ -73,13 +73,8 @@ static struct ref_entry *create_ref_entry(const char *refname,
 }
 
 /* Add a ref_entry to the end of the ref_array (unsorted). */
-static void add_ref(const char *refname, const unsigned char *sha1,
-		    int flag, int check_name, struct ref_array *refs,
-		    struct ref_entry **new_ref)
+static void add_ref(struct ref_array *refs, struct ref_entry *ref)
 {
-	struct ref_entry *ref = create_ref_entry(refname, sha1, flag, check_name);
-	if (new_ref)
-		*new_ref = ref;
 	ALLOC_GROW(refs->refs, refs->nr + 1, refs->alloc);
 	refs->refs[refs->nr++] = ref;
 }
@@ -262,7 +257,8 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
-			add_ref(refname, sha1, flag, 1, array, &last);
+			last = create_ref_entry(refname, sha1, flag, 1);
+			add_ref(array, last);
 			continue;
 		}
 		if (last &&
@@ -277,7 +273,7 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 
 void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 {
-	add_ref(refname, sha1, flag, 0, &extra_refs, NULL);
+	add_ref(&extra_refs, create_ref_entry(refname, sha1, flag, 0));
 }
 
 void clear_extra_refs(void)
@@ -363,7 +359,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			add_ref(refname, sha1, flag, 1, array, NULL);
+			add_ref(array, create_ref_entry(refname, sha1, flag, 1));
 		}
 		free(refname);
 		closedir(dir);
-- 
1.7.8
