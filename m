From: Max Horn <max@quendi.de>
Subject: [PATCH 2/3] remote-hg: allow invalid bookmarks in a few edge cases
Date: Wed, 19 Mar 2014 13:33:18 +0100
Message-ID: <1395232399-60112-2-git-send-email-max@quendi.de>
References: <1395232399-60112-1-git-send-email-max@quendi.de>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 13:33:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQFga-0001GA-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 13:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbaCSMdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 08:33:24 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:48897 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964867AbaCSMdW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 08:33:22 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WQFgP-0008N9-1M; Wed, 19 Mar 2014 13:33:21 +0100
X-Mailer: git-send-email 1.9.0.7.ga299b13
In-Reply-To: <1395232399-60112-1-git-send-email-max@quendi.de>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1395232402;676ca8d1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244440>

Fix the previous commit to workaround issues with edge cases: Specifically,
remote-hg inserts a fake 'master' branch, unless the cloned hg repository
already contains a 'master' bookmark. If that 'master' bookmark happens
to reference the 'null' commit, the preceding fix ignores it. This
would leave us in an inconsistent state. Avoid this by NOT ignoring
null bookmarks named 'master' or 'default' under suitable circumstances.

Signed-off-by: Max Horn <max@quendi.de>
---
 contrib/remote-helpers/git-remote-hg | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 12d850e..49b2c2e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -626,8 +626,11 @@ def do_list(parser):
     repo = parser.repo
     for bmark, node in bookmarks.listbookmarks(repo).iteritems():
         if node == '0000000000000000000000000000000000000000':
-            warn("Ignoring invalid bookmark '%s'", bmark)
-            continue
+            if fake_bmark == 'default' and bmark == 'master':
+                pass
+            else:
+                warn("Ignoring invalid bookmark '%s'", bmark)
+                continue
         bmarks[bmark] = repo[node]
 
     cur = repo.dirstate.branch()
-- 
1.9.0.7.ga299b13
