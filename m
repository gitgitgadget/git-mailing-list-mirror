From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] sha1_loose_object_info: make type lookup optional
Date: Fri, 12 Jul 2013 02:30:48 -0400
Message-ID: <20130712063048.GC15572@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:31:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWsn-0007Yn-Gz
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab3GLGav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:30:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:36574 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208Ab3GLGau (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:30:50 -0400
Received: (qmail 17021 invoked by uid 102); 12 Jul 2013 06:32:08 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 01:32:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 02:30:48 -0400
Content-Disposition: inline
In-Reply-To: <20130712061533.GA11297@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230175>

Until recently, the only items to request from
sha1_object_info_extended were type and size. This meant
that we always had to open a loose object file to determine
one or the other.  But with the addition of the disk_size
query, it's possible that we can fulfill the query without
even opening the object file at all. However, since the
function interface always returns the type, we have no way
of knowing whether the caller cares about it or not.

This patch only modified sha1_loose_object_info to make type
lookup optional using an out-parameter, similar to the way
the size is handled (and the return value is "0" or "-1" for
success or error, respectively).

There should be no functional change yet, though, as
sha1_object_info_extended, the only caller, will always ask
for a type.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously the end goal is to have sha1_object_info_extended do this
optionally, too (which happens in patch 6).

I'm not too happy about the stat_sha1_file function, which is almost
identical to open_sha1_file (and which in turn is almost the same thing
as has_loose_object). They all do:

  try operation X on sha1_file_name(sha1)
  prepare_alt_odb();
  foreach alt_odb
    try operation X on alt_odb/sha1_file_name(sha1)

Unfortunately it's hard to do this kind of factoring out in C, because
the argument and return types for operation X are different in these
cases; you are stuck with providing callback function that takes a void
pointer to some operation-specific data. The boilerplate ends up worse
than the repeated code.

Another solution would be to have a "find the file for loose object Y"
function, and then just do operation X on that. But since X is a
filesystem operation in each case, you do not want to lose the atomicity
of performing the operation directly (not to mention incurring the cost
of an extra stat() on each file).

So I am open to clever refactoring suggestions.

 sha1_file.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e826066..39e7313 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1306,6 +1306,26 @@ static int git_open_noatime(const char *name)
 	}
 }
 
+static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
+{
+	char *name = sha1_file_name(sha1);
+	struct alternate_object_database *alt;
+
+	if (!lstat(name, st))
+		return 0;
+
+	prepare_alt_odb();
+	errno = ENOENT;
+	for (alt = alt_odb_list; alt; alt = alt->next) {
+		name = alt->name;
+		fill_sha1_path(name, sha1);
+		if (!lstat(alt->base, st))
+			return 0;
+	}
+
+	return -1;
+}
+
 static int open_sha1_file(const unsigned char *sha1)
 {
 	int fd;
@@ -2363,7 +2383,9 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *sizep,
+static int sha1_loose_object_info(const unsigned char *sha1,
+				  enum object_type *typep,
+				  unsigned long *sizep,
 				  unsigned long *disk_sizep)
 {
 	int status;
@@ -2372,6 +2394,20 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 	git_zstream stream;
 	char hdr[32];
 
+	/*
+	 * If we don't care about type or size, then we don't
+	 * need to look inside the object at all.
+	 */
+	if (!typep && !sizep) {
+		if (disk_sizep) {
+			struct stat st;
+			if (stat_sha1_file(sha1, &st) < 0)
+				return -1;
+			*disk_sizep = st.st_size;
+		}
+		return 0;
+	}
+
 	map = map_sha1_file(sha1, &mapsize);
 	if (!map)
 		return -1;
@@ -2386,7 +2422,9 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 		*sizep = size;
 	git_inflate_end(&stream);
 	munmap(map, mapsize);
-	return status;
+	if (typep)
+		*typep = status;
+	return 0;
 }
 
 /* returns enum object_type or negative */
@@ -2408,8 +2446,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 
 	if (!find_pack_entry(sha1, &e)) {
 		/* Most likely it's a loose object. */
-		type = sha1_loose_object_info(sha1, oi->sizep, oi->disk_sizep);
-		if (type >= 0) {
+		if (!sha1_loose_object_info(sha1, &type,
+					    oi->sizep, oi->disk_sizep)) {
 			oi->whence = OI_LOOSE;
 			return type;
 		}
@@ -2417,7 +2455,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
 		if (!find_pack_entry(sha1, &e))
-			return type;
+			return -1;
 	}
 
 	type = packed_object_info(e.p, e.offset, oi->sizep, &rtype,
-- 
1.8.3.rc3.24.gec82cb9
