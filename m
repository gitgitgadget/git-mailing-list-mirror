From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH 3/3] git-add --intent-to-add (-N)
Date: Fri, 22 Aug 2008 02:52:39 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808220150410.13589@harper.uchicago.edu>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7viqtukbec.fsf@gitster.siamese.dyndns.org>
 <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0808211608020.26161@harper.uchicago.edu>
 <Pine.GSO.4.62.0808212304200.9108@harper.uchicago.edu>
 <alpine.LNX.1.00.0808220023170.19665@iabervon.org>
 <Pine.GSO.4.62.0808220015190.11259@harper.uchicago.edu>
 <7vtzddd1z5.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0808220119250.12851@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 09:55:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWRU1-0005ZR-H8
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 09:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176AbYHVHxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 03:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756146AbYHVHxw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 03:53:52 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:51038 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbYHVHxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 03:53:50 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7M7qea9020478;
	Fri, 22 Aug 2008 02:52:40 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7M7qdfv015487;
	Fri, 22 Aug 2008 02:52:39 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0808220119250.12851@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93267>

Jonathan Nieder wrote:
[...]
> I still wonder, do we want to pretend we have that object on disk
> and proceed with the commit, or are the hardcoded objects only
> supposed to be sufficient for in-core use?

Sorry, I responded in haste.  The objects are supposed to be used in
core and then written out as needed, so I had been describing a bug.

How about this (in the spirit of patch 1/3)?  If the approach is
right, I can add tests tomorrow.

-- snipsnip --
Subject: update_one(): write out cached objects as needed

Although we can always pretend to have hardcoded objects such as
the empty tree in core, in the on-disk repository, if they are
referred to, they should be present.  Currently, if we try to
write a tree that uses a hardcoded object, we can notice that the
object is missing and fail with "error: invalid object".

With this patch, the objects are written to disk as needed
instead.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 cache-tree.c |   11 +++++++++--
 cache.h      |    1 +
 sha1_file.c  |   16 ++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 5f8ee87..b17f34f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -323,8 +323,15 @@ static int update_one(struct cache_tree *it,
 			mode = ce->ce_mode;
 			entlen = pathlen - baselen;
 		}
-		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))
-			return error("invalid object %s", sha1_to_hex(sha1));
+		if (mode != S_IFGITLINK && !missing_ok &&
+				!has_sha1_file(sha1)) {
+			/* Hopefully it's a cached object.  Make sure. */
+			if (dryrun)
+				(void) sha1_object_info(sha1, NULL);
+			else if (write_cached_object_sha1_file(sha1))
+				return error("invalid object %s",
+					sha1_to_hex(sha1));
+		}
 
 		if (ce->ce_flags & CE_REMOVE)
 			continue; /* entry being removed */
diff --git a/cache.h b/cache.h
index c443df4..83dbdf7 100644
--- a/cache.h
+++ b/cache.h
@@ -546,6 +546,7 @@ extern int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
+extern int write_cached_object_sha1_file(const unsigned char *sha1);
 
 /* just like read_sha1_file(), but non fatal in presence of bad objects */
 extern void *read_object(const unsigned char *sha1, enum object_type *type, unsigned long *size);
diff --git a/sha1_file.c b/sha1_file.c
index 7d86d76..8584a33 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2028,6 +2028,22 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 	return NULL;
 }
 
+int write_cached_object_sha1_file(const unsigned char *sha1)
+{
+	struct cached_object *co = find_cached_object(sha1);
+	unsigned char sha1_compare[20];
+	int result;
+
+	if (co == NULL)
+		return -1;
+	result = write_sha1_file(co->buf, co->size, typename(co->type),
+			sha1_compare);
+	if (memcmp(sha1, sha1_compare, 20))
+		return error("corrupt cached object %s",
+				sha1_to_hex(sha1));
+	return result;
+}
+
 int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 		      unsigned char *sha1)
 {
-- 
1.6.0.481.gabe4
