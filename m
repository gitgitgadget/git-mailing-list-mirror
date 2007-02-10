From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] diff.c: Properly quote file names in diff --summary output.
Date: Sat, 10 Feb 2007 15:37:48 +0100
Message-ID: <87ireadqo3.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 10 15:37:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFtMQ-0004NW-BR
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbXBJOhv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXBJOhv
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:37:51 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:40338 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113AbXBJOhv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:37:51 -0500
Received: from adsl-62-167-54-243.adslplus.ch ([62.167.54.243] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HFtMM-0000GY-6F
	for git@vger.kernel.org; Sat, 10 Feb 2007 08:37:50 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 58CC24FB65; Sat, 10 Feb 2007 15:37:48 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39221>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 diff.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 4c642d7..e036aae 100644
--- a/diff.c
+++ b/diff.c
@@ -2409,19 +2409,24 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 
 static void show_file_mode_name(const char *newdelete, struct diff_filespec *fs)
 {
+	char *name = quote_one(fs->path);
 	if (fs->mode)
-		printf(" %s mode %06o %s\n", newdelete, fs->mode, fs->path);
+		printf(" %s mode %06o %s\n", newdelete, fs->mode, name);
 	else
-		printf(" %s %s\n", newdelete, fs->path);
+		printf(" %s %s\n", newdelete, name);
+	free(name);
 }
 
 
 static void show_mode_change(struct diff_filepair *p, int show_name)
 {
 	if (p->one->mode && p->two->mode && p->one->mode != p->two->mode) {
-		if (show_name)
+		if (show_name) {
+			char *name = quote_one(p->two->path);
 			printf(" mode change %06o => %06o %s\n",
-			       p->one->mode, p->two->mode, p->two->path);
+			       p->one->mode, p->two->mode, name);
+			free(name);
+		}
 		else
 			printf(" mode change %06o => %06o\n",
 			       p->one->mode, p->two->mode);
@@ -2455,8 +2460,10 @@ static void diff_summary(struct diff_filepair *p)
 		break;
 	default:
 		if (p->score) {
-			printf(" rewrite %s (%d%%)\n", p->two->path,
+			char *name = quote_one(p->two->path);
+			printf(" rewrite %s (%d%%)\n", name,
 				(int)(0.5 + p->score * 100.0/MAX_SCORE));
+			free(name);
 			show_mode_change(p, 0);
 		} else	show_mode_change(p, 1);
 		break;
-- 
1.5.0.rc4.31.g6289

-- 
Alexandre Julliard
julliard@winehq.org
