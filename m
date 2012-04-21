From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git-remote-testgit: fix race when spawning fast-import
Date: Sat, 21 Apr 2012 19:45:55 -0400
Message-ID: <20120421234555.GA11808@padd.com>
References: <20120415011118.GA4123@ecki>
 <4F8A8211.2010908@gmail.com>
 <20120415105943.GD6263@ecki>
 <4F8AAE7C.1020507@gmail.com>
 <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com>
 <20120415125140.GA15933@ecki>
 <20120419233445.GA20790@padd.com>
 <4F9145A1.6020201@gmail.com>
 <20120421201524.GA18419@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 01:46:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLk0C-0006f2-UU
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 01:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131Ab2DUXqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 19:46:00 -0400
Received: from honk.padd.com ([74.3.171.149]:39138 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab2DUXp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 19:45:59 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 8864E20CE;
	Sat, 21 Apr 2012 16:45:58 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 01966313E3; Sat, 21 Apr 2012 19:45:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20120421201524.GA18419@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196064>

Test "pushing to local repo" in t5800-remote-helpers can hang
in a race condition between git push and git-remote-testgit.

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

Fix this by setting stdin to unbuffered.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---

This is the one that might be suitable for upstream.  It fixes
the problem with this particular remote helper.

 git-remote-testgit.py     |    7 +++++++
 t/t5800-remote-helpers.sh |   11 +++++++++++
 2 files changed, 18 insertions(+)

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
index 1c62001..cdcee83 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -72,6 +72,17 @@ test_expect_success 'pushing to local repo' '
 	compare_refs localclone HEAD server HEAD
 '
 
+test_expect_success 'racily pushing to local repo' '
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
1.7.10.57.g22c0b.dirty
