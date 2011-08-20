From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/2] fast-import: treat cat-blob as a delta base hint for next blob
Date: Sun, 21 Aug 2011 01:04:12 +0600
Message-ID: <1313867052-11993-3-git-send-email-divanorama@gmail.com>
References: <1313867052-11993-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 21:02:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Quqod-0007dG-E4
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 21:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab1HTTCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 15:02:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34260 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab1HTTCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 15:02:31 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2884431bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qKJv/ptlVpBT/Ub6CiUoYWDIKYarrnRj4UGz7cEESDE=;
        b=wCUK24ai1rjhGBVkAb1NXcuXhWkud6B2meDEHj1DnbmIFXLItn8FvpMSh/QpTsj59b
         rA4SPqqa0yCPkLkjRLZvktJL4FRMtsz5ugZjZK2ioi2Mfx+8HG3nTTny2pZgoPbDbUla
         /1i4OzewBhi+lrw120tAT1RCt8cAuWyWOctZA=
Received: by 10.204.142.148 with SMTP id q20mr248765bku.399.1313866951040;
        Sat, 20 Aug 2011 12:02:31 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id z7sm1402615bkt.6.2011.08.20.12.02.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 12:02:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313867052-11993-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179775>

Delta base for blobs is chosen as a previously saved blob. If we
treat cat-blob's blob as a delta base for the next blob, nothing
is likely to become worse.

For fast-import stream producer like svn-fe cat-blob is used like
following:
- svn-fe reads file delta in svn format
- to apply it, svn-fe asks cat-blob 'svn delta base'
- applies 'svn delta' to the response
- produces a blob command to store the result

Currently there is no way for svn-fe to give fast-import a hint on
object delta base. While what's requested in cat-blob is most of
the time a best delta base possible. Of course, it could be not a
good delta base, but we don't know any better one anyway.

So do treat cat-blob's result as a delta base for next blob. The
profit is nice: 2x to 7x reduction in pack size AND 1.2x to 3x
time speedup due to diff_delta being faster on good deltas. git gc
--aggressive can compress it even more, by 10% to 70%, utilizing
more cpu time, real time and 3 cpu cores.

Tested on 213M and 2.7G fast-import streams, resulting packs are 22M
and 113M, import time is 7s and 60s, both streams are produced by
svn-fe, sniffed and then used as raw input for fast-import.

For git-fast-export produced streams there is no change as it doesn't
use cat-blob and doesn't try to reorder blobs in some smart way to
make successive deltas small.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 2b069e3..0480fbf 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2802,7 +2802,12 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 	strbuf_release(&line);
 	cat_blob_write(buf, size);
 	cat_blob_write("\n", 1);
-	free(buf);
+	if (oe && oe->pack_id == pack_id) {
+		last_blob.offset = oe->idx.offset;
+		strbuf_attach(&last_blob.data, buf, size, size);
+		last_blob.depth = oe->depth;
+	} else
+		free(buf);
 }
 
 static void parse_cat_blob(void)
-- 
1.7.3.4
