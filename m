X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/3] mimic unpack-objects when --stdin is used with index-pack
Date: Wed, 25 Oct 2006 23:31:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610252330320.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 26 Oct 2006 03:32:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30134>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcvyU-00048B-M4 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 05:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750926AbWJZDcH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 23:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWJZDcH
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 23:32:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13289 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1750926AbWJZDcE
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 23:32:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Q005TG4H59N74@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Wed,
 25 Oct 2006 23:31:53 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

It appears that git-unpack-objects writes the last part of the input
buffer to stdout after the pack has been parsed.  This looks a bit
suspicious since the last fill() might have filled the buffer up to
the 4096 byte limit and more data might still be pending on stdin,
but since this is about being a drop-in replacement for unpack-objects
let's simply duplicate the same behavior for now.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 index-pack.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 2046b37..7f7dc5d 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -456,6 +456,7 @@ static void parse_pack_objects(unsigned
 	SHA1_Final(sha1, &input_ctx);
 	if (hashcmp(fill(20), sha1))
 		die("pack is corrupted (SHA1 mismatch)");
+	use(20);
 
 	/* If input_fd is a file, we should have reached its end now. */
 	if (fstat(input_fd, &st))
@@ -765,6 +766,18 @@ static void final(const char *final_pack
 		if (err)
 			die("error while closing pack file: %s", strerror(errno));
 		chmod(curr_pack_name, 0444);
+
+		/*
+		 * Let's just mimic git-unpack-objects here and write
+		 * the last part of the buffer to stdout.
+		 */
+		while (input_len) {
+			err = xwrite(1, input_buffer + input_offset, input_len);
+			if (err <= 0)
+				break;
+			input_len -= err;
+			input_offset += err;
+		}
 	}
 
 	if (final_pack_name != curr_pack_name) {
@@ -863,7 +876,6 @@ int main(int argc, char **argv)
 			    nr_deltas - nr_resolved_deltas);
 	} else {
 		/* Flush remaining pack final 20-byte SHA1. */
-		use(20);
 		flush();
 	}
 	free(deltas);
@@ -872,7 +884,8 @@ int main(int argc, char **argv)
 	free(objects);
 	free(index_name_buf);
 
-	printf("%s\n", sha1_to_hex(sha1));
+	if (!from_stdin)
+		printf("%s\n", sha1_to_hex(sha1));
 
 	return 0;
 }
-- 
1.4.3.3.g10cf-dirty
