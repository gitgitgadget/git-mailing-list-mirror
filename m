From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 03/19] fsck: Provide a function to parse fsck message IDs
Date: Sat, 31 Jan 2015 22:04:59 +0100
Organization: gmx
Message-ID: <c6fb23c70970e083b046a784e2dc22bb3f0776ba.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:05:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfE8-0003vi-JR
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbbAaVFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:05:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:63228 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755558AbbAaVFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:05:06 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MeQ43-1Y1OiZ0AoR-00Q9mF; Sat, 31 Jan 2015 22:05:00
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:083Aly/CH4HHF778q9WIfO16acMrBm77MnXLK1F4QDS74xXRdQ/
 LumzU18ew7/bNuoGFqROQ8CmOA2LKaCiFyqve80R/3ib9CC1QZQq9fvz5tlQQoqhPOLbKe4
 OU37/Qz2q1KKkQCOgVjGnie5oK5icNSG4VFQr/9HkQ1LR5afArLgAt3eiMOLbTa6s2V00Gg
 RGICL8TkUsZSDxFbXK97A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263213>

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
2.2.0.33.gc18b867
