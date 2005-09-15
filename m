From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH RFC] Add support for alternates in HTTP
Date: Wed, 14 Sep 2005 23:26:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509142319330.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 05:23:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFkK3-00079a-7m
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 05:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVIODWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 23:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVIODWA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 23:22:00 -0400
Received: from iabervon.org ([66.92.72.58]:48141 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750896AbVIODV7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 23:21:59 -0400
Received: (qmail 10489 invoked by uid 1000); 14 Sep 2005 23:26:08 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Sep 2005 23:26:08 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8580>

This tries .../objects/info/http-alternates and then
.../objects/info/alternates, looking for a file which specifies where
else to download objects and packs from.

It currently only supports absolute paths, and doesn't support full URLs.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---
This is probably pu material at this point; there's a bit more parsing 
work that ought to get done once there are suitable test cases out there 
for me to try.

It tries to find additional places it should look for things to download. 
What I'd like it to do is:

 Try .../objects/info/http-alternates, which can be a full URL, an 
 absolute path (same server), or a relative path based on the objects 
 directory. This should specify the objects directory, not the base.

 Try .../objects/info/alternates, which can be a relative path as above, 
 or, just in case it works, an absolute path.

Currently implemented are the two absolute path cases, which let me fetch 
from the aegl repository, getting Linus's pack from his repository.

 http-fetch.c |  169 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 134 insertions(+), 35 deletions(-)

c01c2fc40aafddc23a14ffdc07de3bf950e323a4
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -15,7 +15,17 @@
 
 static CURL *curl;
 
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
@@ -71,11 +81,9 @@ void prefetch(unsigned char *sha1)
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
@@ -89,9 +97,9 @@ static int fetch_index(unsigned char *sh
 		fprintf(stderr, "Getting index for pack %s\n",
 			sha1_to_hex(sha1));
 	
-	url = xmalloc(strlen(base) + 64);
+	url = xmalloc(strlen(repo->base) + 64);
 	sprintf(url, "%s/objects/pack/pack-%s.idx",
-		base, sha1_to_hex(sha1));
+		repo->base, sha1_to_hex(sha1));
 	
 	filename = sha1_pack_index_name(sha1);
 	indexfile = fopen(filename, "w");
@@ -112,22 +120,92 @@ static int fetch_index(unsigned char *sh
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
+	if (got_alternates)
+		return 0;
+	data = xmalloc(4096);
+	buffer.size = 4096;
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
+	while (i < buffer.posn) {
+		int posn = i;
+		while (posn < buffer.posn && data[posn] != '\n')
+			posn++;
+		if (data[posn] == '\n') {
+			if (data[i] == '/') {
+				int serverlen = strchr(base + 8, '/') - base;
+				// skip 'objects' at end
+				char *target = 
+					xmalloc(serverlen + posn - i - 6);
+				struct alt_base *newalt;
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
@@ -135,7 +213,7 @@ static int fetch_indices(void)
 	char *data;
 	int i = 0;
 
-	if (got_indices)
+	if (repo->got_indices)
 		return 0;
 
 	data = xmalloc(4096);
@@ -146,8 +224,8 @@ static int fetch_indices(void)
 	if (get_verbosely)
 		fprintf(stderr, "Getting pack list\n");
 	
-	url = xmalloc(strlen(base) + 21);
-	sprintf(url, "%s/objects/info/packs", base);
+	url = xmalloc(strlen(repo->base) + 21);
+	sprintf(url, "%s/objects/info/packs", repo->base);
 
 	curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
@@ -157,7 +235,7 @@ static int fetch_indices(void)
 		return error("Unable to get pack index %s", url);
 	}
 
-	do {
+	while (i < buffer.posn) {
 		switch (data[i]) {
 		case 'P':
 			i++;
@@ -165,7 +243,7 @@ static int fetch_indices(void)
 			    !strncmp(data + i, " pack-", 6) &&
 			    !strncmp(data + i + 46, ".pack\n", 6)) {
 				get_sha1_hex(data + i + 6, sha1);
-				setup_index(sha1);
+				setup_index(repo, sha1);
 				i += 51;
 				break;
 			}
@@ -174,13 +252,13 @@ static int fetch_indices(void)
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
@@ -188,12 +266,11 @@ static int fetch_pack(unsigned char *sha
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
@@ -202,9 +279,9 @@ static int fetch_pack(unsigned char *sha
 			sha1_to_hex(sha1));
 	}
 
-	url = xmalloc(strlen(base) + 65);
+	url = xmalloc(strlen(repo->base) + 65);
 	sprintf(url, "%s/objects/pack/pack-%s.pack",
-		base, sha1_to_hex(target->sha1));
+		repo->base, sha1_to_hex(target->sha1));
 
 	filename = sha1_pack_name(target->sha1);
 	packfile = fopen(filename, "w");
@@ -223,7 +300,7 @@ static int fetch_pack(unsigned char *sha
 
 	fclose(packfile);
 
-	lst = &packs;
+	lst = &repo->packs;
 	while (*lst != target)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
@@ -233,7 +310,7 @@ static int fetch_pack(unsigned char *sha
 	return 0;
 }
 
-int fetch(unsigned char *sha1)
+int fetch_object(struct alt_base *repo, unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
 	char *filename = sha1_file_name(sha1);
@@ -256,9 +333,9 @@ int fetch(unsigned char *sha1)
 	curl_easy_setopt(curl, CURLOPT_FILE, NULL);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 
-	url = xmalloc(strlen(base) + 50);
-	strcpy(url, base);
-	posn = url + strlen(base);
+	url = xmalloc(strlen(repo->base) + 50);
+	strcpy(url, repo->base);
+	posn = url + strlen(repo->base);
 	strcpy(posn, "objects/");
 	posn += 8;
 	memcpy(posn, hex, 2);
@@ -270,9 +347,7 @@ int fetch(unsigned char *sha1)
 
 	if (curl_easy_perform(curl)) {
 		unlink(filename);
-		if (fetch_pack(sha1))
-			return error("Tried %s", url);
-		return 0;
+		return -1;
 	}
 
 	close(local);
@@ -291,11 +366,30 @@ int fetch(unsigned char *sha1)
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
@@ -361,7 +455,12 @@ int main(int argc, char **argv)
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
