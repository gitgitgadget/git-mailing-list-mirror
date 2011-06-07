From: Jeff King <peff@peff.net>
Subject: [PATCH 5/8] teach remote-testgit to import non-HEAD refs
Date: Tue, 7 Jun 2011 13:20:52 -0400
Message-ID: <20110607172052.GD22111@sigill.intra.peff.net>
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
	id 1QTzy0-0001HF-Ry
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756636Ab1FGRU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:20:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50748
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756634Ab1FGRU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:20:56 -0400
Received: (qmail 17092 invoked by uid 107); 7 Jun 2011 17:21:03 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:21:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:20:52 -0400
Content-Disposition: inline
In-Reply-To: <20110607171838.GA21685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175225>

Upon receiving an "import" command, the testgit remote
helper would ignore the ref asked for by git and generate a
fast-export stream based on HEAD. Instead, we should
actually give git the ref it asked for.

This requires adding a new parameter to the export_repo
method in the remote-helpers python library, which may be
used by code outside of git.git. We use a default parameter
so that callers without the new parameter will get the same
behavior as before.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-remote-testgit.py              |    2 +-
 git_remote_helpers/git/exporter.py |    3 ++-
 t/t5800-remote-helpers.sh          |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 937b858..e2ad98e 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -124,7 +124,7 @@ def do_import(repo, args):
         die("Need gitdir to import")
 
     repo = update_local_repo(repo)
-    repo.exporter.export_repo(repo.gitdir)
+    repo.exporter.export_repo(repo.gitdir, args)
     return True
 
 
diff --git a/git_remote_helpers/git/exporter.py b/git_remote_helpers/git/exporter.py
index f40f9d6..1855c6a 100644
--- a/git_remote_helpers/git/exporter.py
+++ b/git_remote_helpers/git/exporter.py
@@ -15,7 +15,7 @@ class GitExporter(object):
 
         self.repo = repo
 
-    def export_repo(self, base):
+    def export_repo(self, base, refs = ["HEAD"]):
         """Exports a fast-export stream for the given directory.
 
         Simply delegates to git fast-epxort and pipes it through sed
@@ -38,6 +38,7 @@ class GitExporter(object):
         sys.stdout.flush()
 
         args = ["git", "--git-dir=" + self.repo.gitpath, "fast-export", "--export-marks=" + path]
+	args.extend(refs)
 
         if os.path.exists(path):
             args.append("--import-marks=" + path)
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index a10a48d..562edf4 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -81,7 +81,7 @@ test_expect_success PYTHON_24 'pushing remote local repo' '
 	compare_refs clone HEAD server HEAD
 '
 
-test_expect_failure PYTHON_24 'fetch new branch' '
+test_expect_success PYTHON_24 'fetch new branch' '
 	(cd public &&
 	 git checkout -b new &&
 	 echo content >>file &&
-- 
1.7.6.rc0.35.gc40cb
