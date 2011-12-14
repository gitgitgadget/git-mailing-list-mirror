From: Sebastian Morr <sebastian@morr.cc>
Subject: [PATCH] stash: Fix multiple error messages on create if no HEAD
Date: Wed, 14 Dec 2011 01:14:32 +0100
Message-ID: <20111214001432.GA2959@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 01:14:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RacUa-0005hg-Cn
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 01:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab1LNAOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 19:14:36 -0500
Received: from static.148.34.47.78.clients.your-server.de ([78.47.34.148]:48131
	"EHLO morr.cc" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329Ab1LNAOg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 19:14:36 -0500
Received: by morr.cc (Postfix, from userid 1001)
	id 5B9644763F7F; Wed, 14 Dec 2011 01:14:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on morr.cc
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
	version=3.3.1
Received: from thinkpad (port-92-196-84-34.dynamic.qsc.de [92.196.84.34])
	by morr.cc (Postfix) with ESMTPSA id D5D664763F7D
	for <git@vger.kernel.org>; Wed, 14 Dec 2011 01:14:33 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187084>

create_stash() checks whether HEAD is valid via rev-parse. If this is
not the case, both itself as well as rev-parse print an error message.
Make rev-parse quiet.

In no_changes(), diff-index is called, which dies unquietly if there is
no commit. Hide it's stderr.

Signed-off-by: Sebastian Morr <sebastian@morr.cc>
---

This bugged me: In a new, empty repository:

    $ git stash
    fatal: bad revision 'HEAD'
    fatal: bad revision 'HEAD'
    fatal: Needed a single revision
    You do not have the initial commit yet

With this patch:

    $ git stash
    You do not have the initial commit yet

With the --quiet option, I wouldn't expect diff-index to print error
messages. But it does so (via revision.c, setup_revisions()). Is this
wanted?

 git-stash.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index c766692..07b6511 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -34,7 +34,7 @@ else
 fi
 
 no_changes () {
-	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
+	git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null &&
 	git diff-files --quiet --ignore-submodules &&
 	(test -z "$untracked" || test -z "$(untracked_files)")
 }
@@ -67,7 +67,7 @@ create_stash () {
 	fi
 
 	# state of the base commit
-	if b_commit=$(git rev-parse --verify HEAD)
+	if b_commit=$(git rev-parse --quiet --verify HEAD)
 	then
 		head=$(git rev-list --oneline -n 1 HEAD --)
 	else
-- 
1.7.8.168.gd6118.dirty
