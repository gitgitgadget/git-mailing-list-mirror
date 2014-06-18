From: Jeff King <peff@peff.net>
Subject: [PATCH 12/16] stat_opt: check extra strlen call
Date: Wed, 18 Jun 2014 15:51:17 -0400
Message-ID: <20140618195117.GL22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:51:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLtD-0006wm-8g
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbaFRTvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:51:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:46961 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754874AbaFRTvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:51:19 -0400
Received: (qmail 30483 invoked by uid 102); 18 Jun 2014 19:51:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:51:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:51:17 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252044>

As in earlier commits, the diff option parser uses
starts_with to find that an argument starts with "--stat-",
and then adds strlen("stat-") to find the rest of the
option.

However, in this case the starts_with and the strlen are
separated across functions, making it easy to call the
latter without the former. Let's use skip_prefix instead of
raw pointer arithmetic to catch such a case.

Signed-off-by: Jeff King <peff@peff.net>
---
Another possibility would be for stat_opt to take only the
prefix-skipped part of the string. But that would involve refactoring
its use of "av" (it needs the whole array because it may need to grab a
follow-on argument).

 diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 2378ae4..06bdfb8 100644
--- a/diff.c
+++ b/diff.c
@@ -3422,7 +3422,8 @@ static int stat_opt(struct diff_options *options, const char **av)
 	int count = options->stat_count;
 	int argcount = 1;
 
-	arg += strlen("--stat");
+	if (!skip_prefix(arg, "--stat", &arg))
+		die("BUG: stat option does not begin with --stat: %s", arg);
 	end = (char *)arg;
 
 	switch (*arg) {
-- 
2.0.0.566.gfe3e6b2
