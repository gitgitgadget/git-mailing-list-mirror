From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 06/19] fsck: Report the ID of the error/warning
Date: Sat, 31 Jan 2015 22:06:28 +0100
Organization: gmx
Message-ID: <824d55e9930395ee70371295d8bc52b050732607.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:06:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfFX-0004yx-8n
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170AbbAaVGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:06:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:62185 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbbAaVGe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:06:34 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lt1S6-1XY7sl0vX8-012Xn2; Sat, 31 Jan 2015 22:06:29
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:2yTDSlxX4mBIALkTRhNmRq9+uJlKUdAD7E6DvW0zpbayBgBtSSU
 VVFKumfj1XvYrlKPFgfHz6HwYOwf9+sBxWOkPDMaT/FTRiKj2MVnJ5vEEv/YaaN9pY0gtht
 Aq7bDokcOUdiAviS+2cY9Fhs69PsqgKaCIfCzUSylHTZ8sC5vKNSKS9P4E+gLUgI369NJYH
 3xIQnD2FvtW0/rE+e5TyQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263224>

Some legacy code has objects with non-fatal fsck issues; To enable the
user to ignore those issues, let's print out the ID (e.g. when
encountering "missing-email", the user might want to call `git config
--add receive.fsck.severity missing-email=warn`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c          | 19 +++++++++++++++++++
 t/t1450-fsck.sh |  4 ++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index b5e7d2c..e52b027 100644
--- a/fsck.c
+++ b/fsck.c
@@ -167,6 +167,23 @@ void fsck_set_severity(struct fsck_options *options, const char *mode)
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
@@ -175,6 +192,8 @@ static int report(struct fsck_options *options, struct object *object,
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
2.2.0.33.gc18b867
