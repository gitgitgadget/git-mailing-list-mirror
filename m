From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 03/19] fsck: Provide a function to parse fsck message IDs
Date: Wed, 21 Jan 2015 20:24:27 +0100
Organization: gmx
Message-ID: <bcc40c9da51cc3967923a057fbcc3def4e48b1e1.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:24:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0tI-0001v8-8h
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbbAUTYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:24:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:50407 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbbAUTYb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:24:31 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LztHH-1Xi8QS2GmZ-014y7p; Wed, 21 Jan 2015 20:24:27
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:SqfeOLycyXtX73UB8l1af5d0K3wcsG2oAikxJd7qET7syYnhdzZ
 AlgPGHaCz6eY3pldP1X0x5eSitQquMPdYgEFBVfAUMOCndK6i1l8ojwkj/1rnrUOGKpLZYE
 6QsclkfrOQiu8SgHKL92VrP6wUqB47oLXrJkq1zxN7uISo/AICjFfw2hm9rNQmjeoxWJrNr
 7I5tzww2td63vr0H4ZhHA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262748>

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
