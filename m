From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] treat any file with NUL as binary
Date: Tue, 15 Jan 2008 17:28:29 +0300
Message-ID: <1200407309-10992-1-git-send-email-dpotapov@gmail.com>
Cc: Steffen Prohaska <prohaska@zib.de>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 15:29:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEmmk-0007fw-Ja
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 15:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbYAOO2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 09:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbYAOO2e
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 09:28:34 -0500
Received: from smtp08.mtu.ru ([62.5.255.55]:55703 "EHLO smtp08.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbYAOO2e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 09:28:34 -0500
Received: from smtp08.mtu.ru (localhost [127.0.0.1])
	by smtp08.mtu.ru (Postfix) with ESMTP id 4FE7EF761FB;
	Tue, 15 Jan 2008 17:28:28 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-67.pppoe.mtu-net.ru [85.141.191.67])
	by smtp08.mtu.ru (Postfix) with ESMTP id D621EF76566;
	Tue, 15 Jan 2008 17:28:27 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JEmmD-0002rd-Q0; Tue, 15 Jan 2008 17:28:29 +0300
X-Mailer: git-send-email 1.5.4.rc3.3.g0321b
X-DCC-STREAM-Metrics: smtp08.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70525>

There are two heuristics in Git to detect whether a file is binary
or text. One in xdiff-interface.c relied on existing NUL byte at
the beginning. However, convert.c used a different heuristic, which
relied that the number of non-printable symbols is less than 1%.

Due to difference in approaches whether a file is binary or not,
it was possible that a file that diff treats as binary will not be
treated as text by CRLF conversation. This is very confusing for
a user who seeing that 'git diff' shows file as binary expects it
to be added as binary.

This patch makes is_binary to consider any file that contains at
least one NUL character as binary.
---

Junio,

I believe that the current behavior where 'git diff' shows me a file
as binary and then adds it as text with crlf conversation is a bug.

Though, it is not very likely to happen, it still possible cases where
a binary file contains large amount of text. For instance, a tar file
of text files can be such a file. Probably, word processor that store
text in binary format may also generate a file with more 99% printable
characters. So, such files will be considered as text by current convert
heuristic. Still such files are considered by diff due present of a NUL
character. This is very confusing for a user to see 'git diff' saying
that a file is binary and then having it converted as text. Because I
don't think that any real text file (especially one that requires CRLF
conversation) may contain NUL character, I believe this change should
improve binary heuristic and avoid user confusion.

So, please, consider it for inclusion as a bug fix.

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
1.5.4.rc3.3.g0321b
