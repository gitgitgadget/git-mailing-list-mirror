From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC] notes: avoid recommitting identical trees
Date: Tue, 31 Aug 2010 17:16:17 +0200
Message-ID: <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net>
References: <4C7CD65F.10509@atlas-elektronik.com>
Cc: Johan Herland <johan@herland.net>,
	stefan.naewe@atlas-elektronik.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 17:16:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqSZT-0003ab-Me
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445Ab0HaPQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 11:16:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47078 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932442Ab0HaPQQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:16:16 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A505B187;
	Tue, 31 Aug 2010 11:16:15 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 31 Aug 2010 11:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=+z+s//a6rtuS0t/9sPRhZW/ZA9E=; b=d5qJVyaQUPsw4uecRxQpQR7F7N7y9KgBbuVYkv8+B8moiGuJ/wuuMn7MNEgNglc9uqHTUGC48+FGXBRrikIuTZlj0dkE2z+V3rpI3yUL/rnoSvhtHlt4dWK9IBhfrZ20VJ5KprGFQRg1O5oAUiyH1A5H5WwGiRQrWte4BL7vQGg=
X-Sasl-enc: 7AiYJYfG4ks0qOyjHN5T346hRuf39P/H74WDDiz5jZ01 1283267775
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 23CDB4067D8;
	Tue, 31 Aug 2010 11:16:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.2.398.g5af70
In-Reply-To: <4C7CD65F.10509@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154910>

Currently, "git notes" behaves like "git commit --allow-empty" when
committing notes trees. In particular, removing nonexisting notes leads
to empty commits "commits with no diff".

Change this to avoid unnecessary notes commits.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I can't believe there's no easier way to lookup the sha1 of a tree of a commit
but I didn't find any, and I did not want to employ the diff machinery for diffing
the trees when their sha1 is (should be) known.

 builtin/notes.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index fbc347c..48da228 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -303,11 +303,15 @@ int commit_notes(struct notes_tree *t, const char *msg)
 		hashclr(prev_commit);
 		parent = NULL;
 	}
-	if (commit_tree(buf.buf + 7, tree_sha1, parent, new_commit, NULL))
-		die("Failed to commit notes tree to database");
-
-	/* Update notes ref with new commit */
-	update_ref(buf.buf, t->ref, new_commit, prev_commit, 0, DIE_ON_ERR);
+	if (!parent || parse_commit(parent->item) || parse_tree(parent->item->tree) ||
+		hashcmp(parent->item->tree->object.sha1, tree_sha1)) {
+		/* avoid recommitting the same tree */
+		if (commit_tree(buf.buf + 7, tree_sha1, parent, new_commit, NULL))
+			die("Failed to commit notes tree to database");
+
+		/* Update notes ref with new commit */
+		update_ref(buf.buf, t->ref, new_commit, prev_commit, 0, DIE_ON_ERR);
+	}
 
 	strbuf_release(&buf);
 	return 0;
-- 
1.7.2.2.398.g5af70
