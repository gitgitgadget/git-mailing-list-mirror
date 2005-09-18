From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Support alternates and http-alternates in http-fetch
Date: Sun, 18 Sep 2005 14:14:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509181411110.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 20:10:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH3cC-0002bd-AR
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 20:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVIRSKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 14:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVIRSKF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 14:10:05 -0400
Received: from iabervon.org ([66.92.72.58]:63249 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932151AbVIRSKE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 14:10:04 -0400
Received: (qmail 22128 invoked by uid 1000); 18 Sep 2005 14:14:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Sep 2005 14:14:19 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8801>

This allows the remote repository to refer to additional repositories
in a file objects/info/http-alternates or
objects/info/alternates. Each line may be:

 a relative path, starting with ../, to get from the objects directory
  of the starting repository to the objects directory of the added
  repository.

 an absolute path of the objects directory of the added repository (on
  the same server).

 (only in http-alternates) a full URL of the objects directory of the
  added repository.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

 http-fetch.c |  202 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 166 insertions(+), 36 deletions(-)

7640b93541f9422e8d101959c2f6c4fc3277e4f8
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -16,7 +16,17 @@
 static CURL *curl;
 static struct curl_slist *no_pragma_header;
 
-static char *base;
+static char *initial_base;
+
+struct alt_base
+{
+	char *base;
+	int got_indices;
+	struct packed_git *packs;
+	struct alt_base *next;
+};
+
+struct alt_base *alt = NULL;
 
 static SHA_CTX c;
 static z_stream stream;
@@ -72,11 +82,9 @@ void prefetch(unsigned char *sha1)
 {
 }
 
-static int got_indices = 0;
-
-static struct packed_git *packs = NULL;
+static int got_alternates = 0;
 
-static int fetch_index(unsigned char *sha1)
+static int fetch_index(struct alt_base *repo, unsigned char *sha1)
 {
 	char *filename;
 	char *url;
@@ -90,9 +98,9 @@ static int fetch_index(unsigned char *sh
 		fprintf(stderr, "Getting index for pack %s\n",
 			sha1_to_hex(sha1));
 	
-	url = xmalloc(strlen(base) + 64);
+	url = xmalloc(strlen(repo->base) + 64);
 	sprintf(url, "%s/objects/pack/pack-%s.idx",
-		base, sha1_to_hex(sha1));
+		repo->base, sha1_to_hex(sha1));
 	
 	filename = sha1_pack_index_name(sha1);
 	indexfile = fopen(filename, "w");
@@ -114,22 +122,123 @@ static int fetch_index(unsigned char *sh
 	return 0;
 }
 
-static int setup_index(unsigned char *sha1)
+static int setup_index(struct alt_base *repo, unsigned char *sha1)
 {
 	struct packed_git *new_pack;
 	if (has_pack_file(sha1))
 		return 0; // don't list this as something we can get
 
-	if (fetch_index(sha1))
+	if (fetch_index(repo, sha1))
 		return -1;
 
 	new_pack = parse_pack_index(sha1);
-	new_pack->next = packs;
-	packs = new_pack;
+	new_pack->next = repo->packs;
+	repo->packs = new_pack;
 	return 0;
 }
 
-static int fetch_indices(void)
+static int fetch_alternates(char *base)
+{
+	int ret = 0;
+	struct buffer buffer;
+	char *url;
+	char *data;
+	int i = 0;
+	int http_specific = 1;
+	if (got_alternates)
+		return 0;
+	data = xmalloc(4096);
+	buffer.size = 4095;
+	buffer.posn = 0;
+	buffer.buffer = data;
+
+	if (get_verbosely)
+		fprintf(stderr, "Getting alternates list\n");
+	
+	url = xmalloc(strlen(base) + 31);
+	sprintf(url, "%s/objects/info/http-alternates", base);
+
+	curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+
+	if (curl_easy_perform(curl) || !buffer.posn) {
+		http_specific = 0;
+
+		sprintf(url, "%s/objects/info/alternates", base);
+		
+		curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
+		curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+		curl_easy_setopt(curl, CURLOPT_URL, url);
+		
+		if (curl_easy_perform(curl)) {
+			return 0;
+		}
+	}
+
+	data[buffer.posn] = '\0';
+
+	while (i < buffer.posn) {
+		int posn = i;
+		while (posn < buffer.posn && data[posn] != '\n')
+			posn++;
+		if (data[posn] == '\n') {
+			int okay = 0;
+			int serverlen = 0;
+			struct alt_base *newalt;
+			char *target = NULL;
+			if (data[i] == '/') {
+				serverlen = strchr(base + 8, '/') - base;
+				okay = 1;
+			} else if (!memcmp(data + i, "../", 3)) {
+				i += 3;
+				serverlen = strlen(base);
+				while (i + 2 < posn && 
+				       !memcmp(data + i, "../", 3)) {
+					do {
+						serverlen--;
+					} while (serverlen &&
+						 base[serverlen - 1] != '/');
+					i += 3;
+				}
+				// If the server got removed, give up.
+				okay = strchr(base, ':') - base + 3 < 
+					serverlen;
+			} else if (http_specific) {
+				char *colon = strchr(data + i, ':');
+				char *slash = strchr(data + i, '/');
+				if (colon && slash && colon < data + posn &&
+				    slash < data + posn && colon < slash) {
+					okay = 1;
+				}
+			}
+			// skip 'objects' at end
+			if (okay) {
+				target = xmalloc(serverlen + posn - i - 6);
+				strncpy(target, base, serverlen);
+				strncpy(target + serverlen, data + i,
+					posn - i - 7);
+				target[serverlen + posn - i - 7] = '\0';
+				if (get_verbosely)
+					fprintf(stderr, 
+						"Also look at %s\n", target);
+				newalt = xmalloc(sizeof(*newalt));
+				newalt->next = alt;
+				newalt->base = target;
+				newalt->got_indices = 0;
+				newalt->packs = NULL;
+				alt = newalt;
+				ret++;
+			}
+		}
+		i = posn + 1;
+	}
+	got_alternates = 1;
+	
+	return ret;
+}
+
+static int fetch_indices(struct alt_base *repo)
 {
 	unsigned char sha1[20];
 	char *url;
@@ -137,7 +246,7 @@ static int fetch_indices(void)
 	char *data;
 	int i = 0;
 
-	if (got_indices)
+	if (repo->got_indices)
 		return 0;
 
 	data = xmalloc(4096);
@@ -148,8 +257,8 @@ static int fetch_indices(void)
 	if (get_verbosely)
 		fprintf(stderr, "Getting pack list\n");
 	
-	url = xmalloc(strlen(base) + 21);
-	sprintf(url, "%s/objects/info/packs", base);
+	url = xmalloc(strlen(repo->base) + 21);
+	sprintf(url, "%s/objects/info/packs", repo->base);
 
 	curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
@@ -157,10 +266,10 @@ static int fetch_indices(void)
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, NULL);
 	
 	if (curl_easy_perform(curl)) {
-		return error("Unable to get pack index %s", url);
+		return -1;
 	}
 
-	do {
+	while (i < buffer.posn) {
 		switch (data[i]) {
 		case 'P':
 			i++;
@@ -168,7 +277,7 @@ static int fetch_indices(void)
 			    !strncmp(data + i, " pack-", 6) &&
 			    !strncmp(data + i + 46, ".pack\n", 6)) {
 				get_sha1_hex(data + i + 6, sha1);
-				setup_index(sha1);
+				setup_index(repo, sha1);
 				i += 51;
 				break;
 			}
@@ -177,13 +286,13 @@ static int fetch_indices(void)
 				i++;
 		}
 		i++;
-	} while (i < buffer.posn);
+	}
 
-	got_indices = 1;
+	repo->got_indices = 1;
 	return 0;
 }
 
