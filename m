From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] pack-objects: stop respecting pack.writebitmaps
Date: Tue, 10 Jun 2014 16:19:13 -0400
Message-ID: <20140610201913.GD14974@sigill.intra.peff.net>
References: <20140610200741.GA11248@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:19:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSWD-00054k-4f
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbaFJUTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:19:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:41257 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932333AbaFJUTO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:19:14 -0400
Received: (qmail 13903 invoked by uid 102); 10 Jun 2014 20:19:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 15:19:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 16:19:13 -0400
Content-Disposition: inline
In-Reply-To: <20140610200741.GA11248@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251228>

The handling of the pack.writebitmaps config option
originally happened in pack-objects, which is quite
low-level. It would make more sense for drivers of
pack-objects to read the config, and then manipulate
pack-objects with command-line options.

Recently, repack learned to do so, making the low-level read
of pack.writebitmaps redundant here. Other callers, like
upload-pack, would not generally want to write bitmaps
anyway.

This could be considered a regression for somebody who is
driving pack-objects themselves outside of repack and
expects the config option to be used. However, such users
seem rather unlikely given how new the bitmap code is (and
the fact that they would basically be reimplementing repack
in the first place).

Note that we do not do anything with pack.writeBitmapHashCache
here. That option is not about "do we write bimaps", but
rather "when we are writing bitmaps, how do we do it?". You
would want that to kick in anytime you decide to write them,
similar to how pack.indexVersion is used.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not sure what we want to do with this. It _is_ a possible regression
as explained above, but I really do find it improbable that anyone will
care. Even at GitHub, where we use a custom script instead of running
`git gc`, we hook into the repack code, and not directly into
pack-objects.

One option is obviously to drop it as not worth it (you don't see the
benefit here, but it enables the cleanups in the rest of the series).

Another option is noting that the regression is worth dealing with,
adding a deprecation notice, and phasing it out eventually. I tend to
think it's not worth the trouble here.

Another option is to track it to graduate to master during the next
cycle. I.e., decide that the possible regression isn't a big deal.

The final option is to track it for maint, along with the earlier
patches.  The argument for that is:

  1. It's not a regression worth caring about (i.e., if it's not worth
     caring about for master, it's probably not worth caring about for
     maint, either).

  2. It shortens the window in which the old behavior is in a release,
     making it less likely for somebody to try depending on it.

 builtin/pack-objects.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de36c60..238b502 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2214,10 +2214,6 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		cache_max_small_delta_size = git_config_int(k, v);
 		return 0;
 	}
-	if (!strcmp(k, "pack.writebitmaps")) {
-		write_bitmap_index = git_config_bool(k, v);
-		return 0;
-	}
 	if (!strcmp(k, "pack.writebitmaphashcache")) {
 		if (git_config_bool(k, v))
 			write_bitmap_options |= BITMAP_OPT_HASH_CACHE;
-- 
2.0.0.729.g520999f
