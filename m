From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] cherry-pick: Bug fix 'cherry picked from' message.
Date: Tue, 6 Mar 2007 00:46:00 -0500
Message-ID: <20070306054600.GA24206@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 06:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOSV1-0005HO-8f
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 06:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933959AbXCFFqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 00:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933958AbXCFFqI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 00:46:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43922 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933959AbXCFFqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 00:46:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOSUs-0002zR-GC; Tue, 06 Mar 2007 00:46:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B6FD720FBAE; Tue,  6 Mar 2007 00:46:00 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41539>

Somewhere along the line (in abd6970a) git-revert.sh learned to
omit the private object name from the new commit message *unless*
-x was supplied on the command line by the user.

The way this was implemented is really non-obvious in the original
script.  Setting replay=t (the default) means we don't include the
the private object name, while setting reply='' (the -x flag) means
we should include the private object name.  These two settings now
relate to the replay=1 and replay=0 cases in the C version, so we
need to negate replay to test it is 0.

I also noticed the C version was adding an extra LF in the -x case,
where the older git-revert.sh was not.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-revert.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 382fe0c..2f2dc1b 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -303,8 +303,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		next = commit;
 		set_author_ident_env(message);
 		add_message_to_msg(message);
-		if (replay) {
-			add_to_msg("\n(cherry picked from commit ");
+		if (!replay) {
+			add_to_msg("(cherry picked from commit ");
 			add_to_msg(sha1_to_hex(commit->object.sha1));
 			add_to_msg(")\n");
 		}
-- 
1.5.0.3.863.gf0989
