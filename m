From: Thomas Rast <tr@thomasrast.ch>
Subject: [RFC PATCH] Revamp git-cherry(1)
Date: Thu, 21 Nov 2013 12:30:56 +0100
Message-ID: <3af3069696e3a59d513f1fef0ca797d103f6d882.1385033403.git.tr@thomasrast.ch>
Cc: a.huemer@commend.com, "Michael S. Tsirkin" <mst@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 12:31:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjSTj-00065w-9F
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 12:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab3KULbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 06:31:17 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:47152 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461Ab3KULbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 06:31:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 1FA284D656F;
	Thu, 21 Nov 2013 12:31:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0RMEopTjj0L7; Thu, 21 Nov 2013 12:31:00 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 4A9FF4D6414;
	Thu, 21 Nov 2013 12:30:59 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.355.g6969a19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238117>

git-cherry(1)'s "description" section has never really managed to
explain to me what the command does.  It contains too much explanation
of the algorithm instead of simply saying what goals it achieves, and
too much terminology that we otherwise do not use (fork-point instead
of merge-base).

Try a much more concise approach: state what it finds out, why this is
neat, and how the output is formatted, in a few short paragraphs.  In
return, provide a longer example of how it fits into a format-patch/am
based workflow.

Also carefully avoid using "merge" in a context where it does not mean
something that comes from git-merge(1).  Instead, say "apply" in an
attempt to further link to patch workflow concepts.

While there, also omit the language about _which_ upstream branch we
treat as the default.  I literally just learned that we support having
several, so let's not confuse new users here, especially considering
that git-config(1) does _not_ document this.

Prompted-by: a.huemer@commend.com on #git
Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 Documentation/git-cherry.txt | 73 +++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 2d0daae..78ffddf 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -3,7 +3,7 @@ git-cherry(1)
 
 NAME
 ----
-git-cherry - Find commits not merged upstream
+git-cherry - Find commits not applied in upstream
 
 SYNOPSIS
 --------
@@ -12,46 +12,27 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-The changeset (or "diff") of each commit between the fork-point and <head>
-is compared against each commit between the fork-point and <upstream>.
-The diffs are compared after removing any whitespace and line numbers.
+Determine whether there are commits in `<head>..<upstream>` that are
+equivalent to those in the range `<limit>..<head>`.
 
-Every commit that doesn't exist in the <upstream> branch
-has its id (sha1) reported, prefixed by a symbol.  The ones that have
-equivalent change already
-in the <upstream> branch are prefixed with a minus (-) sign, and those
-that only exist in the <head> branch are prefixed with a plus (+) symbol:
-
-               __*__*__*__*__> <upstream>
-              /
-    fork-point
-              \__+__+__-__+__+__-__+__> <head>
-
-
-If a <limit> has been given then the commits along the <head> branch up
-to and including <limit> are not reported:
-
-               __*__*__*__*__> <upstream>
-              /
-    fork-point
-              \__*__*__<limit>__-__+__> <head>
-
-
-Because 'git cherry' compares the changeset rather than the commit id
-(sha1), you can use 'git cherry' to find out if a commit you made locally
-has been applied <upstream> under a different commit id.  For example,
-this will happen if you're feeding patches <upstream> via email rather
-than pushing or pulling commits directly.
+The equivalence test is based on the diff, after removing whitespace
+and line numbers.  git-cherry therefore detects when commits have been
+"copied" by means of linkgit:git-cherry-pick[1], linkgit:git-am[1] or
+linkgit:git-rebase[1].
 
+Outputs the SHA1 of every commit in `<limit>..<head>`, prefixed with
+`-` for commits that have an equivalent in <upstream>, and `+` for
+commits that do not.
 
 OPTIONS
 -------
 -v::
-	Verbose.
+	Verbose.  Currently shows the commit subjects next to their
+	SHA1.
 
 <upstream>::
 	Upstream branch to compare against.
-	Defaults to the first tracked remote branch, if available.
+	Defaults to the upstream branch of HEAD.
 
 <head>::
 	Working branch; defaults to HEAD.
@@ -59,6 +40,34 @@ OPTIONS
 <limit>::
 	Do not report commits up to (and including) limit.
 
+EXAMPLES
+--------
+
+git-cherry is frequently used in patch-based workflows (see
+linkgit:gitworkflows[7]) to determine if a series of patches has been
+applied by the upstream maintainer.  In such a workflow you might
+create and send a topic branch like this (fill in appropriate
+arguments for `...`):
++
+------------
+git checkout -b topic origin/master
+# work and create some commits
+git format-patch origin/master
+git send-email ... 00*
+------------
++
+Later, you can whether your changes have been applied by saying (still
+on `topic`):
++
+------------
+git fetch  # update your notion of origin/master
+git cherry -v
+------------
++
+Note that this uses , and assumes that
+`core.autosetupmerge` is enabled (the default).
+
+
 SEE ALSO
 --------
 linkgit:git-patch-id[1]
-- 
1.8.5.rc2.355.g6969a19
