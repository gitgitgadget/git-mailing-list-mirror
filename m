From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Skip excessive blank lines before commit body
Date: Wed,  3 Jan 2007 14:34:13 +0100
Message-ID: <11678312532251-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 03 14:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H26E1-0002XK-RW
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 14:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbXACNcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 08:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbXACNcK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 08:32:10 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:61031 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbXACNcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 08:32:09 -0500
Received: from localhost.localdomain (ti231210a080-8960.bb.online.no [80.212.179.6])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id l03DW3uK013445;
	Wed, 3 Jan 2007 14:32:03 +0100 (CET)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.ge900
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35866>

This modifies pretty_print_commit() to make the output of git-rev-list and
friends a bit more predictable.

A commit body starting with blank lines might be unheard-of, but still possible
to create using git-commit-tree (so is bound to appear somewhere, sometime).

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 commit.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index 544e426..2a58175 100644
--- a/commit.c
+++ b/commit.c
@@ -703,7 +703,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				  const char *after_subject,
 				  int relative_date)
 {
-	int hdr = 1, body = 0;
+	int hdr = 1, body = 0, seen_title = 0;
 	unsigned long offset = 0;
 	int indent = 4;
 	int parents_shown = 0;
@@ -809,6 +809,8 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 			body = 1;
 
 		if (is_empty_line(line, &linelen)) {
+			if (!seen_title)
+				continue;
 			if (!body)
 				continue;
 			if (subject)
@@ -817,6 +819,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				break;
 		}
 
+		seen_title = 1;
 		if (subject) {
 			int slen = strlen(subject);
 			memcpy(buf + offset, subject, slen);
-- 
1.5.0.rc0.ge900
