From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] teach replace objects to sha1_object_info_extended()
Date: Mon, 2 Dec 2013 10:06:34 -0500
Message-ID: <20131202150634.GA20416@sigill.intra.peff.net>
References: <20131130133934.2697.75781.chriscool@tuxfamily.org>
 <20131202145225.GA12457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Joey Hess <joey@kitenet.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 02 16:06:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnV57-0008Qx-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 16:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab3LBPGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 10:06:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:49039 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752255Ab3LBPGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 10:06:36 -0500
Received: (qmail 21443 invoked by uid 102); 2 Dec 2013 15:06:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Dec 2013 09:06:36 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Dec 2013 10:06:34 -0500
Content-Disposition: inline
In-Reply-To: <20131202145225.GA12457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238634>

On Mon, Dec 02, 2013 at 09:52:25AM -0500, Jeff King wrote:

> I find it a little funny that we reuse the READ_SHA1_FILE_REPLACE flag
> directly in lookup_replace_object. That means that it is now a
> meaningful flag for sha1_object_info_extended, even though the name does
> not say so. It also means that the two may have to coordinate further
> flags (since a portion of their flag namespace is shared by
> lookup_replace_object). I don't foresee adding a lot of new flags,
> though, so it probably isn't a huge deal.
> 
> I also would have expected sha1_object_info_extended to simply receive
> the new flag via the struct object_info. Again, probably not a big deal,
> because there aren't many callsites that needed updating. But if we were
> not sharing flags with read_sha1_file, I think doing it as a flag in the
> struct would be nicer.

Curious what this would look like, I wrote the patch. If you drop your
patches 2 and 3, then your final patch (actually fixing the problem)
would look like the one below:

We may be getting into bikeshed territory, and I don't feel
super-strongly about it, so I won't say anything more. Now we've seen
both alternatives, and you or Junio can pick. :)

---
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b2ca775..a2e3e26 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -270,6 +270,7 @@ static int batch_objects(struct batch_options *opt)
 	 * object.
 	 */
 	memset(&data, 0, sizeof(data));
+	data.info.respect_replace = 1;
 	data.mark_query = 1;
 	strbuf_expand(&buf, opt->format, expand_format, &data);
 	data.mark_query = 0;
diff --git a/cache.h b/cache.h
index ce377e1..0ad262f 100644
--- a/cache.h
+++ b/cache.h
@@ -1074,6 +1074,7 @@ struct object_info {
 	enum object_type *typep;
 	unsigned long *sizep;
 	unsigned long *disk_sizep;
+	unsigned respect_replace:1;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index 7dadd04..b6ddad0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2519,8 +2519,11 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
+	const unsigned char *real = oi->respect_replace ?
+				    lookup_replace_object(sha1) :
+				    sha1;
 
-	co = find_cached_object(sha1);
+	co = find_cached_object(real);
 	if (co) {
 		if (oi->typep)
 			*(oi->typep) = co->type;
@@ -2532,16 +2535,16 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 		return 0;
 	}
 
-	if (!find_pack_entry(sha1, &e)) {
+	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(sha1, oi)) {
+		if (!sha1_loose_object_info(real, oi)) {
 			oi->whence = OI_LOOSE;
 			return 0;
 		}
 
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
-		if (!find_pack_entry(sha1, &e))
+		if (!find_pack_entry(real, &e))
 			return -1;
 	}
 
@@ -2570,6 +2573,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 
 	oi.typep = &type;
 	oi.sizep = sizep;
+	oi.respect_replace = 1;
 	if (sha1_object_info_extended(sha1, &oi) < 0)
 		return -1;
 	return type;
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index b90dbdc..bb785ec 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -276,7 +276,7 @@ test_expect_success '-f option bypasses the type check' '
 	git replace -f HEAD^ $BLOB
 '
 
-test_expect_failure 'git cat-file --batch works on replace objects' '
+test_expect_success 'git cat-file --batch works on replace objects' '
 	git replace | grep $PARA3 &&
 	echo $PARA3 | git cat-file --batch
 '
