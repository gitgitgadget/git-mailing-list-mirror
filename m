From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] common_prefix: simplify and fix scanning for prefixes
Date: Wed, 16 Jun 2010 01:02:03 +0200
Message-ID: <f023050aede65c3cc6d9fdf0067c142dc0257c72.1276642610.git.trast@student.ethz.ch>
References: <7vaaqwgd2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 01:02:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOf9L-0000gK-Pc
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 01:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809Ab0FOXC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 19:02:27 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:19855 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754337Ab0FOXC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 19:02:26 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 16 Jun
 2010 01:02:24 +0200
Received: from localhost.localdomain (84.74.100.241) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 16 Jun
 2010 01:02:03 +0200
X-Mailer: git-send-email 1.7.1.608.g80d39f
In-Reply-To: <7vaaqwgd2q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149241>

From: Junio C Hamano <gitster@pobox.com>

common_prefix() scans backwards from the far end of each 'next'
pathspec, starting from 'len', shortening the 'prefix' using 'path' as
a reference.

However, there is a small opportunity for an out-of-bounds access
because len is unconditionally set to prefix-1 after a "direct match"
test failed.  This means that if 'next' is shorter than prefix+2, we
read past it.

Instead of a minimal fix, simplify the loop: scan *forward* over the
'next' entry, remembering the last '/' where it matched the prefix
known so far.  This is far easier to read and also has the advantage
that we only scan over each entry once.

Acked-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > I really didn't like the two-interleaved-loops version in your last
> > mail, but this one is way more readable than even the original.
> >
> > (Why did you wrap the for loop? It's only 76 chars.)
> 
> Because I was writing it in my MUA ;-)

Well then, perhaps I can at least repay the favour by suggesting a
commit message.


 dir.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index 5e36f8e..78eb869 100644
--- a/dir.c
+++ b/dir.c
@@ -33,20 +33,15 @@ static int common_prefix(const char **pathspec)
 
 	prefix = slash - path + 1;
 	while ((next = *++pathspec) != NULL) {
-		int len = strlen(next);
-		if (len >= prefix && !memcmp(path, next, prefix))
+		int len, last_matching_slash = -1;
+		for (len = 0; len < prefix && next[len] == path[len]; len++)
+			if (next[len] == '/')
+				last_matching_slash = len;
+		if (len == prefix)
 			continue;
-		len = prefix - 1;
-		for (;;) {
-			if (!len)
-				return 0;
-			if (next[--len] != '/')
-				continue;
-			if (memcmp(path, next, len+1))
-				continue;
-			prefix = len + 1;
-			break;
-		}
+		if (last_matching_slash < 0)
+			return 0;
+		prefix = last_matching_slash + 1;
 	}
 	return prefix;
 }
-- 
1.7.1.608.g80d39f
