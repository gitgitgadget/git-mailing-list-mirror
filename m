From: Jeff King <peff@peff.net>
Subject: [PATCH] push: support remote branches in guess_ref DWIM
Date: Mon, 26 Oct 2009 17:33:53 -0400
Message-ID: <20091026213353.GA27871@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 22:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2X8x-00040u-UN
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 22:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbZJZVaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 17:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbZJZVaL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 17:30:11 -0400
Received: from peff.net ([208.65.91.99]:58699 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886AbZJZVaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 17:30:10 -0400
Received: (qmail 27884 invoked by uid 1000); 26 Oct 2009 21:33:53 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131273>

When we get an unqualified dest refspec like "foo", we try
to guess its full ref path (like "refs/heads/foo") based on
the source ref. Commit f8aae12 mapped local heads to remote
heads, and local tags to remote tags.

This commit maps local tracking branches under
"refs/remotes" to remote branch heads, so

  git push origin origin/branch:renamed-branch

pushes to refs/heads/renamed-branch.

Signed-off-by: Jeff King <peff@peff.net>
---
This came from a discussion on IRC. I don't see any reason not to do
this; would people really expect it to push into refs/remotes/ on the
other side (right now, it complains and dies)?

A related issue (which exists even without this patch) is that doing
this:

  master:remotes/incoming/master

will create "refs/heads/remotes/incoming/master". Perhaps we should DWYM
a little more and recognize "heads", "remotes", and "tags" as special.

 remote.c              |    2 +-
 t/t5516-fetch-push.sh |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 73d33f2..1a7c81e 100644
--- a/remote.c
+++ b/remote.c
@@ -998,7 +998,7 @@ static char *guess_ref(const char *name, struct ref *peer)
 	if (!r)
 		return NULL;
 
-	if (!prefixcmp(r, "refs/heads/"))
+	if (!prefixcmp(r, "refs/heads/") || !prefixcmp(r, "refs/remotes/"))
 		strbuf_addstr(&buf, "refs/heads/");
 	else if (!prefixcmp(r, "refs/tags/"))
 		strbuf_addstr(&buf, "refs/tags/");
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6889a53..692c773 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -383,6 +383,15 @@ test_expect_success 'push tag with non-existant, incomplete dest' '
 
 '
 
+test_expect_success 'push remote branch with non-existant, incomplete dest' '
+
+	mk_test &&
+	git update-ref refs/remotes/foo/bar master &&
+	git push testrepo foo/bar:branch &&
+	check_push_result $the_commit heads/branch
+
+'
+
 test_expect_success 'push sha1 with non-existant, incomplete dest' '
 
 	mk_test &&
-- 
1.6.5.1.201.g7feba
