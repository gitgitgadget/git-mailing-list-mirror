From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-helper: fix R/C score parsing under -z flag.
Date: Sat, 28 May 2005 21:20:42 -0700
Message-ID: <7v3bs6slwl.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<7vr7frrw8x.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 06:19:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcFGD-0004xz-9p
	for gcvg-git@gmane.org; Sun, 29 May 2005 06:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVE2EUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 00:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVE2EUw
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 00:20:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:21135 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261173AbVE2EUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 00:20:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529042043.SJIU1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 00:20:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vr7frrw8x.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 28 May 2005 12:22:38 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The score number that follows R/C status letter was parsed but
the parse pointer was not updated, causing the entire line to
become unrecognized.  This patch fixes this problem.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-helper.c |   17 ++++++++---------
1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -80,17 +80,16 @@ int main(int ac, const char **av) {
 			if (!strchr("MCRNDU", status))
 				break;
 			two_paths = score = 0;
-			if (status == 'R' || status == 'C') {
+			if (status == 'R' || status == 'C')
 				two_paths = 1;
-				sscanf(cp, "%d", &score);
-				if (line_termination) {
-					cp = strchr(cp,
-						    inter_name_termination);
-					if (!cp)
-						break;
-				}
-			}
 
+			/* pick up score if exists */
+			if (sscanf(cp, "%d", &score) != 1)
+				score = 0;
+			cp = strchr(cp,
+				    inter_name_termination);
+			if (!cp)
+				break;
 			if (*cp++ != inter_name_termination)
 				break;
 
------------------------------------------------

