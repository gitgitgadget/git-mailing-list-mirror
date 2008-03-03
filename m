From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 6/8] Teach upload-pack to log the received need lines to an fd
Date: Sun, 2 Mar 2008 21:35:18 -0500
Message-ID: <20080303023518.GF9966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 03:35:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW0X0-0001c9-2x
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbYCCCfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 21:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755574AbYCCCfW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:35:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59476 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbYCCCfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 21:35:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JW0WC-0002Ra-II; Sun, 02 Mar 2008 21:35:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D148E20FBAE; Sun,  2 Mar 2008 21:35:18 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75874>

To facilitate testing and verification of the requests sent by
git-fetch to the remote side we permit logging the received packet
lines to the file descriptor specified in GIT_DEBUG_SEND_PACK has
been set.  Special start and end lines are included to indicate
the start and end of each connection.

  $ GIT_DEBUG_SEND_PACK=3 git fetch 3>UPLOAD_LOG
  $ cat UPLOAD_LOG
  #S
  want 8e10cf4e007ad7e003463c30c34b1050b039db78 multi_ack side-band-64k thin-pack ofs-delta
  want ddfa4a33562179aca1ace2bcc662244a17d0b503
  #E
  #S
  want 3253df4d1cf6fb138b52b1938473bcfec1483223 multi_ack side-band-64k thin-pack ofs-delta
  #E

>From the above trace the first connection opened by git-fetch was to
download two refs (with values 8e and dd) and the second connection
was opened to automatically follow an annotated tag (32).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 upload-pack.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e5421db..660134a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -35,6 +35,7 @@ static unsigned int timeout;
  * otherwise maximum packet size (up to 65520 bytes).
  */
 static int use_sideband;
+static int debug_fd;
 
 static void reset_timeout(void)
 {
@@ -444,6 +445,8 @@ static void receive_needs(void)
 	static char line[1000];
 	int len, depth = 0;
 
+	if (debug_fd)
+		write_in_full(debug_fd, "#S\n", 3);
 	for (;;) {
 		struct object *o;
 		unsigned char sha1_buf[20];
@@ -451,6 +454,8 @@ static void receive_needs(void)
 		reset_timeout();
 		if (!len)
 			break;
+		if (debug_fd)
+			write_in_full(debug_fd, line, len);
 
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
@@ -506,6 +511,8 @@ static void receive_needs(void)
 			add_object_array(o, NULL, &want_obj);
 		}
 	}
+	if (debug_fd)
+		write_in_full(debug_fd, "#E\n", 3);
 	if (depth == 0 && shallows.nr == 0)
 		return;
 	if (depth > 0) {
@@ -631,6 +638,8 @@ int main(int argc, char **argv)
 		die("'%s': unable to chdir or not a git archive", dir);
 	if (is_repository_shallow())
 		die("attempt to fetch/clone from a shallow repository");
+	if (getenv("GIT_DEBUG_SEND_PACK"))
+		debug_fd = atoi(getenv("GIT_DEBUG_SEND_PACK"));
 	upload_pack();
 	return 0;
 }
-- 
1.5.4.3.468.g36990

