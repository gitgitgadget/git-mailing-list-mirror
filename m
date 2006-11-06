X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Tue, 7 Nov 2006 00:26:16 +0100
Message-ID: <200611070026.16425.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 23:31:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31032>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhDvU-0003n1-IT for gcvg-git@gmane.org; Tue, 07 Nov
 2006 00:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753912AbWKFXap (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 18:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbWKFXap
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 18:30:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:17073 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1753912AbWKFXao (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 18:30:44 -0500
Received: (qmail invoked by alias); 06 Nov 2006 23:30:42 -0000
Received: from p5496B896.dip0.t-ipconnect.de (EHLO noname) [84.150.184.150]
 by mail.gmx.net (mp010) with SMTP; 07 Nov 2006 00:30:42 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

- When requested to checkout read-only remote branches,
  we try to create a new local development branch with same name.
- When we branch off a remote branch, set up default merge source.
---

This patch does the sensible thing when the user requests to
check-out a remote read-only branch (eg. origin/master).
It also automatically sets up the default merge source (with remote
entry) for a new branch.

Example to hack on git's next branch:

 git-clone --use-separate-remote http://www.kernel.org/pub/scm/git/git.git
 cd git
 git-checkout origin/next
 <hack on next>
 git pull (to merge patches from remote 'next')

The checkout creates local branch 'master' to checkout read-only remote branch
'remotes/origin/master'. Additionally, it sets up 'remotes/origin/master' from
remote repository 'origin' as default merge source for the new development branch.

Missing:
- "git branch -D <branch>" should remove remote branch attributes like
  "remote" and "merge"
- As "git-clone" already sets up a local development branch "master", it also
  should set up a default merge source for it

Josef

 git-checkout.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 119bca1..63b622e 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -12,6 +12,8 @@ force=
 branch=
 newbranch=
 newbranch_log=
+remote=
+remotebranch=
 merge=
 while [ "$#" != "0" ]; do
     arg="$1"
@@ -55,6 +57,11 @@ while [ "$#" != "0" ]; do
 			then
 				branch="$arg"
 			fi
+			if git-show-ref --verify --quiet -- "refs/remotes/$arg"
+			then
+				remote=$(echo $arg | sed -ne 's!/.*$!!p')
+				remotebranch=$(echo $arg | sed -e 's!^.*/!!')
+			fi
 		elif rev=$(git-rev-parse --verify "$arg^{tree}" 2>/dev/null)
 		then
 			# checking out selected paths from a tree-ish.
@@ -77,6 +84,20 @@ while [ "$#" != "0" ]; do
     esac
 done
 
+# Create a new local branch when checking out remote read-only branch
+if test -z "$newbranch" -a ! -z "$remotebranch"
+then
+	newbranch=$remotebranch
+	if git-show-ref --verify --quiet -- "refs/heads/$newbranch"
+	then
+		echo "Proposed new branch '$newbranch' to checkout read-only remote branch 'remotes/$remote/$remotebranch' exists!"
+		echo "To checkout, specify a new branch name with -b"
+		exit 1
+	fi
+	echo "Creating local branch '$newbranch' to checkout read-only remote branch 'remotes/$remote/$remotebranch'."
+fi
+
+
 # The behaviour of the command with and without explicit path
 # parameters is quite different.
 #
@@ -211,6 +232,14 @@ if [ "$?" -eq 0 ]; then
 			touch "$GIT_DIR/logs/refs/heads/$newbranch"
 		fi
 		git-update-ref -m "checkout: Created from $new_name" "refs/heads/$newbranch" $new || exit
+
+		if test '' != "$remote"
+		then
+			echo "Using 'remotes/$remote/$remotebranch' from remote repository '$remote' as default merge source."
+			git-repo-config branch."$newbranch".remote "$remote"
+			git-repo-config branch."$newbranch".merge "remotes/$remote/$remotebranch"
+		fi
+
 		branch="$newbranch"
 	fi
 	[ "$branch" ] &&
-- 
1.4.3.rc2.gf8ffb
