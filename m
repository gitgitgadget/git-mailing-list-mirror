From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Don't die in git-http-fetch when fetching packs.
Date: Tue, 9 Jan 2007 20:04:52 -0500
Message-ID: <20070110010452.GA30610@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:05:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Rtl-0001tb-5T
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbXAJBE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbXAJBE6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:04:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37821 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932501AbXAJBE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:04:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4RtU-0007Bj-Ty; Tue, 09 Jan 2007 20:04:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7875220FBAE; Tue,  9 Jan 2007 20:04:53 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36457>

My sp/mmap changes to pack-check.c modified the function such that
it expects packed_git.pack_size to be populated with the total
bytecount of the packfile by the caller.

But that isn't the case for packs obtained by git-http-fetch as
pack_size was not initialized before being accessed.  This caused
verify_pack to think it had 2^32-21 bytes available when the
downloaded pack perhaps was only 305 bytes in length.  The use_pack
function then later dies with "offset beyond end of packfile"
when computing the overall file checksum.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 For the tip of my sp/mmap topic.  Without it HTTP fetch and push
 support is severely broken as it cannot deal with packs.

 http-fetch.c |    1 +
 http-push.c  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index fe8cd7b..67dfb0a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -809,6 +809,7 @@ static int fetch_pack(struct alt_base *repo, unsigned char *sha1)
 		return error("Unable to start request");
 	}
 
+	target->pack_size = ftell(packfile);
 	fclose(packfile);
 
 	ret = move_temp_to_file(tmpfile, filename);
diff --git a/http-push.c b/http-push.c
index 7e73eac..8eb448e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -770,6 +770,7 @@ static void finish_request(struct transfer_request *request)
 				request->url, curl_errorstr);
 			remote->can_update_info_refs = 0;
 		} else {
+			target->pack_size = ftell(request->local_stream);
 			fclose(request->local_stream);
 			request->local_stream = NULL;
 			if (!move_temp_to_file(request->tmpfile,
-- 
1.4.4.4.gf198
