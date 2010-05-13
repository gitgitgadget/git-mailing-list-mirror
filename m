From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/7] grep: refactor handling of binary mode options
Date: Thu, 13 May 2010 22:36:12 +0200
Message-ID: <4BEC62BC.6060701@lsrfire.ath.cx>
References: <4BEC6211.2000309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Phil Lawrence <prlawrence@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 13 22:36:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCf8n-00069x-Ay
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 22:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677Ab0EMUgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 16:36:16 -0400
Received: from india601.server4you.de ([85.25.151.105]:53369 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298Ab0EMUgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 16:36:15 -0400
Received: from [10.0.1.100] (p57B7E766.dip.t-dialin.net [87.183.231.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 3D7732F806A;
	Thu, 13 May 2010 22:36:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BEC6211.2000309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147023>

Turn the switch inside-out and add labels for each possible value
of ->binary.  This makes the code easier to read and avoids calling
buffer_is_binary() if the option -a was given.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/grep.c b/grep.c
index 543b1d5..2a8e879 100644
--- a/grep.c
+++ b/grep.c
@@ -800,17 +800,19 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		opt->show_hunk_mark = 1;
 	opt->last_shown = 0;
 
-	if (buffer_is_binary(buf, size)) {
-		switch (opt->binary) {
-		case GREP_BINARY_DEFAULT:
+	switch (opt->binary) {
+	case GREP_BINARY_DEFAULT:
+		if (buffer_is_binary(buf, size))
 			binary_match_only = 1;
-			break;
-		case GREP_BINARY_NOMATCH:
+		break;
+	case GREP_BINARY_NOMATCH:
+		if (buffer_is_binary(buf, size))
 			return 0; /* Assume unmatch */
-			break;
-		default:
-			break;
-		}
+		break;
+	case GREP_BINARY_TEXT:
+		break;
+	default:
+		die("bug: unknown binary handling mode");
 	}
 
 	memset(&xecfg, 0, sizeof(xecfg));
-- 
1.7.1
