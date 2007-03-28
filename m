From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] http-fetch: don't use double-slash as directory separator in URLs
Date: Wed, 28 Mar 2007 09:46:15 +0000
Message-ID: <20070328094615.32277.qmail@47bcc7bfa0b709.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 11:46:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWUjT-00005G-Lc
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 11:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933638AbXC1Jp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 05:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933691AbXC1Jp7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 05:45:59 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:51200 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933638AbXC1Jp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 05:45:58 -0400
Received: (qmail 32278 invoked by uid 1000); 28 Mar 2007 09:46:15 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43365>

Please see http://bugs.debian.org/409887

http-fetch expected the URL given at the command line to have a trailing
slash anyway, and then added '/objects...' when requesting objects files
from the http server.

Now it doesn't require the trailing slash in <url> anymore, and strips
trailing slashes if given nonetheless.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-clone.sh |    2 +-
 git-fetch.sh |    2 +-
 http-fetch.c |   21 ++++++++++++---------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 6ba477d..513b574 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -60,7 +60,7 @@ Perhaps git-update-server-info needs to be run there?"
 		else
 			tname=$name
 		fi
-		git-http-fetch $v -a -w "$tname" "$name" "$1/" || exit 1
+		git-http-fetch $v -a -w "$tname" "$name" "$1" || exit 1
 	done <"$clone_tmp/refs"
 	rm -fr "$clone_tmp"
 	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
diff --git a/git-fetch.sh b/git-fetch.sh
index 9334933..fd70696 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -248,7 +248,7 @@ fetch_per_ref () {
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
 		die "No such ref $remote_name at $remote"
 	  echo >&2 "Fetching $remote_name from $remote using $proto"
-	  git-http-fetch -v -a "$head" "$remote/" || exit
+	  git-http-fetch -v -a "$head" "$remote" || exit
 	  ;;
       rsync://*)
 	  test -n "$shallow_depth" &&
diff --git a/http-fetch.c b/http-fetch.c
index e6cd11d..58b77a7 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -16,7 +16,7 @@ static struct curl_slist *no_pragma_header;
 
 struct alt_base
 {
-	const char *base;
+	char *base;
 	int path_len;
 	int got_indices;
 	struct packed_git *packs;
@@ -158,12 +158,12 @@ static void start_object_request(struct object_request *obj_req)
 
 	SHA1_Init(&obj_req->c);
 
-	url = xmalloc(strlen(obj_req->repo->base) + 50);
-	obj_req->url = xmalloc(strlen(obj_req->repo->base) + 50);
+	url = xmalloc(strlen(obj_req->repo->base) + 51);
+	obj_req->url = xmalloc(strlen(obj_req->repo->base) + 51);
 	strcpy(url, obj_req->repo->base);
 	posn = url + strlen(obj_req->repo->base);
-	strcpy(posn, "objects/");
-	posn += 8;
+	strcpy(posn, "/objects/");
+	posn += 9;
 	memcpy(posn, hex, 2);
 	posn += 2;
 	*(posn++) = '/';
@@ -938,14 +938,14 @@ static char *quote_ref_url(const char *base, const char *ref)
 	int len, baselen, ch;
 
 	baselen = strlen(base);
-	len = baselen + 6; /* "refs/" + NUL */
+	len = baselen + 7; /* "/refs/" + NUL */
 	for (cp = ref; (ch = *cp) != 0; cp++, len++)
 		if (needs_quote(ch))
 			len += 2; /* extra two hex plus replacement % */
 	qref = xmalloc(len);
 	memcpy(qref, base, baselen);
-	memcpy(qref + baselen, "refs/", 5);
-	for (cp = ref, dp = qref + baselen + 5; (ch = *cp) != 0; cp++) {
+	memcpy(qref + baselen, "/refs/", 6);
+	for (cp = ref, dp = qref + baselen + 6; (ch = *cp) != 0; cp++) {
 		if (needs_quote(ch)) {
 			*dp++ = '%';
 			*dp++ = hex((ch >> 4) & 0xF);
@@ -1044,7 +1044,10 @@ int main(int argc, const char **argv)
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
 	alt = xmalloc(sizeof(*alt));
-	alt->base = url;
+	alt->base = xmalloc(strlen(url) + 1);
+	strcpy(alt->base, url);
+	for (path = alt->base + strlen(alt->base) - 1; *path == '/'; --path)
+		*path = 0;
 	alt->got_indices = 0;
 	alt->packs = NULL;
 	alt->next = NULL;
-- 
1.5.1-rc2.GIT
