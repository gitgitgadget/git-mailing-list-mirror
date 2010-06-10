From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] common_prefix: be more careful about pathspec bounds
Date: Thu, 10 Jun 2010 20:24:20 +0200
Message-ID: <825550ec93610c2d3c7dae7550729d96fc6cebbc.1276194169.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:24:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMmQq-0006cS-4d
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab0FJSYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 14:24:43 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:4009 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab0FJSYn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 14:24:43 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 20:24:42 +0200
Received: from localhost.localdomain (84.74.100.241) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 20:24:21 +0200
X-Mailer: git-send-email 1.7.1.553.ga798e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148903>

common_prefix() scans backwards from the far end of each 'next'
pathspec, starting from 'len', shortening the 'prefix' using 'path' as
a reference.

However, there was a small opportunity for an out-of-bounds access:
len is unconditionally set to prefix-1 after a "direct match" test
failed.  This means that if 'next' is shorter than prefix+2, we read
past it.

Normally this won't be a problem, which is probably why nobody has
noticed that this was broken since 2006.  Even if we find a slash
somewhere beyond the actual contents of 'next', the memcmp after it
can never match because of the terminating NUL.  However, if we are
unlucky and 'next' is right before a page boundary, we may not have
any read access beyond it.

To fix, only set len to prefix-1 if that is actually inside 'next',
i.e., reduces the available length.  As explained in the last
paragraph, increasing the length never results in more matches.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Found by valgrind.

 dir.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 5615f33..ca689ff 100644
--- a/dir.c
+++ b/dir.c
@@ -34,9 +34,11 @@ static int common_prefix(const char **pathspec)
 	prefix = slash - path + 1;
 	while ((next = *++pathspec) != NULL) {
 		int len = strlen(next);
-		if (len >= prefix && !memcmp(path, next, prefix))
-			continue;
-		len = prefix - 1;
+		if (len >= prefix) {
+			if (!memcmp(path, next, prefix))
+				continue;
+			len = prefix - 1;
+		}
 		for (;;) {
 			if (!len)
 				return 0;
-- 
1.7.1.553.ga798e
