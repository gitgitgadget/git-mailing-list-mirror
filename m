From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Sun, 7 Jul 2013 06:09:49 -0400
Message-ID: <20130707100949.GC19143@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 12:10:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvlvA-0000rB-Qr
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 12:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab3GGKJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 06:09:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:46829 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab3GGKJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 06:09:54 -0400
Received: (qmail 12933 invoked by uid 102); 7 Jul 2013 10:11:08 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Jul 2013 05:11:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jul 2013 06:09:49 -0400
Content-Disposition: inline
In-Reply-To: <20130707100133.GA18717@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229765>

This option is just like --batch-check, but shows the
on-disk size rather than the true object size. In other
words, it makes the "disk_size" query of sha1_object_info_extended
available via the command-line.

This can be used for rough attribution of disk usage to
particular refs, though see the caveats in the
documentation.

This patch does not include any tests, as the exact numbers
returned are volatile and subject to zlib and packing
decisions.

Signed-off-by: Jeff King <peff@peff.net>
---
I sort of tacked this onto the --batch-check format by replacing the
"real" object size with the on-disk size when this option is used. I'm
open to suggestions. Two other things I considered were:

  1. Having the option simply output an extra field with the on-disk
     size. But then you are paying for the true object size lookup, even
     if you don't necessarily care.

  2. Simply outputting the disk-size and object name. For my purposes, I
     do not care about the object type, and finding the type takes non-trivial
     resources (we have to walk delta chains to find the true type).

Perhaps we need

  git cat-file --batch-format="%(disk-size) %(object)"

or similar.

 Documentation/git-cat-file.txt | 16 ++++++++++++++++
 builtin/cat-file.c             |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 30d585a..d4af1fc 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -65,6 +65,22 @@ OPTIONS
 	Print the SHA-1, type, and size of each object provided on stdin. May not
 	be combined with any other options or arguments.
 
+--batch-disk-sizes::
+	Like `--batch-check`, but print the on-disk size of each object
+	(including zlib and delta compression) rather than the object's
+	true size. May not be combined with any other options or
+	arguments.
++
+NOTE: The on-disk size reported is accurate, but care should be taken in
+drawing conclusions about which refs or objects are responsible for disk
+usage. The size of a packed non-delta object be much larger than the
+size of objects which delta against it, but the choice of which object
+is the base and which is the delta is arbitrary and is subject to change
+during a repack. Note also that multiple copies of an object may be
+present in the object database; in this case, it is undefined which
+copy's size will be reported.
+
+
 OUTPUT
 ------
 If '-t' is specified, one of the <type>.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 045cee7..5112c64 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -15,6 +15,7 @@
 
 #define BATCH 1
 #define BATCH_CHECK 2
+#define BATCH_DISK_SIZES 3
 
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 {
@@ -135,6 +136,11 @@ static int batch_one_object(const char *obj_name, int print_contents)
 
 	if (print_contents == BATCH)
 		contents = read_sha1_file(sha1, &type, &size);
+	else if (print_contents == BATCH_DISK_SIZES) {
+		struct object_info oi = {0};
+		oi.disk_sizep = &size;
+		type = sha1_object_info_extended(sha1, &oi);
+	}
 	else
 		type = sha1_object_info(sha1, &size);
 
@@ -206,6 +212,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "batch-check", &batch,
 			    N_("show info about objects fed from the standard input"),
 			    BATCH_CHECK),
+		OPT_SET_INT(0, "batch-disk-sizes", &batch,
+			    N_("show on-disk size of objects fed from standard input"),
+			    BATCH_DISK_SIZES),
 		OPT_END()
 	};
 
-- 
1.8.3.rc3.24.gec82cb9
