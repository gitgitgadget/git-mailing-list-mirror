From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Use column indexes in git-cvsserver where necessary.
Date: Mon, 23 Oct 2006 01:09:35 -0400
Message-ID: <20061023050934.GA25018@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 07:10:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbs4Z-0001o4-KR
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 07:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWJWFJs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 01:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWJWFJs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 01:09:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58560 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751502AbWJWFJr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 01:09:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gbs4B-0005lO-2G; Mon, 23 Oct 2006 01:09:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1863A20FB79; Mon, 23 Oct 2006 01:09:35 -0400 (EDT)
To: martyn@catalyst.net.nz, martin@catalyst.net.nz,
	Junio C Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29817>

Tonight I found a git-cvsserver instance spending a lot of time in
disk IO while trying to process operations against a Git repository
with >30,000 objects contained in it.

Blowing away my SQLLite database and rebuilding all tables with
indexes on the attributes that git-cvsserver frequently runs queries
against seems to have resolved the issue quite nicely.

Since the indexes shouldn't hurt performance on small repositories
and always helps on larger repositories we should just always create
them when creating the revision storage tables.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-cvsserver.perl |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 08ad831..8817f8b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2118,9 +2118,17 @@ sub new
                 mode       TEXT NOT NULL
             )
         ");
+        $self->{dbh}->do("
+            CREATE INDEX revision_ix1
+            ON revision (name,revision)
+        ");
+        $self->{dbh}->do("
+            CREATE INDEX revision_ix2
+            ON revision (name,commithash)
+        ");
     }
 
-    # Construct the revision table if required
+    # Construct the head table if required
     unless ( $self->{tables}{head} )
     {
         $self->{dbh}->do("
@@ -2134,6 +2142,10 @@ sub new
                 mode       TEXT NOT NULL
             )
         ");
+        $self->{dbh}->do("
+            CREATE INDEX head_ix1
+            ON head (name)
+        ");
     }
 
     # Construct the properties table if required
-- 
1.4.3.g4e51
