From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 5/6] whitespace: add tab-in-indent support for
 --whitespace=fix
Date: Sat, 3 Apr 2010 00:37:30 +0100
Message-ID: <3edb43ab524b6b2ee883c25cfa80bc6012a4abd4.1270250437.git.chris@arachsys.com>
References: <cover.1270250437.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 01:37:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxqQq-00051w-BZ
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 01:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259Ab0DBXhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 19:37:35 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:39397 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab0DBXhb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 19:37:31 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NxqQc-0004xP-A1; Sat, 03 Apr 2010 00:37:30 +0100
Content-Disposition: inline
In-Reply-To: <cover.1270250437.git.chris@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143863>

If tab-in-indent is set, --whitespace=fix will ensure that any stray tabs in
the initial indent are expanded to the correct number of space characters.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 ws.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/ws.c b/ws.c
index 897ff56..e581535 100644
--- a/ws.c
+++ b/ws.c
@@ -313,8 +313,9 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 		char ch = src[i];
 		if (ch == '\t') {
 			last_tab_in_indent = i;
-			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
-			    0 <= last_space_in_indent)
+			if ((ws_rule & WS_TAB_IN_INDENT) ||
+			    ((ws_rule & WS_SPACE_BEFORE_TAB) &&
+			     0 <= last_space_in_indent))
 			    need_fix_leading_space = 1;
 		} else if (ch == ' ') {
 			last_space_in_indent = i;
@@ -325,7 +326,21 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 			break;
 	}
 
-	if (need_fix_leading_space) {
+	if ((ws_rule & WS_TAB_IN_INDENT) && last_tab_in_indent >= 0) {
+		/* Expand tabs into spaces */
+		int last = last_tab_in_indent + 1;
+		for (i = 0; i < last; i++) {
+			if (src[i] == '\t')
+				do {
+					strbuf_addch(dst, ' ');
+				} while (dst->len % 8);
+			else
+				strbuf_addch(dst, src[i]);
+		}
+		len -= last;
+		src += last;
+		fixed = 1;
+	} else if (need_fix_leading_space) {
 		/* Process indent ourselves */
 		int consecutive_spaces = 0;
 		int last = last_tab_in_indent + 1;
-- 
1.7.0.3
