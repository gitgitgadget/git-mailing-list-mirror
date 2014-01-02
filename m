From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 02 Jan 2014 18:22:01 +0100
Message-ID: <52C5A039.6030408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 02 18:22:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VylyM-0006C8-9x
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 18:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbaABRWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 12:22:13 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:53592 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbaABRWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 12:22:10 -0500
Received: by mail-bk0-f41.google.com with SMTP id v15so4689169bkz.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 09:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=YwIFgEEJeKBsDh+cGANpNBi3/0x0ykN+PvvPn0X2Tps=;
        b=O1STcDD8oHmp0dVYgDCNgSK6k+mKlZtM4ugg7XDA95YKrWE0aOXRPKDkB7O/sVToSe
         NQFauJk9OyumVVlZAwAGniCDp+CKg23yftZFCN01+smuX2I4CoKhRAXsNnBeFC1cUwAR
         yi4ca2loC3dRGiKAMfiPxDgTyhEo2E4AOesimI6JNa1R6rgZ5Hz97oey9SYdYQ1PJ6SV
         NjL4IPCw+MBTVDsbx4pamWokFrYCsSJOr64Wav9df6xY8oCCn1L6UiWzcYk7BOlc4euy
         YHIdFaMgXZ/mH1LsDTZXKQVzWNVnXMnTyfEdFRMMlQU3bCW31g40SXVaBYVL8Sr9Re2G
         H1hw==
X-Received: by 10.205.77.196 with SMTP id zj4mr121438bkb.170.1388683328288;
        Thu, 02 Jan 2014 09:22:08 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id mf4sm43659309bkb.7.2014.01.02.09.22.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 09:22:07 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239859>

See https://github.com/msysgit/git/pull/80.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 sha1_file.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 760dd60..2114c58 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -110,12 +110,15 @@ int safe_create_leading_directories(char *path)
 	char *pos = path + offset_1st_component(path);
 	struct stat st;
 
-	while (pos) {
-		pos = strchr(pos, '/');
-		if (!pos)
-			break;
-		while (*++pos == '/')
-			;
+	while (*pos) {
+		while (!is_dir_sep(*pos)) {
+			++pos;
+			if (!*pos)
+				break;
+		}
+		/* skip consecutive directory separators */
+		while (is_dir_sep(*pos))
+			++pos;
 		if (!*pos)
 			break;
 		*--pos = '\0';
-- 
1.8.4.msysgit.0.1.ge705bba.dirty
