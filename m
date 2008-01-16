From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] treat any file with NUL as binary
Date: Wed, 16 Jan 2008 04:59:12 +0300
Message-ID: <1200448752-16024-1-git-send-email-dpotapov@gmail.com>
References: <7vr6gibm56.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:59:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExZ9-0008NS-Q3
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782AbYAPB7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756732AbYAPB7P
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:59:15 -0500
Received: from smtp08.mtu.ru ([62.5.255.55]:50488 "EHLO smtp08.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756779AbYAPB7O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 20:59:14 -0500
Received: from smtp08.mtu.ru (localhost [127.0.0.1])
	by smtp08.mtu.ru (Postfix) with ESMTP id 300CAF7693E;
	Wed, 16 Jan 2008 04:59:07 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-67.pppoe.mtu-net.ru [85.141.191.67])
	by smtp08.mtu.ru (Postfix) with ESMTP id DEB12F76969;
	Wed, 16 Jan 2008 04:59:06 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JExYe-0004BB-IF; Wed, 16 Jan 2008 04:59:12 +0300
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <7vr6gibm56.fsf@gitster.siamese.dyndns.org>
X-DCC-STREAM-Metrics: smtp08.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70600>

There are two heuristics in Git to detect whether a file is binary
or text. One in xdiff-interface.c (which is taken from GNU diff)
relies on existence of the NUL byte at the beginning. However,
convert.c used a different heuristic, which relied on the percent
of non-printable symbols (less than 1% for text files).

Due to differences in detection whether a file is binary or not,
it was possible that a file that diff treats as binary could be
treated as text by CRLF conversion. This is very confusing for a
user who sees that 'git diff' shows the file as binary expects it
to be added as binary.

This patch makes is_binary to consider any file that contains at
least one NUL character as binary, to ensure that the heuristics
used for CRLF conversion is tighter than what is used by diff.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 convert.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 5adef4f..a51da1f 100644
--- a/convert.c
+++ b/convert.c
@@ -17,8 +17,8 @@
 #define CRLF_INPUT	2
 
 struct text_stat {
-	/* CR, LF and CRLF counts */
-	unsigned cr, lf, crlf;
+	/* NUL, CR, LF and CRLF counts */
+	unsigned nul, cr, lf, crlf;
 
 	/* These are just approximations! */
 	unsigned printable, nonprintable;
@@ -51,6 +51,9 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 			case '\b': case '\t': case '\033': case '\014':
 				stats->printable++;
 				break;
+			case 0:
+				stats->nul++;
+				/* fall through */
 			default:
 				stats->nonprintable++;
 			}
@@ -66,6 +69,8 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 static int is_binary(unsigned long size, struct text_stat *stats)
 {
 
+	if (stats->nul)
+		return 1;
 	if ((stats->printable >> 7) < stats->nonprintable)
 		return 1;
 	/*
-- 
1.5.3.5
