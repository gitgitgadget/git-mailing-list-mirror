From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/4] Pull refs by HTTP
Date: Fri, 13 May 2005 02:57:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505130256150.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 08:51:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWU0T-0000Jl-S2
	for gcvg-git@gmane.org; Fri, 13 May 2005 08:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVEMG6d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 02:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVEMG6d
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 02:58:33 -0400
Received: from iabervon.org ([66.92.72.58]:58373 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262269AbVEMG6W (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 02:58:22 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DWU7S-0008Nb-00; Fri, 13 May 2005 02:57:58 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Adds support for pulling refs by HTTP, and an option for writing the
pulled ref to a file.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: http-pull.c
===================================================================
--- 90e05f81df7b7fd2c39d252b6f9a2374d4dd0cf5/http-pull.c  (mode:100644 sha1:af4e82fdf9c58a15564d40bef85d57e9f6626727)
+++ 4931f2d8b9c2ab83718f6446d5ef3af5fa320b3f/http-pull.c  (mode:100644 sha1:6e8dc48ddd0ea1ae89074f6ae0d89c54303895b7)
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
@@ -93,14 +112,42 @@
 		unlink(filename);
 		return error("File %s has bad hash\n", hex);
 	}
-	
 	pull_say("got %s\n", hex);
 	return 0;
 }
 
 int fetch_ref(char *dir, char *name, unsigned char *sha1)
 {
-	return -1;
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
 }
 
 int main(int argc, char **argv)
@@ -120,6 +167,10 @@
 			get_history = 1;
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
+		} else if (argv[arg][1] == 'w') {
+			char *write_ref = argv[arg + 1];
+			split_ref(&write_ref_dir, &write_ref_name, write_ref);
+			arg++;
 		}
 		arg++;
 	}

