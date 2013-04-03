From: Miklos Vajna <vmiklos@suse.cz>
Subject: [PATCH] cherry-pick: better error message when the parameter is a
 non-commit
Date: Wed, 3 Apr 2013 11:27:04 +0200
Message-ID: <20130403092704.GC21520@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 03 11:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNJyw-0001Q1-6a
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 11:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763226Ab3DCJ1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 05:27:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58445 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763213Ab3DCJ1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 05:27:08 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 49716A51BB;
	Wed,  3 Apr 2013 11:27:07 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219930>

When copy&paste goes wrong, and the user e.g. tries to cherry-pick a
blob, the error message used to be:

	fatal: BUG: expected exactly one commit from walk

Instead, now it is:

	fatal: Can't cherry-pick a blob

Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
---
 sequencer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index baa0310..0ac00d4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1082,8 +1082,15 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		if (prepare_revision_walk(opts->revs))
 			die(_("revision walk setup failed"));
 		cmit = get_revision(opts->revs);
-		if (!cmit || get_revision(opts->revs))
+		if (!cmit || get_revision(opts->revs)) {
+			unsigned char sha1[20];
+			if (!get_sha1(opts->revs->cmdline.rev->name, sha1)) {
+				enum object_type type = sha1_object_info(sha1, NULL);
+				if (type > 0 && type != OBJ_COMMIT)
+					die(_("Can't cherry-pick a %s"), typename(type));
+			}
 			die("BUG: expected exactly one commit from walk");
+		}
 		return single_pick(cmit, opts);
 	}
 
-- 
1.8.1.4
