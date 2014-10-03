From: Jeff King <peff@peff.net>
Subject: [PATCH 04/16] object_array: add a "clear" function
Date: Fri, 3 Oct 2014 16:22:47 -0400
Message-ID: <20141003202247.GD16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:23:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9NW-00077o-Gz
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbaJCUWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:22:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:54820 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750850AbaJCUWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:22:50 -0400
Received: (qmail 2767 invoked by uid 102); 3 Oct 2014 20:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:22:49 -0500
Received: (qmail 14969 invoked by uid 107); 3 Oct 2014 20:22:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:22:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:22:47 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257854>

There's currently no easy way to free the memory associated
with an object_array (and in most cases, we simply leak the
memory in a rev_info's pending array). Let's provide a
helper to make this easier to handle.

We can make use of it in list-objects.c, which does the same
thing by hand (but fails to free the "name" field of each
entry, potentially leaking memory).

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c |  7 +------
 object.c       | 10 ++++++++++
 object.h       |  6 ++++++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 3595ee7..fad6808 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -228,11 +228,6 @@ void traverse_commit_list(struct rev_info *revs,
 		die("unknown pending object %s (%s)",
 		    sha1_to_hex(obj->sha1), name);
 	}
-	if (revs->pending.nr) {
-		free(revs->pending.objects);
-		revs->pending.nr = 0;
-		revs->pending.alloc = 0;
-		revs->pending.objects = NULL;
-	}
+	object_array_clear(&revs->pending);
 	strbuf_release(&base);
 }
diff --git a/object.c b/object.c
index 14238dc..e36e33d 100644
--- a/object.c
+++ b/object.c
@@ -379,6 +379,16 @@ void object_array_filter(struct object_array *array,
 	array->nr = dst;
 }
 
+void object_array_clear(struct object_array *array)
+{
+	int i;
+	for (i = 0; i < array->nr; i++)
+		object_array_release_entry(&array->objects[i]);
+	free(array->objects);
+	array->objects = NULL;
+	array->nr = array->alloc = 0;
+}
+
 /*
  * Return true iff array already contains an entry with name.
  */
diff --git a/object.h b/object.h
index e028ced..2a755a2 100644
--- a/object.h
+++ b/object.h
@@ -133,6 +133,12 @@ void object_array_filter(struct object_array *array,
  */
 void object_array_remove_duplicates(struct object_array *array);
 
+/*
+ * Remove any objects from the array, freeing all used memory; afterwards
+ * the array is ready to store more objects with add_object_array().
+ */
+void object_array_clear(struct object_array *array);
+
 void clear_object_flags(unsigned flags);
 
 #endif /* OBJECT_H */
-- 
2.1.1.566.gdb1f904
