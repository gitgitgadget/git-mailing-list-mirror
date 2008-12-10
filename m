From: Jeff King <peff@peff.net>
Subject: [PATCH] rebase: improve error messages about dirty state
Date: Wed, 10 Dec 2008 04:25:19 -0500
Message-ID: <20081210092518.GA14424@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:26:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LALL6-00018u-PQ
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 10:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbYLJJZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 04:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYLJJZX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 04:25:23 -0500
Received: from peff.net ([208.65.91.99]:2323 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbYLJJZW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 04:25:22 -0500
Received: (qmail 7707 invoked by uid 111); 10 Dec 2008 09:25:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 10 Dec 2008 04:25:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2008 04:25:19 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102678>

If you have unstaged changes in your working tree and try to
rebase, you will get the cryptic "foo: needs update"
message, but nothing else.  If you have staged changes, you
get "your index is not up-to-date".

Let's improve this situation in two ways:

 - for unstaged changes, let's also tell them we are
   canceling the rebase, and why (in addition to the "needs
   update" lines)

 - for the staged changes case, let's use language that is a
   little more clear to the user: their index contains
   uncommitted changes

Signed-off-by: Jeff King <peff@peff.net>
---
I am cleaning up some old branches, and I think this is worth applying.
It came out of a "rebase's error message is confusing" thread back in
April:

  http://thread.gmane.org/gmane.comp.version-control.git/78698

It would be nice also to say "foo: locally modified" instead of "foo:
needs update" but the REFRESH_SAY_CHANGED functionality isn't exposed
via the command line.

 git-rebase.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index ea7720d..ebd4df3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -332,11 +332,14 @@ else
 fi
 
 # The tree must be really really clean.
-git update-index --ignore-submodules --refresh || exit
+if ! git update-index --ignore-submodules --refresh; then
+	echo >&2 "cannot rebase: you have unstaged changes"
+	exit 1
+fi
 diff=$(git diff-index --cached --name-status -r --ignore-submodules HEAD --)
 case "$diff" in
-?*)	echo "cannot rebase: your index is not up-to-date"
-	echo "$diff"
+?*)	echo >&2 "cannot rebase: your index contains uncommitted changes"
+	echo >&2 "$diff"
 	exit 1
 	;;
 esac
-- 
1.6.1.rc2.15.g7752a
