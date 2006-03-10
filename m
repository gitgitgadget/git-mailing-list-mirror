From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] fetch,parse-remote,fmt-merge-msg: refs/remotes/* support
Date: Fri, 10 Mar 2006 04:19:07 -0800
Message-ID: <20060310121907.GA15746@localdomain>
References: <20060309115452.GA13369@localdomain> <7vzmjz5y6o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 13:19:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHgaP-0002eg-NY
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 13:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWCJMTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 07:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWCJMTK
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 07:19:10 -0500
Received: from hand.yhbt.net ([66.150.188.102]:2767 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750787AbWCJMTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 07:19:09 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 16B322DC01A;
	Fri, 10 Mar 2006 04:19:08 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 10 Mar 2006 04:19:07 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmjz5y6o.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17473>

Note: This replaces the previous patch to fetch and parse-remote.

We can now easily fetch and merge things from heads in the
refs/remotes/ hierarchy in remote repositories.

The refs/remotes/ hierarchy is likely to become the standard for
tracking foreign SCMs, as well as the location of Pull: targets
for non-master heads of newly cloned repositories.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-fetch.sh           |    8 +++++++-
 git-fmt-merge-msg.perl |    8 ++++++++
 git-parse-remote.sh    |    8 ++++----
 3 files changed, 19 insertions(+), 5 deletions(-)

6697c83da96b26739c3fe33c8526da6124cea909
diff --git a/git-fetch.sh b/git-fetch.sh
index 0346d4a..11e9a9d 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -94,6 +94,9 @@ append_fetch_head () {
     # remote-nick is the URL given on the command line (or a shorthand)
     # remote-name is the $GIT_DIR relative refs/ path we computed
     # for this refspec.
+
+    # the $note_ variable will be fed to git-fmt-merge-msg for further
+    # processing.
     case "$remote_name_" in
     HEAD)
 	note_= ;;
@@ -103,6 +106,9 @@ append_fetch_head () {
     refs/tags/*)
 	note_="$(expr "$remote_name_" : 'refs/tags/\(.*\)')"
 	note_="tag '$note_' of " ;;
+    refs/remotes/*)
+	note_="$(expr "$remote_name_" : 'refs/\(remotes/.*\)')"
+	note_="remote branch '$note_' of " ;;
     *)
 	note_="$remote_name of " ;;
     esac
@@ -150,7 +156,7 @@ fast_forward_local () {
 	git-update-ref "$1" "$2" 
 	;;
 
-    refs/heads/*)
+    refs/heads/* | refs/remotes/*)
 	# $1 is the ref being updated.
 	# $2 is the new value for the ref.
 	local=$(git-rev-parse --verify "$1^0" 2>/dev/null)
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index afe80e6..5986e54 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -75,6 +75,7 @@ while (<>) {
 		$src{$src} = {
 			BRANCH => [],
 			TAG => [],
+			R_BRANCH => [],
 			GENERIC => [],
 			# &1 == has HEAD.
 			# &2 == has others.
@@ -91,6 +92,11 @@ while (<>) {
 		push @{$src{$src}{TAG}}, $1;
 		$src{$src}{HEAD_STATUS} |= 2;
 	}
+	elsif (/^remote branch (.*)$/) {
+		$origin = $1;
+		push @{$src{$src}{R_BRANCH}}, $1;
+		$src{$src}{HEAD_STATUS} |= 2;
+	}
 	elsif (/^HEAD$/) {
 		$origin = $src;
 		$src{$src}{HEAD_STATUS} |= 1;
@@ -123,6 +129,8 @@ for my $src (@src) {
 	}
 	push @this, andjoin("branch ", "branches ",
 			   $src{$src}{BRANCH});
+	push @this, andjoin("remote branch ", "remote branches ",
+			   $src{$src}{R_BRANCH});
 	push @this, andjoin("tag ", "tags ",
 			   $src{$src}{TAG});
 	push @this, andjoin("commit ", "commits ",
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5f158c6..63f2281 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -86,14 +86,14 @@ canon_refs_list_for_fetch () {
 		local=$(expr "$ref" : '[^:]*:\(.*\)')
 		case "$remote" in
 		'') remote=HEAD ;;
-		refs/heads/* | refs/tags/*) ;;
-		heads/* | tags/* ) remote="refs/$remote" ;;
+		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
+		heads/* | tags/* | remotes/* ) remote="refs/$remote" ;;
 		*) remote="refs/heads/$remote" ;;
 		esac
 		case "$local" in
 		'') local= ;;
-		refs/heads/* | refs/tags/*) ;;
-		heads/* | tags/* ) local="refs/$local" ;;
+		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
+		heads/* | tags/* | remotes/* ) local="refs/$local" ;;
 		*) local="refs/heads/$local" ;;
 		esac
 
-- 
1.2.4.gbe2d
