From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/25] object_array_entry: fix memory handling of the name field
Date: Sat, 25 May 2013 11:08:14 +0200
Message-ID: <1369472904-12875-16-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:10:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAUv-0005zn-SU
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab3EYJJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:21 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:53315 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754347Ab3EYJJS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:18 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-d0-51a07fbd337f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.43.02380.DBF70A15; Sat, 25 May 2013 05:09:17 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gup000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:16 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqLu3fkGgwbqTFhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzjjTt4S94JZexacZs9gbGNeodjFyckgImEis+/iVEcIWk7hwbz1b
	FyMXh5DAZUaJrUu/MEI4F5gkbnX3MYNUsQnoSizqaWYCsUUEHCVOPLjOClLELNDLKPHw0Xew
	hLBAsMStKffAGlgEVCXm7DzLBmLzCrhKrF+5GGqdgsTlWWuAajg4OIHib09wgoSFBFwknn86
	xzqBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3UlNJNjJBA49vB2L5e5hCj
	AAejEg+vQPn8QCHWxLLiytxDjJIcTEqivPy1CwKF+JLyUyozEosz4otKc1KLDzFKcDArifAy
	pADleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvB51QI2CRanpqRVp
	mTklCGkmDk4QwQWygQdow1mQQt7igsTc4sx0iKJTjIpS4rwTQRICIImM0jy4AbCU8IpRHOgf
	Yd4FIFU8wHQC1/0KaDAT0OCbufNBBpckIqSkGhh53qne+LLT67Vj6rKmZypM10/NntT8l6W0
	aXfzM885FwMnXknLuly07n/F2pkrL2ldftadePft0adpyzafzlM8uT3+TRrbwl1HdG5NXGQv
	Xcd079O1Xa3M3X+jDvrbyF88sWHK51U2QlP6m/MMlh1ZZ7qZe9bcKj3+trAtyWdX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225509>

Previously, the memory management of the object_array_entry::name
field was inconsistent and undocumented.  object_array_entries are
ultimately created by a single function, add_object_array_with_mode(),
which has an argument "const char *name".  This function used to
simply set the name field to reference the string pointed to by the
name parameter, and nobody on the object_array side ever freed the
memory.  Thus, it assumed that the memory for the name field would be
managed by the caller, and that the lifetime of that string would be
at least as long as the lifetime of the object_array_entry.  But
callers were inconsistent:

* Some passed pointers to constant strings or argv entries, which was
  OK.

* Some passed pointers to newly-allocated memory, but didn't arrange
  for the memory ever to be freed.

* Some passed the return value of sha1_to_hex(), which is a pointer to
  a statically-allocated buffer that can be overwritten at any time.

* Some passed pointers to refnames that they received from a
  for_each_ref()-type iteration, but the lifetimes of such refnames is
  not guaranteed by the refs API.

Bring consistency to this mess by changing object_array to make its
own copy for the object_array_entry::name field and free this memory
when an object_array_entry is deleted from the array.

Many callers were passing the empty string as the name parameter, so
as a performance optimization, treat the empty string specially.
Instead of making a copy, store a pointer to a statically-allocated
empty string to object_array_entry::name.  When deleting such an
entry, skip the free().

Change the callers that were already passing copies to
add_object_array_with_mode() to either skip the copy, or (if the
memory needed to be allocated anyway) freeing the memory itself.

A part of this commit effectively reverts

    70d26c6e76 read_revisions_from_stdin: make copies for handle_revision_arg

because the copying introduced by that commit (which is still
necessary) is now done at a deeper level.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 bundle.c   |  2 +-
 object.c   | 26 +++++++++++++++++++++++---
 object.h   |  8 +++++++-
 revision.c |  6 ++++--
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4b0e5cd..3d64311 100644
--- a/bundle.c
+++ b/bundle.c
@@ -281,7 +281,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 			if (!get_sha1_hex(buf.buf + 1, sha1)) {
 				struct object *object = parse_object_or_die(sha1, buf.buf);
 				object->flags |= UNINTERESTING;
-				add_pending_object(&revs, object, xstrdup(buf.buf));
+				add_pending_object(&revs, object, buf.buf);
 			}
 		} else if (!get_sha1_hex(buf.buf, sha1)) {
 			struct object *object = parse_object_or_die(sha1, buf.buf);
diff --git a/object.c b/object.c
index 10b5349..e4ff714 100644
--- a/object.c
+++ b/object.c
@@ -260,11 +260,18 @@ void add_object_array(struct object *obj, const char *name, struct object_array
 	add_object_array_with_mode(obj, name, array, S_IFINVALID);
 }
 
+/*
+ * A zero-length string to which object_array_entry::name can be
+ * initialized without requiring a malloc/free.
+ */
+char object_array_slopbuf[1];
+
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
 {
 	unsigned nr = array->nr;
 	unsigned alloc = array->alloc;
 	struct object_array_entry *objects = array->objects;
+	struct object_array_entry *entry;
 
 	if (nr >= alloc) {
 		alloc = (alloc + 32) * 2;
@@ -272,9 +279,16 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
 		array->alloc = alloc;
 		array->objects = objects;
 	}
-	objects[nr].item = obj;
-	objects[nr].name = name;
-	objects[nr].mode = mode;
+	entry = &objects[nr];
+	entry->item = obj;
+	if (!name)
+		entry->name = NULL;
+	else if (!*name)
+		/* Use our own empty string instead of allocating one: */
+		entry->name = object_array_slopbuf;
+	else
+		entry->name = xstrdup(name);
+	entry->mode = mode;
 	array->nr = ++nr;
 }
 
@@ -289,6 +303,9 @@ void object_array_filter(struct object_array *array,
 			if (src != dst)
 				objects[dst] = objects[src];
 			dst++;
+		} else {
+			if (objects[src].name != object_array_slopbuf)
+				free(objects[src].name);
 		}
 	}
 	array->nr = dst;
@@ -319,6 +336,9 @@ void object_array_remove_duplicates(struct object_array *array)
 			if (src != array->nr)
 				objects[array->nr] = objects[src];
 			array->nr++;
+		} else {
+			if (objects[src].name != object_array_slopbuf)
+				free(objects[src].name);
 		}
 	}
 }
diff --git a/object.h b/object.h
index 6c1c27f..2ff68c5 100644
--- a/object.h
+++ b/object.h
@@ -11,7 +11,13 @@ struct object_array {
 	unsigned int alloc;
 	struct object_array_entry {
 		struct object *item;
-		const char *name;
+		/*
+		 * name or NULL.  If non-NULL, the memory pointed to
+		 * is owned by this object *except* if it points at
+		 * object_array_slopbuf, which is a static copy of the
+		 * empty string.
+		 */
+		char *name;
 		unsigned mode;
 	} *objects;
 };
diff --git a/revision.c b/revision.c
index be73cb4..4aeda33 100644
--- a/revision.c
+++ b/revision.c
@@ -88,7 +88,9 @@ void add_object(struct object *obj,
 		struct name_path *path,
 		const char *name)
 {
-	add_object_array(obj, path_name(path, name), p);
+	char *pn = path_name(path, name);
+	add_object_array(obj, pn, p);
+	free(pn);
 }
 
 static void mark_blob_uninteresting(struct blob *blob)
@@ -1288,7 +1290,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 			}
 			die("options not supported in --stdin mode");
 		}
-		if (handle_revision_arg(xstrdup(sb.buf), revs, 0,
+		if (handle_revision_arg(sb.buf, revs, 0,
 					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
 	}
-- 
1.8.2.3
