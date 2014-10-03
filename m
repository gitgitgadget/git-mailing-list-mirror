From: Jeff King <peff@peff.net>
Subject: [PATCH 03/16] object_array: factor out slopbuf-freeing logic
Date: Fri, 3 Oct 2014 16:22:22 -0400
Message-ID: <20141003202222.GC16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:22:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9My-0006ut-Hy
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbaJCUWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:22:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:54813 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750850AbaJCUWY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:22:24 -0400
Received: (qmail 2708 invoked by uid 102); 3 Oct 2014 20:22:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:22:24 -0500
Received: (qmail 14944 invoked by uid 107); 3 Oct 2014 20:22:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:22:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:22:22 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257853>

This is not a lot of code, but it's a logical construct that
should not need to be repeated (and we are about to add a
third repetition).

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index ca9d790..14238dc 100644
--- a/object.c
+++ b/object.c
@@ -355,6 +355,12 @@ void add_object_array_with_context(struct object *obj, const char *name, struct
 		add_object_array_with_mode_context(obj, name, array, S_IFINVALID, context);
 }
 
+static void object_array_release_entry(struct object_array_entry *ent)
+{
+	if (ent->name != object_array_slopbuf)
+		free(ent->name);
+}
+
 void object_array_filter(struct object_array *array,
 			 object_array_each_func_t want, void *cb_data)
 {
@@ -367,8 +373,7 @@ void object_array_filter(struct object_array *array,
 				objects[dst] = objects[src];
 			dst++;
 		} else {
-			if (objects[src].name != object_array_slopbuf)
-				free(objects[src].name);
+			object_array_release_entry(&objects[src]);
 		}
 	}
 	array->nr = dst;
@@ -400,8 +405,7 @@ void object_array_remove_duplicates(struct object_array *array)
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
2.1.1.566.gdb1f904
