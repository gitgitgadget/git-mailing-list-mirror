From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Thu, 21 Aug 2008 19:23:20 +0200
Message-ID: <20080821172320.GA5119@blimp.local>
References: <20080820185028.GA16626@blimp.local> <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080820200440.GF16626@blimp.local> <alpine.DEB.1.00.0808202213340.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080820202952.GH16626@blimp.local> <7vd4k3nx7m.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 19:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWDtc-0007jS-4d
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 19:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbYHURXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 13:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbYHURXY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 13:23:24 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:16437 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYHURXX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 13:23:23 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (fruni mo12) (RZmta 16.47)
	with ESMTP id N06856k7LGHSJX ; Thu, 21 Aug 2008 19:23:21 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 308E4277AE;
	Thu, 21 Aug 2008 19:23:21 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 03D5836D18; Thu, 21 Aug 2008 19:23:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4k3nx7m.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93179>

The code handles additionally "refs/remotes/<something>/name",
"remotes/<something>/name", and "refs/<namespace>/name".

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Junio C Hamano, Thu, Aug 21, 2008 00:22:21 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> > Johannes Schindelin, Wed, Aug 20, 2008 22:16:19 +0200:
> >> > No. It strips refs/ OR remotes/ (because of prefixcmp with argv[0]).
> >> > And I still wanted refs/<namespace>/something...
> >> 
> >> Yes, you are correct.  However, to fix my thinko, I deem this preferable:
> >> 
> >
> > Yes, I agree (and its shorter). The git-checkout manpage can be
> > improved, too (no DWIM is obvious, except may be for the implementor).
> 
> I think that makes sense.  Care to send an appliable patch with
> documentation updates, please?

I just have another quiet evening, so I did that. Johannes, I changed
your fix a bit: I see that argv[0] is used later (or if I'm blind and
it actually isn't, it may be used in future: I have a feeling that
builtint-checkout.c will be popular place).

 Documentation/git-checkout.txt |   18 +++++++++++++++---
 builtin-checkout.c             |   13 ++++++++-----
 t/t7201-co.sh                  |   23 ++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 43d4502..d93a18f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -64,9 +64,21 @@ OPTIONS
 	given. Set it to `always` if you want this behavior when the
 	start-point is either a local or remote branch.
 +
-If no '-b' option was given, a name will be made up for you, by stripping
-the part up to the first slash of the tracked branch.  For example, if you
-called 'git checkout --track origin/next', the branch name will be 'next'.
+If no '-b' option was given, the name of the new branch will be
+derived from the remote branch, by attempting to guess the name of the
+branch on remote system and use it. The algorithm will remove a
+prefixed refs/ and the part after refs/ up to a slash (that part
+usually being a branch namespace, which makes it confusing to use for
+branch names). If the part after refs/ was remotes/, than a part past
+it is stripped too (it is expected to be the name of remote system).
+Otherwise, the part up to the first slash is removed.
+The algorithm aborts either if the given name has no slashes in it or
+if the part left after stripping the prefixes is empty. In this case,
+the name should be provided with '-b'.
++
+For example, if you called 'git checkout --track origin/next', the
+branch name will be 'next', as it will for 'git checkout --track
+remotes/origin/next'.
 
 --no-track::
 	Ignore the branch.autosetupmerge configuration variable.
diff --git a/builtin-checkout.c b/builtin-checkout.c
index e95eab9..214b0b2 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -445,12 +445,15 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	/* --track without -b should DWIM */
 	if (opts.track && opts.track != -1 && !opts.new_branch) {
 		char *slash;
-		if (!argc || !strcmp(argv[0], "--"))
+		char *argv0 = argv[0];
+		if (!argc || !strcmp(argv0, "--"))
 			die ("--track needs a branch name");
-		slash = strchr(argv[0], '/');
-		if (slash && !prefixcmp(argv[0], "refs/"))
-			slash = strchr(slash + 1, '/');
-		if (slash && !prefixcmp(argv[0], "remotes/"))
+		slash = strchr(argv0, '/');
+		if (slash && !prefixcmp(argv0, "refs/")) {
+			argv0 = slash + 1;
+			slash = strchr(argv0, '/');
+		}
+		if (slash && !prefixcmp(argv0, "remotes/"))
 			slash = strchr(slash + 1, '/');
 		if (!slash || !slash[1])
 			die ("Missing branch name; try -b");
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 943dd57..1dff84d 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -340,9 +340,30 @@ test_expect_success \
 test_expect_success \
     'checkout with --track fakes a sensible -b <name>' '
     git update-ref refs/remotes/origin/koala/bear renamer &&
+    git update-ref refs/new/koala/bear renamer &&
+
     git checkout --track origin/koala/bear &&
     test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)"'
+    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
+
+    git checkout master && git branch -D koala/bear &&
+
+    git checkout --track refs/remotes/origin/koala/bear &&
+    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
+
+    git checkout master && git branch -D koala/bear &&
+
+    git checkout --track remotes/origin/koala/bear &&
+    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
+
+    git checkout master && git branch -D koala/bear &&
+
+    git checkout --track refs/new/koala/bear &&
+    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)"
+'
 
 test_expect_success \
     'checkout with --track, but without -b, fails with too short tracked name' '
-- 
1.6.0.59.g8ae62
