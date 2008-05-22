From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Add a test for another combination of --reference
Date: Thu, 22 May 2008 18:03:05 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805221800090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 00:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzItL-0006Yi-Di
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 00:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764437AbYEVWDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 18:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764073AbYEVWDK
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 18:03:10 -0400
Received: from iabervon.org ([66.92.72.58]:58047 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761779AbYEVWDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 18:03:07 -0400
Received: (qmail 25004 invoked by uid 1000); 22 May 2008 22:03:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 May 2008 22:03:05 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82659>

From: Johan Herland <johan@herland.net>

In this case, the reference repository has some useful loose objects,
but not all useful objects, and we make sure that we can find the
objects we fetch from the repository we're cloning in the new
repository, instead of potentially being distracted by the reference
repository.

Doing the wrong thing in a builtin-clone implementation would lead to
this looking for an object in the wrong place, not finding it (because
it's only in the right place), and crashing.

Signed-off-by: Johan Herland <johan@herland.net>
Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
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
1.5.3.7
