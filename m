From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCHv2 1/2] Wrap rewrite globals in a struct in preparation for
 adding another set
Date: Mon, 7 Sep 2009 01:56:00 -0700
Message-ID: <bdf2f41d610eb68d335bfd02c9bf4638a02a225a.1252313313.git.josh@joshtriplett.org>
References: <cover.1252313313.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 07 10:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mka1Q-0003g1-3n
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbZIGI4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbZIGI4N
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:56:13 -0400
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:42091 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbZIGI4N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:56:13 -0400
Received: from feather (pool-173-50-250-234.ptldor.fios.verizon.net [173.50.250.234])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 75995362C0;
	Mon,  7 Sep 2009 10:56:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cover.1252313313.git.josh@joshtriplett.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127911>

remote.c has a global set of URL rewrites, accessed by alias_url and
make_rewrite.  Wrap them in a new "struct rewrites", passed to alias_url
and make_rewrite.  This allows adding other sets of rewrites.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 remote.c |   53 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/remote.c b/remote.c
index 4b5b905..ff8e71f 100644
--- a/remote.c
+++ b/remote.c
@@ -28,6 +28,11 @@ struct rewrite {
 	int instead_of_nr;
 	int instead_of_alloc;
 };
+struct rewrites {
+	struct rewrite **rewrite;
+	int rewrite_alloc;
+	int rewrite_nr;
+};
 
 static struct remote **remotes;
 static int remotes_alloc;
@@ -41,14 +46,12 @@ static struct branch *current_branch;
 static const char *default_remote_name;
 static int explicit_default_remote_name;
 
-static struct rewrite **rewrite;
-static int rewrite_alloc;
-static int rewrite_nr;
+static struct rewrites rewrites;
 
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
 
-static const char *alias_url(const char *url)
+static const char *alias_url(const char *url, struct rewrites *r)
 {
 	int i, j;
 	char *ret;
@@ -57,14 +60,14 @@ static const char *alias_url(const char *url)
 
 	longest = NULL;
 	longest_i = -1;
-	for (i = 0; i < rewrite_nr; i++) {
-		if (!rewrite[i])
+	for (i = 0; i < r->rewrite_nr; i++) {
+		if (!r->rewrite[i])
 			continue;
-		for (j = 0; j < rewrite[i]->instead_of_nr; j++) {
-			if (!prefixcmp(url, rewrite[i]->instead_of[j].s) &&
+		for (j = 0; j < r->rewrite[i]->instead_of_nr; j++) {
+			if (!prefixcmp(url, r->rewrite[i]->instead_of[j].s) &&
 			    (!longest ||
-			     longest->len < rewrite[i]->instead_of[j].len)) {
-				longest = &(rewrite[i]->instead_of[j]);
+			     longest->len < r->rewrite[i]->instead_of[j].len)) {
+				longest = &(r->rewrite[i]->instead_of[j]);
 				longest_i = i;
 			}
 		}
@@ -72,10 +75,10 @@ static const char *alias_url(const char *url)
 	if (!longest)
 		return url;
 
-	ret = xmalloc(rewrite[longest_i]->baselen +
+	ret = xmalloc(r->rewrite[longest_i]->baselen +
 		     (strlen(url) - longest->len) + 1);
-	strcpy(ret, rewrite[longest_i]->base);
-	strcpy(ret + rewrite[longest_i]->baselen, url + longest->len);
+	strcpy(ret, r->rewrite[longest_i]->base);
+	strcpy(ret + r->rewrite[longest_i]->baselen, url + longest->len);
 	return ret;
 }
 
@@ -103,7 +106,7 @@ static void add_url(struct remote *remote, const char *url)
 
 static void add_url_alias(struct remote *remote, const char *url)
 {
-	add_url(remote, alias_url(url));
+	add_url(remote, alias_url(url, &rewrites));
 }
 
 static void add_pushurl(struct remote *remote, const char *pushurl)
@@ -169,22 +172,22 @@ static struct branch *make_branch(const char *name, int len)
 	return ret;
 }
 
-static struct rewrite *make_rewrite(const char *base, int len)
+static struct rewrite *make_rewrite(struct rewrites *r, const char *base, int len)
 {
 	struct rewrite *ret;
 	int i;
 
-	for (i = 0; i < rewrite_nr; i++) {
+	for (i = 0; i < r->rewrite_nr; i++) {
 		if (len
-		    ? (len == rewrite[i]->baselen &&
-		       !strncmp(base, rewrite[i]->base, len))
-		    : !strcmp(base, rewrite[i]->base))
-			return rewrite[i];
+		    ? (len == r->rewrite[i]->baselen &&
+		       !strncmp(base, r->rewrite[i]->base, len))
+		    : !strcmp(base, r->rewrite[i]->base))
+			return r->rewrite[i];
 	}
 
-	ALLOC_GROW(rewrite, rewrite_nr + 1, rewrite_alloc);
+	ALLOC_GROW(r->rewrite, r->rewrite_nr + 1, r->rewrite_alloc);
 	ret = xcalloc(1, sizeof(struct rewrite));
-	rewrite[rewrite_nr++] = ret;
+	r->rewrite[r->rewrite_nr++] = ret;
 	if (len) {
 		ret->base = xstrndup(base, len);
 		ret->baselen = len;
@@ -355,7 +358,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		subkey = strrchr(name, '.');
 		if (!subkey)
 			return 0;
-		rewrite = make_rewrite(name, subkey - name);
+		rewrite = make_rewrite(&rewrites, name, subkey - name);
 		if (!strcmp(subkey, ".insteadof")) {
 			if (!value)
 				return config_error_nonbool(key);
@@ -433,10 +436,10 @@ static void alias_all_urls(void)
 		if (!remotes[i])
 			continue;
 		for (j = 0; j < remotes[i]->url_nr; j++) {
-			remotes[i]->url[j] = alias_url(remotes[i]->url[j]);
+			remotes[i]->url[j] = alias_url(remotes[i]->url[j], &rewrites);
 		}
 		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
-			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j]);
+			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
 		}
 	}
 }
-- 
1.6.3.3
