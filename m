From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] Make git-apply understand "\ No newline at end of file" in non-english locales
Date: Sun, 4 Sep 2005 19:29:02 +0200
Message-ID: <20050904172901.GA20574@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Sep 04 19:30:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EByJI-00020y-8A
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 19:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVIDR3a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 13:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVIDR3a
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 13:29:30 -0400
Received: from [85.8.31.11] ([85.8.31.11]:55499 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932077AbVIDR3a (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2005 13:29:30 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 683AB411B; Sun,  4 Sep 2005 19:33:34 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EByIg-0000j6-00; Sun, 04 Sep 2005 19:29:02 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8062>

The message "\ No newline at end of file" which sometimes is produced by
diff(1) is locale dependent. We can't assume more than that it begins
with "\ ".

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>
---

For example, given two files, "foo" and "bar", with appropriate
contents 'diff -u foo bar' will produce the following output on my
system.


--- foo 2005-09-04 18:59:38.000000000 +0200
+++ bar 2005-09-04 18:59:16.000000000 +0200
@@ -1 +1 @@
-foobar
+foo
\ Ingen nyrad vid filslut


 apply.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

18d17c911a200c9d45414af403a145c7ac4f9317
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -672,9 +672,13 @@ static int parse_fragment(char *line, un
 			added++;
 			newlines--;
 			break;
-		/* We allow "\ No newline at end of file" */
+
+                /* We allow "\ No newline at end of file". Depending
+                 * on locale settings when the patch was produced we
+                 * don't know what this line looks like. The only
+                 * thing we do know is that it begins with "\ ". */
 		case '\\':
-			if (len < 12 || memcmp(line, "\\ No newline", 12))
+			if (len < 12 || memcmp(line, "\\ ", 2))
 				return -1;
 			break;
 		}
@@ -683,7 +687,7 @@ static int parse_fragment(char *line, un
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
 	 */
-	if (12 < size && !memcmp(line, "\\ No newline", 12))
+	if (12 < size && !memcmp(line, "\\ ", 2))
 		offset += linelen(line, size);
 
 	patch->lines_added += added;
