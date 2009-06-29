From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] mailinfo: Remove only one set of square brackets
Date: Mon, 29 Jun 2009 11:55:51 +0200
Message-ID: <1246269351-26929-1-git-send-email-ae@op5.se>
References: <4A488F07.10002@op5.se>
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 11:56:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLDam-0004BE-In
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 11:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758597AbZF2Jzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 05:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757845AbZF2Jzy
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 05:55:54 -0400
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36031 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758057AbZF2Jzx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 05:55:53 -0400
Received: from source ([72.14.220.152]) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkiPq33dp8SNt9mqmuWJ2D+74piTIj9U@postini.com; Mon, 29 Jun 2009 02:55:57 PDT
Received: by fg-out-1718.google.com with SMTP id 16so748019fgg.13
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 02:55:54 -0700 (PDT)
Received: by 10.86.84.16 with SMTP id h16mr1368019fgb.36.1246269354622;
        Mon, 29 Jun 2009 02:55:54 -0700 (PDT)
Received: from localhost.localdomain ([212.112.174.166])
        by mx.google.com with ESMTPS id l19sm11941740fgb.26.2009.06.29.02.55.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 02:55:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.354.gfb24
In-Reply-To: <4A488F07.10002@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122434>

git-format-patch prepends patches with a [PATCH x/n] prefix, but
mailinfo used to remove any number of square-bracket pairs and
the content between them. This prevents one from using a commit
subject like this:

  [ and ] must be allowed as input

Removing the square bracket pair from this rather clumsily
constructed subject line loses important information, so we must
take care not to.

This patch causes the subject stripping to stop after it has
encountered one pair of square brackets.

One possible downside of this patch is that the patch-handling
programs will now fail at removing author-added square-brackets
to be removed, such as

  [RFC][PATCH x/n]

However, since format-patch only adds one set of square brackets,
this behaviour is quite easily undesrstood and defended while the
previous behaviour is not.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 builtin-mailinfo.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 92637ac..fb5ad70 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -221,6 +221,8 @@ static void cleanup_subject(struct strbuf *subject)
 {
 	char *pos;
 	size_t remove;
+	int brackets_removed = 0;
+
 	while (subject->len) {
 		switch (*subject->buf) {
 		case 'r': case 'R':
@@ -235,10 +237,15 @@ static void cleanup_subject(struct strbuf *subject)
 			strbuf_remove(subject, 0, 1);
 			continue;
 		case '[':
+			/* remove only one set of square brackets */
+			if (brackets_removed)
+				break;
+
 			if ((pos = strchr(subject->buf, ']'))) {
 				remove = pos - subject->buf;
 				if (remove <= (subject->len - remove) * 2) {
 					strbuf_remove(subject, 0, remove + 1);
+					brackets_removed = 1;
 					continue;
 				}
 			} else
-- 
1.6.3.3.354.gfb24
