From: Max Horn <max@quendi.de>
Subject: [PATCH 1/3] remote-hg: do not fail on invalid bookmarks
Date: Wed, 19 Mar 2014 13:33:17 +0100
Message-ID: <1395232399-60112-1-git-send-email-max@quendi.de>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 13:33:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQFgb-0001GA-C9
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 13:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbaCSMdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 08:33:23 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:48895 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964863AbaCSMdW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 08:33:22 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WQFgO-0008N9-Uu; Wed, 19 Mar 2014 13:33:20 +0100
X-Mailer: git-send-email 1.9.0.7.ga299b13
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1395232402;676ca8d1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244441>

From: Antoine Pelisse <apelisse@gmail.com>

Mercurial can have bookmarks pointing to "nullid" (the empty root
revision), while Git can not have references to it.
When cloning or fetching from a Mercurial repository that has such a
bookmark, the import will fail because git-remote-hg will not be able to
create the corresponding reference.

Warn the user about the invalid reference, and continue the import,
instead of stopping right away.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Max Horn <max@quendi.de>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index eb89ef6..12d850e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -625,6 +625,9 @@ def list_head(repo, cur):
 def do_list(parser):
     repo = parser.repo
     for bmark, node in bookmarks.listbookmarks(repo).iteritems():
+        if node == '0000000000000000000000000000000000000000':
+            warn("Ignoring invalid bookmark '%s'", bmark)
+            continue
         bmarks[bmark] = repo[node]
 
     cur = repo.dirstate.branch()
-- 
1.9.0.7.ga299b13
