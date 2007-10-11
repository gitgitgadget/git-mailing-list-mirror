From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] fetch: if not fetching from default remote, ignore default
 merge
Date: Thu, 11 Oct 2007 12:35:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710111235440.4174@racer.site>
References: <Pine.LNX.4.64.0710110146200.4174@racer.site> <470DC53A.4050707@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, hjemli@gmail.com, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 13:36:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfwL8-0007tQ-3t
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 13:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbXJKLgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 07:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbXJKLgV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 07:36:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:44483 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753199AbXJKLgU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 07:36:20 -0400
Received: (qmail invoked by alias); 11 Oct 2007 11:36:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 11 Oct 2007 13:36:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2xI5+uW+2bDe3gPyVfUv6EUovfE2nxdH0Vkra7X
	Hn2jaRREgQnwiZ
X-X-Sender: gene099@racer.site
In-Reply-To: <470DC53A.4050707@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60593>


When doing "git fetch <remote>" on a remote that does not have the
branch referenced in branch.<current-branch>.merge, git fetch failed.
It failed because it tried to add the "merge" ref to the refs to be
fetched.

Fix that.  And add a test case.

Incidentally, this unconvered a bug in our own test suite, where
"git pull <some-path>" was expected to merge the ref given in the
defaults, even if not pulling from the default remote.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-fetch.c            |    8 +++++++-
 t/t5510-fetch.sh           |    8 ++++++++
 t/t5700-clone-reference.sh |    4 ++--
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index cf7498b..ca4de9f 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -105,7 +105,13 @@ static struct ref *get_ref_map(struct transport *transport,
 				    !remote->fetch[0].pattern)
 					ref_map->merge = 1;
 			}
-			if (has_merge)
+			/*
+			 * if the remote we're fetching from is the same
+			 * as given in branch.<name>.remote, we add the
+			 * ref given in branch.<name>.merge, too.
+			 */
+			if (has_merge && !strcmp(branch->remote_name,
+						remote->name))
 				add_merge_config(&ref_map, remote_refs, branch, &tail);
 		} else {
 			ref_map = get_remote_ref(remote_refs, "HEAD");
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 73a4e3c..1f398bc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -188,4 +188,12 @@ test_expect_success 'push via rsync' '
 '
 }
 
+test_expect_success 'fetch with a non-applying branch.<name>.merge' '
+	git config branch.master.remote yeti &&
+	git config branch.master.merge refs/heads/bigfoot &&
+	git config remote.blub.url one &&
+	git config remote.blub.fetch "refs/heads/*:refs/remotes/one/*" &&
+	git fetch blub
+'
+
 test_done
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 4e93aaa..b6a5486 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -38,7 +38,7 @@ cd "$base_dir"
 
 test_expect_success 'pulling from reference' \
 'cd C &&
-git pull ../B'
+git pull ../B master'
 
 cd "$base_dir"
 
@@ -61,7 +61,7 @@ test_expect_success 'existence of info/alternates' \
 cd "$base_dir"
 
 test_expect_success 'pulling from reference' \
-'cd D && git pull ../B'
+'cd D && git pull ../B master'
 
 cd "$base_dir"
 
-- 
1.5.3.4.1174.gcd0d6-dirty
