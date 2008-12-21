From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] fast-import.c: stricter strtoul check, silence compiler
 warning
Date: Sun, 21 Dec 2008 02:28:48 +0100
Message-ID: <1229822928.31765.30.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 21 02:30:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LED9F-0007QI-5m
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 02:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbYLUB2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 20:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbYLUB2w
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 20:28:52 -0500
Received: from india601.server4you.de ([85.25.151.105]:51104 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbYLUB2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 20:28:51 -0500
Received: from [10.0.1.101] (p57B7C7C1.dip.t-dialin.net [87.183.199.193])
	by india601.server4you.de (Postfix) with ESMTPSA id 4BC4B2F805F;
	Sun, 21 Dec 2008 02:28:49 +0100 (CET)
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103679>

Store the return value of strtoul() in order to avoid compiler
warnings on Ubuntu 8.10.

Also check errno after each call, which is the only way to notice
an overflow without making ULONG_MAX an illegal date.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
I don't really like the first part, as we're ignoring the return
value anyway, even if we store it in the variable "date", so this
is quite useless.  But better to have a bit more useless code
than to see these equally useless warnings on every build.
Turning them off completely is not a good idea, since some of
them resulted in useful fixes (see 47d32af2, 304dcf26, 7be77de2).

 fast-import.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 171d178..a6bce66 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1748,18 +1748,21 @@ static int validate_raw_date(const char *src, char *result, int maxlen)
 {
 	const char *orig_src = src;
 	char *endp, sign;
+	unsigned long date;
 
-	strtoul(src, &endp, 10);
-	if (endp == src || *endp != ' ')
+	errno = 0;
+
+	date = strtoul(src, &endp, 10);
+	if (errno || endp == src || *endp != ' ')
 		return -1;
 
 	src = endp + 1;
 	if (*src != '-' && *src != '+')
 		return -1;
 	sign = *src;
 
-	strtoul(src + 1, &endp, 10);
-	if (endp == src || *endp || (endp - orig_src) >= maxlen)
+	date = strtoul(src + 1, &endp, 10);
+	if (errno || endp == src || *endp || (endp - orig_src) >= maxlen)
 		return -1;
 
 	strcpy(result, orig_src);
-- 
1.6.1.rc3.52.g589372
