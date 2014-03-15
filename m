From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pack-objects: show progress for reused packfiles
Date: Fri, 14 Mar 2014 22:26:21 -0400
Message-ID: <20140315022620.GA987@sigill.intra.peff.net>
References: <20140315022550.GA875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 03:26:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOeIt-0005ZX-0h
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 03:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbaCOC0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 22:26:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:39840 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754352AbaCOC0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 22:26:22 -0400
Received: (qmail 4010 invoked by uid 102); 15 Mar 2014 02:26:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Mar 2014 21:26:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 22:26:21 -0400
Content-Disposition: inline
In-Reply-To: <20140315022550.GA875@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244135>

When the "--all-progress" option is in effect, pack-objects
shows a progress report for the "writing" phase. If the
repository has bitmaps and we are reusing a packfile, the
user sees no progress update until the whole packfile is
sent.  Since this is typically the bulk of what is being
written, it can look like git hangs during this phase, even
though the transfer is proceeding.

This generally only happens with "git push" from a
repository with bitmaps. We do not use "--all-progress" for
fetch (since the result is going to index-pack on the
client, which takes care of progress reporting). And for
regular repacks to disk, we do not reuse packfiles.

We already have the progress meter setup during
write_reused_pack; we just need to call display_progress
whiel we are writing out the pack. The progress meter is
attached to our output descriptor, so it automatically
handles the throughput measurements.

However, we need to update the object count as we go, since
that is what feeds the percentage we show. We aren't
actually parsing the packfile as we send it, so we have no
idea how many objects we have sent; we only know that at the
end of N bytes, we will have sent M objects. So we cheat a
little and assume each object is M/N bytes (i.e., the mean
of the objects we are sending). While this isn't strictly
true, it actually produces a more pleasing progress meter
for the user, as it moves smoothly and predictably (and
nobody really cares about the object count; they care about
the percentage, and the object count is a proxy for that).

One alternative would be to actually show two progress
meters: one for the reused pack, and one for the rest of the
objects. That would more closely reflect the data we have
(the first would be measured in bytes, and the second
measured in objects). But it would also be more complex and
annoying to the user; rather than seeing one progress meter
counting up to 100%, they would finish one meter, then start
another one at zero.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f2365a4..12aa94c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -708,7 +708,7 @@ static struct object_entry **compute_write_order(void)
 static off_t write_reused_pack(struct sha1file *f)
 {
 	unsigned char buffer[8192];
-	off_t to_write;
+	off_t to_write, total;
 	int fd;
 
 	if (!is_pack_valid(reuse_packfile))
@@ -725,7 +725,7 @@ static off_t write_reused_pack(struct sha1file *f)
 	if (reuse_packfile_offset < 0)
 		reuse_packfile_offset = reuse_packfile->pack_size - 20;
 
-	to_write = reuse_packfile_offset - sizeof(struct pack_header);
+	total = to_write = reuse_packfile_offset - sizeof(struct pack_header);
 
 	while (to_write) {
 		int read_pack = xread(fd, buffer, sizeof(buffer));
@@ -738,10 +738,23 @@ static off_t write_reused_pack(struct sha1file *f)
 
 		sha1write(f, buffer, read_pack);
 		to_write -= read_pack;
+
+		/*
+		 * We don't know the actual number of objects written,
+		 * only how many bytes written, how many bytes total, and
+		 * how many objects total. So we can fake it by pretending all
+		 * objects we are writing are the same size. This gives us a
+		 * smooth progress meter, and at the end it matches the true
+		 * answer.
+		 */
+		written = reuse_packfile_objects *
+				(((double)(total - to_write)) / total);
+		display_progress(progress_state, written);
 	}
 
 	close(fd);
-	written += reuse_packfile_objects;
+	written = reuse_packfile_objects;
+	display_progress(progress_state, written);
 	return reuse_packfile_offset - sizeof(struct pack_header);
 }
 
-- 
1.9.0.417.gc6bea4f
