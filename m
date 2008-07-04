From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Fix apply --recount handling of no-EOL line
Date: Fri,  4 Jul 2008 21:10:14 +0200
Message-ID: <1215198614-22148-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 21:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEqgQ-0001vx-No
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 21:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbYGDTKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 15:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbYGDTKE
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 15:10:04 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:40883 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbYGDTKD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 15:10:03 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 4 Jul 2008 21:10:01 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 4 Jul 2008 21:10:00 +0200
X-Mailer: git-send-email 1.5.6.1.330.g2ff03
X-OriginalArrivalTime: 04 Jul 2008 19:10:01.0022 (UTC) FILETIME=[8EB2E5E0:01C8DE09]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87410>

If a patch modifies the last line of a file that previously had no
terminating '\n', it looks like

-old text
\ No newline at end of file
+new text

Hence, a '\' line does not signal the end of the hunk.  This modifies
'git apply --recount' to take this into account.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is just the straightforward fix.  A more elaborate solution might
check if the previous line was a ' ' and '+', and if so, consider the
hunk terminated anyway.

- Thomas

 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 194f03b..fb85a5b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -931,7 +931,7 @@ static void recount_diff(char *line, int size, struct fragment *fragment)
 			newlines++;
 			continue;
 		case '\\':
-			break;
+			continue;
 		case '@':
 			ret = size < 3 || prefixcmp(line, "@@ ");
 			break;
-- 
1.5.6.1.330.g2ff03
