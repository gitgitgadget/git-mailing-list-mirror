From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH 2/2] notes: don't alter refs starting with 'refs/' in
 expand_notes_ref
Date: Wed, 05 Sep 2012 08:52:45 -0400
Message-ID: <8c65d450f545ad3f6a241ef1b95fca272ec3a38a.1346849556.git.wking@tremily.us>
References: <cover.1346848834.git.wking@tremily.us>
Cc: "W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 15:53:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9G2x-0007L2-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 15:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055Ab2IENx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 09:53:27 -0400
Received: from vms173009pub.verizon.net ([206.46.173.9]:22236 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab2IENx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 09:53:27 -0400
X-Greylist: delayed 3606 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2012 09:53:27 EDT
Received: from odin.tremily.us ([unknown] [72.68.111.221])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M9V00L66NS9FI30@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 05 Sep 2012 07:53:03 -0500 (CDT)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with ESMTPS id 1B3255C2EAE; Wed,
 05 Sep 2012 08:52:56 -0400 (EDT)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 05 Sep 2012 08:53:05 -0400
X-Mailer: git-send-email 1.7.12.176.g3fc0e4c.dirty
In-reply-to: <cover.1346848834.git.wking@tremily.us>
In-reply-to: <4eea4f3eab8ee827a40802a50aa2cda9e4b43943.1346849556.git.wking@tremily.us>
References: <4eea4f3eab8ee827a40802a50aa2cda9e4b43943.1346849556.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204829>

From: "W. Trevor King" <wking@tremily.us>

This avoids surprising cases like:

  $ GIT_NOTES_REF=refs/remotes/origin/notes/commits git notes get-ref --expand
  refs/notes/refs/remotes/origin/notes/commits

With the old implementation, all note refs had to live under
'refs/notes/' which was not mentioned in the git-notes.txt.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 notes.c          | 2 +-
 t/t3301-notes.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index 93e9868..60394c8 100644
--- a/notes.c
+++ b/notes.c
@@ -1289,7 +1289,7 @@ int copy_note(struct notes_tree *t,
 
 void expand_notes_ref(struct strbuf *sb)
 {
-	if (!prefixcmp(sb->buf, "refs/notes/"))
+	if (!prefixcmp(sb->buf, "refs/"))
 		return; /* we're happy */
 	else if (!prefixcmp(sb->buf, "notes/"))
 		strbuf_insert(sb, 0, "refs/", 5);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index c0486a0..707d7e6 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1230,4 +1230,8 @@ test_expect_success 'git notes get-ref (--expand)' '
 	test "$(GIT_NOTES_REF=commits git notes get-ref --expand)" = "refs/notes/commits"
 '
 
+test_expect_success 'git notes get-ref (--expand)' '
+	test "$(GIT_NOTES_REF=refs/remotes/origin/notes/commits git notes get-ref --expand)" = "refs/remotes/origin/notes/commits"
+'
+
 test_done
-- 
1.7.12.176.g3fc0e4c.dirty
