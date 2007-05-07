From: Michael Spang <mspang@uwaterloo.ca>
Subject: Re: [PATCH 2/3] dir.c: Omit non-excluded directories with dir->show_ignored
Date: Sun, 06 May 2007 22:35:04 -0400
Message-ID: <463E9058.5080907@uwaterloo.ca>
References: <463E1705.2090201@gmail.com> <463E19D4.4030400@uwaterloo.ca> <alpine.LFD.0.98.0705061239460.25245@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 07 04:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkt4T-0007i8-Ck
	for gcvg-git@gmane.org; Mon, 07 May 2007 04:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbXEGCf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 22:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbXEGCf0
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 22:35:26 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:40838 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753105AbXEGCfZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 22:35:25 -0400
Received: from [10.100.100.102] (rn-wan3a10.uwaterloo.ca [129.97.219.111])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l472ZC0a021134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 22:35:18 -0400 (EDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <alpine.LFD.0.98.0705061239460.25245@woody.linux-foundation.org>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sun, 06 May 2007 22:35:19 -0400 (EDT)
X-Miltered: at mailchk-m01 with ID 463E9060.003 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.90.2, clamav-milter version 0.90.2 on localhost
X-Virus-Status: Clean
X-UUID: 9e659d29-3c8d-4a1b-a14c-e99e423fe784
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46405>

This makes "git-ls-files --others --directory --ignored" behave
as documented and consequently also fixes "git-clean -d -X".
Previously, git-clean would remove non-excluded directories
even when using the -X option.

Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
---

This fixes the style issue noted by Linus.


 dir.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index d306352..11fab7f 100644
--- a/dir.c
+++ b/dir.c
@@ -448,6 +448,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 
 		while ((de = readdir(fdir)) != NULL) {
 			int len;
+			int exclude;
 
 			if ((de->d_name[0] == '.') &&
 			    (de->d_name[1] == 0 ||
@@ -461,7 +462,9 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			memcpy(fullname + baselen, de->d_name, len+1);
 			if (simplify_away(fullname, baselen + len, simplify))
 				continue;
-			if (excluded(dir, fullname) != dir->show_ignored) {
+
+			exclude = excluded(dir, fullname);
+			if (exclude != dir->show_ignored) {
 				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
 					continue;
 				}
@@ -484,6 +487,8 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				len++;
 				switch (treat_directory(dir, fullname, baselen + len, simplify)) {
 				case show_directory:
+					if (exclude != dir->show_ignored)
+						continue;
 					break;
 				case recurse_into_directory:
 					contents += read_directory_recursive(dir,
