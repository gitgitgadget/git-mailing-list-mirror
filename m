From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Tue, 26 Jun 2007 00:08:01 +0200
Message-ID: <87odj3sn5q.fsf@rho.meyering.net>
References: <87r6nzu666.fsf@rho.meyering.net>
	<87bqf3u324.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0706251450240.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 26 00:08:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2wjA-000552-NS
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 00:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbXFYWIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 18:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbXFYWIE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 18:08:04 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:41290 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbXFYWID (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 18:08:03 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A521C5A317
	for <git@vger.kernel.org>; Tue, 26 Jun 2007 00:08:01 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 70AAC3495B; Tue, 26 Jun 2007 00:08:01 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0706251450240.8675@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 25 Jun 2007 14\:53\:11 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50931>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 25 Jun 2007, Jim Meyering wrote:
>>
>> Here's a version of that patch that retains the fflush call
>> and adds a comment explaining why it's needed.
>
> Ok. I will hereby just suggest to Junio that he just not take patches from
> you.
>
> You seem to be totally unable to ever really think or worry about your own
> little uninteresting test-case, and have shown yourself totally
> uninterested in anything anybody ever tells you.
>
> In other words, you now screwed up EPIPE.
>
> AGAIN.
>
> And why? All apparently because you want "disk full" rather than just
> "write error".
>
> Jim, you really need to see past your small test, and think about the
> bigger picture.

No.  I don't keep the "small", git-specific, picture in mind
all the time.  Git is the only project I contribute to with
this no-EPIPE restriction, and it doesn't come naturally yet.

Here's the patch you seem to want.

---------------------------------------------------------
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
index 813aadf..94f8fca 100644
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
+	if (fflush(stdout) && errno != EPIPE)
+		die("write failure on standard output: %s", strerror(errno));
+
 	if (commit->parents) {
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
