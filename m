From: =?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
Subject: [PATCH] http-push: fail when info/refs exists and is already locked
Date: Sat, 19 Jan 2008 16:22:48 +0100
Message-ID: <1200756171-11696-2-git-send-email-gb@gbarbier.org>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
Cc: gitster@pobox.com,
	=?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 16:23:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFXc-0007U3-A1
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759869AbYASPW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 10:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759844AbYASPW5
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:22:57 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48542 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758701AbYASPWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 10:22:55 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 812991AB2CE;
	Sat, 19 Jan 2008 16:22:52 +0100 (CET)
Received: from localhost.localdomain (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6797A1AB30B;
	Sat, 19 Jan 2008 16:22:52 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc3.54.g4b665-dirty
In-Reply-To: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71113>

Rationale:

Failing instead of silently not updating remote refs makes the things cleare
for the user when trying to push on a repository while another person do (or
while a dandling locks are waiting for a 10 minutes timeout).

When silently not updating remote refs, the user does not even know that git
has pushed the objects but leaved the refs as they were before (e.g. a new
bunch of commits on branch "master" is uploaded, however the branch by itsel
still points on the previous head commit).
---
 http-push.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index 2c4e91d..e1984d3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2243,6 +2243,11 @@ int main(int argc, char **argv)
 		info_ref_lock = lock_remote("info/refs", LOCK_TIME);
 		if (info_ref_lock)
 			remote->can_update_info_refs = 1;
+		else {
+			fprintf(stderr, "Error: cannot lock existing info/refs\n");
+			rc = 1;
+			goto cleanup;
+		}
 	}
 	if (remote->has_info_packs)
 		fetch_indices();
-- 
1.5.4.rc3.52.g9a5bd-dirty
