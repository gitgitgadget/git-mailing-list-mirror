From: Jeff King <peff@peff.net>
Subject: [PATCH] git-stash: don't complain when listing in a repo with no
	stash
Date: Mon, 2 Jul 2007 00:21:24 -0400
Message-ID: <20070702042124.GA29479@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@bluebottle.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 06:21:30 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5DPk-0007sJ-Uc
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 06:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbXGBEV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 00:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbXGBEV1
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 00:21:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3526 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbXGBEV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 00:21:26 -0400
Received: (qmail 10781 invoked from network); 2 Jul 2007 04:21:47 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 2 Jul 2007 04:21:47 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2007 00:21:24 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51342>

Previously, the git-log invocation would complain if a repo
had not had any stashes created in it yet:

$ git-init
$ git-stash
fatal: ambiguous argument 'refs/stash': unknown revision or
  path not in the working tree.
Use '--' to separate paths from revisions

Instead, we only call git-log if we actually have a
refs/stash. We could alternatively create the ref when any
stash command is called, but it's better for the 'list'
command to not require write access to the repo.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-stash.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7644bd5..18d3322 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -76,7 +76,12 @@ save_stash () {
 	printf >&2 'Saved WIP on %s\n' "$msg"
 }
 
+have_stash () {
+	git-rev-parse --verify $ref_stash >/dev/null 2>&1
+}
+
 list_stash () {
+	have_stash || return 0
 	git-log --pretty=oneline -g "$@" $ref_stash |
 	sed -n -e 's/^[.0-9a-f]* refs\///p'
 }
-- 
1.5.2.2.1452.g896f6
