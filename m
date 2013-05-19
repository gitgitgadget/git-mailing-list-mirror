From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 16/17] object_array_entry: copy name before storing in name field
Date: Sun, 19 May 2013 22:27:11 +0200
Message-ID: <1368995232-11042-17-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADZ-0004ax-RV
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab3ESU2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:23 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:55032 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754834Ab3ESU2V (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:21 -0400
X-AuditID: 1207440f-b7f0e6d000000957-30-519935e46b17
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A2.6C.02391.4E539915; Sun, 19 May 2013 16:28:20 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5Z026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:19 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqPvEdGagwewrOhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtj/nfPgosyFfce3GRqYDwk1sXIySEhYCKx4OkDJghbTOLCvfVsXYxcHEIClxkl7sy7
	CpYQEjjPJHHodhWIzSagK7GopxksLiIgK/H98EZGEJtZYAKjxNL+QhBbWMBf4tDS9WBxFgFV
	ic2HvrOA2LwCrhLb199ghFimIHF51hpmEJsTKL6lfRcrxC4XiX/9t1knMPIuYGRYxSiXmFOa
	q5ubmJlTnJqsW5ycmJeXWqRropebWaKXmlK6iRESUPw7GLvWyxxiFOBgVOLh1Xg3PVCINbGs
	uDL3EKMkB5OSKO87k5mBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR49wgB5XhTEiurUovyYVLS
	HCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzuIEMFi1LTUyvSMnNKENJMHJwgw7mkRIpT
	81JSixJLSzLiQXERXwyMDJAUD9De+yDtvMUFiblAUYjWU4y6HJvPT37HKMSSl5+XKiXOexGk
	SACkKKM0D24FLH28YhQH+liY9whIFQ8w9cBNegW0hAloCeu1qSBLShIRUlINjN38k82/B7xo
	Wh7CXim8cmJNtdXmTyZMpX/2MKsmMnlszPjwYlvc3R8rw9zsIncc/izxZsUUbj8HLZ3p158Z
	VZ6b+6vB9mrIAcenWa4p5j85DRbMv7DdIdFDkXunREvwh1N/cwoX8E85/PmMU9im 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224916>

Change object_array and object_array_entry to copy the name before
storing it in the name field, and free it when an entry is deleted
from the array.  This is useful because some of the name strings
passed to add_object_array() or add_object_array_with_mode() are
refnames whose lifetime is not defined by the refs API (and which we
want to shorten).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This is the culmination of the last few commits.  Since some callers
want to store refnames in the name field of object_array elements, but
we don't want those callers to assume that the refnames that they got
from for_each_ref() have infinite lifetime, the easiest thing to do is
have object_array make a copy of the names before writing them in the
entries, and to free the names for entries that are no longer in use.
This change fixes the problem, but has some disadvantages:

* It requires extra copies to be made of strings that are already
  copies, for example when the results of path_name(path, name) are
  used as a name in revision.c:add_object().  This might be rare
  enough that it can be ignored (though the original result of
  path_name() would have to be freed, which this patch doesn't do so
  there is a memory leak).

* Many callers store the empty string ("") as the name; for example,
  most of the entries created during a run of rev-list have "" as
  their name.  This means that lots of needless copies of "" are being
  made.  I think that the best solution to this problem would be to
  store NULL rather than "" for such entries, but I haven't figured
  out all of the places where the name is used.

The alternative would be to have callers make the copies if necessary
*before* passing the names into add_object_array(), and themselves
ensure that those copies get freed sometime.  This would be more work:
effectively each object_array would have to have its own memory
ownership policy and we would have to figure out exactly where in the
code entries are added and removed from particular lists.

Since I'm not too clear on what these names are used for, how many
object_array entries are created in different scenarios, etc., I
decided to submit this patch as an RFC to get some feedback before I
work on a final solution.

 object.c | 6 +++++-
 object.h | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 10b5349..a678c1b 100644
--- a/object.c
+++ b/object.c
@@ -273,7 +273,7 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
 		array->objects = objects;
 	}
 	objects[nr].item = obj;
-	objects[nr].name = name;
+	objects[nr].name = name ? xstrdup(name) : NULL;
 	objects[nr].mode = mode;
 	array->nr = ++nr;
 }
@@ -289,6 +289,8 @@ void object_array_filter(struct object_array *array,
 			if (src != dst)
 				objects[dst] = objects[src];
 			dst++;
+		} else {
+			free(objects[src].name);
 		}
 	}
 	array->nr = dst;
@@ -319,6 +321,8 @@ void object_array_remove_duplicates(struct object_array *array)
 			if (src != array->nr)
 				objects[array->nr] = objects[src];
 			array->nr++;
+		} else {
+			free(objects[src].name);
 		}
 	}
 }
diff --git a/object.h b/object.h
index 6c1c27f..f2c503a 100644
--- a/object.h
+++ b/object.h
@@ -11,7 +11,11 @@ struct object_array {
 	unsigned int alloc;
 	struct object_array_entry {
 		struct object *item;
-		const char *name;
+		/*
+		 * name or NULL.  If non-NULL, the memory pointed to
+		 * is owned by this object.
+		 */
+		char *name;
 		unsigned mode;
 	} *objects;
 };
-- 
1.8.2.3
