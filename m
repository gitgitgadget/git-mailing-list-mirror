From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-apply: do not fix whitespaces on context lines.
Date: Tue, 27 Feb 2007 01:33:33 -0800
Message-ID: <7vzm70hrma.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 10:33:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLyiI-0005lL-AC
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 10:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbXB0Jdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 04:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbXB0Jde
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 04:33:34 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40557 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161102AbXB0Jde (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 04:33:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227093333.EGTY2670.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 04:33:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UZZZ1W0081kojtg0000000; Tue, 27 Feb 2007 04:33:33 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40702>

Internal function apply_line() is called to copy both context lines
and added lines to the output buffer, while possibly fixing the
whitespace breakages depending on --whitespace=strip settings.
However, it did its fix-up on both context lines and added lines.

This resulted in two symptoms:

 (1) The number of lines reported to have been fixed up included
     these context lines.

 (2) However, the lines actually shown were limited to the added
     lines that had whitespace breakages.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-apply.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index abe3538..bec95d6 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1539,7 +1539,8 @@ static int apply_line(char *output, const char *patch, int plen)
 	int need_fix_leading_space = 0;
 	char *buf;
 
-	if ((new_whitespace != strip_whitespace) || !whitespace_error) {
+	if ((new_whitespace != strip_whitespace) || !whitespace_error ||
+	    *patch != '+') {
 		memcpy(output, patch + 1, plen);
 		return plen;
 	}
-- 
1.5.0.2.775.g1a500
