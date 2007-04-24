From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Improve request-pull to handle non-rebased branches
Date: Tue, 24 Apr 2007 12:40:19 -0400
Message-ID: <20070424164019.GA5780@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 18:40:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgO4G-0006mT-Mr
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 18:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbXDXQka (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 12:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbXDXQk3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 12:40:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54771 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422770AbXDXQk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 12:40:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgO3d-00079n-TL; Tue, 24 Apr 2007 12:40:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3E27520FBAE; Tue, 24 Apr 2007 12:40:19 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45468>

This is actually a few different changes to request-pull,
making it slightly smarter:

 1) Compute the merge-base between the two revisions upfront
    and reuse that selected merge-base for all log and diff
    operations.

 2) Disable the PAGER when running shortlog and diff, as these
    would otherwise activate the pager for each command when
    git-request-pull is run on a tty.  Users can get the entire
    output paged (if desired) using `git -p request-pull`.

 3) Use shortlog rather than `git log | git shortlog` now that
    recent shortlog versions are able to run the revision listing
    internally.

 4) Attempt to resolve the input URL using the user's configured
    remotes.  This is useful if the URL you want the recipient to
    see is also the one you used to push your changes.  If not a
    config-file remote could easily be setup for the public URL
    and request-pull can be passed that instead.

 5) Minor cleanup of revision->base variable names, making it
    follow the head/headrev naming convention that is already
    in use.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-request-pull.sh |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 4eacc3a..367b262 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -9,25 +9,27 @@ LONG_USAGE='Summarizes the changes since <commit> to the standard output,
 and includes <url> in the message generated.'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
+. git-parse-remote
 
-revision=$1
+base=$1
 url=$2
 head=${3-HEAD}
 
-[ "$revision" ] || usage
+[ "$base" ] || usage
 [ "$url" ] || usage
 
-baserev=`git-rev-parse --verify "$revision"^0` &&
+baserev=`git-merge-base "$base" "$head"` &&
 headrev=`git-rev-parse --verify "$head"^0` || exit
 
+PAGER=
+export PAGER
 echo "The following changes since commit $baserev:"
-git log --max-count=1 --pretty=short "$baserev" |
-git-shortlog | sed -e 's/^\(.\)/  \1/'
+git shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'
 
 echo "are found in the git repository at:" 
 echo
-echo "  $url"
+echo "  `get_remote_url "$url"`"
 echo
 
-git log  $baserev..$headrev | git-shortlog ;
-git diff -M --stat --summary $baserev..$headrev
+git shortlog ^$baserev $headrev
+git diff -M --stat --summary $baserev $headrev
-- 
1.5.1.1.135.gf948
