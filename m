From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 06/18] fsck: Report the ID of the error/warning
Date: Mon, 19 Jan 2015 16:50:39 +0100
Organization: gmx
Message-ID: <e7a87928aad28d124c25214e62766c724398b8fb.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 16:59:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEju-0006J3-8N
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 16:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbbASP7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 10:59:31 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751592AbbASP7a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:30 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFod2n026298;
	Mon, 19 Jan 2015 16:50:39 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFodpk026297;
	Mon, 19 Jan 2015 16:50:39 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262622>

Some legacy code has objects with non-fatal fsck issues; To enable the
user to ignore those issues, let's print out the ID (e.g. when
encountering "missing-email", the user might want to call `git config
receive.fsck.warn missing-email`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c          | 19 +++++++++++++++++++
 t/t1450-fsck.sh |  4 ++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 7d4c22c..78944f0 100644
--- a/fsck.c
+++ b/fsck.c
@@ -161,6 +161,23 @@ void fsck_set_severity(struct fsck_options *options, const char *mode)
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
@@ -169,6 +186,8 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_severity = fsck_msg_severity(id, options), result;
 
+	append_msg_id(&sb, msg_id_info[id].id_string);
+
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
 	result = options->error_func(object, msg_severity, sb.buf);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index cfb32b6..ea0f216 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -231,8 +231,8 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	git fsck --tags 2>out &&
 
 	cat >expect <<-EOF &&
-	warning in tag $tag: invalid '\''tag'\'' name: wrong name format
-	warning in tag $tag: invalid format - expected '\''tagger'\'' line
+	warning in tag $tag: invalid-tag-name: invalid '\''tag'\'' name: wrong name format
+	warning in tag $tag: missing-tagger-entry: invalid format - expected '\''tagger'\'' line
 	EOF
 	test_cmp expect out
 '
-- 
2.0.0.rc3.9669.g840d1f9
