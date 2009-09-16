From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH 2/2] fetch: Speed up fetch by using ref dictionary
Date: Wed, 16 Sep 2009 08:53:03 +0100
Message-ID: <20090916075304.58044.83034.julian@quantumfyre.co.uk>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 09:54:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnpLt-0005wD-2O
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 09:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbZIPHyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 03:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbZIPHyg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 03:54:36 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36065 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751585AbZIPHyf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 03:54:35 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 1BF3633FA29
	for <git@vger.kernel.org>; Wed, 16 Sep 2009 08:54:38 +0100 (BST)
Received: (qmail 30309 invoked by uid 103); 16 Sep 2009 08:53:11 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9808. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.026665 secs); 16 Sep 2009 07:53:11 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 16 Sep 2009 08:53:11 +0100
X-git-sha1: 9f31c7f792b7b9da295ae4a48968dfac5e76cf57 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128612>

When trying to get a list of remote tags to see if we need to fetch
any we were doing a linear search for the matching tag ref for the
tag^{} commit entries.  This proves to be incredibly slow for large
numbers of tags.

For a repository with 50000 tags (and just a single commit on a single
branch), a fetch that does nothing goes from ~ 1m50s to ~4.5s.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin-fetch.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index cb48c57..16cfee6 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "sigchain.h"
+#include "ref-dict.h"
 
 static const char * const builtin_fetch_usage[] = {
 	"git fetch [options] [<repository> <refspec>...]",
@@ -513,12 +514,16 @@ static void find_non_local_tags(struct transport *transport,
 	char *ref_name;
 	int ref_name_len;
 	const unsigned char *ref_sha1;
-	const struct ref *tag_ref;
+	unsigned char tag_sha1[40];
 	struct ref *rm = NULL;
 	const struct ref *ref;
+	struct hash_table dict;
+	const struct ref *remote_refs = transport_get_remote_refs(transport);
+
+	ref_dict_create(&dict, remote_refs);
 
 	for_each_ref(add_existing, &existing_refs);
-	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
+	for (ref = remote_refs; ref; ref = ref->next) {
 		if (prefixcmp(ref->name, "refs/tags"))
 			continue;
 
@@ -528,14 +533,8 @@ static void find_non_local_tags(struct transport *transport,
 
 		if (!strcmp(ref_name + ref_name_len - 3, "^{}")) {
 			ref_name[ref_name_len - 3] = 0;
-			tag_ref = transport_get_remote_refs(transport);
-			while (tag_ref) {
-				if (!strcmp(tag_ref->name, ref_name)) {
-					ref_sha1 = tag_ref->old_sha1;
-					break;
-				}
-				tag_ref = tag_ref->next;
-			}
+			if (ref_dict_get(&dict, ref_name, tag_sha1))
+				ref_sha1 = tag_sha1;
 		}
 
 		if (!string_list_has_string(&existing_refs, ref_name) &&
-- 
1.6.4.2
