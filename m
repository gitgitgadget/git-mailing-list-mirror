From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [2/5] Add tag header/parser to library
Date: Thu, 28 Apr 2005 01:06:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504280105010.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 07:03:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR1Ak-0007Ck-Ki
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVD1FIA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVD1FH7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:07:59 -0400
Received: from iabervon.org ([66.92.72.58]:51716 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261987AbVD1FHA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 01:07:00 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DR1Eg-0001EC-00; Thu, 28 Apr 2005 01:06:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds preliminary support for tags in the library. It doesn't even
store the signature, however, let alone provide any way of checking it.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 40a5a5657d67569bdc0e37b8ea2b76ec42824604/Makefile  (mode:100644 sha1:2d2913b6b98ac836b43755b1304d2a838dad87dd)
+++ e08498de8d0216a24378c454597ecb38f65c4ee1/Makefile  (mode:100644 sha1:b533a2834da564f2fc8d00680aeac59c9d197bd8)
@@ -25,7 +25,7 @@
 install: $(PROG) $(SCRIPTS)
 	install $(PROG) $(SCRIPTS) $(HOME)/bin/
 
-LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o
+LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o tag.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h
 
Index: tag.c
===================================================================
--- /dev/null  (tree:40a5a5657d67569bdc0e37b8ea2b76ec42824604)
+++ e08498de8d0216a24378c454597ecb38f65c4ee1/tag.c  (mode:100644 sha1:f079d83a9de5c3d6d98b2a29339ec1ef3a25f333)
@@ -0,0 +1,73 @@
+#include "tag.h"
+#include "cache.h"
+
+const char *tag_type = "tag";
+
+struct tag *lookup_tag(unsigned char *sha1)
+{
+        struct object *obj = lookup_object(sha1);
+        if (!obj) {
+                struct tag *ret = xmalloc(sizeof(struct tag));
+                memset(ret, 0, sizeof(struct tag));
+                created_object(sha1, &ret->object);
+                ret->object.type = tag_type;
+                return ret;
+        }
+        if (obj->type != tag_type) {
+                error("Object %s is a %s, not a tree", 
+                      sha1_to_hex(sha1), obj->type);
+                return NULL;
+        }
+        return (struct tag *) obj;
+}
+
+int parse_tag(struct tag *item)
+{
+        char type[20];
+        void *data, *bufptr;
+        unsigned long size;
+        if (item->object.parsed)
+                return 0;
+        item->object.parsed = 1;
+        data = bufptr = read_sha1_file(item->object.sha1, type, &size);
+        if (!data)
+                return error("Could not read %s",
+                             sha1_to_hex(item->object.sha1));
+        if (strcmp(type, tag_type))
+                return error("Object %s not a tag",
+                             sha1_to_hex(item->object.sha1));
+
+	int typelen, taglen;
+	unsigned char object[20];
+	const char *type_line, *tag_line, *sig_line;
+
+	if (size < 64)
+		return -1;
+	if (memcmp("object ", data, 7) || get_sha1_hex(data + 7, object))
+		return -1;
+
+	item->tagged = parse_object(object);
+
+	type_line = data + 48;
+	if (memcmp("\ntype ", type_line-1, 6))
+		return -1;
+
+	tag_line = strchr(type_line, '\n');
+	if (!tag_line || memcmp("tag ", ++tag_line, 4))
+		return -1;
+
+	sig_line = strchr(tag_line, '\n');
+	if (!sig_line)
+		return -1;
+	sig_line++;
+
+	typelen = tag_line - type_line - strlen("type \n");
+	if (typelen >= 20)
+		return -1;
+	taglen = sig_line - tag_line - strlen("tag \n");
+	item->tag = xmalloc(taglen + 1);
+	memcpy(item->tag, tag_line + 4, taglen);
+	item->tag[taglen] = '\0';
+
+	return 0;
+}
Index: tag.h
===================================================================
--- /dev/null  (tree:40a5a5657d67569bdc0e37b8ea2b76ec42824604)
+++ e08498de8d0216a24378c454597ecb38f65c4ee1/tag.h  (mode:100644 sha1:7ae7864d8a8477bfd22d4e29d78119d345f2bbb9)
@@ -0,0 +1,15 @@
+#ifndef TAG_H
+#define TAG_H
+
+#include "object.h"
+
+extern const char *tag_type;
+
+struct tag {
+	struct object object;
+	struct object *tagged;
+	char *tag;
+	char *signature; /* not actually implemented */
+};
+
+#endif /* TAG_H */

