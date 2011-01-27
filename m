From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] rebase: use explicit "--" with checkout
Date: Wed, 26 Jan 2011 19:26:59 -0500
Message-ID: <20110127002658.GA32711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 01:27:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiFhe-0008Rf-PP
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 01:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412Ab1A0A1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 19:27:00 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33080 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504Ab1A0A07 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 19:26:59 -0500
Received: (qmail 10921 invoked by uid 111); 27 Jan 2011 00:26:57 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 27 Jan 2011 00:26:57 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jan 2011 19:26:59 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165564>

In the case of a ref/pathname conflict, checkout will
already do the right thing and checkout the ref. However,
for a non-existant ref, this has two advantages:

  1. If a file with that pathname exists, rebase will
     refresh the file from the index and then rebase the
     current branch instead of producing an error.

  2. If no such file exists, the error message using an
     explicit "--" is better:

       # before
       $ git rebase -i origin bogus
       error: pathspec 'bogus' did not match any file(s) known to git.
       Could not checkout bogus

       # after
       $ git rebase -i origin bogus
       fatal: invalid reference: bogus
       Could not checkout bogus

The problems seem to be trigger-able only through "git
rebase -i", as regular git-rebase checks the validity of the
branch parameter as a ref very early on. However, it doesn't
hurt to be defensive.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-rebase--interactive.sh |    2 +-
 git-rebase.sh              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a5ffd9a..7bd5602 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -894,7 +894,7 @@ first and then run 'git rebase --continue' again."
 
 		if test ! -z "$1"
 		then
-			output git checkout "$1" ||
+			output git checkout "$1" -- ||
 				die "Could not checkout $1"
 		fi
 
diff --git a/git-rebase.sh b/git-rebase.sh
index d8e1903..345b18c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -513,7 +513,7 @@ then
 	if test -z "$force_rebase"
 	then
 		# Lazily switch to the target branch if needed...
-		test -z "$switch_to" || git checkout "$switch_to"
+		test -z "$switch_to" || git checkout "$switch_to" --
 		say "Current branch $branch_name is up to date."
 		exit 0
 	else
-- 
1.7.4.rc3.5.g8354b
