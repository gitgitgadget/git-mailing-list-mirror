From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/8] grep: grep: refactor handling of binary mode options
Date: Sat, 22 May 2010 23:28:17 +0200
Message-ID: <4BF84C71.2030100@lsrfire.ath.cx>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <4BF84B9E.7060009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat May 22 23:28:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFwFH-0001QC-IB
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 23:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758727Ab0EVV2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 17:28:31 -0400
Received: from india601.server4you.de ([85.25.151.105]:51044 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758278Ab0EVV2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 17:28:30 -0400
Received: from [10.0.1.100] (p57B7F4C3.dip.t-dialin.net [87.183.244.195])
	by india601.server4you.de (Postfix) with ESMTPSA id 4131A2F8069;
	Sat, 22 May 2010 23:28:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BF84B9E.7060009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147543>

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
