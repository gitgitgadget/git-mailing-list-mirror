From: Jeff King <peff@peff.net>
Subject: [PATCHv2 09/10] remote-curl: move ref-parsing code up in file
Date: Mon, 18 Feb 2013 04:29:36 -0500
Message-ID: <20130218092936.GI5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:30:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7N2x-0004Vf-TY
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352Ab3BRJ3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:29:40 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51700 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756681Ab3BRJ3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:29:39 -0500
Received: (qmail 17787 invoked by uid 107); 18 Feb 2013 09:31:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:31:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:29:36 -0500
Content-Disposition: inline
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216456>

The ref-parsing functions are static. Let's move them up in
the file to be available to more functions, which will help
us with later refactoring.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a cleanup for the next patch. We could also just do extra
declarations at the top.

 remote-curl.c | 117 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index f049da2..62f82d1 100644
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
@@ -173,64 +232,6 @@ static struct discovery* discover_refs(const char *service)
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
 
 static struct ref *get_refs(int for_push)
 {
-- 
1.8.1.20.g7078b03
