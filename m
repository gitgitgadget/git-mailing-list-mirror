From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 07/10] unpack-object: cache for non written objects
Date: Mon, 25 Feb 2008 22:54:57 +0100
Message-ID: <12039765002534-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002397-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765001192-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:56:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlIo-0006Td-L7
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757023AbYBYVz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759854AbYBYVz1
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:55:27 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55610 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759606AbYBYVzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:55:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 0EEB7680BF93;
	Mon, 25 Feb 2008 22:55:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g6fX1dIpENbG; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 63B186870AA0; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12039765001192-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75076>

Preventing objects with broken links entering the repository
means, that write of some objects must be delayed.

This patch adds a cache to keep the object data in memory. The delta
resolving code must also search in the cache.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-unpack-objects.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 1e51865..f18c7e8 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -8,6 +8,7 @@
 #include "tag.h"
 #include "tree.h"
 #include "progress.h"
+#include "decorate.h"
 
 static int dry_run, quiet, recover, has_errors;
 static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-file";
@@ -18,6 +19,28 @@ static unsigned int offset, len;
 static off_t consumed_bytes;
 static SHA_CTX ctx;
 
+struct obj_buffer {
+	char *buffer;
+	unsigned long size;
+};
+
+static struct decoration obj_decorate;
+
+static struct obj_buffer *lookup_object_buffer(struct object *base)
+{
+	return lookup_decoration(&obj_decorate, base);
+}
+
+static void add_object_buffer(struct object *object, char *buffer, unsigned long size)
+{
+	struct obj_buffer *obj;
+	obj = xcalloc(1, sizeof(struct obj_buffer));
+	obj->buffer = buffer;
+	obj->size = size;
+	if (add_decoration(&obj_decorate, object, obj))
+		die("object %s tried to add buffer twice!", sha1_to_hex(object->sha1));
+}
+
 /*
  * Make sure at least "min" bytes are available in the buffer, and
  * return the pointer to the buffer.
@@ -252,6 +275,15 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		}
 	}
 
+	struct object* obj = lookup_object(base_sha1);
+	if (obj) {
+		struct obj_buffer *obj_buf = lookup_object_buffer (obj);
+		if (obj_buf) {
+			resolve_delta(nr, obj->type, obj_buf->buffer, obj_buf->size, delta_data, delta_size);
+			return;
+		}
+	}
+
 	base = read_sha1_file(base_sha1, &type, &base_size);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
-- 
1.5.4.3.g3c5f
