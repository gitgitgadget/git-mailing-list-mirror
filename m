From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 03/18] fsck: Provide a function to parse fsck message IDs
Date: Mon, 19 Jan 2015 16:50:19 +0100
Organization: gmx
Message-ID: <5181b6a21b1f565c6715d3eb99bd6321c6c3a6f7.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 16:59:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEjs-0006J3-9P
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 16:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbbASP71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 10:59:27 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029AbbASP7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:25 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFoJxd026247;
	Mon, 19 Jan 2015 16:50:19 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFoJNg026246;
	Mon, 19 Jan 2015 16:50:19 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262624>

This function will be used in the next commits to allow the user to
ask fsck to handle specific problems differently, e.g. demoting certain
errors to warnings. It has to handle partial strings because we would
like to be able to parse, say, 'missing-email,missing-tagger-entry'
command lines.

To make the parsing robust, we generate strings from the enum keys, and
using these keys, we will map lower-case, dash-separated strings values
to the corresponding enum values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 30f7a48..2d91e28 100644
--- a/fsck.c
+++ b/fsck.c
@@ -63,15 +63,38 @@ enum fsck_msg_id {
 };
 #undef MSG_ID
 
-#define MSG_ID(id, severity) { FSCK_##severity },
+#define STR(x) #x
+#define MSG_ID(id, severity) { STR(id), FSCK_##severity },
 static struct {
+	const char *id_string;
 	int severity;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
 	FOREACH_MSG_ID(MSG_ID)
-	{ -1 }
+	{ NULL, -1 }
 };
 #undef MSG_ID
 
+static int parse_msg_id(const char *text, int len)
+{
+	int i, j;
+
+	for (i = 0; i < FSCK_MSG_MAX; i++) {
+		const char *key = msg_id_info[i].id_string;
+		/* id_string is upper-case, with underscores */
+		for (j = 0; j < len; j++) {
+			char c = *(key++);
+			if (c == '_')
+				c = '-';
+			if (text[j] != tolower(c))
+				break;
+		}
+		if (j == len && !*key)
+			return i;
+	}
+
+	die("Unhandled message id: %.*s", len, text);
+}
+
 static int fsck_msg_severity(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
-- 
2.0.0.rc3.9669.g840d1f9
