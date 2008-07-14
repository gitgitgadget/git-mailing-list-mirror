From: Nicolas Pitre <nico@cam.org>
Subject: [BUG] commit walk machinery is dangerous !
Date: Mon, 14 Jul 2008 16:54:24 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807141641110.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 22:55:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIV4v-0002ci-Ao
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 22:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939AbYGNUy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 16:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbYGNUy0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 16:54:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8408 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbYGNUyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 16:54:25 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K400041UKQOGVE0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 16:54:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88463>

Good!  I have all your attention now.

Yes, I'm kinda fscking upset about my hardware at this moment.  I 
apparently have git packs corrupting themselves from time to time which 
prompted me to make git more robust against some kind of corruptions 
recently.

However this time a corruption turned up and exposed what I think is a 
major flaw in git's error checking.  To demonstrate it, I created the 
following test case.  Turning the error() into a die() on line 772 of 
commit.c makes this test pass but I don't know if this is the 
appropriate fix (e.g. some attempt to parse non existing commits could 
be valid usage, etc.).  Note this is critical only for git versions 
later than commit 8eca0b47ff15.

So here's the test.  The catastrophic consequences that this can have on 
one's repository is left as an exercise to the reader.

diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
new file mode 100755
index 0000000..a5fe190
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
+   test_must_fail git fsck --all
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
