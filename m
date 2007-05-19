From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Teach "delta" attribute to pack-objects.
Date: Sat, 19 May 2007 00:48:11 -0700
Message-ID: <11795608922961-git-send-email-junkio@cox.net>
References: <11795608912129-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 09:48:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpJfl-0006Ul-BG
	for gcvg-git@gmane.org; Sat, 19 May 2007 09:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029AbXESHsO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 03:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbXESHsO
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 03:48:14 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35242 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029AbXESHsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 03:48:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519074811.FMVK2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Sat, 19 May 2007 03:48:11 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0voC1X0031kojtg0000100; Sat, 19 May 2007 03:48:12 -0400
X-Mailer: git-send-email 1.5.2.rc3.87.g404f
In-Reply-To: <11795608912129-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47727>

This teaches pack-objects to use .gitattributes mechanism so
that the user can specify certain blobs are not worth spending
CPU cycles to attempt deltification.

The name of the attrbute is "delta", and when it is set to
false, like this:

	== .gitattributes ==
	*.jpg	-delta

they are always stored in the plain-compressed base object
representation.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-pack-objects.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 12d9685..651011c 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "attr.h"
 #include "object.h"
 #include "blob.h"
 #include "commit.h"
@@ -40,9 +41,10 @@ struct object_entry {
 	enum object_type in_pack_type;	/* could be delta */
 	unsigned char in_pack_header_size;
 	unsigned char preferred_base; /* we do not pack this, but is available
-				       * to be used as the base objectto delta
+				       * to be used as the base object to delta
 				       * objects against.
 				       */
+	unsigned char no_try_delta;
 };
 
 /*
@@ -737,6 +739,28 @@ static unsigned name_hash(const char *name)
 	return hash;
 }
 
+static void setup_delta_attr_check(struct git_attr_check *check)
+{
+	static struct git_attr *attr_delta;
+
+	if (!attr_delta)
+		attr_delta = git_attr("delta", 5);
+
+	check[0].attr = attr_delta;
+}
+
+static int no_try_delta(const char *path)
+{
+	struct git_attr_check check[1];
+
+	setup_delta_attr_check(check);
+	if (git_checkattr(path, ARRAY_SIZE(check), check))
+		return 0;
+	if (ATTR_FALSE(check->value))
+		return 1;
+	return 0;
+}
+
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    const char *name, int exclude)
 {
@@ -801,6 +825,9 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	if (progress)
 		display_progress(&progress_state, nr_objects);
 
+	if (name && no_try_delta(name))
+		entry->no_try_delta = 1;
+
 	return 1;
 }
 
@@ -1349,6 +1376,10 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 
 		if (entry->size < 50)
 			continue;
+
+		if (entry->no_try_delta)
+			continue;
+
 		free_delta_index(n->index);
 		n->index = NULL;
 		free(n->data);
@@ -1376,6 +1407,8 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 			m = array + other_idx;
 			if (!m->entry)
 				break;
+			if (m->entry->no_try_delta)
+				continue;
 			if (try_delta(n, m, max_depth) < 0)
 				break;
 		}
-- 
1.5.2.rc3.87.g404f
