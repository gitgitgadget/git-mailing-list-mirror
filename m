From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Tue, 27 Feb 2007 23:47:19 -0500
Message-ID: <20070228044719.GA6068@spearce.org>
References: <17892.64236.443170.43061@lisa.zopyra.com> <20070228035713.GC5597@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 05:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMGis-0006bC-QP
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 05:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbXB1ErY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 23:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbXB1ErY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 23:47:24 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34525 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbXB1ErX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 23:47:23 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMGib-0001Yw-Fu; Tue, 27 Feb 2007 23:47:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 38F4820FBAE; Tue, 27 Feb 2007 23:47:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070228035713.GC5597@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40894>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Bill Lear <rael@zopyra.com> wrote:
> > Using 1.5.0.1.  Can't see what is wrong with this clone...
> ...
> > Indexing 4589 objects.
> > remote: Total 4589 (delta 2209), reused 4589 (delta 2209)
> >  100% (4589/4589) done
> > Resolving 2209 deltas.
> > fatal: cannot pread pack file: Success
> > fatal: index-pack died with error code 128
> > fetch-pack from '/home/rael/devel/project/.git' failed.
> 
> I think the pread() in get_data_from_pack of index-pack is wrong,
> it really should be looping until we fill the buffer in case the
> OS doesn't fully satisfy our read request the first time.

Does this fix your problem?

-->8--
[PATCH] index-pack: Loop over pread until data loading is complete.

A filesystem might not be able to completely supply our pread
request in one system call, such as if we are reading data from a
network file system and the requested length is just simply huge.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 index-pack.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 859ec01..cf81a99 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -277,13 +277,19 @@ static void *get_data_from_pack(struct object_entry *obj)
 {
 	unsigned long from = obj[0].offset + obj[0].hdr_size;
 	unsigned long len = obj[1].offset - from;
+	unsigned long rdy = 0;
 	unsigned char *src, *data;
 	z_stream stream;
 	int st;
 
 	src = xmalloc(len);
-	if (pread(pack_fd, src, len, from) != len)
-		die("cannot pread pack file: %s", strerror(errno));
+	data = src;
+	do {
+		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
+		if (n <= 0)
+			die("cannot pread pack file: %s", strerror(errno));
+		rdy += n;
+	} while (rdy < len);
 	data = xmalloc(obj->size);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = data;
-- 
1.5.0.2.775.g1a500

-- 
Shawn.
