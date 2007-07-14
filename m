From: Jeff King <peff@peff.net>
Subject: [PATCH] git-reset: allow --soft in a bare repo
Date: Sat, 14 Jul 2007 00:49:16 -0400
Message-ID: <20070714044916.GA24911@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 06:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9ZZU-0002Eb-LT
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 06:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbXGNEtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 00:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbXGNEtT
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 00:49:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2665 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbXGNEtS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 00:49:18 -0400
Received: (qmail 24945 invoked from network); 14 Jul 2007 04:49:43 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 Jul 2007 04:49:43 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jul 2007 00:49:16 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52438>

Previously, git-reset always required a work directory. For
--mixed and --hard resets, this makes sense, as the bare
repo doesn't have an index or a working tree. However, for
--soft, there's no reason to prohibit this behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
Somebody asked about this on irc ("how do I rewind history in a bare
repo"). The only other ways right now are to update the ref manually
(which involves plumbing), or to "git-push -f" from a non-bare
repository. I can't think of any good reason why a soft reset shouldn't
be allowed.

 git-reset.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index 1dc606f..5450289 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -6,7 +6,6 @@ USAGE='[--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 set_reflog_action "reset $*"
-require_work_tree
 
 update= reset_type=--mixed
 unset rev
@@ -32,6 +31,13 @@ do
 	shift
 done
 
+case "$reset_type" in
+	--soft)
+		;;
+	*)
+		require_work_tree
+esac
+
 : ${rev=HEAD}
 rev=$(git rev-parse --verify $rev^0) || exit
 
-- 
1.5.3.rc1.807.g51fb9-dirty
