From: Jeff King <peff@peff.net>
Subject: [PATCH v2 4/7] wt-status: use capture_command
Date: Sun, 22 Mar 2015 23:53:52 -0400
Message-ID: <20150323035352.GD30337@peff.net>
References: <20150323035302.GA30279@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 04:54:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZtR9-00051R-4M
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 04:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbCWDxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 23:53:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:37021 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752108AbbCWDxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 23:53:54 -0400
Received: (qmail 14598 invoked by uid 102); 23 Mar 2015 03:53:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 22:53:54 -0500
Received: (qmail 12227 invoked by uid 107); 23 Mar 2015 03:54:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 23:54:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 23:53:52 -0400
Content-Disposition: inline
In-Reply-To: <20150323035302.GA30279@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266119>

When we spawn "git submodule status" to read its output, we
use run_command() followed by strbuf_read() read from the
pipe. This can deadlock if the subprocess output is larger
than the system pipe buffer.

Furthermore, if start_command() fails, we'll try to read
from a bogus descriptor (probably "-1" or a descriptor we
just closed, but it is a bad idea for us to make assumptions
about how start_command implements its error handling). And
if start_command succeeds, we leak the file descriptor for
the pipe to the child.

All of these can be solved by using the capture_command
helper.

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index b47f6d9..853419f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -744,11 +744,8 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 
 	sm_summary.git_cmd = 1;
 	sm_summary.no_stdin = 1;
-	sm_summary.out = -1;
 
-	run_command(&sm_summary);
-
-	strbuf_read(&cmd_stdout, sm_summary.out, 1024);
+	capture_command(&sm_summary, &cmd_stdout, 1024);
 
 	/* prepend header, only if there's an actual output */
 	if (cmd_stdout.len) {
-- 
2.3.3.618.ga041503
