From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] fix textconv leak in emit_rewrite_diff
Date: Thu, 1 Apr 2010 20:04:14 -0400
Message-ID: <20100402000414.GB16462@coredump.intra.peff.net>
References: <20100402000159.GA15101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 02:04:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxUNE-00081f-Ve
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 02:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759042Ab0DBAE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 20:04:28 -0400
Received: from peff.net ([208.65.91.99]:33407 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759038Ab0DBAE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 20:04:26 -0400
Received: (qmail 5148 invoked by uid 107); 2 Apr 2010 00:05:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Apr 2010 20:05:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Apr 2010 20:04:14 -0400
Content-Disposition: inline
In-Reply-To: <20100402000159.GA15101@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143763>

We correctly free() for the normal diff case, but leak for
rewrite diffs.

Signed-off-by: Jeff King <peff@peff.net>
---
I suppose we never noticed this because rewrite diffs and textconv are
both uncommonly used codepaths, and leaking a little bit of textconv
probably just isn't that big a deal in a short-running process. But
stopping leaks is good.

 diff.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 2daa732..db2cd5d 100644
--- a/diff.c
+++ b/diff.c
@@ -550,6 +550,10 @@ static void emit_rewrite_diff(const char *name_a,
 		emit_rewrite_lines(&ecbdata, '-', data_one, size_one);
 	if (lc_b)
 		emit_rewrite_lines(&ecbdata, '+', data_two, size_two);
+	if (textconv_one)
+		free(data_one);
+	if (textconv_two)
+		free(data_two);
 }
 
 struct diff_words_buffer {
-- 
1.7.0.4.299.gba9d4
