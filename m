From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Make git add -n and git -u -n output consistent
Date: Thu, 22 May 2008 23:59:42 +0200
Message-ID: <1211493582-13400-1-git-send-email-hendeby@isy.liu.se>
References: <4835E1AE.6030201@isy.liu.se>
Cc: vmiklos@frugalware.org, git@vger.kernel.org,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 23 00:32:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzJKX-0006jH-JW
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 00:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760611AbYEVWbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 18:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934283AbYEVWbM
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 18:31:12 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:47789 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934261AbYEVWbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 18:31:10 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 2E28125A37;
	Fri, 23 May 2008 00:31:09 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 25079-08; Thu,  8 May 2008 07:37:08 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 6C99D24F8B;
	Fri, 23 May 2008 00:31:08 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 67B01177A0; Thu, 22 May 2008 23:59:42 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.501.gefb4
In-Reply-To: <4835E1AE.6030201@isy.liu.se>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82661>


Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

This would be one way to go to get a more coherent behavior or the -n
switch to git add.  It would also unify the implementation somewhat.
I'd suggest amending this to your patch, or would the output be likely
to be used by scrips?  In that case I'd vote for changing the output
of git add -n -u,

/Gustaf


 builtin-add.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index dd2ca4b..e8dce30 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -261,17 +261,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	fill_directory(&dir, pathspec, ignored_too);
 
-	if (show_only) {
-		const char *sep = "", *eof = "";
-		for (i = 0; i < dir.nr; i++) {
-			printf("%s%s", sep, dir.entries[i]->name);
-			sep = " ";
-			eof = "\n";
-		}
-		fputs(eof, stdout);
-		return 0;
-	}
-
 	if (read_cache() < 0)
 		die("index file corrupt");
 
@@ -284,12 +273,16 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die("no files added");
 	}
 
-	for (i = 0; i < dir.nr; i++)
-		if (add_file_to_cache(dir.entries[i]->name, verbose ? ADD_CACHE_VERBOSE : 0)) {
+	for (i = 0; i < dir.nr; i++) {
+		int flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
+								 (show_only ? ADD_CACHE_PRETEND : 0) |
+								 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0));
+		if (add_file_to_cache(dir.entries[i]->name, flags)) {
 			if (!ignore_add_errors)
 				die("adding files failed");
 			exit_status = 1;
 		}
+	}
 
  finish:
 	if (active_cache_changed) {
-- 
1.5.5.1.501.gefb4
