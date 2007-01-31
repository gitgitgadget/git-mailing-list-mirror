From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Don't coredump on bad refs in update-server-info.
Date: Wed, 31 Jan 2007 02:24:44 -0500
Message-ID: <20070131072444.GA28804@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 08:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC9q0-0003Mw-Op
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 08:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbXAaHYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 02:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbXAaHYv
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 02:24:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36091 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932838AbXAaHYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 02:24:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HC9pm-0002ao-No; Wed, 31 Jan 2007 02:24:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A95EA20FBAE; Wed, 31 Jan 2007 02:24:44 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38232>

Apparently if we are unable to parse an object update-server-info
coredumps, as it doesn't bother to check the return value of its
call to parse_object.

Instead of coredumping, skip the ref.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I don't know how often folks might run into this.  I intentionally
 broke pack reading in one of my topics and discovered that
 update-server-info crashed with a segfault when the pack access code
 was unable to decompress the object behind the ref.  That's less
 than optimal.

 server-info.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/server-info.c b/server-info.c
index 6cd38be..f9be5a7 100644
--- a/server-info.c
+++ b/server-info.c
@@ -10,6 +10,8 @@ static FILE *info_ref_fp;
 static int add_info_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
+	if (!o)
+		return -1;
 
 	fprintf(info_ref_fp, "%s	%s\n", sha1_to_hex(sha1), path);
 	if (o->type == OBJ_TAG) {
-- 
1.5.0.rc2.81.g73a2
