From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] config: clear the executable bits (if any) on $GIT_DIR/config
Date: Sat, 15 Nov 2014 08:26:19 +0100
Message-ID: <1416036379-4994-3-git-send-email-mhagger@alum.mit.edu>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 08:26:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpXkr-0002Cw-LU
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 08:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbaKOH0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 02:26:40 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59413 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752003AbaKOH0j (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2014 02:26:39 -0500
X-AuditID: 12074414-f79246d000000c4d-ce-5467002a937c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F8.45.03149.A2007645; Sat, 15 Nov 2014 02:26:34 -0500 (EST)
Received: from michael.fritz.box (p5DDB2373.dip0.t-ipconnect.de [93.219.35.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAF7QTan011566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 15 Nov 2014 02:26:33 -0500
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqKvFkB5icOiOkEXXlW4mi4beK8wW
	C/8dZbe4vWI+s8X+piQHVo+/7z8weeycdZfd4+IlZY/Pm+Q8mqecZw1gjeK2SUosKQvOTM/T
	t0vgzpjVdoK1YCV3xdJNXawNjN84uhg5OSQETCSm9pxghrDFJC7cW8/WxcjFISRwmVGid0EL
	I4Rzgkni/MEGdpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMAlMZJfY8Ws4CkhAWCJJYdn4jWBGL
	gKrEvBc7wJp5BZwlTs77DLVOTmLv5NVg9ZwCLhIds16C1QgB1exe/4l9AiPvAkaGVYxyiTml
	ubq5iZk5xanJusXJiXl5qUW6Fnq5mSV6qSmlmxghQSWyg/HISblDjAIcjEo8vBpT00KEWBPL
	iitzDzFKcjApifIW3AEK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuE98h0ox5uSWFmVWpQPk5Lm
	YFES5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEkwSv7H6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4
	NS8ltSixtCQjHhQd8cXA+ABJ8QDtDQJp5y0uSMwFikK0nmJUlBLnlQFJCIAkMkrz4MbCUsUr
	RnGgL4V5i0GqeIBpBq77FdBgJqDBjMdSQQaXJCKkpBoYI8UzuzaKLFASzLH4uXeWcvEiE4lC
	hT97kyu/lbNbWr2SUK1c/465KmTCRT2N/zusMubu79oo7Fa2YcPDe1P9TWWnXH2b1zBNrVRV
	5tjsjlf+sp+E0lfr1DAvyj8puKpe9szCXJU/T0NmiLacXfUv5+/7HDfzt9fvN9nq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no reason for $GIT_DIR/config to be executable, plus this
change will help clean up repositories affected by the bug that was
fixed by the previous commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 config.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 9e42d38..0942e5f 100644
--- a/config.c
+++ b/config.c
@@ -1653,7 +1653,15 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
 
-		if (chmod(lock->filename, st.st_mode & 07777) < 0) {
+		/*
+		 * We make of the executable bits because (a) it
+		 * doesn't make sense to have executable bits set on
+		 * the config file, and (b) there was a bug in git 2.1
+		 * which caused the config file to be created with u+x
+		 * set, so this will help repair repositories created
+		 * with that version.
+		 */
+		if (chmod(lock->filename, st.st_mode & 07666) < 0) {
 			error("chmod on %s failed: %s",
 				lock->filename, strerror(errno));
 			ret = CONFIG_NO_WRITE;
@@ -1832,7 +1840,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 
 	fstat(fileno(config_file), &st);
 
-	if (chmod(lock->filename, st.st_mode & 07777) < 0) {
+	if (chmod(lock->filename, st.st_mode & 07666) < 0) {
 		ret = error("chmod on %s failed: %s",
 				lock->filename, strerror(errno));
 		goto out;
-- 
2.1.1
