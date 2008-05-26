From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Don't diff empty tree on branch creation in paranoid update hook
Date: Sun, 25 May 2008 22:17:57 -0400
Message-ID: <20080526021757.GA29990@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 26 04:18:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0SIX-0003Oj-Oh
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 04:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYEZCSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 22:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYEZCSB
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 22:18:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52492 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbYEZCSB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 22:18:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K0SHT-0001Dd-Dh; Sun, 25 May 2008 22:17:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BBC0320FBAE; Sun, 25 May 2008 22:17:57 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82890>

Listing all files in a branch during branch creation is silly;
the user's file-level ACLs probably don't mean anything at this
point.  We now treat the base case of 0{40} as an empty diff,
as this happens only when the user is creating the branch and
there are file level ACLs that diff against the old value of
the branch.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I had this series of 3 patches laying around that I forgot to send.
 They have been in production for a while (~5 months) and are
 safe to apply.  Funny what you find laying around in your topic
 branches sometimes...

 contrib/hooks/update-paranoid |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index 068fa37..6e0d97c 100644
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -225,14 +225,12 @@ sub load_diff ($) {
 		local $/ = "\0";
 		my %this_diff;
 		if ($base =~ /^0{40}$/) {
-			open(T,'-|','git','ls-tree',
-				'-r','--name-only','-z',
-				$new) or return undef;
-			while (<T>) {
-				chop;
-				$this_diff{$_} = 'A';
-			}
-			close T or return undef;
+			# Don't load the diff at all; we are making the
+			# branch and have no base to compare to in this
+			# case.  A file level ACL makes no sense in this
+			# context.  Having an empty diff will allow the
+			# branch creation.
+			#
 		} else {
 			open(T,'-|','git','diff-tree',
 				'-r','--name-status','-z',
-- 
1.5.5.1.501.gefb4
