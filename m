From: Kevin Bracey <kevin@bracey.fi>
Subject: [RFC/PATCH] Make --full-history consider more merges
Date: Mon, 22 Apr 2013 22:23:22 +0300
Message-ID: <1366658602-12254-1-git-send-email-kevin@bracey.fi>
References: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 21:47:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMi8-00048f-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912Ab3DVTrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:47:32 -0400
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:42986 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754847Ab3DVTrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 15:47:31 -0400
Received: from mail91.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id B7A8DFF892E
	for <git@vger.kernel.org>; Mon, 22 Apr 2013 21:23:27 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 22 Apr 2013 21:23:27 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 22 Apr 2013 21:23:25 +0200
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.255.g39c5835
In-Reply-To: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 10244563252597592286
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrfeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrfeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222048>

History simplification previously always treated merges as TREESAME
if they were TREESAME to any parent.

While the desired default behaviour, this could be extremely unhelpful
when searching detailed history, and could not be overridden. For
example, if a merge had ignored a change, as if by "-s ours", then:

  git log -m -p --full-history -Schange file

would successfully locate "change"'s addition but would not locate the
merge that resolved against it.

This patch changes the simplification so that when --full-history is
specified, a merge is treated as TREESAME only if it is TREESAME to
_all_ parents. This means the command above locates a merge that dropped
"change".

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
This would address my problem case - it passes existing tests, and covers
my (all-too-common) problem. But it would also need documentation changes and
a new test.

 revision.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index eb98128..96fe3f5 100644
--- a/revision.c
+++ b/revision.c
@@ -516,8 +516,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		}
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
-	if (tree_changed && !tree_same)
-		return;
+
+	if (tree_changed) {
+		if (!tree_same)
+			return;
+
+		if (!revs->simplify_history && !revs->simplify_merges)
+			return;
+	}
 	commit->object.flags |= TREESAME;
 }
 
-- 
1.8.2.255.g39c5835
