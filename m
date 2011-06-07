From: Jeff King <peff@peff.net>
Subject: [PATCH 4/8] t5800: document some non-functional parts of remote
 helpers
Date: Tue, 7 Jun 2011 13:20:30 -0400
Message-ID: <20110607172030.GC22111@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:20:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzxH-0000re-GR
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab1FGRUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:20:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50739
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525Ab1FGRUe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:20:34 -0400
Received: (qmail 17021 invoked by uid 107); 7 Jun 2011 17:20:40 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:20:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:20:30 -0400
Content-Disposition: inline
In-Reply-To: <20110607171838.GA21685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175221>

These are all things one might expect to work in a helper
that is capable of handling multiple branches (which our
testgit helper in theory should be able to do, as it is
backed by git). All of these bugs are specific to the
import/export codepaths, so they don't affect helpers like
git-remote-curl that use fetch/push commands.

The first and fourth tests are about fetching and pushing
new refs, and demonstrate bugs in the git_remote_helpers
library (so they would be most likely to impact helpers for
other VCSs which import/export git).

The second test is about importing multiple refs; it
demonstrates a bug in git-remote-testgit, which is mostly
for exercising the test code. Therefore it probably doesn't
affect anyone in practice.

The third test demonstrates a bug in git's side of the
helper code when the upstream has added new refs without us.
This could impact git users who use remote helpers to access
foreign VCSs.

All of those bugs have fixes later in this series.

The fifth test is the most complex, and does not have a fix
in this series. It tests pushing a ref via the export
mechanism to a new name on the remote side (i.e.,
"git push $remote old:new").

The problem is that we push all of the work of generating
the export stream onto fast-export, but we have no way of
communicating to fast-export that this name mapping is
happening. So we tell fast-export to generate a stream with
the commits for "old", but we can't tell it to label them
all as "new".

There are two possible solutions:

  1. Indicate the mapping to fast-export, so that it can
     generate the "mapped" names. Unfortunately, this is
     somewhat difficult due to the way fast-import is
     implemented. It feeds its revision parameters to the
     regular rev-walking machinery, asking the revision code
     to mark the "source" of each commit. So if fast-export
     sees that we want commits from "refs/heads/old", but
     also that we want to call commits from old as
     "refs/heads/new", it can't distinguish between the
     case of "I want _only_ new, using the commits of old"
     and "I want _both_ old and new, which happen to point
     to the same commits".

     And it's important to distinguish those cases, because
     in one, the remote will update master, and in the
     other, it will not.

     This isn't an insurmountable obstacle, but it's going
     to mean either fast-export has to take on more of the
     revision argument parsing and revwalking
     responsibility, or the revision walker's show_source
     code will have to learn about mapping names.

  2. Indicate the mapping to the remote helper, who can then
     apply the mapping to the results of the export. Right
     now the export remote helper command has no arguments;
     it simply says "hey, I'm going to dump a fast-export
     stream on you". And the remote-helper looks through the
     results of the stream to decide which refs are being
     pushed. This could be extended instead to something
     like:

       export refs/heads/foo
       export refs/heads/old:refs/heads/new
       <blank line>

     which would allow the remote helper to map names as
     appropriate. This a reasonably elegant solution; the
     downside is that it breaks compatibility with existing
     remote helpers.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5800-remote-helpers.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 3a37ad0..a10a48d 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -81,4 +81,51 @@ test_expect_success PYTHON_24 'pushing remote local repo' '
 	compare_refs clone HEAD server HEAD
 '
 
+test_expect_failure PYTHON_24 'fetch new branch' '
+	(cd public &&
+	 git checkout -b new &&
+	 echo content >>file &&
+	 git commit -a -m five &&
+	 git push origin new
+	) &&
+	(cd localclone &&
+	 git fetch origin new
+	) &&
+	compare_refs public HEAD localclone FETCH_HEAD
+'
+
+test_expect_failure PYTHON_24 'fetch multiple branches' '
+	(cd localclone &&
+	 git fetch
+	) &&
+	compare_refs server master localclone refs/remotes/origin/master &&
+	compare_refs server new localclone refs/remotes/origin/new
+'
+
+test_expect_failure PYTHON_24 'push when remote has extra refs' '
+	(cd clone &&
+	 echo content >>file &&
+	 git commit -a -m six &&
+	 git push
+	) &&
+	compare_refs clone master server master
+'
+
+test_expect_failure PYTHON_24 'push new branch by name' '
+	(cd clone &&
+	 git checkout -b new-name  &&
+	 echo content >>file &&
+	 git commit -a -m seven &&
+	 git push origin new-name
+	) &&
+	compare_refs clone HEAD server refs/heads/new-name
+'
+
+test_expect_failure PYTHON_24 'push new branch with old:new refspec' '
+	(cd clone &&
+	 git push origin new-name:new-refspec
+	) &&
+	compare_refs clone HEAD server refs/heads/new-refspec
+'
+
 test_done
-- 
1.7.6.rc0.35.gc40cb
