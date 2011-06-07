From: Jeff King <peff@peff.net>
Subject: [PATCH 6/8] teach remote-testgit to import multiple refs
Date: Tue, 7 Jun 2011 13:21:04 -0400
Message-ID: <20110607172104.GE22111@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:21:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzy1-0001HF-EY
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637Ab1FGRVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:21:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50755
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316Ab1FGRVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:21:07 -0400
Received: (qmail 17125 invoked by uid 107); 7 Jun 2011 17:21:14 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:21:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:21:04 -0400
Content-Disposition: inline
In-Reply-To: <20110607171838.GA21685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175223>

When git wants to fetch multiple refs from a remote helper,
it will issue multiple "import" lines. In this case, testgit
would then run multiple fast-exports, one per commit. Not
only is this inefficient (since the refs may have shared
history), but the data stream will appear bogus to
fast-import, which sees the output of the exports
concatenated (specifically, each export starts with
"feature" lines, which are not allowed to come after "data"
lines).

Instead, the helper needs to collect the list of refs to be
imported, and then run a single fast-import with all of the
refs (once git has signalled to us the list is done by
hanging up).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-remote-testgit.py     |   24 +++++++++++++++++++++---
 t/t5800-remote-helpers.sh |    2 +-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index e2ad98e..c04f1b3 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -113,9 +113,13 @@ def update_local_repo(repo):
     return repo
 
 
+to_import = []
 def do_import(repo, args):
-    """Exports a fast-import stream from testgit for git to import.
+    """Collect a set of refs to import; we must do the final
+       import at the end, since we only want to exec fast-export
+       once.
     """
+    global to_import
 
     if len(args) != 1:
         die("Import needs exactly one ref")
@@ -123,11 +127,24 @@ def do_import(repo, args):
     if not repo.gitdir:
         die("Need gitdir to import")
 
-    repo = update_local_repo(repo)
-    repo.exporter.export_repo(repo.gitdir, args)
+    to_import.append(args[0])
     return True
 
 
+def finalize_import(repo):
+    """Exports a fast-import stream from testgit for git to import;
+       we should have collected the list of refs already in
+       to_import.
+    """
+    global to_import
+
+    if len(to_import) == 0:
+	    return
+
+    repo = update_local_repo(repo)
+    repo.exporter.export_repo(repo.gitdir, to_import)
+
+
 def do_export(repo, args):
     """Imports a fast-import stream from git to testgit.
     """
@@ -199,6 +216,7 @@ def read_one_line(repo):
     cmdline = cmdline.strip().split()
     if not cmdline:
         # Blank line means we're about to quit
+        finalize_import(repo)
         return False
 
     cmd = cmdline.pop(0)
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 562edf4..b28f2b3 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -94,7 +94,7 @@ test_expect_success PYTHON_24 'fetch new branch' '
 	compare_refs public HEAD localclone FETCH_HEAD
 '
 
-test_expect_failure PYTHON_24 'fetch multiple branches' '
+test_expect_success PYTHON_24 'fetch multiple branches' '
 	(cd localclone &&
 	 git fetch
 	) &&
-- 
1.7.6.rc0.35.gc40cb
