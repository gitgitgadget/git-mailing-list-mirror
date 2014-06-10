From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] repack: simplify handling of --write-bitmap-index
Date: Tue, 10 Jun 2014 16:19:38 -0400
Message-ID: <20140610201938.GE14974@sigill.intra.peff.net>
References: <20140610200741.GA11248@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:19:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSWI-00058V-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933273AbaFJUTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:19:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:41261 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932306AbaFJUTk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:19:40 -0400
Received: (qmail 13916 invoked by uid 102); 10 Jun 2014 20:19:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 15:19:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 16:19:38 -0400
Content-Disposition: inline
In-Reply-To: <20140610200741.GA11248@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251229>

We previously needed to pass --no-write-bitmap-index
explicitly to pack-objects to override its reading of
pack.writebitmaps from the config. Now that it no longer
does so, we can assume that bitmaps are off by default, and
only turn them on when necessary. This also lets us avoid a
confusing tri-state flag for write_bitmaps.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously needs to be dropped if we don't take the previous patch.

 builtin/repack.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 36c1cf9..0e119b7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -10,7 +10,7 @@
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
-static int write_bitmaps = -1;
+static int write_bitmaps;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -195,7 +195,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				git_repack_usage, 0);
 
 	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmaps > 0;
+		pack_kept_objects = write_bitmaps;
 
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
@@ -221,9 +221,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_pushf(&cmd_args, "--no-reuse-delta");
 	if (no_reuse_object)
 		argv_array_pushf(&cmd_args, "--no-reuse-object");
-	if (write_bitmaps >= 0)
-		argv_array_pushf(&cmd_args, "--%swrite-bitmap-index",
-				 write_bitmaps ? "" : "no-");
+	if (write_bitmaps)
+		argv_array_push(&cmd_args, "--write-bitmap-index");
 
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs);
-- 
2.0.0.729.g520999f
