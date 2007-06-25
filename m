From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Mon, 25 Jun 2007 23:39:15 +0200
Message-ID: <87bqf3u324.fsf@rho.meyering.net>
References: <87r6nzu666.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 23:39:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2wHH-0007Vq-1Q
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 23:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbXFYVjR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 17:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbXFYVjR
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 17:39:17 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:41605 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbXFYVjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 17:39:17 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BFD145A2C3
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 23:39:15 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A9F022BBF7; Mon, 25 Jun 2007 23:39:15 +0200 (CEST)
In-Reply-To: <87r6nzu666.fsf@rho.meyering.net> (Jim Meyering's message of "Mon\, 25 Jun 2007 22\:32\:01 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50928>

Jim Meyering <jim@meyering.net> wrote:
> [this patch depends on the one I posted here:
>  http://marc.info/?l=git&m=118280134031923&w=2 ]

Here's a version of that patch that retains the fflush call
and adds a comment explaining why it's needed.

Without this patch, git-rev-list unnecessarily omits strerror(errno)
from its diagnostic, upon write failure:

    $ ./git-rev-list --max-count=1 HEAD > /dev/full
    fatal: write failure on standard output

With the patch, git reports the desired ENOSPC diagnostic:

    fatal: write failure on standard output: No space left on device

* builtin-rev-list (show_commit): Diagnose a failed fflush call.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 builtin-rev-list.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 813aadf..f13a594 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -100,7 +100,12 @@ static void show_commit(struct commit *commit)
 		printf("%s%c", buf, hdr_termination);
 		free(buf);
 	}
-	fflush(stdout);
+
+	/* Flush regularly.
+	   This is especially important for an asynchronous consumer.  */
+	if (fflush(stdout))
+		die("write failure on standard output: %s", strerror(errno));
+
 	if (commit->parents) {
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
