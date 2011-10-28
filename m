From: mhagger@alum.mit.edu
Subject: [PATCH v2 04/12] create_ref_entry(): extract function from add_ref()
Date: Fri, 28 Oct 2011 13:27:56 +0200
Message-ID: <1319801284-15625-5-git-send-email-mhagger@alum.mit.edu>
References: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:28:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkbn-0002Nv-Cw
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab1J1L2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:28:18 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:54958 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab1J1L2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:28:14 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkVI-0007Cx-HF; Fri, 28 Oct 2011 13:21:40 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184362>

From: Michael Haggerty <mhagger@alum.mit.edu>

Separate the creation of the ref_entry from its addition to a ref_array.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   36 +++++++++++++++++++++---------------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 080e277..163ce91 100644
--- a/refs.c
+++ b/refs.c
@@ -56,27 +56,33 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	return line;
 }
 
-/* Add a ref_entry to the end of the ref_array (unsorted). */
-static void add_ref(const char *refname, const unsigned char *sha1,
-		    int flag, struct ref_array *refs,
-		    struct ref_entry **new_entry)
+static struct ref_entry *create_ref_entry(const char *refname,
+					  const unsigned char *sha1, int flag)
 {
 	int len;
-	struct ref_entry *entry;
+	struct ref_entry *ref;
 
-	/* Allocate it and add it in.. */
-	len = strlen(refname) + 1;
-	entry = xmalloc(sizeof(struct ref_entry) + len);
-	hashcpy(entry->sha1, sha1);
-	hashclr(entry->peeled);
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
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
+		    int flag, struct ref_array *refs,
+		    struct ref_entry **new_ref)
+{
+	struct ref_entry *ref = create_ref_entry(refname, sha1, flag);
+	if (new_ref)
+		*new_ref = ref;
 	ALLOC_GROW(refs->refs, refs->nr + 1, refs->alloc);
-	refs->refs[refs->nr++] = entry;
+	refs->refs[refs->nr++] = ref;
 }
 
 static int ref_entry_cmp(const void *a, const void *b)
-- 
1.7.7
