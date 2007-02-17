From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Add `struct object_hash`
Date: Sat, 17 Feb 2007 18:38:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702171838150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Feb 17 18:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HITWR-0000Ze-LK
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 18:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992954AbXBQRiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 12:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992802AbXBQRiw
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 12:38:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:41460 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992954AbXBQRiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 12:38:52 -0500
Received: (qmail invoked by alias); 17 Feb 2007 17:38:50 -0000
X-Provags-ID: V01U2FsdGVkX199QbdOEZl9NaNCoy8IxXf1OlL+rx0TZQapB3FUcZ
	NtOw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39993>


Using object_hash, you can store interesting information about
objects in a private hash map. This makes up for the lack of a
`util` member of `struct object`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	We should have done that earlier. Now, git.git already
	contains two specialised versions of an object hash map:
	obj_hash and refs_hash.

	obj_hash is not really a hash map, but rather a hash set,
	but there is no excuse for refs_hash having its own little
	private implementation nobody else can reuse.

 Makefile      |    2 +-
 object-hash.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 object-hash.h |   19 ++++++++++++++++
 3 files changed, 87 insertions(+), 1 deletions(-)
 create mode 100644 object-hash.c
 create mode 100644 object-hash.h

diff --git a/Makefile b/Makefile
index dfe226f..e53a5ad 100644
--- a/Makefile
+++ b/Makefile
@@ -267,7 +267,7 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o
+	convert.o object-hash.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/object-hash.c b/object-hash.c
new file mode 100644
index 0000000..2295e33
--- /dev/null
+++ b/object-hash.c
@@ -0,0 +1,67 @@
+#include "cache.h"
+#include "object.h"
+#include "object-hash.h"
+
+static unsigned int hash_obj(struct object *obj, unsigned int n)
+{
+	unsigned int hash = *(unsigned int *)obj->sha1;
+	return hash % n;
+}
+
+static void insert_object_into_hash(struct object *object, void *util,
+		struct object_hash *hash)
+{
+	int j = hash_obj(object, hash->size);
+
+	while (hash->hash[j].object) {
+		j++;
+		if (j >= hash->size)
+			j = 0;
+	}
+	hash->hash[j].object = object;
+	hash->hash[j].util = util;
+}
+
+static void grow_object_hash(struct object_hash *hash)
+{
+	struct object_hash_entry *old_hash = hash->hash;
+	int new_size = (hash->size + 1000) * 3 / 2, i;
+
+	hash->hash = xcalloc(sizeof(struct object_hash_entry), new_size);
+	for (i = 0; i < hash->size; i++) {
+		struct object_hash_entry *entry = old_hash + i;
+		if (!entry->object)
+			continue;
+		insert_object_into_hash(entry->object, entry->util, hash);
+	}
+	hash->size = new_size;
+	free(old_hash);
+}
+
+void add_object_to_hash(struct object *obj, void *util,
+		struct object_hash *hash)
+{
+	if (++hash->nr > hash->size * 2 / 3)
+		grow_object_hash(hash);
+	insert_object_into_hash(obj, util, hash);
+}
+
+void *lookup_object_in_hash(struct object *obj, struct object_hash *hash)
+{
+	int j;
+
+	/* nothing to lookup */
+	if (!hash->size)
+		return NULL;
+	j = hash_obj(obj, hash->size);
+	while (hash->hash[j].object) {
+		if (hash->hash[j].object == obj)
+			return hash->hash[j].util;
+		j++;
+		if (j >= hash->size)
+			j = 0;
+	}
+	return NULL;
+}
+
+
diff --git a/object-hash.h b/object-hash.h
new file mode 100644
index 0000000..0da7824
--- /dev/null
+++ b/object-hash.h
@@ -0,0 +1,19 @@
+#ifndef OBJECT_HASH_H
+#define OBJECT_HASH_H
+
+struct object_hash_entry {
+	struct object *object;
+	void *util;
+};
+
+struct object_hash {
+	unsigned int size, nr;
+	struct object_hash_entry *hash;
+};
+
+extern void add_object_to_hash(struct object *obj, void *util,
+		struct object_hash *hash);
+extern void *lookup_object_in_hash(struct object *obj,
+		struct object_hash *hash);
+
+#endif
-- 
1.5.0.2139.gdafc9-dirty
