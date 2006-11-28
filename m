X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Fix broken bash completion of local refs.
Date: Tue, 28 Nov 2006 12:12:26 -0500
Message-ID: <20061128171226.GB28830@spearce.org>
References: <a7f722557e34d86c38da7163392e3be8021692e2.1164733875.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 17:13:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <a7f722557e34d86c38da7163392e3be8021692e2.1164733875.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32551>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp6VV-0002pE-NF for gcvg-git@gmane.org; Tue, 28 Nov
 2006 18:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758706AbWK1RMa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 12:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758708AbWK1RMa
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 12:12:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:30613 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758706AbWK1RMa
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 12:12:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gp6VJ-0003hv-TT; Tue, 28 Nov 2006 12:12:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0B1E420FB7F; Tue, 28 Nov 2006 12:12:27 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Commit 35e65ecc broke completion of local refs, e.g. "git pull . fo<tab>"
no longer would complete to "foo".  Instead it printed out an internal
git error ("fatal: Not a git repository: '.'").

The break occurred when I tried to improve performance by switching from
git-peek-remote to git-for-each-ref.  Apparently git-peek-remote will
drop into directory "$1/.git" (where $1 is its first parameter) if it
is given a repository with a working directory.  This allowed the bash
completion code to work properly even though it was not handing over
the true repository directory.

So now we do a stat in bash to see if we need to add "/.git" to the
path string before running any command with --git-dir.

I also tried to optimize away two "git rev-parse --git-dir" invocations
in common cases like "git log fo<tab>" as typically the user is in the
top level directory of their project and therefore the .git subdirectory
is in the current working directory.  This should make a difference on
systems where fork+exec might take a little while.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 This fixes the breakage noticed by Junio.

 contrib/completion/git-completion.bash |   37 ++++++++++++++++---------------
 1 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be978cf..447ec20 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -34,7 +34,19 @@
 
 __gitdir ()
 {
-	echo "${__git_dir:-$(git rev-parse --git-dir 2>/dev/null)}"
+	if [ -z "$1" ]; then
+		if [ -n "$__git_dir" ]; then
+			echo "$__git_dir"
+		elif [ -d .git ]; then
+			echo .git
+		else
+			git rev-parse --git-dir 2>/dev/null
+		fi
+	elif [ -d "$1/.git" ]; then
+		echo "$1/.git"
+	else
+		echo "$1"
+	fi
 }
 
 __git_ps1 ()
@@ -51,7 +63,7 @@ __git_ps1 ()
 
 __git_heads ()
 {
-	local cmd i is_hash=y dir="${1:-$(__gitdir)}"
+	local cmd i is_hash=y dir="$(__gitdir "$1")"
 	if [ -d "$dir" ]; then
 		for i in $(git --git-dir="$dir" \
 			for-each-ref --format='%(refname)' \
@@ -60,7 +72,7 @@ __git_heads ()
 		done
 		return
 	fi
-	for i in $(git-ls-remote "$dir" 2>/dev/null); do
+	for i in $(git-ls-remote "$1" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
@@ -72,7 +84,7 @@ __git_heads ()
 
 __git_refs ()
 {
-	local cmd i is_hash=y dir="${1:-$(__gitdir)}"
+	local cmd i is_hash=y dir="$(__gitdir "$1")"
 	if [ -d "$dir" ]; then
 		if [ -e "$dir/HEAD" ]; then echo HEAD; fi
 		for i in $(git --git-dir="$dir" \
@@ -101,20 +113,9 @@ __git_refs ()
 
 __git_refs2 ()
 {
-	local cmd i is_hash=y dir="${1:-$(__gitdir)}"
-	if [ -d "$dir" ]; then
-		cmd=git-peek-remote
-	else
-		cmd=git-ls-remote
-	fi
-	for i in $($cmd "$dir" 2>/dev/null); do
-		case "$is_hash,$i" in
-		y,*) is_hash=n ;;
-		n,*^{}) is_hash=y ;;
-		n,refs/tags/*) is_hash=y; echo "${i#refs/tags/}:${i#refs/tags/}" ;;
-		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}:${i#refs/heads/}" ;;
-		n,*) is_hash=y; echo "$i:$i" ;;
-		esac
+	local i
+	for i in $(__git_refs "$1"); do
+		echo "$i:$i"
 	done
 }
 
-- 
