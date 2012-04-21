From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from
 remote remote"
Date: Sun, 22 Apr 2012 01:35:21 +0200
Message-ID: <20120421233521.GB20473@ecki>
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
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 01:55:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLk9g-000385-W0
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 01:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452Ab2DUXzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 19:55:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:65020 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab2DUXzO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 19:55:14 -0400
Received: from [127.0.0.1] (p5B22E4D1.dip.t-dialin.net [91.34.228.209])
	by bsmtp.bon.at (Postfix) with ESMTP id 8125710011;
	Sun, 22 Apr 2012 01:51:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120421201524.GA18419@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196065>

Hi Pete,

Thanks for solving the mystery.

On Sat, Apr 21, 2012 at 04:15:24PM -0400, Pete Wyckoff wrote:
> 
> Not sure yet what is the right way to fix this.  And I don't know
> if it's just git-remote-testgit that has the problem because it
> forks an importer, or if other remote helpers would be similarly
> affected.
> 
> The easiest fix is to invoke "python -u" in
> git-remote-testgit.py, or do
> 
>     sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)
> 
> But I'm not sure if this works on all systems.

Which part are you worried about? Maybe the patch below is more
portable?

> We could also consider adding a handshake after "export", to give the
> helper time to get ready.

Not sure I understand. The helper is throwing away some input. It seems
to me there is nothing one can do to prevent such brokeness.

It would be nice if the deadlock could be detected and if git would time
out in such a case, instead of hanging forever. But rather long delays
can also be the result of the remote helper legimitately waiting for
data from a slow network.

Clemens
---

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 616e772..bdd1116 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -135,6 +135,22 @@ def update_local_repo(repo):
     return repo
 
 
+def read_line_fd(fd):
+    """Read from fd until end of line or EOF, and no further.
+    """
+
+    line = ''
+
+    while True:
+        c = os.read(fd, 1)
+        if c == '':
+            break
+        line += c
+        if c == '\n':
+            break
+
+    return line
+
 def do_import(repo, args):
     """Exports a fast-import stream from testgit for git to import.
     """
@@ -149,7 +165,7 @@ def do_import(repo, args):
     refs = [ref]
 
     while True:
-        line = sys.stdin.readline()
+        line = read_line_fd(sys.stdin.fileno())
         if line == '\n':
             break
         if not line.startswith('import '):
@@ -211,9 +227,7 @@ def read_one_line(repo):
         time.sleep(int(sleepy))
         debug("Awake, to readline")
 
-    line = sys.stdin.readline()
-
-    cmdline = line
+    cmdline = read_line_fd(sys.stdin.fileno())
 
     if not cmdline:
         warn("Unexpected EOF")
-- 
1.7.10
