From: mhagger@alum.mit.edu
Subject: [PATCH v2 15/51] create_ref_entry(): extract function from add_ref()
Date: Mon, 12 Dec 2011 06:38:22 +0100
Message-ID: <1323668338-1764-16-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycd-0000Sq-6P
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab1LLFkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:05 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34651 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab1LLFkC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:02 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aS015577;
	Mon, 12 Dec 2011 06:39:44 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186838>

From: Michael Haggerty <mhagger@alum.mit.edu>

Separate the creation of the ref_entry from its addition to a ref_array.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 2e7bc0c..442b87c 100644
--- a/refs.c
+++ b/refs.c
@@ -53,28 +53,35 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	return line;
 }
 
-/* Add a ref_entry to the end of the ref_array (unsorted). */
-static void add_ref(const char *refname, const unsigned char *sha1,
-		    int flag, int check_name, struct ref_array *refs,
-		    struct ref_entry **new_entry)
+static struct ref_entry *create_ref_entry(const char *refname,
+					  const unsigned char *sha1, int flag,
+					  int check_name)
 {
 	int len;
-	struct ref_entry *entry;
+	struct ref_entry *ref;
 
-	/* Allocate it and add it in.. */
-	len = strlen(refname) + 1;
-	entry = xmalloc(sizeof(struct ref_entry) + len);
-	hashcpy(entry->sha1, sha1);
-	hashclr(entry->peeled);
 	if (check_name &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
 		die("Reference has invalid format: '%s'", refname);
-	memcpy(entry->name, refname, len);
-	entry->flag = flag;
-	if (new_entry)
-		*new_entry = entry;
+	len = strlen(refname) + 1;
+	ref = xmalloc(sizeof(struct ref_entry) + len);
+	hashcpy(ref->sha1, sha1);
+	hashclr(ref->peeled);
+	memcpy(ref->name, refname, len);
+	ref->flag = flag;
+	return ref;
+}
+
+/* Add a ref_entry to the end of the ref_array (unsorted). */
+static void add_ref(const char *refname, const unsigned char *sha1,
+		    int flag, int check_name, struct ref_array *refs,
+		    struct ref_entry **new_ref)
+{
+	struct ref_entry *ref = create_ref_entry(refname, sha1, flag, check_name);
+	if (new_ref)
+		*new_ref = ref;
 	ALLOC_GROW(refs->refs, refs->nr + 1, refs->alloc);
-	refs->refs[refs->nr++] = entry;
+	refs->refs[refs->nr++] = ref;
 }
 
 static int ref_entry_cmp(const void *a, const void *b)
-- 
1.7.8
