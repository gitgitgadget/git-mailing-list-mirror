From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/11] writing out a huge blob to working tree
Date: Wed, 18 May 2011 03:08:37 -0400
Message-ID: <20110518070837.GC27482@sigill.intra.peff.net>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <20110518064158.GB27482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 09:08:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMas9-0008Th-5u
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 09:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab1ERHIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 03:08:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37185
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab1ERHIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 03:08:39 -0400
Received: (qmail 2493 invoked by uid 107); 18 May 2011 07:10:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 May 2011 03:10:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2011 03:08:37 -0400
Content-Disposition: inline
In-Reply-To: <20110518064158.GB27482@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173852>

On Wed, May 18, 2011 at 02:41:58AM -0400, Jeff King wrote:

> According to perf, though, it's not the increased writes; the slowdown
> is actually from create_pack_revindex, in this call chain:
> 
>  create_pack_revindex
>  find_pack_revindex
>  packed_object_info_detail
>  sha1_object_info_extended
>  istream_source
>  open_istream
>  streaming_write_entry

Part of the problem is that with the current code, all you care about is
"Is it loose, packed non-delta, or packed delta?". And
packed_object_info_detail will tell you not just whether it's deltafied,
but will go to a lot more work to make the revindex. One solution is to
let the cheap packed_object_info() report back on delta status, since
it's free there, and then we don't have to deal with the revindex at
all.

Of course, it may turn out that the extra information is useful if and
when open_istream_* actually gets implemented for delta-fied objects.

The patch below implements the cheap "is_delta" check. But it only
shaves off a half second (dropping us from 7s to 6.5s). Prior to your
patches, we were at 4.5 seconds. So there's still quite a bit of
slowdown to figure out.

diff --git a/cache.h b/cache.h
index 39e53c8..829c3a4 100644
--- a/cache.h
+++ b/cache.h
@@ -1026,6 +1026,7 @@ extern int unpack_object_header(struct packed_git *, struct pack_window **, off_
 struct object_info {
 	/* Request */
 	unsigned long *sizep;
+	int *is_deltap;
 	int want_deltainfo;
 
 	/* Response */
diff --git a/sha1_file.c b/sha1_file.c
index 15f1c05..35be909 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1481,7 +1481,7 @@ static off_t get_delta_base(struct packed_git *p,
 
 /* forward declaration for a mutually recursive function */
 static int packed_object_info(struct packed_git *p, off_t offset,
-			      unsigned long *sizep);
+			      unsigned long *sizep, int *is_delta);
 
 static int packed_delta_info(struct packed_git *p,
 			     struct pack_window **w_curs,
@@ -1495,7 +1495,7 @@ static int packed_delta_info(struct packed_git *p,
 	base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
 	if (!base_offset)
 		return OBJ_BAD;
-	type = packed_object_info(p, base_offset, NULL);
+	type = packed_object_info(p, base_offset, NULL, NULL);
 	if (type <= OBJ_NONE) {
 		struct revindex_entry *revidx;
 		const unsigned char *base_sha1;
@@ -1605,7 +1605,7 @@ int packed_object_info_detail(struct packed_git *p,
 }
 
 static int packed_object_info(struct packed_git *p, off_t obj_offset,
-			      unsigned long *sizep)
+			      unsigned long *sizep, int *is_delta)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
@@ -1619,6 +1619,8 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 	case OBJ_REF_DELTA:
 		type = packed_delta_info(p, &w_curs, curpos,
 					 type, obj_offset, sizep);
+		if (is_delta)
+			*is_delta = 1;
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
@@ -1626,11 +1628,15 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 	case OBJ_TAG:
 		if (sizep)
 			*sizep = size;
+		if (is_delta)
+			*is_delta = 0;
 		break;
 	default:
 		error("unknown object type %i at offset %"PRIuMAX" in %s",
 		      type, (uintmax_t)obj_offset, p->pack_name);
 		type = OBJ_BAD;
+		if (is_delta)
+			*is_delta = 0;
 	}
 	unuse_pack(&w_curs);
 	return type;
@@ -2130,7 +2136,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 	}
 
 	if (!oi->want_deltainfo) {
-		status = packed_object_info(e.p, e.offset, oi->sizep);
+		status = packed_object_info(e.p, e.offset, oi->sizep,
+					    oi->is_deltap);
 	} else {
 		unsigned long size, store_size;
 		unsigned int delta_chain_length;
diff --git a/streaming.c b/streaming.c
index 03c58b2..a2c0e84 100644
--- a/streaming.c
+++ b/streaming.c
@@ -84,10 +84,12 @@ static enum input_source istream_source(const unsigned char *sha1,
 					struct object_info *oi)
 {
 	unsigned long size;
+	int is_delta;
 	int status;
 
 	oi->sizep = &size;
-	oi->want_deltainfo = 1;
+	oi->is_deltap = &is_delta;
+	oi->want_deltainfo = 0;
 
 	status = sha1_object_info_extended(sha1, oi);
 	if (status < 0)
@@ -98,7 +100,7 @@ static enum input_source istream_source(const unsigned char *sha1,
 	case OI_LOOSE:
 		return loose;
 	case OI_PACKED:
-		if (!oi->u.packed.delta && big_file_threshold <= size)
+		if (!is_delta && big_file_threshold <= size)
 			return pack_non_delta;
 		/* fallthru */
 	default:
