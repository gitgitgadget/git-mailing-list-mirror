From: Jeff King <peff@peff.net>
Subject: [PATCH] fix reflog approxidate parsing bug
Date: Wed, 30 Apr 2008 00:13:58 -0400
Message-ID: <20080430041358.GA30494@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 06:14:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr3iS-0001Lj-VM
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 06:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbYD3EOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 00:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbYD3EOB
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 00:14:01 -0400
Received: from peff.net ([208.65.91.99]:3953 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbYD3EOA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 00:14:00 -0400
Received: (qmail 10015 invoked by uid 111); 30 Apr 2008 04:13:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Apr 2008 00:13:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2008 00:13:58 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80785>

In get_sha1_basic, we parse a string like

  HEAD@{10 seconds ago}:path/to/file

into its constituent ref, reflog date, and path components.
We never actually munge the string itself, but instead keep
offsets into the string with their associated lengths.

When we call approxidate on the contents inside braces,
however, we pass just a string without a length. This means
that approxidate could sometimes look past the closing brace
and (erroneously) interpret the rest of the string as part
of the date.

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry, I don't have a concise way of writing a test-case. Geoff's
example shows the bug when parsing:

  HEAD{10 seconds ago}:data/node/node.newds1

but it works OK with:

  HEAD{10 seconds ago}:data/node

I didn't track down the exact conditions that cause approxidate to not
like the string, since it seems wrong to be sending it a non-terminated
string anyway.

 sha1_name.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 491d2e7..b0b2167 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -351,8 +351,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		}
 		if (0 <= nth)
 			at_time = 0;
-		else
-			at_time = approxidate(str + at + 2);
+		else {
+			char *tmp = xstrndup(str + at + 2, reflog_len);
+			at_time = approxidate(tmp);
+			free(tmp);
+		}
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (at_time)
-- 
1.5.5.1.178.gc1eb9.dirty
