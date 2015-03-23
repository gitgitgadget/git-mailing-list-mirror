From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/7] wt-status: don't flush before running "submodule
 status"
Date: Sun, 22 Mar 2015 23:53:24 -0400
Message-ID: <20150323035324.GA30337@peff.net>
References: <20150323035302.GA30279@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 04:53:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZtQh-0004fD-Ic
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 04:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbbCWDx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 23:53:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:37003 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751985AbbCWDx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 23:53:27 -0400
Received: (qmail 14554 invoked by uid 102); 23 Mar 2015 03:53:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 22:53:27 -0500
Received: (qmail 12183 invoked by uid 107); 23 Mar 2015 03:53:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 23:53:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 23:53:24 -0400
Content-Disposition: inline
In-Reply-To: <20150323035302.GA30279@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266116>

This is a holdover from the original implementation in
ac8d5af (builtin-status: submodule summary support,
2008-04-12), which just had the sub-process output to our
descriptor; we had to make sure we had flushed any data that
we produced before it started writing.

Since 3ba7407 (submodule summary: ignore --for-status
option, 2013-09-06), however, we pipe the sub-process output
back to ourselves. So there's no longer any need to flush
(it does not hurt, but it may leave readers wondering why we
do it).

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 7036fa2..1712762 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -745,7 +745,6 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 
 	sm_summary.git_cmd = 1;
 	sm_summary.no_stdin = 1;
-	fflush(s->fp);
 	sm_summary.out = -1;
 
 	run_command(&sm_summary);
-- 
2.3.3.618.ga041503
