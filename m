From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] sha1_object_info_extended: make type calculation optional
Date: Fri, 12 Jul 2013 02:34:57 -0400
Message-ID: <20130712063457.GF15572@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:35:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWwc-0002BI-9h
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405Ab3GLGfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:35:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:36608 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192Ab3GLGe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:34:59 -0400
Received: (qmail 17275 invoked by uid 102); 12 Jul 2013 06:36:17 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 01:36:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 02:34:57 -0400
Content-Disposition: inline
In-Reply-To: <20130712061533.GA11297@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230179>

Each caller of sha1_object_info_extended sets up an
object_info struct to tell the function which elements of
the object it wants to get. Until now, getting the type of
the object has always been required (and it is returned via
the return type rather than a pointer in object_info).

This can involve actually opening a loose object file to
determine its type, or following delta chains to determine a
packed file's base type. These effects produce a measurable
slow-down when doing a "cat-file --batch-check" that does
not include %(objecttype).

This patch adds a "typep" query to struct object_info, so
that it can be optionally queried just like size and
disk_size. As a result, the return type of the function is
no longer the object type, but rather 0/-1 for success/error.

As there are only three callers total, we just fix up each
caller rather than keep a compatibility wrapper:

  1. The simpler sha1_object_info wrapper continues to
     always ask for and return the type field.

  2. The istream_source function wants to know the type, and
     so always asks for it.

  3. The cat-file batch code asks for the type only when
     %(objecttype) is part of the format string.

On linux.git, the best-of-five for running:

  $ git rev-list --objects --all >objects
  $ time git cat-file --batch-check='%(objectsize:disk)'

on a fully packed repository goes from:

  real    0m8.680s
  user    0m8.160s
  sys     0m0.512s

to:

  real    0m7.205s
  user    0m6.580s
  sys     0m0.608s

Signed-off-by: Jeff King <peff@peff.net>
---
This ends up changing the behavior of sha1_object_info_extended without
changing its function signature. Given that it is a fairly inactive area
of the code and that there are no topics in flight, I think this is OK.
But an alternative could be to add (yet another) wrapper to leave the
first two call-sites untouched.

 builtin/cat-file.c |  7 ++++---
 cache.h            |  1 +
 sha1_file.c        | 20 +++++++++++++-------
 streaming.c        |  2 +-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index fe5c77f..163ce6c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -150,7 +150,9 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		if (!data->mark_query)
 			strbuf_addstr(sb, sha1_to_hex(data->sha1));
 	} else if (is_atom("objecttype", atom, len)) {
-		if (!data->mark_query)
+		if (data->mark_query)
+			data->info.typep = &data->type;
+		else
 			strbuf_addstr(sb, typename(data->type));
 	} else if (is_atom("objectsize", atom, len)) {
 		if (data->mark_query)
@@ -229,8 +231,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 		return 0;
 	}
 
-	data->type = sha1_object_info_extended(data->sha1, &data->info);
-	if (data->type <= 0) {
+	if (sha1_object_info_extended(data->sha1, &data->info) < 0) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
 		return 0;
diff --git a/cache.h b/cache.h
index c1fd82c..d3b770c 100644
--- a/cache.h
+++ b/cache.h
@@ -1130,6 +1130,7 @@ struct object_info {
 
 struct object_info {
 	/* Request */
+	enum object_type *typep;
 	unsigned long *sizep;
 	unsigned long *disk_sizep;
 
diff --git a/sha1_file.c b/sha1_file.c
index 2a1e230..52f7a1e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2452,24 +2452,26 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 {
 	struct cached_object *co;
 	struct pack_entry e;
-	int type, rtype;
+	int rtype;
 
 	co = find_cached_object(sha1);
 	if (co) {
+		if (oi->typep)
+			*(oi->typep) = co->type;
 		if (oi->sizep)
 			*(oi->sizep) = co->size;
 		if (oi->disk_sizep)
 			*(oi->disk_sizep) = 0;
 		oi->whence = OI_CACHED;
-		return co->type;
+		return 0;
 	}
 
 	if (!find_pack_entry(sha1, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(sha1, &type,
+		if (!sha1_loose_object_info(sha1, oi->typep,
 					    oi->sizep, oi->disk_sizep)) {
 			oi->whence = OI_LOOSE;
-			return type;
+			return 0;
 		}
 
 		/* Not a loose object; someone else may have just packed it. */
@@ -2478,7 +2480,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 			return -1;
 	}
 
-	rtype = packed_object_info(e.p, e.offset, &type, oi->sizep,
+	rtype = packed_object_info(e.p, e.offset, oi->typep, oi->sizep,
 				   oi->disk_sizep);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, sha1);
@@ -2493,15 +2495,19 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 					 rtype == OBJ_OFS_DELTA);
 	}
 
-	return type;
+	return 0;
 }
 
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
+	enum object_type type;
 	struct object_info oi = {0};
 
+	oi.typep = &type;
 	oi.sizep = sizep;
-	return sha1_object_info_extended(sha1, &oi);
+	if (sha1_object_info_extended(sha1, &oi) < 0)
+		return -1;
+	return type;
 }
 
 static void *read_packed_sha1(const unsigned char *sha1,
diff --git a/streaming.c b/streaming.c
index cac282f..870657a 100644
--- a/streaming.c
+++ b/streaming.c
@@ -111,11 +111,11 @@ static enum input_source istream_source(const unsigned char *sha1,
 	unsigned long size;
 	int status;
 
+	oi->typep = type;
 	oi->sizep = &size;
 	status = sha1_object_info_extended(sha1, oi);
 	if (status < 0)
 		return stream_error;
-	*type = status;
 
 	switch (oi->whence) {
 	case OI_LOOSE:
-- 
1.8.3.rc3.24.gec82cb9
