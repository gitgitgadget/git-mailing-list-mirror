From: barkalow@iabervon.org
Subject: [PATCH 2/2] Support downloading packs by HTTP
Date: Sun, 31 Jul 2005 16:10:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0507311610270.23721@iabervon.org>
References: <Pine.LNX.4.62.0507311600040.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 22:10:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzK87-0000IA-GU
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 22:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVGaUJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 16:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVGaUJH
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 16:09:07 -0400
Received: from iabervon.org ([66.92.72.58]:37637 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261975AbVGaUH5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 16:07:57 -0400
Received: (qmail 24098 invoked by uid 1000); 31 Jul 2005 16:10:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jul 2005 16:10:53 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.62.0507311600040.23721@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds support to http-pull for finding the list of pack files
available on the server, downloading the index files for those pack
files, and downloading pack files when they contain needed objects not
available individually. It retains the index files even if the pack
files were not needed, but downloads the list of pack files once per
run if an object is not found separately.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

  http-pull.c |  181 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
  1 files changed, 175 insertions(+), 6 deletions(-)

dff0b76c4a2efbb8407778a1da6dc2ea2ca1458f
diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -33,7 +33,8 @@ struct buffer
  };

  static size_t fwrite_buffer(void *ptr, size_t eltsize, size_t nmemb,
-                            struct buffer *buffer) {
+                            struct buffer *buffer)
+{
          size_t size = eltsize * nmemb;
          if (size > buffer->size - buffer->posn)
                  size = buffer->size - buffer->posn;
@@ -42,8 +43,9 @@ static size_t fwrite_buffer(void *ptr, s
          return size;
  }

-static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb, 
-			       void *data) {
+static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
+			       void *data)
+{
  	unsigned char expn[4096];
  	size_t size = eltsize * nmemb;
  	int posn = 0;
@@ -65,6 +67,168 @@ static size_t fwrite_sha1_file(void *ptr
  	return size;
  }

+static int got_indices = 0;
+
+static struct packed_git *packs = NULL;
+
+static int fetch_index(unsigned char *sha1)
+{
+	char *filename;
+	char *url;
+
+	FILE *indexfile;
+
+	if (has_pack_index(sha1))
+		return 0;
+
+	if (get_verbosely)
+		fprintf(stderr, "Getting index for pack %s\n",
+			sha1_to_hex(sha1));
+ 
+	url = xmalloc(strlen(base) + 64);
+	sprintf(url, "%s/objects/pack/pack-%s.idx",
+		base, sha1_to_hex(sha1));
+ 
+	filename = sha1_pack_index_name(sha1);
+	indexfile = fopen(filename, "w");
+	if (!indexfile)
+		return error("Unable to open local file %s for pack index",
+			     filename);
+
+	curl_easy_setopt(curl, CURLOPT_FILE, indexfile);
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+ 
+	if (curl_easy_perform(curl)) {
+		fclose(indexfile);
+		return error("Unable to get pack index %s", url);
+	}
+
+	fclose(indexfile);
+	return 0;
+}
+
+static int setup_index(unsigned char *sha1)
+{
+	struct packed_git *new_pack;
+	if (has_pack_file(sha1))
+		return 0; // don't list this as something we can get
+
+	if (fetch_index(sha1))
+		return -1;
+
+	new_pack = parse_pack_index(sha1);
+	new_pack->next = packs;
+	packs = new_pack;
+	return 0;
+}
+
+static int fetch_indices(void)
+{
+	unsigned char sha1[20];
+	char *url;
+	struct buffer buffer;
+	char *data;
+	int i = 0;
+
+	if (got_indices)
+		return 0;
+
+	data = xmalloc(4096);
+	buffer.size = 4096;
+	buffer.posn = 0;
+	buffer.buffer = data;
+
+	if (get_verbosely)
+		fprintf(stderr, "Getting pack list\n");
+ 
+	url = xmalloc(strlen(base) + 21);
+	sprintf(url, "%s/objects/info/packs", base);
+
+	curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+ 
+	if (curl_easy_perform(curl)) {
+		return error("Unable to get pack index %s", url);
+	}
+
+	do {
+		switch (data[i]) {
+		case 'P':
+			i++;
+			if (i + 52 < buffer.posn &&
+			    !strncmp(data + i, " pack-", 6) &&
+			    !strncmp(data + i + 46, ".pack\n", 6)) {
+				get_sha1_hex(data + i + 6, sha1);
+				setup_index(sha1);
+				i += 51;
+				break;
+			}
+		default:
+			while (data[i] != '\n')
+				i++;
+		}
+		i++;
+	} while (i < buffer.posn);
+
+	got_indices = 1;
+	return 0;
+}
+
+static int fetch_pack(unsigned char *sha1)
+{
+	char *url;
+	struct packed_git *target;
+	struct packed_git **lst;
+	FILE *packfile;
+	char *filename;
+
+	if (fetch_indices())
+		return -1;
+	target = find_sha1_pack(sha1, packs);
+	if (!target)
+		return error("Couldn't get %s: not separate or in any pack",
+			     sha1_to_hex(sha1));
+
+	if (get_verbosely) {
+		fprintf(stderr, "Getting pack %s\n",
+			sha1_to_hex(target->sha1));
+		fprintf(stderr, " which contains %s\n",
+			sha1_to_hex(sha1));
+	}
+
+	url = xmalloc(strlen(base) + 65);
+	sprintf(url, "%s/objects/pack/pack-%s.pack",
+		base, sha1_to_hex(target->sha1));
+
+	filename = sha1_pack_name(target->sha1);
+	packfile = fopen(filename, "w");
+	if (!packfile)
+		return error("Unable to open local file %s for pack",
+			     filename);
+
+	curl_easy_setopt(curl, CURLOPT_FILE, packfile);
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+ 
+	if (curl_easy_perform(curl)) {
+		fclose(packfile);
+		return error("Unable to get pack file %s", url);
+	}
+
+	fclose(packfile);
+
+	lst = &packs;
+	while (*lst != target)
+		lst = &((*lst)->next);
+	*lst = (*lst)->next;
+
+	install_packed_git(target);
+
+	return 0;
+}
+
  int fetch(unsigned char *sha1)
  {
  	char *hex = sha1_to_hex(sha1);
@@ -76,7 +240,7 @@ int fetch(unsigned char *sha1)
  	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);

  	if (local < 0)
-		return error("Couldn't open %s\n", filename);
+		return error("Couldn't open local object %s\n", filename);

  	memset(&stream, 0, sizeof(stream));

@@ -84,6 +248,7 @@ int fetch(unsigned char *sha1)

  	SHA1_Init(&c);

+	curl_easy_setopt(curl, CURLOPT_FAILONERROR, 1);
  	curl_easy_setopt(curl, CURLOPT_FILE, NULL);
  	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);

@@ -99,8 +264,12 @@ int fetch(unsigned char *sha1)

  	curl_easy_setopt(curl, CURLOPT_URL, url);

-	if (curl_easy_perform(curl))
-		return error("Couldn't get %s for %s\n", url, hex);
+	if (curl_easy_perform(curl)) {
+		unlink(filename);
+		if (fetch_pack(sha1))
+			return error("Tried %s", url);
+		return 0;
+	}

  	close(local);
  	inflateEnd(&stream);
