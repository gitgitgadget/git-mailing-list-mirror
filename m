From: Jeff King <peff@peff.net>
Subject: [PATCH 8/8] git_remote_helpers: push all refs during a non-local
 export
Date: Tue, 7 Jun 2011 13:21:29 -0400
Message-ID: <20110607172129.GG22111@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:21:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzyF-0001PV-Fw
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab1FGRVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:21:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50773
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379Ab1FGRVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:21:33 -0400
Received: (qmail 17236 invoked by uid 107); 7 Jun 2011 17:21:39 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:21:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:21:29 -0400
Content-Disposition: inline
In-Reply-To: <20110607171838.GA21685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175226>

When a remote helper exports to a non-local git repo, the
steps are roughly:

  1. fast-export into a local staging area; the set of
     interesting refs is defined by what is in the fast-export
     stream

  2. git push from the staging area to the non-local repo

In the second step, we should explicitly push all refs, not
just matching ones. This will let us push refs that do not
yet exist in the remote repo.

Signed-off-by: Jeff King <peff@peff.net>
---
 git_remote_helpers/git/non_local.py |    2 +-
 t/t5800-remote-helpers.sh           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git_remote_helpers/git/non_local.py b/git_remote_helpers/git/non_local.py
index f27389b..c53e074 100644
--- a/git_remote_helpers/git/non_local.py
+++ b/git_remote_helpers/git/non_local.py
@@ -63,7 +63,7 @@ class NonLocalGit(object):
         if not os.path.exists(path):
             die("could not find repo at %s", path)
 
-        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath]
+        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath, "--all"]
         child = subprocess.Popen(args)
         if child.wait() != 0:
             raise CalledProcessError
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index a6cc43b..682f813 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -111,7 +111,7 @@ test_expect_success PYTHON_24 'push when remote has extra refs' '
 	compare_refs clone master server master
 '
 
-test_expect_failure PYTHON_24 'push new branch by name' '
+test_expect_success PYTHON_24 'push new branch by name' '
 	(cd clone &&
 	 git checkout -b new-name  &&
 	 echo content >>file &&
-- 
1.7.6.rc0.35.gc40cb
