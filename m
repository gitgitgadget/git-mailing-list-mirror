From: Jeff King <peff@peff.net>
Subject: [PATCH] diff: try lazy read of config only once
Date: Fri, 4 Jan 2008 03:31:16 -0500
Message-ID: <20080104083116.GA3354@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAhxx-0007MW-Se
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbYADIbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbYADIbT
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:31:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1902 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650AbYADIbT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:31:19 -0500
Received: (qmail 15851 invoked by uid 111); 4 Jan 2008 08:31:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 03:31:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 03:31:16 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69559>

The function read_config_if_needed used a list pointer to
determined whether it had already been called. However, if
the user had no diff drivers, the function would repeatedly
read the config (typically once per diffed file).

Instead, let's use a signal variable so that we read it only
once (note that we may actually still read it an extra time,
since the config may already have been read outside of this
function). This reduces the cost of

  git-whatchanged -p >/dev/null

from 34 seconds to 33 seconds.

Signed-off-by: Jeff King <peff@peff.net>
---
This are might be changed from the fallout of the other mail I just
sent, but I wanted to at least mention it. The speedup is not terribly
significant, but it just seems stupid to parse the config file thousands
of times. And I suspect on slow-I/O systems (like Cygwin) that it might
make more of a difference.

 diff.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 5bdc111..f6a8515 100644
--- a/diff.c
+++ b/diff.c
@@ -61,10 +61,15 @@ static struct ll_diff_driver {
 
 static void read_config_if_needed(void)
 {
+	static int done = 0;
+	if (done)
+		return;
+
 	if (!user_diff_tail) {
 		user_diff_tail = &user_diff;
 		git_config(git_diff_ui_config);
 	}
+	done = 1;
 }
 
 /*
-- 
1.5.4.rc2.1122.g6954-dirty
