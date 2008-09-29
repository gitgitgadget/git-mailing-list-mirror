From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] Clarify how the user can satisfy stash's 'dirty state'
 check.
Date: Mon, 29 Sep 2008 04:12:04 -0500
Organization: Exigence
Message-ID: <20080929041204.846ba617.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 11:13:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkEon-0008VO-Tt
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 11:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbYI2JMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 05:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbYI2JMM
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 05:12:12 -0400
Received: from smtp112.sat.emailsrvr.com ([66.216.121.112]:46962 "EHLO
	smtp112.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbYI2JML (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 05:12:11 -0400
Received: from relay1.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay1.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id B582824DD24;
	Mon, 29 Sep 2008 05:12:08 -0400 (EDT)
Received: by relay1.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 51E3124CC96;
	Mon, 29 Sep 2008 05:12:08 -0400 (EDT)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97002>

Clarify how the user can satisfy stash's 'dirty state' check.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---

Feel free to tweak the wording, but we had a false assumption that you
could not apply multiple stashes in a row due to this confusing error
message. I.e. "dirty state" was taken as "dirty working tree and/or
index" instead of just "dirty working tree".

I don't have any tests, but t3903-stash.sh runs the same ("10: stash
branch" is failing both before and after my change change).

Looking into it more, I dislike that t3903's "3: apply needs clean
working directory" uses test_must_fail because without actively
asserting that the expected error message comes back, we can't be sure
the boundary condition that was originally tested for is still being met
(e.g. `git stash` could be returning non-zero for some entirely
different reason now--not likely, yes, but possible). test_must_fail
mentions a "segv" reason, which I'll somewhat blindly accept as good,
but it would be nice if I could pass in/grep against/something the error
message. Perhaps on another line/invocation?

Anyway...the patch:

 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index e15c12a..a932ca7 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -151,7 +151,7 @@ show_stash () {
 
 apply_stash () {
 	git diff-files --quiet --ignore-submodules ||
-		die 'Cannot restore on top of a dirty state'
+		die 'Cannot apply to a dirty working tree, please stage your changes'
 
 	unstash_index=
 	case "$1" in
-- 
1.6.0.2
