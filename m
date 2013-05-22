From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH -v2] guilt: force the use of bare branches
Date: Wed, 22 May 2013 08:11:17 -0400
Message-ID: <1369224677-16404-1-git-send-email-tytso@mit.edu>
References: <20130522032946.GA101217@meili.valhalla.31bits.net>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Per Cederqvist <cederp@opera.com>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Wed May 22 14:11:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf7t6-0006y7-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 14:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab3EVMLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 08:11:20 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:50700 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755751Ab3EVMLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 08:11:19 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1Uf7ve-0004xz-1R; Wed, 22 May 2013 12:14:02 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 90E375814B7; Wed, 22 May 2013 08:11:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc0.22.gcdd159b
In-Reply-To: <20130522032946.GA101217@meili.valhalla.31bits.net>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225148>

To make it harder to accidentally do "git push" with a guilt patch
applied, "guilt push" changes branch from e.g. "master" to
"guilt/master" starting with commit 67d3af63f422.  This is a feature
which I use for ext4 development; I actually *do* want to be able to
push patches to the dev branch, which is a rewindable branch much like
git's "pu" branch.

Allow the use of the environment variable GUILT_FORCE_BARE_BRANCH
which disables the new behavior introduced by commit 67d3af63f422.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Cc: Per Cederqvist <cederp@opera.com>
---
 guilt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/guilt b/guilt
index e9b2aab..35a84dc 100755
--- a/guilt
+++ b/guilt
@@ -914,13 +914,22 @@ else
 	die "Unsupported operating system: $UNAME_S"
 fi
 
-if [ "$branch" = "$raw_git_branch" ] && [ -n "`get_top 2>/dev/null`" ]
-then
-    # This is for compat with old repositories that still have a
-    # pushed patch without the new-style branch prefix.
+if [ -n "`get_top 2>/dev/null`" ]; then
+  #
+  # If we have repositories patches pushed, then use whatever scheme
+  # is currently in use
+  #
+  if [ "$branch" = "$raw_git_branch" ]; then
     old_style_prefix=true
+  else
+    old_style_prefix=false
+  fi
 else
+  if [ "$(git config --bool --get guilt.bareBranch)" = "true" ]; then
+    old_style_prefix=true
+  else
     old_style_prefix=false
+  fi
 fi
 
 _main "$@"
-- 
1.7.12.rc0.22.gcdd159b
