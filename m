From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/6] record_author_info: fix memory leak on malformed
 commit
Date: Wed, 27 Aug 2014 03:56:31 -0400
Message-ID: <20140827075631.GB26384@peff.net>
References: <20140827075503.GA19521@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 09:56:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMY61-0002ET-NI
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 09:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbaH0H4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 03:56:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:59886 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751932AbaH0H4d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 03:56:33 -0400
Received: (qmail 14605 invoked by uid 102); 27 Aug 2014 07:56:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 02:56:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 03:56:31 -0400
Content-Disposition: inline
In-Reply-To: <20140827075503.GA19521@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255984>

If we hit the end-of-header without finding an "author"
line, we just return from the function. We should jump to
the fail_exit path to clean up the buffer that we may have
allocated.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index b6ffd62..4ff8c66 100644
--- a/commit.c
+++ b/commit.c
@@ -594,7 +594,7 @@ static void record_author_date(struct author_date_slab *author_date,
 		line_end = strchrnul(buf, '\n');
 		if (!skip_prefix(buf, "author ", &ident_line)) {
 			if (!line_end[0] || line_end[1] == '\n')
-				return; /* end of header */
+				goto fail_exit; /* end of header */
 			continue;
 		}
 		if (split_ident_line(&ident,
-- 
2.1.0.346.ga0367b9
