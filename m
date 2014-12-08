From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 06/18] fsck: report the ID of the error/warning
Date: Mon, 8 Dec 2014 17:14:42 +0100 (CET)
Message-ID: <2bc462ca50abdc07a89d1a8c58ac1633748b3b91.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:14:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0xb-0005wZ-1f
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853AbaLHQOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:14:50 -0500
Received: from mout.gmx.net ([212.227.17.22]:59825 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806AbaLHQOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:14:49 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LnxVE-1XVHuV3bfk-00g3Fv;
 Mon, 08 Dec 2014 17:14:43 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:nO7DUhBgnkQe9V927oFmBLkZH5M0b9L/bhILuwHBoUA4yNSi9bL
 1i1emOOr4GdQVQKlYR1UUZ6Z1YcGlqIXcZu2qxEdLdUQU8An3g1Ma1QsjBJtLNuw7Lw1Oc1
 pTg07gJ9FBLvqg/9NNU/oa2nSM9Fzj9O0RZJk3pB3uMzycg5Ejg+HoxKrvlFxUF8cQ4x/br
 SfPdxoEW67WNHNqcGucMA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261058>

Some legacy code has objects with non-fatal fsck issues; To enable the
user to ignore those issues, let's print out the ID (e.g. when
encountering "missing-email", the user might want to call `git config
receive.fsck.missing-email warn`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fsck.c b/fsck.c
index 9e6d70f..ff50a87 100644
--- a/fsck.c
+++ b/fsck.c
@@ -154,6 +154,23 @@ void fsck_strict_mode(struct fsck_options *options, const char *mode)
 	}
 }
 
+static void append_msg_id(struct strbuf *sb, const char *msg_id)
+{
+	for (;;) {
+		char c = *(msg_id)++;
+
+		if (!c)
+			break;
+		if (c == '_')
+			c = '-';
+		else
+			c = tolower(c);
+		strbuf_addch(sb, c);
+	}
+
+	strbuf_addstr(sb, ": ");
+}
+
 __attribute__((format (printf, 4, 5)))
 static int report(struct fsck_options *options, struct object *object,
 	enum fsck_msg_id id, const char *fmt, ...)
@@ -162,6 +179,8 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_type = fsck_msg_type(id, options), result;
 
+	append_msg_id(&sb, msg_id_str[id]);
+
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
 	result = options->error_func(object, msg_type, sb.buf);
-- 
2.0.0.rc3.9669.g840d1f9
