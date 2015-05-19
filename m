From: Jeff King <peff@peff.net>
Subject: [PATCH] progress: treat "no terminal" as being in the foreground
Date: Tue, 19 May 2015 01:24:57 -0400
Message-ID: <20150519052457.GA18772@peff.net>
References: <20150415093418.GH23475@mewburn.net>
 <20150519051752.GA16173@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Luke Mewburn <luke@mewburn.net>
X-From: git-owner@vger.kernel.org Tue May 19 07:25:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yua1a-0006vM-1J
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 07:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbbESFZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 01:25:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:60599 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753172AbbESFZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 01:25:00 -0400
Received: (qmail 10074 invoked by uid 102); 19 May 2015 05:25:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 00:25:00 -0500
Received: (qmail 9960 invoked by uid 107); 19 May 2015 05:25:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 01:25:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 01:24:57 -0400
Content-Disposition: inline
In-Reply-To: <20150519051752.GA16173@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269341>

On Tue, May 19, 2015 at 01:17:52AM -0400, Jeff King wrote:

> One reasonable fix (I think) would be to treat an error return from
> tcgetpgrp() as "yes, we are the foreground", like:

I think I convinced myself this is the right fix. So here it is, all
wrapped up with a commit message. I'd love to hear confirmation, though.
:)

-- >8 --
progress: treat "no terminal" as being in the foreground

Commit 85cb890 (progress: no progress in background,
2015-04-13) avoids sending progress from background
processes by checking that the process group id of the
current process is the same as that of the controlling
terminal.

If we don't have a terminal, however, this check never
succeeds, and we print no progress at all (until the final
"done" message). This can be seen when cloning a large
repository; instead of getting progress updates for
"counting objects", it will appear to hang then print the
final count.

We can fix this by treating an error return from tcgetpgrp()
as a signal to show the progress.

Signed-off-by: Jeff King <peff@peff.net>
---
 progress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/progress.c b/progress.c
index 43d9228..2e31bec 100644
--- a/progress.c
+++ b/progress.c
@@ -74,7 +74,8 @@ static void clear_progress_signal(void)
 
 static int is_foreground_fd(int fd)
 {
-	return getpgid(0) == tcgetpgrp(fd);
+	int tpgrp = tcgetpgrp(fd);
+	return tpgrp < 0 || tpgrp == getpgid(0);
 }
 
 static int display(struct progress *progress, unsigned n, const char *done)
-- 
2.4.1.396.g7ba6d7b
