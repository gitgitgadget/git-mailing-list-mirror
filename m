From: Jeff King <peff@peff.net>
Subject: [PATCH v2 03/25] object_array: factor out slopbuf-freeing logic
Date: Wed, 15 Oct 2014 18:34:19 -0400
Message-ID: <20141015223419.GC25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:34:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeX9F-0003kh-OJ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbaJOWeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:34:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:58924 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750721AbaJOWeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:34:21 -0400
Received: (qmail 2077 invoked by uid 102); 15 Oct 2014 22:34:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:34:21 -0500
Received: (qmail 27875 invoked by uid 107); 15 Oct 2014 22:34:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:34:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:34:19 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is not a lot of code, but it's a logical construct that
should not need to be repeated (and we are about to add a
third repetition).

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index ca9d790..60f4864 100644
--- a/object.c
+++ b/object.c
@@ -355,6 +355,16 @@ void add_object_array_with_context(struct object *obj, const char *name, struct
 		add_object_array_with_mode_context(obj, name, array, S_IFINVALID, context);
 }
 
+/*
+ * Free all memory associated with an entry; the result is
+ * in an unspecified state and should not be examined.
+ */
+static void object_array_release_entry(struct object_array_entry *ent)
+{
+	if (ent->name != object_array_slopbuf)
+		free(ent->name);
+}
+
 void object_array_filter(struct object_array *array,
 			 object_array_each_func_t want, void *cb_data)
 {
@@ -367,8 +377,7 @@ void object_array_filter(struct object_array *array,
 				objects[dst] = objects[src];
 			dst++;
 		} else {
-			if (objects[src].name != object_array_slopbuf)
-				free(objects[src].name);
+			object_array_release_entry(&objects[src]);
 		}
 	}
 	array->nr = dst;
@@ -400,8 +409,7 @@ void object_array_remove_duplicates(struct object_array *array)
 				objects[array->nr] = objects[src];
 			array->nr++;
 		} else {
-			if (objects[src].name != object_array_slopbuf)
-				free(objects[src].name);
+			object_array_release_entry(&objects[src]);
 		}
 	}
 }
-- 
2.1.2.596.g7379948
