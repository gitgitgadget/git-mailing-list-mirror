From: Jeff King <peff@peff.net>
Subject: [PATCH v3 18/19] remote-curl: move ref-parsing code up in file
Date: Wed, 20 Feb 2013 15:07:11 -0500
Message-ID: <20130220200711.GR25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:07:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8FxG-0008Fs-Md
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935355Ab3BTUHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:07:16 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54697 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935098Ab3BTUHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:07:14 -0500
Received: (qmail 17925 invoked by uid 107); 20 Feb 2013 20:08:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:08:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:07:11 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216733>

The ref-parsing functions are static. Let's move them up in
the file to be available to more functions, which will help
us with later refactoring.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 118 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index e07f654..856decc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -80,6 +80,65 @@ static struct discovery *last_discovery;
 };
 static struct discovery *last_discovery;
 
+static struct ref *parse_git_refs(struct discovery *heads, int for_push)
+{
+	struct ref *list = NULL;
+	get_remote_heads(-1, heads->buf, heads->len, &list,
+			 for_push ? REF_NORMAL : 0, NULL);
+	return list;
+}
+
+static struct ref *parse_info_refs(struct discovery *heads)
+{
+	char *data, *start, *mid;
+	char *ref_name;
+	int i = 0;
+
+	struct ref *refs = NULL;
+	struct ref *ref = NULL;
+	struct ref *last_ref = NULL;
+
+	data = heads->buf;
+	start = NULL;
+	mid = data;
+	while (i < heads->len) {
+		if (!start) {
+			start = &data[i];
+		}
+		if (data[i] == '\t')
+			mid = &data[i];
+		if (data[i] == '\n') {
+			if (mid - start != 40)
+				die("%sinfo/refs not valid: is this a git repository?", url);
+			data[i] = 0;
+			ref_name = mid + 1;
+			ref = xmalloc(sizeof(struct ref) +
+				      strlen(ref_name) + 1);
+			memset(ref, 0, sizeof(struct ref));
+			strcpy(ref->name, ref_name);
+			get_sha1_hex(start, ref->old_sha1);
+			if (!refs)
+				refs = ref;
+			if (last_ref)
+				last_ref->next = ref;
+			last_ref = ref;
+			start = NULL;
+		}
+		i++;
+	}
+
+	ref = alloc_ref("HEAD");
+	if (!http_fetch_ref(url, ref) &&
+	    !resolve_remote_symref(ref, refs)) {
+		ref->next = refs;
+		refs = ref;
+	} else {
+		free(ref);
+	}
+
+	return refs;
+}
+
 static void free_discovery(struct discovery *d)
 {
 	if (d) {
@@ -170,65 +229,6 @@ static struct discovery* discover_refs(const char *service)
 	return last;
 }
 
-static struct ref *parse_git_refs(struct discovery *heads, int for_push)
-{
-	struct ref *list = NULL;
-	get_remote_heads(-1, heads->buf, heads->len, &list,
-			 for_push ? REF_NORMAL : 0, NULL);
-	return list;
-}
-
-static struct ref *parse_info_refs(struct discovery *heads)
-{
-	char *data, *start, *mid;
-	char *ref_name;
-	int i = 0;
-
-	struct ref *refs = NULL;
-	struct ref *ref = NULL;
-	struct ref *last_ref = NULL;
-
-	data = heads->buf;
-	start = NULL;
-	mid = data;
-	while (i < heads->len) {
-		if (!start) {
-			start = &data[i];
-		}
-		if (data[i] == '\t')
-			mid = &data[i];
-		if (data[i] == '\n') {
-			if (mid - start != 40)
-				die("%sinfo/refs not valid: is this a git repository?", url);
-			data[i] = 0;
-			ref_name = mid + 1;
-			ref = xmalloc(sizeof(struct ref) +
-				      strlen(ref_name) + 1);
-			memset(ref, 0, sizeof(struct ref));
-			strcpy(ref->name, ref_name);
-			get_sha1_hex(start, ref->old_sha1);
-			if (!refs)
-				refs = ref;
-			if (last_ref)
-				last_ref->next = ref;
-			last_ref = ref;
-			start = NULL;
-		}
-		i++;
-	}
-
-	ref = alloc_ref("HEAD");
-	if (!http_fetch_ref(url, ref) &&
-	    !resolve_remote_symref(ref, refs)) {
-		ref->next = refs;
-		refs = ref;
-	} else {
-		free(ref);
-	}
-
-	return refs;
-}
-
 static struct ref *get_refs(int for_push)
 {
 	struct discovery *heads;
-- 
1.8.2.rc0.9.g352092c
