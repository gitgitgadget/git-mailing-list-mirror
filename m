From: Johan Herland <johan@herland.net>
Subject: [PATCH 02/11] Add a test for another combination of --reference
Date: Sat, 8 Mar 2008 18:03:59 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081803580.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8CG-0001nk-WD
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbYCHXKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYCHXKm
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:10:42 -0500
Received: from iabervon.org ([66.92.72.58]:48093 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbYCHXKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:10:41 -0500
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Mar 2008 18:10:41 EST
Received: (qmail 18562 invoked by uid 1000); 8 Mar 2008 23:03:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:03:59 -0000
X-X-Sender: barkalow@iabervon.org
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76610>

In this case, the reference repository has some useful loose objects,
but not all useful objects, and we make sure that we can find the
objects we fetch from the repository we're cloning in the new
repository, instead of potentially being distracted by the reference
repository.

Doing the wrong thing in a builtin-clone implementation would lead to
this looking for an object in the wrong place, not finding it (because
it's only in the right place), and crashing.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t5700-clone-reference.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index d318780..0c42d9f 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -118,4 +118,25 @@ test_expect_success 'cloning with reference being subset of source (-l -s)' \
 
 cd "$base_dir"
 
+test_expect_success 'preparing alternate repository #1' \
+'test_create_repo F && cd F &&
+echo first > file1 &&
+git add file1 &&
+git commit -m initial'
+
+cd "$base_dir"
+
+test_expect_success 'cloning alternate repo #2 and adding changes to repo #1' \
+'git clone F G && cd F &&
+echo second > file2 &&
+git add file2 &&
+git commit -m addition'
+
+cd "$base_dir"
+
+test_expect_success 'cloning alternate repo #1, using #2 as reference' \
+'git clone --reference G F H'
+
+cd "$base_dir"
+
 test_done
-- 
1.5.4.3.327.g614d7.dirty

