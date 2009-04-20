From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix uninitialized memory in get_local_heads()
Date: Mon, 20 Apr 2009 12:20:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904201219240.6955@intel-tinevez-2-302>
References: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 20 12:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvqdw-0005gz-JR
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 12:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbZDTKUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbZDTKUy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:20:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:35868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753751AbZDTKUy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:20:54 -0400
Received: (qmail invoked by alias); 20 Apr 2009 10:20:52 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 20 Apr 2009 12:20:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7W00wMzG7z/LOp4/MHh3Pdz5CgCoUB9jSwPrAHQ
	yB4MIKNxTk+Zcr
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116961>


In 454e202(move duplicated get_local_heads() to remote.c), a static
local variable was moved into a function, but not initialized.

This resulted in a crash when trying to push from an empty repository.

Noticed by Matthieu Moy.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 20 Apr 2009, Matthieu Moy wrote:

	> Ideally, "git push" from an empty repository to another empty 
	> one should be a no-op, or perhaps should error out cleanly.
	> Currently, it just segfaults.

	Good catch.  This patch goes on top of yours.

	/me is running valgrind now.

 remote.c               |    2 +-
 t/t5701-clone-local.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index a06761a..e4c89b8 100644
--- a/remote.c
+++ b/remote.c
@@ -1504,7 +1504,7 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 
 struct ref *get_local_heads(void)
 {
-	struct ref *local_refs, **local_tail = &local_refs;
+	struct ref *local_refs = NULL, **local_tail = &local_refs;
 	for_each_ref(one_local_ref, &local_tail);
 	return local_refs;
 }
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 7c6ef4c..f26b511 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -132,7 +132,7 @@ test_expect_success 'clone empty repository' '
 	 test $actual = $expected)
 '
 
-test_expect_failure 'clone empty repository, and then push should not segfault.' '
+test_expect_success 'clone empty repository, and then push should not segfault.' '
 	cd "$D" &&
 	rm -fr empty/ empty-clone/ &&
 	mkdir empty &&
-- 
1.6.2.1.493.g67cf3
