From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Improve request-pull to handle non-rebased branches
Date: Wed, 25 Apr 2007 02:41:05 -0400
Message-ID: <20070425064105.GA8047@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 08:41:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgbBl-0000dj-Hr
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 08:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161408AbXDYGlO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 02:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161616AbXDYGlO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 02:41:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56087 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161408AbXDYGlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 02:41:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgbBd-0002cF-4H; Wed, 25 Apr 2007 02:41:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8AAAF20FBAE; Wed, 25 Apr 2007 02:41:05 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45500>

This is actually a few different changes to request-pull,
making it slightly smarter:

 1) Minor cleanup of revision->base variable names, making it
    follow the head/headrev naming convention that is already
    in use.

 2) Compute the merge-base between the two revisions upfront
    and reuse that selected merge-base to create the diffstat.

 3) Refuse to generate a pull request for branches that have no
    existing relationship.  These aren't very common and would mess
    up our diffstat generation.

 4) Disable the PAGER when running shortlog and diff, as these
    would otherwise activate the pager for each command when
    git-request-pull is run on a tty.  Instead users can get the
    entire output paged (if desired) using `git -p request-pull`.

 5) Use shortlog rather than `git log | git shortlog` now that
    recent shortlog versions are able to run the revision listing
    internally.

 6) Attempt to resolve the input URL using the user's configured
    remotes.  This is useful if the URL you want the recipient to
    see is also the one you used to push your changes.  If not a
    config-file remote could easily be setup for the public URL
    and request-pull could be passed that name instead.

 7) Automatically guess and include the remote branch name in the
    body of the message.  We list the branch name immediately after
    the URL, making it easy for the recipient to copy and paste
    the entire line onto a `git pull` command line.  Rumor has it
    Linus likes this format, for exactly that reason.

    If multiple branches at the remote match $headrev we take the
    first one returned by peek-remote and assume it is suitable.

    If no branches are available we warn the user about the problem,
    but insert a static string that is not a valid branch name
    and would be obvious to anyone reading the message as being
    totally incorrect.  This allows users to still generate a
    template message without network access (for example) and
    hand-correct the bits that cannot be verified.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is attempt #2, after including your recent comments.  Thoughts?

 git-request-pull.sh |   41 ++++++++++++++++++++++++++++++++---------
 1 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 4eacc3a..ba577d4 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -9,25 +9,48 @@ LONG_USAGE='Summarizes the changes since <commit> to the standard output,
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
+baserev=`git-rev-parse --verify "$base"^0` &&
 headrev=`git-rev-parse --verify "$head"^0` || exit
 
+merge_base=`git merge-base $baserev $headrev` ||
+die "fatal: No commits in common between $base and $head"
+
+url="`get_remote_url "$url"`"
+branch=`git peek-remote "$url" \
+	| sed -n -e "/^$headrev	refs.heads./{
+		s/^.*	refs.heads.//
+		p
+		q
+	}"`
+if [ -z "$branch" ]; then
+	echo "warn: No branch of $url is at:" >&2
+	git log --max-count=1 --pretty='format:warn:   %h: %s' $headrev >&2
+	echo "warn: Are you sure you pushed $head there?" >&2
+	echo >&2
+	echo >&2
+	branch=..BRANCH.NOT.VERIFIED..
+	status=1
+fi
+
+PAGER=
+export PAGER
 echo "The following changes since commit $baserev:"
-git log --max-count=1 --pretty=short "$baserev" |
-git-shortlog | sed -e 's/^\(.\)/  \1/'
+git shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'
 
-echo "are found in the git repository at:" 
+echo "are available in the git repository at:"
 echo
-echo "  $url"
+echo "  $url $branch"
 echo
 
-git log  $baserev..$headrev | git-shortlog ;
-git diff -M --stat --summary $baserev..$headrev
+git shortlog ^$baserev $headrev
+git diff -M --stat --summary $merge_base $headrev
+exit $status
-- 
1.5.1.1.135.gf948
