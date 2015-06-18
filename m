From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 03/19] fsck: Provide a function to parse fsck message IDs
Date: Thu, 18 Jun 2015 22:07:58 +0200
Organization: gmx
Message-ID: <44712302530b17207465cfaa7c4ca180acbb2769.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:08:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g6b-0002KR-Iq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909AbbFRUIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:08:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:59254 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625AbbFRUID (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:08:03 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MgKUo-1ZSJJo3lRe-00NiG9; Thu, 18 Jun 2015 22:07:58
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:7Az35+OD8OHXdf6CDIQH8BlLJiCvW7eqbrsFCniadbaXXRZU385
 jBdlvkv0KjSIp5/j8OAyKME/zS12u/vHtoa5H/rum7TayR1u9CfljCyIXQQjUtdw+RL885c
 8bU+CKDzXj9NRm0IbhHuGOjltxk1a9LMi9bSUXuqDsuR9V73wz+pk63dMLEh/aNUp1ydbJn
 ritfX6bSBbtKDhuiFUIBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o8aymJAb9v4=:z/uzWt9W8WR0k6RiBfbDbc
 913Y0DQm5gnxbY4Yv0IxB66fUOlseRWCIjRPd8C1P2V8Be/OumVZmsMhPx3Wz64/oJq+g5hYu
 JVTpp9A7/gNnQIe5gknVcSPRphmDx+fAMtYnYNEygUqszmWiAepmFvAWrVJM92usV3hISvR3s
 GOVGHhp/DGunmvXAV7jknQco2TMV8QAAH++GgxhXZ2/kYEMXgNwVgT6Ccgk6RiIpw02fIyEUs
 cWvYRkhmEqdxZTS+ArAqr8MYNXGHNnoY/qBqg9BZuGcpAcRT0erKMCtBGWWUyi4S1jfdticqY
 yCp5dI2TxbjCdbdeTEQ4Xkr/OQnla7W29Y7ykQPqGHBULuCHlkqbyHqKwk7tv9i8xepgAyzPY
 Ghroc0pwtE1V09pcRY3CER128SPQdpbCDzrD/8AFXGPKwQt/usHoeEfzaNC/3czK4EdOLguSE
 Zmw5mb8dopwFT34snWg1INbCH6xFHmABNsg3PUbCYc0h3l9fZ7ak9wKs9UuvA4pjrFGN5a0+I
 6bm+OvS7NGf0UBeqz4fq5KhhvkJE4LtdBrFIK6qVI7/oJ42eTUO+5Vg2MQgdzOo8T3kJ+f5V4
 S4lafE9uPe5aubfYoPsXcAxc8zRc7vk9eD/OUNLCcZ1gMEGhWvTsdAH0em3GoIFaf1U9BZyhv
 G2TJQz0J6NhhOE+G4uqFMFJXGzEdMR0+owdLEXB5npI8O0aSOK2wWL/oUq57VEVzDVOo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272045>

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
index ed0bfc3..4595c7f 100644
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
