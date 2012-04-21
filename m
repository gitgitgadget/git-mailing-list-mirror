From: Pete Wyckoff <pw@padd.com>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from
 remote remote"
Date: Sat, 21 Apr 2012 16:15:24 -0400
Message-ID: <20120421201524.GA18419@padd.com>
References: <4F8A0F96.5060408@gmail.com>
 <20120415011118.GA4123@ecki>
 <4F8A8211.2010908@gmail.com>
 <20120415105943.GD6263@ecki>
 <4F8AAE7C.1020507@gmail.com>
 <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com>
 <20120415125140.GA15933@ecki>
 <20120419233445.GA20790@padd.com>
 <4F9145A1.6020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 22:15:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLgiU-0008FN-SK
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 22:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087Ab2DUUP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 16:15:29 -0400
Received: from honk.padd.com ([74.3.171.149]:54933 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab2DUUP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 16:15:28 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 43471E8E;
	Sat, 21 Apr 2012 13:15:27 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AB6E7313E3; Sat, 21 Apr 2012 16:15:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4F9145A1.6020201@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196059>

stefano.lattarini@gmail.com wrote on Fri, 20 Apr 2012 13:16 +0200:
> On 04/20/2012 01:34 AM, Pete Wyckoff wrote:
> > drizzd@aon.at wrote on Sun, 15 Apr 2012 14:51 +0200:
> >> The 'pushing to local repo' test of t5800 which pushes using
> >> git-remote-testgit.py results in a deadlock for Stefano. Invoking
> >> fast-export/fast-import manually seems to work, however. I don't know
> >> what else to try at this point.
> >>
> >> I am pasting some relevant results below.
> >>
> >>> expecting success:
> >>>         (cd localclone &&
> >>>         echo content >>file &&
> >>>         git commit -a -m three &&
> >>>         GIT_TRACE=1 GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 git push) &&
> >>>         compare_refs localclone HEAD server HEAD
> > 
> > fast-export should say to fd 1 "feature done\nblob\n..."
> > 
> > fast-import is probably blocked on reading fd 0, hoping to find a
> > sequence of commands
> > 
> > I too cannot reproduce the problem.  Stefano, can you try this
> > bigger hammer?  We'll see if anything sticks out.
> > 
> >     GIT_TRACE=1 GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 strace -vf -s 2000 -o /tmp/strace.out git push
> > 
> > Then "bzip2 /tmp/strace.out" and attach /tmp/strace.out.bz2, please.
> > 
> > 		-- Pete
> >
> Here it is.  Details of the git version I've used to do this test:
> 
>   $ git describe
>   v1.7.10-207-g0bb2ee1
> 
>   $ git diff
>   diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
>   index 1c62001..770cda6 100755
>   --- a/t/t5800-remote-helpers.sh
>   +++ b/t/t5800-remote-helpers.sh
>   @@ -68,7 +68,10 @@ test_expect_success 'pushing to local repo' '
>           (cd localclone &&
>           echo content >>file &&
>           git commit -a -m three &&
>   -       git push) &&
>   +        GIT_TRACE=1 \
>   +        GIT_TRANSPORT_HELPER_DEBUG=1 \
>   +        GIT_DEBUG_TESTGIT=1 \
>   +        strace -vf -s 2000 -o /tmp/strace.out git push) &&
>           compare_refs localclone HEAD server HEAD
>    '

Thank you.  Adding the strace made that test work, and a later
one hung with the same race condition.  Here's a patch that
describes the race, and adds a strategic sleep to make it easily
reproducible.

Not sure yet what is the right way to fix this.  And I don't know
if it's just git-remote-testgit that has the problem because it
forks an importer, or if other remote helpers would be similarly
affected.

The easiest fix is to invoke "python -u" in
git-remote-testgit.py, or do

    sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)

But I'm not sure if this works on all systems.  We could also
consider adding a handshake after "export", to give the helper
time to get ready.

		-- Pete

--8<--

>From 4179e326d86b6ab9f9c7f79a9dbd03b8d81b6a6a Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Sat, 21 Apr 2012 14:57:31 -0400
Subject: [PATCH] demonstrate git-remote-testgit race

Test t5800-remote-helpers "pushing to local repo" can hang
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

If fast-export is faster than git-remote-testgit + git
fast-import, the fast-export output can end up in libc's buffer,
rather than in git fast-import.  The latter blocks on a now-empty
stdin.

This patch demonstates the problem.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-remote-testgit.py     |    7 +++++++
 t/t5800-remote-helpers.sh |   17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 3dc4851..616e772 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -22,6 +22,7 @@ except ImportError:
     _digest = sha.new
 import sys
 import os
+import time
 sys.path.insert(0, os.getenv("GITPYTHONLIB","."))
 
 from git_remote_helpers.util import die, debug, warn
@@ -204,6 +205,12 @@ def read_one_line(repo):
     """Reads and processes one command.
     """
 
+    sleepy = os.environ.get("GIT_REMOTE_TESTGIT_SLEEPY")
+    if sleepy:
+        debug("Sleeping %d sec before readline" % int(sleepy))
+        time.sleep(int(sleepy))
+        debug("Awake, to readline")
+
     line = sys.stdin.readline()
 
     cmdline = line
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 1c62001..7555be6 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -72,6 +72,23 @@ test_expect_success 'pushing to local repo' '
 	compare_refs localclone HEAD server HEAD
 '
 
+test_expect_failure 'racily pushing to local repo' '
+	cp -a server server2 &&
+	git clone "testgit::${PWD}/server2" localclone2 &&
+	test_when_finished "rm -rf server2 localclone2" &&
+	(cd localclone2 &&
+	echo content >>file &&
+	git commit -a -m three &&
+	GIT_TRANSPORT_HELPER_DEBUG=1 GIT_REMOTE_TESTGIT_SLEEPY=2 timeout 10 strace -o trace.out -f git push
+	ret=$? &&
+	if [ $ret -eq 124 ]; then
+	    echo "Check for too much input in export line" &&
+	    grep "read(0, .export" trace.out ; true
+	fi &&
+	exit $ret) &&
+	compare_refs localclone2 HEAD server2 HEAD
+'
+
 test_expect_success 'synch with changes from localclone' '
 	(cd clone &&
 	 git pull)
-- 
1.7.10.57.g7fa2a.dirty
