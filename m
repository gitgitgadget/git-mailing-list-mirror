From: Jeff King <peff@peff.net>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 04:08:26 -0400
Message-ID: <20080423080826.GA11935@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com> <20080422023918.GA5402@sigill.intra.peff.net> <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 10:09:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joa2t-0002cp-K3
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 10:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbYDWIIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 04:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbYDWIIc
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 04:08:32 -0400
Received: from peff.net ([208.65.91.99]:2033 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbYDWII2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 04:08:28 -0400
Received: (qmail 32718 invoked by uid 111); 23 Apr 2008 08:08:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 04:08:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 04:08:26 -0400
Content-Disposition: inline
In-Reply-To: <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80196>

On Tue, Apr 22, 2008 at 12:51:14PM -0400, Avery Pennarun wrote:

> Do you think git would benefit from having a generalized version of
> this script?  Basically, the user provides a "munge" script on the
> command line, and there's a git-filter-branch mode for auto-munging
> (with a cache) every file in every checkin.  Even if it's *only* ever
> used for CRLF, I can imagine this being useful to a lot of people.

It was easy enough to work up the patch below, which allows

  git filter-branch --blob-filter 'tr a-z A-Z'

However, it's _still_ horribly slow. Shell script is nice and flexible,
but running a tight loop like this is just painful. I suspect
filter-branch in something like perl would be a lot faster and just as
flexible (you could even do it in C, but you'd probably have to invent a
little domain-specific scripting language).

It is still much better performance than a tree filter, though:

  $ cd git && time git filter-branch --tree-filter '
      find . -type f | while read f; do
        tr a-z A-Z <"$f" >tmp
        mv tmp "$f"
      done
    ' HEAD~10..HEAD

  real    4m38.626s
  user    1m32.726s
  sys     2m51.163s

  $ cd git && git filter-branch --blob-filter 'tr a-z A-Z' HEAD~10..HEAD
  real    1m40.809s
  user    0m36.822s
  sys     1m14.273s

Lots of system time in both. I'm sure we spend a fair bit of time
hitting our very large map and blob-cache directories, which would be
much more nicely implemented as associative arrays in memory (if we were
using a more featureful language).

Anyway, here is the patch. I don't know if it is even worth applying,
since it is still painfully slow.

---
 git-filter-branch.sh |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 333f6a8..0602b25 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -54,6 +54,23 @@ EOF
 
 eval "$functions"
 
+munge_blobs() {
+	while read mode sha1 stage path
+	do
+		if ! test -r "$workdir/../blob-cache/$sha1"
+		then
+			new=`git cat-file blob $sha1 |
+			     eval "$filter_blob" |
+			     git hash-object -w --stdin`
+			printf $new >$workdir/../blob-cache/$sha1
+		fi
+		printf "%s %s\t%s\n" \
+			"$mode" \
+			$(cat "$workdir/../blob-cache/$sha1") \
+			"$path"
+	done
+}
+
 # When piped a commit, output a script to set the ident of either
 # "author" or "committer
 
@@ -105,6 +122,7 @@ tempdir=.git-rewrite
 filter_env=
 filter_tree=
 filter_index=
+filter_blob=
 filter_parent=
 filter_msg=cat
 filter_commit='git commit-tree "$@"'
@@ -150,6 +168,9 @@ do
 	--index-filter)
 		filter_index="$OPTARG"
 		;;
+	--blob-filter)
+		filter_blob="$OPTARG"
+		;;
 	--parent-filter)
 		filter_parent="$OPTARG"
 		;;
@@ -227,6 +248,9 @@ ret=0
 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"
 
+# cache rewritten blobs for blob filter
+mkdir ../blob-cache || die "Could not create blob-cache/ directory"
+
 case "$filter_subdir" in
 "")
 	git rev-list --reverse --topo-order --default HEAD \
@@ -295,6 +319,12 @@ while read commit parents; do
 	eval "$filter_index" < /dev/null ||
 		die "index filter failed: $filter_index"
 
+	if test -n "$filter_blob"; then
+		git ls-files --stage |
+		munge_blobs |
+		git update-index --index-info
+	fi
+
 	parentstr=
 	for parent in $parents; do
 		for reparent in $(map "$parent"); do
-- 
1.5.5.1.144.g4c416.dirty
