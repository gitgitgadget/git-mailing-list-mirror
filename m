From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2] Fix safe_create_leading_directories() for Windows
Date: Thu, 02 Jan 2014 21:54:25 +0100
Message-ID: <52C5D201.5070008@gmail.com>
References: <52C5A039.6030408@gmail.com>	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info> <xmqqtxdmp39a.fsf@gitster.dls.corp.google.com> <52C5D0AB.7050309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 02 21:54:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypHq-0008Ny-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 21:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbaABUye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 15:54:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55237 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaABUyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 15:54:33 -0500
Received: by mail-bk0-f46.google.com with SMTP id u15so4698505bkz.19
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uGlau3UuYrbdFuGJ7lZd5nFD+eeZcccn3vcugo5TkUg=;
        b=J4cFmM21BUrA98cPdkTgR8dRcB44JKYEhjrXhmmrwcZ9bzR3xjSqhnHrbe2tyab8m7
         JzJbGsZrR9llfwPO1FDNbw2uhVUPMJMOpPeqNuNp5wVtUspDfYY75fY93MQxn6hRtRlv
         dXjgpROb3o1pxM4ii6VUPzRdV0G+leJU/rCmfHNIa3DmnMer9X0RKr+5uQtQ9loKTrAv
         /Nincs0tOuAkdKL8TFODJ1emftGpmoXeUzlKJMtcQVPxUe/qEGMphOAlvvlomoc11Ext
         2ITGJ/DTMF5YrdlXXG3/6dgLP3BosiwKLncHd5KVNsWV3oG0aiel2hmd+Anp8HEzzujm
         6feg==
X-Received: by 10.204.122.1 with SMTP id j1mr8979bkr.57.1388696072725;
        Thu, 02 Jan 2014 12:54:32 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id bg1sm27775644bkc.4.2014.01.02.12.54.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 12:54:31 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <52C5D0AB.7050309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239878>

When cloning to a directory "C:\foo\bar" from Windows' cmd.exe where "foo"
does not exist yet, Git would throw an error like

fatal: could not create work tree dir 'c:\foo\bar'.: No such file or directory

Fix this by not hard-coding a platform specific directory separator into
safe_create_leading_directories().

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
