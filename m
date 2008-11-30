From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] upload-pack.c: refactor receive_needs()
Date: Sun, 30 Nov 2008 01:57:32 -0800
Message-ID: <1228039053-31099-5-git-send-email-gitster@pobox.com>
References: <1228039053-31099-1-git-send-email-gitster@pobox.com>
 <1228039053-31099-2-git-send-email-gitster@pobox.com>
 <1228039053-31099-3-git-send-email-gitster@pobox.com>
 <1228039053-31099-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:00:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6j5t-00017W-2R
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbYK3J6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 04:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbYK3J6X
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 04:58:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYK3J6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 04:58:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D87082474
	for <git@vger.kernel.org>; Sun, 30 Nov 2008 04:58:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C68BD82472 for
 <git@vger.kernel.org>; Sun, 30 Nov 2008 04:58:12 -0500 (EST)
X-Mailer: git-send-email 1.6.0.4.850.g6bd829
In-Reply-To: <1228039053-31099-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6B23D8E4-BEC5-11DD-9763-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101957>

At the end of the function it had a block of "shallow fetch" support code
that assumed it will be the last protocol extension ever by returning
early.  Move the bulky code away into a separate function to make it
maintainable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c |   97 ++++++++++++++++++++++++++++++---------------------------
 1 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..4029019 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -444,6 +444,56 @@ static int get_common_commits(void)
 	}
 }
 
+static void exchange_shallows(int depth, struct object_array *shallows)
+{
+	if (depth == 0 && shallows->nr == 0)
+		return;
+	if (depth > 0) {
+		struct commit_list *result, *backup;
+		int i;
+		backup = result = get_shallow_commits(&want_obj, depth,
+			SHALLOW, NOT_SHALLOW);
+		while (result) {
+			struct object *object = &result->item->object;
+			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
+				packet_write(1, "shallow %s",
+						sha1_to_hex(object->sha1));
+				register_shallow(object->sha1);
+			}
+			result = result->next;
+		}
+		free_commit_list(backup);
+		for (i = 0; i < shallows->nr; i++) {
+			struct object *object = shallows->objects[i].item;
+			if (object->flags & NOT_SHALLOW) {
+				struct commit_list *parents;
+				packet_write(1, "unshallow %s",
+					sha1_to_hex(object->sha1));
+				object->flags &= ~CLIENT_SHALLOW;
+				/* make sure the real parents are parsed */
+				unregister_shallow(object->sha1);
+				object->parsed = 0;
+				if (parse_commit((struct commit *)object))
+					die("invalid commit");
+				parents = ((struct commit *)object)->parents;
+				while (parents) {
+					add_object_array(&parents->item->object,
+							NULL, &want_obj);
+					parents = parents->next;
+				}
+			}
+			/* make sure commit traversal conforms to client */
+			register_shallow(object->sha1);
+		}
+		packet_flush(1);
+	} else
+		if (shallows->nr > 0) {
+			int i;
+			for (i = 0; i < shallows->nr; i++)
+				register_shallow(shallows->objects[i].item->sha1);
+		}
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows = {0, 0, NULL};
@@ -520,52 +570,7 @@ static void receive_needs(void)
 	}
 	if (debug_fd)
 		write_in_full(debug_fd, "#E\n", 3);
-	if (depth == 0 && shallows.nr == 0)
-		return;
-	if (depth > 0) {
-		struct commit_list *result, *backup;
-		int i;
-		backup = result = get_shallow_commits(&want_obj, depth,
-			SHALLOW, NOT_SHALLOW);
-		while (result) {
-			struct object *object = &result->item->object;
-			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
-				packet_write(1, "shallow %s",
-						sha1_to_hex(object->sha1));
-				register_shallow(object->sha1);
-			}
-			result = result->next;
-		}
-		free_commit_list(backup);
-		for (i = 0; i < shallows.nr; i++) {
-			struct object *object = shallows.objects[i].item;
-			if (object->flags & NOT_SHALLOW) {
-				struct commit_list *parents;
-				packet_write(1, "unshallow %s",
-					sha1_to_hex(object->sha1));
-				object->flags &= ~CLIENT_SHALLOW;
-				/* make sure the real parents are parsed */
-				unregister_shallow(object->sha1);
-				object->parsed = 0;
-				if (parse_commit((struct commit *)object))
-					die("invalid commit");
-				parents = ((struct commit *)object)->parents;
-				while (parents) {
-					add_object_array(&parents->item->object,
-							NULL, &want_obj);
-					parents = parents->next;
-				}
-			}
-			/* make sure commit traversal conforms to client */
-			register_shallow(object->sha1);
-		}
-		packet_flush(1);
-	} else
-		if (shallows.nr > 0) {
-			int i;
-			for (i = 0; i < shallows.nr; i++)
-				register_shallow(shallows.objects[i].item->sha1);
-		}
+	exchange_shallows(depth, &shallows);
 	free(shallows.objects);
 }
 
-- 
1.6.0.4.850.g6bd829
