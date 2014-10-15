From: Jeff King <peff@peff.net>
Subject: [PATCH v2 04/25] object_array: add a "clear" function
Date: Wed, 15 Oct 2014 18:34:34 -0400
Message-ID: <20141015223434.GD25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:34:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeX9U-0003ro-HV
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbaJOWeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:34:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:58928 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751202AbaJOWeg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:34:36 -0400
Received: (qmail 2088 invoked by uid 102); 15 Oct 2014 22:34:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:34:36 -0500
Received: (qmail 27893 invoked by uid 107); 15 Oct 2014 22:34:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:34:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:34:34 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 60f4864..6aeb1bb 100644
--- a/object.c
+++ b/object.c
@@ -383,6 +383,16 @@ void object_array_filter(struct object_array *array,
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
2.1.2.596.g7379948
