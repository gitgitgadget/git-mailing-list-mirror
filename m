From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 03/18] Provide a function to parse fsck message IDs
Date: Mon, 8 Dec 2014 17:14:24 +0100 (CET)
Message-ID: <e217caa9c30b72004eca9b15be3aa1c6674dc278.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:14:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0xN-0005n6-FM
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705AbaLHQOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:14:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:52709 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755591AbaLHQOa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:14:30 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MZ8fw-1YGdCe1q6G-00KvBo;
 Mon, 08 Dec 2014 17:14:24 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:4KzUGAIczUupHXWW6tyMR8H2h4Se8W0jRsXjtzU4p09y/lc2UcB
 dAfPbmoBC43jY9Zebzi81wkpIgX5NykFntJN25BIYFI2OObAsFOdveBGL+UgZ4tavKYY4Qs
 5gfwxzpZoomS4a4iqA4zzClHeirqJ5q4yYHJlj7Sr55/d0bQSNhru9llS1TWvpVg8X5kB2l
 cOhxeZ7zilwkVO+XYLLHQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261055>

This function will be used in the next commits to allow the user to
ask fsck to handle specific problems differently, e.g. demoting certain
errors to warnings. It has to handle partial strings because we would
like to be able to parse, say, '--strict=missing-email=warn' command
lines.

To make the parsing robust, we generate strings from the enum keys, and we
will match both lower-case, dash-separated values as well as camelCased
ones (e.g. both "missing-email" and "missingEmail" will match the
"MISSING_EMAIL" key).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/fsck.c b/fsck.c
index 3cea034..05b146c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -63,6 +63,38 @@ enum fsck_msg_id {
 	FSCK_MSG_MAX
 };
 
+#define STR(x) #x
+#define MSG_ID_STR(x) STR(x),
+static const char *msg_id_str[FSCK_MSG_MAX + 1] = {
+	FOREACH_MSG_ID(MSG_ID_STR)
+	NULL
+};
+
+static int parse_msg_id(const char *text, int len)
+{
+	int i, j;
+
+	for (i = 0; i < FSCK_MSG_MAX; i++) {
+		const char *key = msg_id_str[i];
+		/* msg_id_str is upper-case, with underscores */
+		for (j = 0; j < len; j++) {
+			char c = *(key++);
+			if (c == '_') {
+				if (isalpha(text[j]))
+					c = *(key++);
+				else if (text[j] != '_')
+					c = '-';
+			}
+			if (toupper(text[j]) != c)
+				break;
+		}
+		if (j == len && !*key)
+			return i;
+	}
+
+	die("Unhandled type: %.*s", len, text);
+}
+
 int fsck_msg_type(enum fsck_msg_id msg_id, struct fsck_options *options)
 {
 	return msg_id < FIRST_WARNING ? FSCK_ERROR : FSCK_WARN;
-- 
2.0.0.rc3.9669.g840d1f9
