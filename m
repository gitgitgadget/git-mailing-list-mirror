From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 03/19] fsck: Provide a function to parse fsck message IDs
Date: Mon, 22 Jun 2015 17:25:14 +0200
Organization: gmx
Message-ID: <bd90483f53f8158cf9e76cea85db407156b8f885.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:25:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73bJ-0006Sj-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbbFVPZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:25:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:58204 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411AbbFVPZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:25:25 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MFMIO-1ZLLLM2rMS-00EMDY; Mon, 22 Jun 2015 17:25:16
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:hQyoXf8y+YT/6gS802826JWvfooVP6sJunc9XNU2AilIfPBes3F
 JlsF0oIIcjAOVdWNzb85FUi+9lLwjP7zqXXB5Xav+F7AHQ4gemqYqRYtqxhpalNy5J/LqZu
 18uMUbwiwRM/Hev4eAwvefmm5DCXIV/lDVzPCU3sWYwLr1FD7fdn0N+doMvwcungNUPrDTS
 ZWnkgRbFnre3Ia1lmdqgQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272374>

These functions will be used in the next commits to allow the user to
ask fsck to handle specific problems differently, e.g. demoting certain
errors to warnings. The upcoming `fsck_set_msg_types()` function has to
handle partial strings because we would like to be able to parse, say,
'missingemail=warn,missingtaggerentry=warn' command line parameters
(which will be passed by receive-pack to index-pack and unpack-objects).

To make the parsing robust, we generate strings from the enum keys, and
using these keys, we match up strings without dashes case-insensitively
to the corresponding enum values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index ab24618..1a3f7ce 100644
--- a/fsck.c
+++ b/fsck.c
@@ -63,15 +63,47 @@ enum fsck_msg_id {
 };
 #undef MSG_ID
 
-#define MSG_ID(id, msg_type) { FSCK_##msg_type },
+#define STR(x) #x
+#define MSG_ID(id, msg_type) { STR(id), FSCK_##msg_type },
 static struct {
+	const char *id_string;
 	int msg_type;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
 	FOREACH_MSG_ID(MSG_ID)
-	{ -1 }
+	{ NULL, -1 }
 };
 #undef MSG_ID
 
+static int parse_msg_id(const char *text)
+{
+	static char **lowercased;
+	int i;
+
+	if (!lowercased) {
+		/* convert id_string to lower case, without underscores. */
+		lowercased = xmalloc(FSCK_MSG_MAX * sizeof(*lowercased));
+		for (i = 0; i < FSCK_MSG_MAX; i++) {
+			const char *p = msg_id_info[i].id_string;
+			int len = strlen(p);
+			char *q = xmalloc(len);
+
+			lowercased[i] = q;
+			while (*p)
+				if (*p == '_')
+					p++;
+				else
+					*(q)++ = tolower(*(p)++);
+			*q = '\0';
+		}
+	}
+
+	for (i = 0; i < FSCK_MSG_MAX; i++)
+		if (!strcmp(text, lowercased[i]))
+			return i;
+
+	return -1;
+}
+
 static int fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
-- 
2.3.1.windows.1.9.g8c01ab4
