From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 03/19] fsck: Provide a function to parse fsck message IDs
Date: Fri, 19 Jun 2015 15:32:56 +0200
Organization: gmx
Message-ID: <8129a20ee6befc74eb45b6225edaaa1b61647d08.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:33:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wPr-0007Rm-FY
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbbFSNdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:33:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:56176 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbbFSNdA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:33:00 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MYtId-1ZbeKR3gvL-00Vi8S; Fri, 19 Jun 2015 15:32:56
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:AP/GDH34nponyViQpv7s5QbD4tPCpNwRPZ0hOaTdZnqrpUIdPdQ
 CXigNy+za+kgBW649vUNglkzX8HMzfpBUiiSpkYX0oUi+71i8akNdps1VtEK+ruxiyu+heE
 jKWndIkUfy8f+YfEPZRRFKJxlHVQrERL8a2d1bNT/APbQUo5xoTqLeSL+3rueJZ3vf3kdAe
 GUE6WDwkwRoE4fwcVGMkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qYtSuoiXygQ=:4HqJ2wDkVgLMq5va0WHXqt
 hpYbKGLcCvtoA5lWkXRepflNcRMJXYTK/peXqkkvWyOTc96YZjTYc//okYwM2hMSS/clTmSnl
 H3fz7Tro6G68Er4g81Y8q+Q6Rxi4cGZxJEKhfAEZG83HptPuJfkf3dGGdIpOfg9r/Wr988QB9
 IzZBzTYf0aw4rJe2ROO4HStscCNQ5JBGfR+xe1qehoscFIXkgXJIFZTEFYuEk4NKrKaRwtR4b
 nXlaWx96rOGGKiMaqKRDrLBC+qx2B+01NCNsN54Riwf8JV3ObZcZ+glRXAvMBepEKupFWB7sx
 QAm0Vl9cchqoaw9DAlSdxZ8BxESAc7sk082kR74V8PuNQ8d/hn6eo6MiAV8vg8VQQNEPDwmcf
 dovqv8DSadET3JcSy032jhnwIxFP2NasBTP2DgcXHUB4bKIIBXqfeuSVRCo3qwZ4JvACySBn7
 Df5G/rKGxVMYCu4U+p6aRnDCBomJybxLb6dd/OO4yXT61nNJJ0eUzF8Ur07vskI5lx7pZN5od
 yRqaytCq4eh6MYrCg/dLaDjmmaDcjWOh2pcHQIDX+inOaPiSSSMC88r3mlkDid6RjEW+sz0eG
 TrI1Gwff5MP7CBtvUBSsKBzHpBYX8q2LHwEFKfMiyWQmS8oNDHd9lNXNy+LnUkSED3xs2fjKH
 YB4TkSyc4r70o4TnSH+rfu2gm4OImqYZpX0taJQrSV/E9dk7V0PVmk/L47YZdYhRAgEA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272138>

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
 fsck.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index ab24618..da5717c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -63,15 +63,41 @@ enum fsck_msg_id {
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
 
+static int parse_msg_id(const char *text, int len)
+{
+	int i, j;
+
+	if (len < 0)
+		len = strlen(text);
+
+	for (i = 0; i < FSCK_MSG_MAX; i++) {
+		const char *key = msg_id_info[i].id_string;
+		/* match id_string case-insensitively, without underscores. */
+		for (j = 0; j < len; j++) {
+			char c = *(key++);
+			if (c == '_')
+				c = *(key++);
+			if (toupper(text[j]) != c)
+				break;
+		}
+		if (j == len && !*key)
+			return i;
+	}
+
+	return -1;
+}
+
 static int fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
-- 
2.3.1.windows.1.9.g8c01ab4
