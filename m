From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2] git-remote-testgit: fix race when spawning fast-import
Date: Sun, 22 Apr 2012 16:30:58 -0400
Message-ID: <20120422203058.GA17290@padd.com>
References: <20120415105943.GD6263@ecki>
 <4F8AAE7C.1020507@gmail.com>
 <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com>
 <20120415125140.GA15933@ecki>
 <20120419233445.GA20790@padd.com>
 <4F9145A1.6020201@gmail.com>
 <20120421201524.GA18419@padd.com>
 <20120421234555.GA11808@padd.com>
 <xmqqty0cxtcd.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 22:31:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SM3R7-000393-7n
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 22:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab2DVUbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 16:31:04 -0400
Received: from honk.padd.com ([74.3.171.149]:40701 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166Ab2DVUbC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 16:31:02 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id CD10FD27;
	Sun, 22 Apr 2012 13:31:00 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7BA9C313E3; Sun, 22 Apr 2012 16:30:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqty0cxtcd.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196090>

Test "pushing to local repo" in t5800-remote-helpers can hang
due to a race condition in git-remote-testgit.  Fix it by
setting stdin to unbuffered.

On the writer side, "git push" invokes push_refs_with_export(),
which sends to stdout the command "export\n" and immediately
starts up "git fast-export".  The latter writes its output stream
to the same stdout.

On the reader side, remote helper "git-remote-testgit" reads from
stdin to get its next command.  It uses getc() to read characters
from libc up until \n.  Libc has buffered a potentially much
larger chunk of stdin.  When it sees the "export\n" command, it
forks "git fast-import" to read the stream.

If fast-export finishes before git fast-import starts, the
fast-export output can end up in libc's buffer in
git-remote-testgit, rather than in git fast-import.  The latter
hangs indefinitely on a now-empty stdin.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
gitster@pobox.com wrote on Sat, 21 Apr 2012 21:50 -0700:
> If I understand your explanation correctly, the primary purpose of the
> remote-testgit is to test the parts of the system that talk to remote
> helpers that are used in production in the t/t5800 script, and this
> "sleep" is to make it easier to trigger the particular bug you fixed 
> in *this* script.  The bug is _not_ in the parts of the system being
> tested, but is in this test scaffolding.

Indeed.  I tried to make that more obvious in the commit message.

> If that is the case, then it should not be enabled unconditionally.
> When somebody wants to see if remote-testgit was broken again (perhaps
> after observing occassional hangs), the environment should be set when
> running the test, but not in t5800.

Clemens suggested disabling the test by default, as I've done
here.  I think it would be okay to remove it entirely, too.

		-- Pete

 git-remote-testgit.py     |    7 +++++++
 t/t5800-remote-helpers.sh |   14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 3dc4851..5f3ebd2 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -22,6 +22,7 @@ except ImportError:
     _digest = sha.new
 import sys
 import os
+import time
 sys.path.insert(0, os.getenv("GITPYTHONLIB","."))
 
 from git_remote_helpers.util import die, debug, warn
@@ -204,6 +205,11 @@ def read_one_line(repo):
     """Reads and processes one command.
     """
 
+    sleepy = os.environ.get("GIT_REMOTE_TESTGIT_SLEEPY")
+    if sleepy:
+        debug("Sleeping %d sec before readline" % int(sleepy))
+        time.sleep(int(sleepy))
+
     line = sys.stdin.readline()
 
     cmdline = line
@@ -258,6 +264,7 @@ def main(args):
 
     more = True
 
+    sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)
     while (more):
         more = read_one_line(repo)
 
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 1c62001..85a8042 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -72,6 +72,20 @@ test_expect_success 'pushing to local repo' '
 	compare_refs localclone HEAD server HEAD
 '
 
+# Generally, skip this test.  It demonstrates a now-fixed
+# race in git-remote-testgit, but is too slow to leave in
+# for general use.
+test_expect_success DEBUG_TESTGIT_RACE 'racily pushing to local repo' '
+	cp -a server server2 &&
+	git clone "testgit::${PWD}/server2" localclone2 &&
+	test_when_finished "rm -rf server2 localclone2" &&
+	(cd localclone2 &&
+	echo content >>file &&
+	git commit -a -m three &&
+	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
+	compare_refs localclone2 HEAD server2 HEAD
+'
+
 test_expect_success 'synch with changes from localclone' '
 	(cd clone &&
 	 git pull)
-- 
1.7.10.57.g437cb.dirty
