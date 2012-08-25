From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/3] remote-testsvn.c: Avoid the getline() GNU extension function
Date: Sat, 25 Aug 2012 18:13:23 +0100
Message-ID: <503907B3.9040101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: florian.achleitner.2.6.31@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 25 19:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5KAN-00019k-OZ
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 19:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab2HYR2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 13:28:54 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:50052 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751931Ab2HYR2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 13:28:52 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id A8FD0384080;
	Sat, 25 Aug 2012 18:28:49 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id A395838407F;	Sat, 25 Aug 2012 18:28:47 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Sat, 25 Aug 2012 18:28:43 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204276>


The getline() function is a GNU extension (you need to define
_GNU_SOURCE before including stdio.h) and is, therefore, not
portable. In particular, getline() is not available on MinGW.

In order to support non-GNU systems, we replace the call to
getline() with (almost) equivalent code using strbuf_getline().
Note that, unlike getline(), strbuf_getline() removes the
newline terminator from the returned string. This difference
in semantics does not matter at this call-site. Also, we note
that the original code was leaking the memory allocated to
'line' by getline().

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Florian,

Could you please squash this into commit 0320cef0 ("remote-svn: add
marks-file regeneration", 22-08-2012).

ATB,
Ramsay Jones

 remote-testsvn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index 09dc304..d0b81d5 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -121,9 +121,8 @@ static void regenerate_marks(void)
 
 static void check_or_regenerate_marks(int latestrev) {
 	FILE *marksfile;
-	char *line = NULL;
-	size_t linelen = 0;
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf line = STRBUF_INIT;
 	int found = 0;
 
 	if (latestrev < 1)
@@ -139,8 +138,8 @@ static void check_or_regenerate_marks(int latestrev) {
 		fclose(marksfile);
 	} else {
 		strbuf_addf(&sb, ":%d ", latestrev);
-		while (getline(&line, &linelen, marksfile) != -1) {
-			if (!prefixcmp(line, sb.buf)) {
+		while (strbuf_getline(&line, marksfile, '\n') != EOF) {
+			if (!prefixcmp(line.buf, sb.buf)) {
 				found++;
 				break;
 			}
@@ -151,6 +150,7 @@ static void check_or_regenerate_marks(int latestrev) {
 	}
 	free_notes(NULL);
 	strbuf_release(&sb);
+	strbuf_release(&line);
 }
 
 static int cmd_import(const char *line)
-- 
1.7.12
