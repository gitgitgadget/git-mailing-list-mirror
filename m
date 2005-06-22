From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Pull refs by HTTP
Date: Tue, 21 Jun 2005 20:45:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506212043540.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 22 02:43:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DktKD-0003YK-Dy
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 02:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVFVAsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 20:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVFVAsN
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 20:48:13 -0400
Received: from iabervon.org ([66.92.72.58]:51974 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262417AbVFVArY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 20:47:24 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DktNG-0003x2-00; Tue, 21 Jun 2005 20:45:50 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds support for refs to http-pull, both the -w option and reading
the target from a served file.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: http-pull.c
===================================================================
--- b6a510708036fe29a19c33472f5c0b746e2d26d7/http-pull.c  (mode:100644 sha1:f49525c00228b5db9dc2fbd4860883887bb7dbad)
+++ bc8b6802c7004e93b812698bd699c3548906653b/http-pull.c  (mode:100644 sha1:ec53dad8efbe6e7734b75eaba8821ac290a5abbb)
@@ -16,6 +16,23 @@
 static int local;
 static int zret;
 
+struct buffer
+{
+        size_t posn;
+        size_t size;
+        void *buffer;
+};
+
+static size_t fwrite_buffer(void *ptr, size_t eltsize, size_t nmemb,
+                            struct buffer *buffer) {
+        size_t size = eltsize * nmemb;
+        if (size > buffer->size - buffer->posn)
+                size = buffer->size - buffer->posn;
+        memcpy(buffer->buffer + buffer->posn, ptr, size);
+        buffer->posn += size;
+        return size;
+}
+
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb, 
 			       void *data) {
 	unsigned char expn[4096];
@@ -94,7 +111,32 @@
 
 int fetch_ref(char *ref, unsigned char *sha1)
 {
-	return -1;
+        char *url, *posn;
+        char hex[42];
+        struct buffer buffer;
+        buffer.size = 41;
+        buffer.posn = 0;
+        buffer.buffer = hex;
+        hex[41] = '\0';
+        
+        curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
+        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+
+        url = xmalloc(strlen(base) + 6 + strlen(ref));
+        strcpy(url, base);
+        posn = url + strlen(base);
+        strcpy(posn, "refs/");
+        posn += 5;
+        strcpy(posn, ref);
+
+        curl_easy_setopt(curl, CURLOPT_URL, url);
+
+        if (curl_easy_perform(curl))
+                return error("Couldn't get %s for %s\n", url, ref);
+
+        hex[40] = '\0';
+        get_sha1_hex(hex, sha1);
+        return 0;
 }
 
 int main(int argc, char **argv)
@@ -118,11 +160,14 @@
 			get_history = 1;
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
+		} else if (argv[arg][1] == 'w') {
+			write_ref = argv[arg + 1];
+			arg++;
 		}
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("git-http-pull [-c] [-t] [-a] [-d] [-v] [--recover] commit-id url");
+		usage("git-http-pull [-c] [-t] [-a] [-d] [-v] [--recover] [-w ref] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];

