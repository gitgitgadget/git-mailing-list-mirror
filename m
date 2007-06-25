From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Mon, 25 Jun 2007 22:32:01 +0200
Message-ID: <87r6nzu666.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 22:32:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2vEG-0001Lc-T5
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 22:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbXFYUcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 16:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbXFYUcE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 16:32:04 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55582 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbXFYUcD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 16:32:03 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id ABEDE5A3CF
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 22:32:01 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 939AC9055; Mon, 25 Jun 2007 22:32:01 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50918>

[this patch depends on the one I posted here:
 http://marc.info/?l=git&m=118280134031923&w=2 ]

Without this patch, git-rev-list unnecessarily omits strerror(errno)
from its diagnostic, upon write failure:

    $ ./git-rev-list --max-count=1 HEAD > /dev/full
    fatal: write failure on standard output

With the patch, git reports the desired ENOSPC diagnostic:

    fatal: write failure on standard output: No space left on device

* builtin-rev-list (show_commit): Don't fflush stdout here.
Instead, let the fclose in main do it, so there's a better
chance the underlying cause (errno) will be reported.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 builtin-rev-list.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 813aadf..62f0ba9 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -100,7 +100,6 @@ static void show_commit(struct commit *commit)
 		printf("%s%c", buf, hdr_termination);
 		free(buf);
 	}
-	fflush(stdout);
 	if (commit->parents) {
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
