From: Jeff King <peff@peff.net>
Subject: [PATCH] test-path-utils: use xsnprintf in favor of strcpy
Date: Thu, 14 Jan 2016 15:26:08 -0500
Message-ID: <20160114202608.GA8806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:26:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJoTK-0000pS-P3
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 21:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbcANU0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 15:26:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:53910 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754237AbcANU0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 15:26:11 -0500
Received: (qmail 8224 invoked by uid 102); 14 Jan 2016 20:26:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 15:26:11 -0500
Received: (qmail 11308 invoked by uid 107); 14 Jan 2016 20:26:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 15:26:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 15:26:08 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284087>

This strcpy will never overflow because it's copying from
baked-in test data. But we would prefer to avoid strcpy
entirely, as it makes it harder to audit for real security
bugs.

Signed-off-by: Jeff King <peff@peff.net>
---
I admit that an audit could probably just avoid looking at test-* in the
first place, but not all do (coverity complained about this one, for
example).

This sort-of applies on top of js/dirname-basename, which is in next.
Textually, it's fine, but that topic is based on v2.6.5, and xsnprintf
was only added in the v2.7.0 cycle. The simplest thing is probably to
wait for it to graduate to master, and then apply there as a new topic
(if we do v2.6.6, it's OK for it not to have this patch).

I can hold and resend in a week or two if that's easier.

 test-path-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-path-utils.c b/test-path-utils.c
index 4ab68ac..b9ece10 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -55,7 +55,7 @@ static int test_function(struct test_data *data, char *(*func)(char *input),
 		if (!data[i].from)
 			to = func(NULL);
 		else {
-			strcpy(buffer, data[i].from);
+			xsnprintf(buffer, sizeof(buffer), "%s", data[i].from);
 			to = func(buffer);
 		}
 		if (strcmp(to, data[i].to)) {
-- 
2.7.0.244.g0701a9d
