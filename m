From: Romain Francoise <romain@orebokech.com>
Subject: [PATCH] mailmap: avoid out-of-bounds memory access
Date: Sun, 28 Oct 2012 00:49:55 +0200
Organization: orebokech dot com
Message-ID: <87k3ub4jjg.fsf@silenus.orebokech.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 00:50:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSFD4-0001mK-HB
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 00:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab2J0Wt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 18:49:57 -0400
Received: from stringer.orebokech.com ([88.190.240.207]:59798 "EHLO
	stringer.orebokech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab2J0Wt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 18:49:57 -0400
Received: from silenus.orebokech.com (silenus [192.168.1.4])
	by stringer.orebokech.com (Postfix) with ESMTP id DAC931880033;
	Sun, 28 Oct 2012 00:49:55 +0200 (CEST)
Received: by silenus.orebokech.com (Postfix, from userid 1000)
	id B0F2BA01D0; Sun, 28 Oct 2012 00:49:55 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208515>

AddressSanitizer (http://clang.llvm.org/docs/AddressSanitizer.html)
complains of a one-byte buffer underflow in parse_name_and_email() while
running the test suite. And indeed, if one of the lines in the mailmap
begins with '<', we dereference the address just before the beginning of
the buffer when looking for whitespace to remove, before checking that
we aren't going too far.

So reverse the order of the tests to make sure that we don't read
outside the buffer.

Signed-off-by: Romain Francoise <romain@orebokech.com>
---
 mailmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index 47aa419..ea4b471 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -118,7 +118,7 @@ static char *parse_name_and_email(char *buffer, char **name,
 	while (isspace(*nstart) && nstart < left)
 		++nstart;
 	nend = left-1;
-	while (isspace(*nend) && nend > nstart)
+	while (nend > nstart && isspace(*nend))
 		--nend;
 
 	*name = (nstart < nend ? nstart : NULL);
-- 
1.7.10.4
