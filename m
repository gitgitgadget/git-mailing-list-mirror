From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Use the empty tree for base diff in paranoid-update on new branches
Date: Thu, 9 Aug 2007 02:38:16 -0400
Message-ID: <20070809063816.GC26843@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 08:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ1fW-00087S-Lj
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 08:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764463AbXHIGiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 02:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763964AbXHIGiW
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 02:38:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38811 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762991AbXHIGiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 02:38:20 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IJ1ez-0001DV-82; Thu, 09 Aug 2007 02:38:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4945020FBAE; Thu,  9 Aug 2007 02:38:16 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55414>

We have to load a tree difference for the purpose of testing
file patterns.  But if our branch is being created and there is no
specific base to difference against in the rule our base will be
'0'x40.  This is (usually) not a valid tree-ish object in a Git
repository, so there's nothing to difference against.

Instead of creating the empty tree and running git-diff against
that we just take the output of `ls-tree -r --name-only` and mark
every returned pathname as an add.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/hooks/update-paranoid |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index 84ed452..068fa37 100644
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -223,20 +223,31 @@ sub load_diff ($) {
 	my $d = $diff_cache{$base};
 	unless ($d) {
 		local $/ = "\0";
-		open(T,'-|','git','diff-tree',
-			'-r','--name-status','-z',
-			$base,$new) or return undef;
 		my %this_diff;
-		while (<T>) {
-			my $op = $_;
-			chop $op;
+		if ($base =~ /^0{40}$/) {
+			open(T,'-|','git','ls-tree',
+				'-r','--name-only','-z',
+				$new) or return undef;
+			while (<T>) {
+				chop;
+				$this_diff{$_} = 'A';
+			}
+			close T or return undef;
+		} else {
+			open(T,'-|','git','diff-tree',
+				'-r','--name-status','-z',
+				$base,$new) or return undef;
+			while (<T>) {
+				my $op = $_;
+				chop $op;
 
-			my $path = <T>;
-			chop $path;
+				my $path = <T>;
+				chop $path;
 
-			$this_diff{$path} = $op;
+				$this_diff{$path} = $op;
+			}
+			close T or return undef;
 		}
-		close T or return undef;
 		$d = \%this_diff;
 		$diff_cache{$base} = $d;
 	}
-- 
1.5.3.rc4.29.g74276
