From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Make git-apply understand "\ No newline at end of file" in non-english locales
Date: Sun, 4 Sep 2005 20:46:25 +0200
Message-ID: <20050904184625.GB23525@c165.ib.student.liu.se>
References: <20050904172901.GA20574@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Sep 04 20:47:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBzVm-0005wS-Ee
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 20:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVIDSqa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 14:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVIDSqa
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 14:46:30 -0400
Received: from [85.8.31.11] ([85.8.31.11]:20428 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750979AbVIDSq3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2005 14:46:29 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 1781F411E; Sun,  4 Sep 2005 20:51:01 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EBzVb-0007Eh-00; Sun, 04 Sep 2005 20:46:27 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050904172901.GA20574@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8066>


The message "\ No newline at end of file" which sometimes is produced
by diff(1) is locale dependent. We can't assume more than that it
begins with "\ ".

Signed-off-by: Fredrik Kuivinen <freku@ida.liu.se>
---

The previous patch wasn't doing the right thing. Hopefully I have
managed to get it right this time.


 apply.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

b94e5e845c241fff14334001aa5d418d22cd115e
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -672,9 +672,13 @@ static int parse_fragment(char *line, un
 			added++;
 			newlines--;
 			break;
-		/* We allow "\ No newline at end of file" */
+
+		/* We allow "\ No newline at end of file". Depending
+		 * on locale settings when the patch was produced we
+		 * don't know what this line looks like. The only
+		 * thing we do know is that it begins with "\ ". */
 		case '\\':
-			if (len < 12 || memcmp(line, "\\ No newline", 12))
+			if (len < 2 || line[1] != ' ')
 				return -1;
 			break;
 		}
@@ -683,7 +687,7 @@ static int parse_fragment(char *line, un
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
 	 */
-	if (12 < size && !memcmp(line, "\\ No newline", 12))
+	if (2 < size && !memcmp(line, "\\ ", 2))
 		offset += linelen(line, size);
 
 	patch->lines_added += added;
