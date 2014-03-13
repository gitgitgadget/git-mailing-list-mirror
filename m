From: Jeff King <peff@peff.net>
Subject: Re: No progress from push when using bitmaps
Date: Thu, 13 Mar 2014 18:24:28 -0400
Message-ID: <20140313222428.GA18406@sigill.intra.peff.net>
References: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com>
 <20140313212626.GA23618@sigill.intra.peff.net>
 <CAJo=hJu1WscibwectWzrUcoOV4-9xk4hBm1JA+RjONmgvZTXwQ@mail.gmail.com>
 <20140313220754.GA20173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 23:24:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOE3G-0005pi-JH
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 23:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbaCMWYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 18:24:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:39069 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753769AbaCMWYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 18:24:30 -0400
Received: (qmail 15988 invoked by uid 102); 13 Mar 2014 22:24:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 17:24:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2014 18:24:28 -0400
Content-Disposition: inline
In-Reply-To: <20140313220754.GA20173@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244057>

On Thu, Mar 13, 2014 at 06:07:54PM -0400, Jeff King wrote:

>   3. Use the regular "Writing objects" progress, but fake the object
>      count. We know we are writing M bytes with N objects. Bump the
>      counter by 1 for every M/N bytes we write.

Here is that strategy. I think it looks pretty nice, and it seamlessly
handles the case where you have extra objects to send on top of the
reused pack (we just keep the same progress meter counting up).

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 831dd05..f187859 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -709,7 +709,7 @@ static struct object_entry **compute_write_order(void)
 static off_t write_reused_pack(struct sha1file *f)
 {
 	unsigned char buffer[8192];
-	off_t to_write;
+	off_t to_write, total;
 	int fd;
 
 	if (!is_pack_valid(reuse_packfile))
@@ -726,7 +726,7 @@ static off_t write_reused_pack(struct sha1file *f)
 	if (reuse_packfile_offset < 0)
 		reuse_packfile_offset = reuse_packfile->pack_size - 20;
 
-	to_write = reuse_packfile_offset - sizeof(struct pack_header);
+	total = to_write = reuse_packfile_offset - sizeof(struct pack_header);
 
 	while (to_write) {
 		int read_pack = xread(fd, buffer, sizeof(buffer));
@@ -739,10 +739,23 @@ static off_t write_reused_pack(struct sha1file *f)
 
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
 
