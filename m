From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] repack: do not accidentally pack kept objects by default
Date: Tue, 10 Jun 2014 16:08:38 -0400
Message-ID: <20140610200837.GA14974@sigill.intra.peff.net>
References: <20140610200741.GA11248@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:08:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSLc-0004MU-GS
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbaFJUIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:08:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:41239 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932223AbaFJUIi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:08:38 -0400
Received: (qmail 13297 invoked by uid 102); 10 Jun 2014 20:08:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 15:08:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 16:08:38 -0400
Content-Disposition: inline
In-Reply-To: <20140610200741.GA11248@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251224>

Commit ee34a2b (repack: add `repack.packKeptObjects` config
var, 2014-03-03) added a flag which could duplicate kept
objects, but did not mean to turn it on by default. Instead,
the option is tied by default to the decision to write
bitmaps, like:

  if (pack_kept_objects < 0)
	  pack_kept_objects = write_bitmap;

after which we expect pack_kept_objects to be a boolean 0 or
1.  However, that assignment neglects that write_bitmap is
_also_ a tri-state with "-1" as the default, and with
neither option given, we accidentally turn the option on.

This patch is the minimal fix to restore the desired
behavior for the default state. Further patches will fix the
more complicated cases.

Note the update to t7700. It failed to turn on bitmaps,
meaning we were actually confirming the wrong behavior!

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c  | 2 +-
 t/t7700-repack.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6b0b62d..17bc8da 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -191,7 +191,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				git_repack_usage, 0);
 
 	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmap;
+		pack_kept_objects = write_bitmap > 0;
 
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 284018e..f054434 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -37,7 +37,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 
 test_expect_success 'writing bitmaps can duplicate .keep objects' '
 	# build on $objsha1, $packsha1, and .keep state from previous
-	git repack -Adl &&
+	git repack -Adbl &&
 	test_when_finished "found_duplicate_object=" &&
 	for p in .git/objects/pack/*.idx; do
 		idx=$(basename $p)
-- 
2.0.0.729.g520999f
