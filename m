From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add [HOWTO] using merge subtree.
Date: Tue, 15 Jan 2008 01:35:02 +0100
Message-ID: <20080115003502.GN29972@genesis.frugalware.org>
References: <7vabnefx3d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 01:35:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEZmQ-0003F3-6H
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 01:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbYAOAfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 19:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbYAOAfV
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 19:35:21 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:39077 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbYAOAfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 19:35:20 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JEZlm-00085m-Rk
	from <vmiklos@frugalware.org>; Tue, 15 Jan 2008 01:35:16 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 12DFC176C06D; Tue, 15 Jan 2008 01:35:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vabnefx3d.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70494>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Here comes the 3rd try. I wonder if I should remove the mail header :) The
commands are from the mail, but the patch itself now are more based on the
suggestions by Junio (and reworded / reorganized).

Sorry for the late reply, I had some problem with my mail setup.

 Documentation/Makefile                    |    2 +-
 Documentation/howto/use-merge-subtree.txt |   71 +++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/howto/use-merge-subtree.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7b0685b..4addb8a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -23,7 +23,7 @@ ARTICLES += everyday
 ARTICLES += git-tools
 ARTICLES += glossary
 # with their own formatting rules.
-SP_ARTICLES = howto/revert-branch-rebase user-manual
+SP_ARTICLES = howto/revert-branch-rebase howto/use-merge-subtree user-manual
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
 SP_ARTICLES += technical/api-index
diff --git a/Documentation/howto/use-merge-subtree.txt b/Documentation/howto/use-merge-subtree.txt
new file mode 100644
index 0000000..2f4f38a
--- /dev/null
+++ b/Documentation/howto/use-merge-subtree.txt
@@ -0,0 +1,71 @@
+Date: Sat, 5 Jan 2008 20:17:40 -0500
+From: Sean <seanlkml@sympatico.ca>
+To: Miklos Vajna <vmiklos@frugalware.org>
+Cc: git@vger.kernel.org
+Subject: Re: how to use git merge -s subtree?
+Abstract: In this article, Sean demonstrates how one can use the subtree merge
+ strategy.
+Message-ID: <BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
+
+How to use the subtree merge strategy
+=====================================
+
+There are situations where you want to include contents in your project from an
+independently developed project. You can just pull from the other project as
+long as there are no conflicting paths.
+
+The problematic case is when there are conflicting files. Potential candidates
+are Makefiles and other standard filenames. You could merge these files but
+probably you do not want.  A better solution for this problem can be to merge
+the project to its own subdirectory. This is not supported by the 'recursive'
+merge strategy, so just pulling won't work.
+
+What you want is the 'subtree' merge strategy, which helps you in such a
+situation.
+
+In this example, let's say you have the repository at `/path/to/B` (but it can
+be an URL as well, if you want). You want to merge the 'master' branch of that
+repository to the `dir-B` subdirectory in your current branch.
+
+Here are all the commands you need:
+
+----------------
+$ git remote add -f Bproject /path/to/B <1>
+$ git merge -s ours --no-commit Bproject/master <2>
+$ git read-tree --prefix=dir-B/ -u Bproject/master <3>
+$ git commit -m "Merge B project as our subdirectory" <4>
+
+$ git pull -s subtree Bproject master <5>
+----------------
+<1> name the other project "Bproject", and fetch.
+<2> prepare for the later step to record the result as a merge.
+<3> read "master" branch of Bproject to the subdirectory "dir-B".
+<4> record the merge result.
+<5> maintain the result with subsequent merges using "subtree"
+
+The first four commands are necessary for the initial merge, while the last one
+should be used to merge updates from 'B project'.
+
+Comparing 'subtree' merge with submodules
+-----------------------------------------
+
+- The benefit of using subtree merge is that it requires less attention from
+  the users of your repository. It works with older (before Git v1.5.2) clients
+  and you have the code right after clone.
+
+- However if you use submodules then you can choose not to transfer the
+  submodule objects. This may be a problem with the subtree merge.
+
+- Also, in case you make changes to the other project, it is easier to submit
+  changes if you just use submodules.
+
+Additional tips
+---------------
+
+- If you made changes to the other project in your repository, they may want to
+  merge from your project. This is possible using subtree -- it can shift up
+  the paths in your tree and then they can merge only the relevant parts of
+  your tree.
+
+- Please note that if the other project merges from you, then it will connects
+  its history to yours, which can be something they don't want to.
-- 
1.5.4.rc2-dirty