-static int fetch_pack(unsigned char *sha1)
+static int fetch_pack(struct alt_base *repo, unsigned char *sha1)
 {
 	char *url;
 	struct packed_git *target;
@@ -191,12 +300,11 @@ static int fetch_pack(unsigned char *sha
 	FILE *packfile;
 	char *filename;
 
-	if (fetch_indices())
+	if (fetch_indices(repo))
 		return -1;
-	target = find_sha1_pack(sha1, packs);
+	target = find_sha1_pack(sha1, repo->packs);
 	if (!target)
-		return error("Couldn't get %s: not separate or in any pack",
-			     sha1_to_hex(sha1));
+		return -1;
 
 	if (get_verbosely) {
 		fprintf(stderr, "Getting pack %s\n",
@@ -205,9 +313,9 @@ static int fetch_pack(unsigned char *sha
 			sha1_to_hex(sha1));
 	}
 
-	url = xmalloc(strlen(base) + 65);
+	url = xmalloc(strlen(repo->base) + 65);
 	sprintf(url, "%s/objects/pack/pack-%s.pack",
-		base, sha1_to_hex(target->sha1));
+		repo->base, sha1_to_hex(target->sha1));
 
 	filename = sha1_pack_name(target->sha1);
 	packfile = fopen(filename, "w");
@@ -227,7 +335,7 @@ static int fetch_pack(unsigned char *sha
 
 	fclose(packfile);
 
-	lst = &packs;
+	lst = &repo->packs;
 	while (*lst != target)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
@@ -237,7 +345,7 @@ static int fetch_pack(unsigned char *sha
 	return 0;
 }
 
-int fetch(unsigned char *sha1)
+int fetch_object(struct alt_base *repo, unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
 	char *filename = sha1_file_name(sha1);
@@ -261,9 +369,9 @@ int fetch(unsigned char *sha1)
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
 
-	url = xmalloc(strlen(base) + 50);
-	strcpy(url, base);
-	posn = url + strlen(base);
+	url = xmalloc(strlen(repo->base) + 50);
+	strcpy(url, repo->base);
+	posn = url + strlen(repo->base);
 	strcpy(posn, "objects/");
 	posn += 8;
 	memcpy(posn, hex, 2);
@@ -275,9 +383,7 @@ int fetch(unsigned char *sha1)
 
 	if (curl_easy_perform(curl)) {
 		unlink(filename);
-		if (fetch_pack(sha1))
-			return error("Tried %s", url);
-		return 0;
+		return -1;
 	}
 
 	close(local);
@@ -296,11 +402,30 @@ int fetch(unsigned char *sha1)
 	return 0;
 }
 
+int fetch(unsigned char *sha1)
+{
+	struct alt_base *altbase = alt;
+	while (altbase) {
+		if (!fetch_object(altbase, sha1))
+			return 0;
+		if (!fetch_pack(altbase, sha1))
+			return 0;
+		if (fetch_alternates(altbase->base) > 0) {
+			altbase = alt;
+			continue;
+		}
+		altbase = altbase->next;
+	}
+	return error("Unable to find %s under %s\n", sha1_to_hex(sha1), 
+		     initial_base);
+}
+
 int fetch_ref(char *ref, unsigned char *sha1)
 {
         char *url, *posn;
         char hex[42];
         struct buffer buffer;
+	char *base = initial_base;
         buffer.size = 41;
         buffer.posn = 0;
         buffer.buffer = hex;
@@ -368,7 +493,12 @@ int main(int argc, char **argv)
 	curl_easy_setopt(curl, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
 
-	base = url;
+	alt = xmalloc(sizeof(*alt));
+	alt->base = url;
+	alt->got_indices = 0;
+	alt->packs = NULL;
+	alt->next = NULL;
+	initial_base = url;
 
 	if (pull(commit_id))
 		return 1;
