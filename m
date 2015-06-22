From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 06/19] fsck: Report the ID of the error/warning
Date: Mon, 22 Jun 2015 17:25:52 +0200
Organization: gmx
Message-ID: <ba9759ec82c03e2d60e1e71f1d6f8033d3c17c03.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:26:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73c4-0006sw-Qy
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbbFVP0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:26:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:59811 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753661AbbFVP0K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:26:10 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LpL4H-1YdnCX3oOL-00f7wU; Mon, 22 Jun 2015 17:25:52
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:I63KkI9ywTmfaHnPiXu/5MfycuPMEfyOEupeq4i0VoslNsUCJPa
 CvtCDgDU1DhTaeIzzaoXNAqKspT1TJhuVKRvsKV2420zPBbDHsQ5DH1toUKbjHgybizZUk+
 +/NBwyu/pLALI84R9iVStmTopveOidEQMU8I9jFdzMjo2Wk/KutZ5VbuequIaAKn3JDoFmD
 Nsa4RK3NQMo2ZVJoScABw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zpWC7A/fB10=:oevtWJ1eLayT4hwi95WRh4
 HpFdc4RbHOGXCN55WdamxsV4zP45uLX5C8bpG9twBfFKXuTFrpSX3ltnSzq3CJkAgyRm+TpGe
 7Rv9vfMehaJtDwIro1aSFwNlZ7gGPVgfm2aCFhfEZaStdVgxvsXvhWxuywzbw2zwuB9ZW2USz
 xLGdzqm1KeN0ewQ10b3FeSt3st0x/wnkQS7pMAp+HIHaCtL0muw1Gkxlad1URnBeDUjuPWXeg
 WAWGSOl5juuS1R1d0Pp0NibCry33L5Cdx9bkPCgj6ZaQA7r/J4/3c1c9SUogMNSmvAkNIEeKS
 dfFVBWE3nQIobBAim/+4BwdcAKMbRfzMrWgCrlK8Mh1VN26n+Ix2bITyvSH2IDAD+F+J2S+ZE
 dqCk6MyDWkww2sNcWxoaE+zLvS6RZA/JIsXJ/qF2GzIgVr1M3Rcqa9S/GrEINS7/pzF288Mzp
 qA373eJ8AtepfZSS+RcKrax8R7rR5NEBrsQxL/TvAm2evSquqpdAQFlTv/iEhaU2A4cucCRVm
 6e9EtZl7+227MwyYW5LEF6cULIFKDgxoWqrZWAAuv4KA06yXPodNoft5APfsTmpV3WxIhYZwD
 SXrnLfTSFTP7TBaFegFr8JSBesDo6v8v+HnwcPyIOk9cejbwXIQuaYL7Sbix892mN9MW7C6S1
 VEUmI6ADXm+PLmb3D4+5uaSFpgwXCsA5qhGQOpqNB8oNGZHFQwUtkdpXVFiIYN72wOQM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272379>

Some legacy code has objects with non-fatal fsck issues; To enable the
user to ignore those issues, let's print out the ID (e.g. when
encountering "missingEmail", the user might want to call `git config
--add receive.fsck.missingEmail=warn`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c          | 20 ++++++++++++++++++++
 t/t1450-fsck.sh |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 02af3ed..0ec02b2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -188,6 +188,24 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 	free(to_free);
 }
 
+static void append_msg_id(struct strbuf *sb, const char *msg_id)
+{
+	for (;;) {
+		char c = *(msg_id)++;
+
+		if (!c)
+			break;
+		if (c != '_')
+			strbuf_addch(sb, tolower(c));
+		else {
+			assert(*msg_id);
+			strbuf_addch(sb, *(msg_id)++);
+		}
+	}
+
+	strbuf_addstr(sb, ": ");
+}
+
 __attribute__((format (printf, 4, 5)))
 static int report(struct fsck_options *options, struct object *object,
 	enum fsck_msg_id id, const char *fmt, ...)
@@ -196,6 +214,8 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_type = fsck_msg_type(id, options), result;
 
+	append_msg_id(&sb, msg_id_info[id].id_string);
+
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
 	result = options->error_func(object, msg_type, sb.buf);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index cfb32b6..7c5b3d5 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -231,8 +231,8 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	git fsck --tags 2>out &&
 
 	cat >expect <<-EOF &&
-	warning in tag $tag: invalid '\''tag'\'' name: wrong name format
-	warning in tag $tag: invalid format - expected '\''tagger'\'' line
+	warning in tag $tag: badTagName: invalid '\''tag'\'' name: wrong name format
+	warning in tag $tag: missingTaggerEntry: invalid format - expected '\''tagger'\'' line
 	EOF
 	test_cmp expect out
 '
-- 
2.3.1.windows.1.9.g8c01ab4
