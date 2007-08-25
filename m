From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Don't segfault if we failed to inflate a packed delta
Date: Sat, 25 Aug 2007 03:26:04 -0400
Message-ID: <20070825072604.GA20155@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 09:26:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOq2c-0005z4-EH
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 09:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749AbXHYH0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 03:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754994AbXHYH0J
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 03:26:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57159 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbXHYH0I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 03:26:08 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IOq20-0005P1-5V; Sat, 25 Aug 2007 03:26:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3E07320FBAE; Sat, 25 Aug 2007 03:26:04 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56624>

Under some types of packfile corruption the zlib stream holding the
data for a delta within a packfile may fail to inflate, due to say
a CRC failure within the compressed data itself.  When this occurs
the unpack_compressed_entry function will return NULL as a signal to
the caller that the data is not available.  Unfortunately we then
tried to use that NULL as though it referenced a memory location
where a delta was stored and tried to apply it to the delta base.
Loading a byte from the NULL address typically causes a SIGSEGV.

cate on #git noticed this failure in `git fsck --full` where the
call to verify_pack() first noticed that the packfile was corrupt
by finding that the packfile's SHA-1 did not match the raw data of
the file.  After finding this fsck went ahead and tried to verify
every object within the packfile, even though the packfile was
already known to be bad.  If we are going to shovel bad data at
the delta unpacking code, we better handle it correctly.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b219d4d..9978a58 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1570,6 +1570,10 @@ static void *unpack_delta_entry(struct packed_git *p,
 		    (uintmax_t)base_offset, p->pack_name);
 
 	delta_data = unpack_compressed_entry(p, w_curs, curpos, delta_size);
+	if (!delta_data)
+		die("failed to unpack compressed delta"
+		    " at %"PRIuMAX" from %s",
+		    (uintmax_t)curpos, p->pack_name);
 	result = patch_delta(base, base_size,
 			     delta_data, delta_size,
 			     sizep);
-- 
1.5.3.rc6.17.g1911
