From: Michael Spang <mspang@uwaterloo.ca>
Subject: [PATCH 2/3] dir.c: Omit non-excluded directories with dir->show_ignored
Date: Sun, 06 May 2007 14:09:24 -0400
Message-ID: <463E19D4.4030400@uwaterloo.ca>
References: <463E1705.2090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 20:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HklAw-00066R-Gf
	for gcvg-git@gmane.org; Sun, 06 May 2007 20:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbXEFSJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 14:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754868AbXEFSJe
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 14:09:34 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:63868 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754846AbXEFSJe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 14:09:34 -0400
Received: from [10.100.100.102] (rn-wan3a10.uwaterloo.ca [129.97.219.111])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l46I9U64023568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 14:09:31 -0400 (EDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <463E1705.2090201@gmail.com>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sun, 06 May 2007 14:09:31 -0400 (EDT)
X-Miltered: at psyche with ID 463E19DA.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.90.2, clamav-milter version 0.90.2 on localhost
X-Virus-Status: Clean
X-UUID: 4a6b159b-033b-4e07-9878-71a781bc7735
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46354>

This makes "git-ls-files --others --directory --ignored" behave
as documented and consequently also fixes "git-clean -d -X".
Previously, git-clean would remove non-excluded directories
even when using the -X option.

Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
---
 dir.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index d306352..adb3e62 100644
--- a/dir.c
+++ b/dir.c
@@ -448,6 +448,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 
 		while ((de = readdir(fdir)) != NULL) {
 			int len;
+			int exclude;
 
 			if ((de->d_name[0] == '.') &&
 			    (de->d_name[1] == 0 ||
@@ -461,7 +462,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			memcpy(fullname + baselen, de->d_name, len+1);
 			if (simplify_away(fullname, baselen + len, simplify))
 				continue;
-			if (excluded(dir, fullname) != dir->show_ignored) {
+			if ((exclude = excluded(dir, fullname)) != dir->show_ignored) {
 				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
 					continue;
 				}
@@ -484,6 +485,8 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				len++;
 				switch (treat_directory(dir, fullname, baselen + len, simplify)) {
 				case show_directory:
+					if (exclude != dir->show_ignored)
+						continue;
 					break;
 				case recurse_into_directory:
 					contents += read_directory_recursive(dir,
-- 
1.5.2.rc1.4.g47e1
