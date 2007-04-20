From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Don't repack existing objects in fast-import
Date: Fri, 20 Apr 2007 11:29:22 -0400
Message-ID: <20070420152922.GA17701@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 17:29:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hev3C-0004X9-5q
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 17:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767126AbXDTP31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 11:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767130AbXDTP31
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 11:29:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41819 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767126AbXDTP30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 11:29:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hev30-0001U0-Kn; Fri, 20 Apr 2007 11:29:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 93A3220FBAE; Fri, 20 Apr 2007 11:29:22 -0400 (EDT)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45112>

Some users of fast-import have been trying to use it to rewrite
commits and trees, an activity where the all of the relevant blobs
are already available from the existing packfiles.  In such a case
we don't want to repack a blob, even if the frontend application
has supplied us the raw data rather than a mark or a SHA-1 name.

I'm intentionally only checking the packfiles that existed when
fast-import started and am always ignoring all loose object files.

We ignore loose objects because fast-import tends to operate on a
very large number of objects in a very short timespan, and it is
usually creating new objects, not reusing existing ones.  In such
a situtation the majority of the objects will not be found in the
existing packfiles, nor will they be loose object files.  If the
frontend application really wants us to look at loose object files,
then they can just repack the repository before running fast-import.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is also now available in the master branch of my fastimport
 tree on repo.or.cz.

 fast-import.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index cdd629d..e3290df 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -904,6 +904,12 @@ static int store_object(
 	if (e->offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
+	} else if (find_sha1_pack(sha1, packed_git)) {
+		e->type = type;
+		e->pack_id = MAX_PACK_ID;
+		e->offset = 1; /* just not zero! */
+		duplicate_count_by_type[type]++;
+		return 1;
 	}
 
 	if (last && last->data && last->depth < max_depth) {
@@ -2021,6 +2027,7 @@ static void import_marks(const char *input_file)
 			e = insert_object(sha1);
 			e->type = type;
 			e->pack_id = MAX_PACK_ID;
+			e->offset = 1; /* just not zero! */
 		}
 		insert_mark(mark, e);
 	}
@@ -2086,6 +2093,7 @@ int main(int argc, const char **argv)
 	if (i != argc)
 		usage(fast_import_usage);
 
+	prepare_packed_git();
 	start_packfile();
 	for (;;) {
 		read_next_command();
-- 
1.5.1.1.135.gf948
