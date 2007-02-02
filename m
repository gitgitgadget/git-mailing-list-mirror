From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Flag and skip over packfiles known to be invalid.
Date: Fri, 2 Feb 2007 03:00:10 -0500
Message-ID: <20070202080010.GB21094@spearce.org>
References: <dda240a4adf0511b3e1ab1eb74abdd28821358b0.1170403175.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 09:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCtLM-0003hF-Cm
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 09:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423214AbXBBIAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 03:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423215AbXBBIAP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 03:00:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41497 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423214AbXBBIAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 03:00:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCtL9-00084l-56; Fri, 02 Feb 2007 03:00:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B9BFC20FBAE; Fri,  2 Feb 2007 03:00:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <dda240a4adf0511b3e1ab1eb74abdd28821358b0.1170403175.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38473>

If we've already looked at a packfile and determined it isn't
valid/usable as a pack, we shouldn't try to use it again in
the future either.  This avoids multiple error messages from
the same packfile.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h     |    1 +
 sha1_file.c |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 9873ee9..64c2d3f 100644
--- a/cache.h
+++ b/cache.h
@@ -357,6 +357,7 @@ extern struct packed_git {
 	off_t pack_size;
 	int pack_fd;
 	int pack_local;
+	unsigned invalid:1;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
diff --git a/sha1_file.c b/sha1_file.c
index ba1c799..9f6e94e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -714,6 +714,7 @@ struct packed_git *add_packed_git(char *path, int path_len, int local)
 	p->next = NULL;
 	p->windows = NULL;
 	p->pack_fd = -1;
+	p->invalid = 0;
 	p->pack_local = local;
 	if ((path_len > 44) && !get_sha1_hex(path + path_len - 44, sha1))
 		hashcpy(p->sha1, sha1);
@@ -746,6 +747,7 @@ struct packed_git *parse_pack_index_file(const unsigned char *sha1, char *idx_pa
 	p->next = NULL;
 	p->windows = NULL;
 	p->pack_fd = -1;
+	p->invalid = 0;
 	hashcpy(p->sha1, sha1);
 	return p;
 }
@@ -1395,6 +1397,8 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 	prepare_packed_git();
 
 	for (p = packed_git; p; p = p->next) {
+		if (p->invalid)
+			continue;
 		if (ignore_packed) {
 			const char **ig;
 			for (ig = ignore_packed; *ig; ig++)
@@ -1418,6 +1422,7 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 					close(p->pack_fd);
 					p->pack_fd = -1;
 				}
+				p->invalid = 1;
 				error("packfile %s cannot be accessed", p->pack_name);
 				continue;
 			}
-- 
1.5.0.rc3.1.ge4b0e
