From: Michael Weber <michaelw@foldr.org>
Subject: [PATCH] Always copy template files (no symlinking)
Date: Tue, 22 Apr 2008 16:03:59 +0200
Organization: foldr.org, Folding Right since 1996
Message-ID: <20080422140359.GA9590@roadkill.foldr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 16:06:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoJ7E-0003Nh-Sd
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 16:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbYDVOEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 10:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbYDVOEK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 10:04:10 -0400
Received: from lambda.foldr.org ([88.198.49.16]:57393 "EHLO mail.foldr.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751557AbYDVOEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 10:04:09 -0400
Received: from roadkill.foldr.org (zilver015088.mobiel.utwente.nl [130.89.15.88])
	by mail.foldr.org (8.14.2/8.14.2/Debian-3) with ESMTP id m3ME40fr012437
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 22 Apr 2008 16:04:01 +0200
Received: by roadkill.foldr.org (Postfix, from userid 501)
	id 9DD38814BE6; Tue, 22 Apr 2008 16:03:59 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-GPG-Fingerprint: 1024D/F65C68CD: BF52 F4F7 5CAF 5349 1F47  A989 EA4A CD5C F65C 68CD
X-Accept-Language: en de
X-Scanned-By: milter-spamc/1.12.383 .383 (mail.foldr.org [88.198.102.118]); Tue, 22 Apr 2008 16:04:07 +0200
X-Spam-Status: NO, hits=-1.70 required=5.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80122>

Previously, git would readlink(2) template files that are symlinks,
and then symlink(2) the result into .git/.  This does not work for
relative symlinks (as produced by, e.g., encap), and is probably not a
good idea either: it is an irrelevant detail that a file in the
template directory is symlinked.

Signed-off-by: Michael Weber <michaelw@foldr.org>
---
 builtin-init-db.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 2854868..b025a62 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -83,19 +83,8 @@ static void copy_templates_1(char *path, int baselen,
 		}
 		else if (exists)
 			continue;
-		else if (S_ISLNK(st_template.st_mode)) {
-			char lnk[256];
-			int len;
-			len = readlink(template, lnk, sizeof(lnk));
-			if (len < 0)
-				die("cannot readlink %s", template);
-			if (sizeof(lnk) <= len)
-				die("insanely long symlink %s", template);
-			lnk[len] = 0;
-			if (symlink(lnk, path))
-				die("cannot symlink %s %s", lnk, path);
-		}
-		else if (S_ISREG(st_template.st_mode)) {
+		else if (S_ISREG(st_template.st_mode) ||
+			 S_ISLNK(st_template.st_mode)) {
 			if (copy_file(path, template, st_template.st_mode))
 				die("cannot copy %s to %s", template, path);
 		}
-- 
1.5.5.69.ga0a105
