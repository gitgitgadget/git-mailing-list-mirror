From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [2/2] Complete http-pull
Date: Sun, 1 May 2005 17:56:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505011753000.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0505011746230.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 23:57:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSMRH-0005fz-Nr
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVEAWCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 18:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVEAWA1
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 18:00:27 -0400
Received: from iabervon.org ([66.92.72.58]:52996 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262680AbVEAV4c (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 17:56:32 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSMQL-0002zI-00; Sun, 1 May 2005 17:56:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0505011746230.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds support for fetching a reference from the remote repository and
for writing to a local reference file (with the -w option). It also makes
rpull aware that it lacks this capability.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: http-pull.c
===================================================================
--- f0d6a3af54a5ec8dd588fb8e501e38f6252eda19/http-pull.c  (mode:100644 sha1:d877c4abe3ff7766d858bfeac5c9a0eaf1385b65)
+++ 6bae8854157f3f8b29f9afee2c54434334f899e4/http-pull.c  (mode:100644 sha1:9a52c08f51d8e9f96c4704f84f8d0d15637fe397)
@@ -7,6 +7,8 @@
 #include <errno.h>
 #include <stdio.h>
 
+#include "refs.h"
+
 #include "pull.h"
 
 #include <curl/curl.h>
@@ -45,6 +47,23 @@
 	return size;
 }
 
+struct buffer
+{
+	size_t posn;
+	size_t size;
+	void *buffer;
+};
+
+static size_t fwrite_buffer(void *ptr, size_t eltsize, size_t nmemb,
+			    struct buffer *buffer) {
+	size_t size = eltsize * nmemb;
+	if (size > buffer->size - buffer->posn)
+		size = buffer->size - buffer->posn;
+	memcpy(buffer->buffer + buffer->posn, ptr, size);
+	buffer->posn += size;
+	return size;
+}
+
 int fetch(unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
@@ -103,6 +122,40 @@
 	return 0;
 }
 
+int fetch_ref(char *dir, char *name, unsigned char *sha1)
+{
+	char *url, *posn;
+	char hex[42];
+	struct buffer buffer;
+	buffer.size = 41;
+	buffer.posn = 0;
+	buffer.buffer = hex;
+	hex[41] = '\0';
+	
+	curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+
+	url = xmalloc(strlen(base) + 7 + strlen(dir) + strlen(name));
+	strcpy(url, base);
+	posn = url + strlen(base);
+	strcpy(posn, "refs/");
+	posn += 5;
+	strcpy(posn, dir);
+	posn += strlen(dir);
+	*(posn++) = '/';
+	strcpy(posn, name);
+
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+
+	if (curl_easy_perform(curl))
+		return error("Couldn't get %s for %s/%s\n", url,
+			     dir, name);
+
+	hex[40] = '\0';
+	get_sha1_hex(hex, sha1);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	char *commit_id;
@@ -118,6 +171,10 @@
 			get_all = 1;
 			get_tree = 1;
 			get_history = 1;
+		} else if (argv[arg][1] == 'w') {
+			char *write_ref = argv[arg + 1];
+			split_ref(&write_ref_dir, &write_ref_name, write_ref);
+			arg++;
 		}
 		arg++;
 	}
Index: pull.c
===================================================================
--- f0d6a3af54a5ec8dd588fb8e501e38f6252eda19/pull.c  (mode:100644 sha1:90d2d41ed2c56580f72f020bc93c3e1b8a3befa5)
+++ 6bae8854157f3f8b29f9afee2c54434334f899e4/pull.c  (mode:100644 sha1:89f11906f67ea9b36e1d4d85fa87f0e9b7d08d65)
@@ -3,6 +3,12 @@
 #include "cache.h"
 #include "commit.h"
 #include "tree.h"
+#include "tag.h"
+
+#include "refs.h"
+
+char *write_ref_dir = NULL;
+char *write_ref_name = NULL;
 
 int get_tree = 0;
 int get_history = 0;
@@ -61,15 +67,53 @@
 	return 0;
 }
 
+static int process_tag(unsigned char *sha1)
+{
+	return 0;
+}
+
+static int process_unknown(unsigned char *sha1)
+{
+	struct object *obj;
+	if (fetch(sha1))
+		return -1;
+	obj = parse_object(sha1);
+	if (obj->type == commit_type)
+		return process_commit(sha1);
+	else if (obj->type == tag_type)
+		return process_tag(sha1);
+	return error("Cannot pull a %s object", obj->type);
+}
+
+static int interpret_target(char *target, unsigned char *sha1)
+{
+	char *dir, *name;
+	if (!get_sha1_hex(target, sha1))
+		return 0;
+	if (!split_ref(&dir, &name, target)) {
+		if (!fetch_ref(dir, name, sha1)) {
+			return 0;
+		}
+	}
+	return -1;
+}
+
 int pull(char *target)
 {
 	int retval;
 	unsigned char sha1[20];
-	retval = get_sha1_hex(target, sha1);
+	retval = interpret_target(target, sha1);
+	if (retval) {
+		return error("Could not interpret %s as something to pull",
+			     target);
+	}
+	retval = fetch(sha1);
 	if (retval)
 		return retval;
-	retval = fetch(sha1);
+	retval = process_unknown(sha1);
 	if (retval)
 		return retval;
-	return process_commit(sha1);
+	if (write_ref_dir && write_ref_name)
+		write_split_ref_sha1(write_ref_dir, write_ref_name, sha1);
+	return 0;
 }
Index: pull.h
===================================================================
--- f0d6a3af54a5ec8dd588fb8e501e38f6252eda19/pull.h  (mode:100644 sha1:314bc7e95ab1a73634f6a96a8a3782fda91ea261)
+++ 6bae8854157f3f8b29f9afee2c54434334f899e4/pull.h  (mode:100644 sha1:5df0ff6001ad4129dcd8b2af7c927bade8c413d2)
@@ -4,6 +4,12 @@
 /** To be provided by the particular implementation. **/
 extern int fetch(unsigned char *sha1);
 
+extern int fetch_ref(char *dir, char *name, unsigned char *sha1);
+
+/** Ref filename to write target to. **/
+extern char *write_ref_dir;
+extern char *write_ref_name;
+
 /** Set to fetch the target tree. */
 extern int get_tree;
 
Index: rpull.c
===================================================================
--- f0d6a3af54a5ec8dd588fb8e501e38f6252eda19/rpull.c  (mode:100644 sha1:6624440d5ad24854e1bd1a8dff628427581198e0)
+++ 6bae8854157f3f8b29f9afee2c54434334f899e4/rpull.c  (mode:100644 sha1:a1c1be18195d40a152f86ed35886364dbc806d80)
@@ -20,6 +20,11 @@
 	return write_sha1_from_fd(sha1, fd_in);
 }
 
+int fetch_ref(char *name, char *dir, unsigned char *sha1)
+{
+	return -1;
+}
+
 int main(int argc, char **argv)
 {
 	char *commit_id;

