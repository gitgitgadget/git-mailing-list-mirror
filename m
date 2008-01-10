From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 6/6] Use new compress helpers in builtin-pack-objects.c
Date: Thu, 10 Jan 2008 22:34:49 +0100
Message-ID: <e5bfff550801101334p5df5adaerf0eeae02ddf28334@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:35:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD53W-0000rJ-S4
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbYAJVev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbYAJVev
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:34:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:36811 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYAJVeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:34:50 -0500
Received: by rv-out-0910.google.com with SMTP id k20so708809rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=bFD0w49Kl5DB2KxP9IqcmEpLkFGlZt2dM1W7AUmMrP0=;
        b=sEJwAk/s+mk1vm0bDFDYR5/6BjF0rbHwYDyRQSQcSecbIHdZGZ+B9k7bt71e2CCz2L6b7CTGiIQ1Hvt2tnqU2fki9H/GRLtWPi4OLotpHuarULGQCOgj7n0zUBX+/l3RApOggi30v7arqmNQ8u+fyRMrmwe2y5BvzEksj02v83A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pKqssfTCXAnQ0+HV89bg7uwEpe8WYJgqbSSz3wDCcTrgAp5LH+SlNviXLu155+QS9Squ5D17z82oDX5IPKvwEymJ/fttffWQUyKhjE+DM7Ycwb7N7v4/S97OGqD+9iXBFEEOf1bZnqE16bLKD9Nq5vpRWh42LfMP6wzrDAGzOe4=
Received: by 10.141.122.20 with SMTP id z20mr1511854rvm.239.1200000889845;
        Thu, 10 Jan 2008 13:34:49 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 13:34:49 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70096>

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---


It's 'compress helper' not 'decomrpess helper' of course.

All my patch series is misnamed by my idiocy!

This is the last one for this evening, this is interesting
because pack_compression_level instead of the usual
zlib_compression_level is used.

The goal of this patch series is to have some
comment before to procede with remaining conversions.

When compression is fully abstarceted out I will go with
decompression (inflate).

At the end of this job perhaps we have something that
allows us to have fun with different compression libraries.

In any case IMHO this patch series is valid 'per se' as a
cleanup and (a lot of) code lines removing.


 builtin-pack-objects.c |   21 ++++-----------------
 1 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a39cb82..682d7fb 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "compress.h"
 #include "attr.h"
 #include "object.h"
 #include "blob.h"
@@ -409,9 +410,7 @@ static unsigned long write_object(struct sha1file *f,
 				 */

 	if (!to_reuse) {
-		z_stream stream;
-		unsigned long maxsize;
-		void *out;
+		unsigned char *out = NULL;
 		if (!usable_delta) {
 			buf = read_sha1_file(entry->idx.sha1, &obj_type, &size);
 			if (!buf)
@@ -432,20 +431,8 @@ static unsigned long write_object(struct sha1file *f,
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		}
 		/* compress the data to store and put compressed length in datalen */
-		memset(&stream, 0, sizeof(stream));
-		deflateInit(&stream, pack_compression_level);
-		maxsize = deflateBound(&stream, size);
-		out = xmalloc(maxsize);
-		/* Compress it */
-		stream.next_in = buf;
-		stream.avail_in = size;
-		stream.next_out = out;
-		stream.avail_out = maxsize;
-		while (deflate(&stream, Z_FINISH) == Z_OK)
-			/* nothing */;
-		deflateEnd(&stream);
-		datalen = stream.total_out;
-		deflateEnd(&stream);
+		datalen = z_deflate_all(pack_compression_level, buf, size, &out);
+
 		/*
 		 * The object header is a byte of 'type' followed by zero or
 		 * more bytes of length.
-- 
1.5.4.rc2.89.g1b3f-dirty
