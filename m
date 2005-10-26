From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH] fetch-pack: avoid packing reachable objects.
Date: Wed, 26 Oct 2005 00:26:32 -0400
Message-ID: <20051026042632.GA3059@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 26 06:27:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUcrz-0002v0-Sc
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 06:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVJZE0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 00:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVJZE0d
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 00:26:33 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:43433 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S932536AbVJZE0c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 00:26:32 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1EUcrw-0004Hr-00; Wed, 26 Oct 2005 00:26:32 -0400
To: git@vger.kernel.org, junkio@cox.net
Mail-Followup-To: git@vger.kernel.org, junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10645>

Mark remote commits that were found in the alternate repository as
COMPLETE and avoid unnecessary packing of already available objects.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---

When we pull updates from a shared repository into a clone that was
created with 'git clone -l -s', we pack objects that are already
reachable. This was because we only marked local refs as COMPLETE.

diff --git a/fetch-pack.c b/fetch-pack.c
index 8566ab1..17524d8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -169,6 +169,7 @@ static int everything_local(struct ref *
 		 */
 		if (o->type == commit_type) {
 			struct commit *commit = (struct commit *)o;
+			commit->object.flags |= COMPLETE;
 			if (!cutoff || cutoff < commit->date)
 				cutoff = commit->date;
 		}
