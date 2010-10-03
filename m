From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Sun,  3 Oct 2010 09:56:44 +0000
Message-ID: <1286099806-25774-7-git-send-email-avarab@gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 11:58:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2LKe-0005Kx-VE
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 11:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab0JCJ5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 05:57:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44676 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab0JCJ5b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 05:57:31 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so2994753wwj.1
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=E2Y4GV03i54thlRW9n97FnNDGn1jt4Ob35HFccowc/0=;
        b=g/XWSmxT7zsgy8JPUHmYLCYYFJ2djgMg4KxloCSmc5aSV7OzHwrBaonNzGj61vykkY
         Yvyteh9R7pqAZ8RNYDjut0IQFC52/7lvdHlfQgKxv4GN3zorZLr5oHYKHaFwhulj8VXC
         9v72wHTCAnOdfteTc1VFrb5JwPHKiaNXyBzWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pUw8mSFGOvocTM4c4iKv5veygaVWin5jY/Ysdk3EcPig3wKA76IlRQlz4iuwS0amEa
         YTdfirGKq4ltcKpHJNP/wKdJqNkMIMBifgJBurbC3XmP5EqLkN/43Oz8+v/X1x/w3Lxc
         SUn4z65SqEDAJCybYYzFLwYF3s7KzmXQDru7U=
Received: by 10.227.151.193 with SMTP id d1mr6240796wbw.151.1286099850940;
        Sun, 03 Oct 2010 02:57:30 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id h29sm2968435wbc.9.2010.10.03.02.57.29
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 02:57:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <4CA847D5.4000903@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157856>

From: Joshua Jensen <jjensen@workspacewhiz.com>

When mydir/filea.txt is added, mydir/ is renamed to MyDir/, and
MyDir/fileb.txt is added, running git ls-files mydir only shows
mydir/filea.txt. Running git ls-files MyDir shows MyDir/fileb.txt.
Running git ls-files mYdIR shows nothing.

With this patch running git ls-files for mydir, MyDir, and mYdIR shows
mydir/filea.txt and MyDir/fileb.txt.

Wildcards are not handled case insensitively in this patch. Example:
MyDir/aBc/file.txt is added. git ls-files MyDir/a* works fine, but git
ls-files mydir/a* does not.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/dir.c b/dir.c
index cf8f65c..53aa4f3 100644
--- a/dir.c
+++ b/dir.c
@@ -107,16 +107,30 @@ static int match_one(const char *match, const char *name, int namelen)
 	if (!*match)
 		return MATCHED_RECURSIVELY;
 
-	for (;;) {
-		unsigned char c1 = *match;
-		unsigned char c2 = *name;
-		if (c1 == '\0' || is_glob_special(c1))
-			break;
-		if (c1 != c2)
-			return 0;
-		match++;
-		name++;
-		namelen--;
+	if (ignore_case) {
+		for (;;) {
+			unsigned char c1 = tolower(*match);
+			unsigned char c2 = tolower(*name);
+			if (c1 == '\0' || is_glob_special(c1))
+				break;
+			if (c1 != c2)
+				return 0;
+			match++;
+			name++;
+			namelen--;
+		}
+	} else {
+		for (;;) {
+			unsigned char c1 = *match;
+			unsigned char c2 = *name;
+			if (c1 == '\0' || is_glob_special(c1))
+				break;
+			if (c1 != c2)
+				return 0;
+			match++;
+			name++;
+			namelen--;
+		}
 	}
 
 
@@ -125,8 +139,8 @@ static int match_one(const char *match, const char *name, int namelen)
 	 * we need to match by fnmatch
 	 */
 	matchlen = strlen(match);
-	if (strncmp(match, name, matchlen))
-		return !fnmatch(match, name, 0) ? MATCHED_FNMATCH : 0;
+	if (strncmp_icase(match, name, matchlen))
+		return !fnmatch_icase(match, name, 0) ? MATCHED_FNMATCH : 0;
 
 	if (namelen == matchlen)
 		return MATCHED_EXACTLY;
-- 
1.7.3.159.g610493
