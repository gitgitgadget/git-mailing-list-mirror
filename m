From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 5/7] Teach upload-pack to log the received need lines to fd 3
Date: Sat, 1 Mar 2008 00:25:19 -0500
Message-ID: <20080301052519.GE27300@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 06:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVKEQ-0004xA-Ss
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 06:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbYCAFZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 00:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbYCAFZX
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 00:25:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48628 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbYCAFZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 00:25:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVKDo-0000uF-G3; Sat, 01 Mar 2008 00:25:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 87B6420FBAE; Sat,  1 Mar 2008 00:25:19 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75617>

To facilitate testing and verification of the requests sent by git-fetch
to the remote side we permit logging the received packet lines to file
descriptor 3 if GIT_DEBUG_SEND_PACK has been set.  Special start and
end lines are included to indicate the start and end of each connection.

  $ GIT_DEBUG_SEND_PACK=1 git fetch 3>UPLOAD_LOG
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
 upload-pack.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b26d053..4e14020 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -444,7 +444,10 @@ static void receive_needs(void)
 	struct object_array shallows = {0, 0, NULL};
 	static char line[1000];
 	int len, depth = 0;
+	int debug_needs = !!getenv("GIT_DEBUG_SEND_PACK");
 
+	if (debug_needs)
+		write_in_full(3, "#S\n", 3);
 	for (;;) {
 		struct object *o;
 		unsigned char sha1_buf[20];
@@ -452,6 +455,8 @@ static void receive_needs(void)
 		reset_timeout();
 		if (!len)
 			break;
+		if (debug_needs)
+			write_in_full(3, line, len);
 
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
@@ -507,6 +512,8 @@ static void receive_needs(void)
 			add_object_array(o, NULL, &want_obj);
 		}
 	}
+	if (debug_needs)
+		write_in_full(3, "#E\n", 3);
 	if (depth == 0 && shallows.nr == 0)
 		return;
 	if (depth > 0) {
-- 
1.5.4.3.409.g88113

