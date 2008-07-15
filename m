From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/2] test case for previous commit
Date: Mon, 14 Jul 2008 21:50:46 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807142147270.12484@xanadu.home>
References: <alpine.LFD.1.10.0807141641110.12484@xanadu.home>
 <7vbq10f7wr.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807141904250.12484@xanadu.home>
 <7vod50dote.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807141937180.12484@xanadu.home>
 <alpine.LFD.1.10.0807142134450.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 03:51:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIZht-0007jt-In
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 03:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbYGOBus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 21:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755218AbYGOBus
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 21:50:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48578 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173AbYGOBur (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 21:50:47 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4000DDZYGMK960@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 21:50:46 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0807142134450.12484@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88498>

Here's a test demonstrating a case of what was broken before
(and fixed by) the previous patch.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
new file mode 100755
index 0000000..e51eb41
--- /dev/null
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='git rev-list should notice bad commits'
+
+. ./test-lib.sh
+
+# Note:
+# - compression level is set to zero to make "corruptions" easier to perform
+# - reflog is disabled to avoid extra references which would twart the test
+
+test_expect_success 'setup' \
+   '
+   git init &&
+   git config core.compression 0 &&
+   git config core.logallrefupdates false &&
+   echo "foo" > foo &&
+   git add foo &&
+   git commit -m "first commit" &&
+   echo "bar" > bar &&
+   git add bar &&
+   git commit -m "second commit" &&
+   echo "baz" > baz &&
+   git add baz &&
+   git commit -m "third commit" &&
+   echo "foo again" >> foo &&
+   git add foo &&
+   git commit -m "fourth commit" &&
+   git repack -a -f -d
+   '
+
+test_expect_success 'verify number of revisions' \
+   '
+   revs=$(git rev-list --all | wc -l) &&
+   test $revs -eq 4 &&
+   first_commit=$(git rev-parse HEAD~3)
+   '
+
+test_expect_success 'corrupt second commit object' \
+   '
+   perl -i.bak -pe "s/second commit/socond commit/" .git/objects/pack/*.pack &&
+   test_must_fail git fsck --full
+   '
+
+test_expect_success 'rev-list should fail' \
+   '
+   test_must_fail git rev-list --all > /dev/null
+   '
+
+test_expect_success 'git repack _MUST_ fail' \
+   '
+   test_must_fail git repack -a -f -d
+   '
+
+test_expect_success 'first commit is still available' \
+   '
+   git log $first_commit
+   '
+
+test_done
+
