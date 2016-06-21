Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1472420189
	for <e@80x24.org>; Tue, 21 Jun 2016 10:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbcFUKkz (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:40:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:60931 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbcFUKgC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 06:36:02 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LuPYt-1bPjE61wvv-011hLp; Tue, 21 Jun 2016 12:35:13
 +0200
Date:	Tue, 21 Jun 2016 12:35:12 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 6/9] shortlog: support outputting to streams other than
 stdout
In-Reply-To: <cover.1466505222.git.johannes.schindelin@gmx.de>
Message-ID: <e568e34c23eaf9a40a2d17be7df08426b74a27dc.1466505223.git.johannes.schindelin@gmx.de>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QrDw29B+U09Lvs+KwYcbhXkDAPzawlyFOcUOwhlpSBc1M2AAs2E
 O92tcC1evQmKBcfqH25ds3dRFdBvJUKDezUpk5UWgR6M1lX07/msMRw6eMYHBE5vAbytChP
 1X7SALr1Xs5dGp6vkm1rEdee/S55SiQAgmc5NhN2CN4W5mBRQQnoGHeeUPuRnCwt3cYRh3H
 WhYBVMqYXtmwhy7hl5G3A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:m+XIpZt5/zw=:0QPr8deNrJay9gsl23dgia
 2WRu3AAelx6caGhMxyqLbZkhbV3Jcad8xrxH5dFJU3pubn2fSy9v7BrnA2YQ3dlvZfWbJ2t+g
 0XDmunwRgB2hOWoj0EtUpx5g2RkbKVlFSottvM39h/07+Ux+2OhtZ9zoIOp97dQ+hEoLlKUW+
 8HyKNNvDHjbs8s8YcZuZGkwNac09L4yStTXDhZMbvHEldTmcJ/v1UTLJ5m4e792lwW7YvxVrP
 1NhOcW5NLgkqaBsRKobGv+XtQ31vpJSFuekXeiwe4w8qJz6inZl25N4qbickRw1U+B4QNpFSN
 Lbubx0/IC9gY4wTKRR+e8sgoE5QN2MDMntW5knDSlenwqUslGU4rs2UcEjfWame/uGJO7oxJD
 VC4rP5ty56WSrcBdIuHKe1WwCI7G6kF1X8UIp11ThfCfH2uRbLSWMOTHSSee6V4/6Hwn1w5VZ
 gSQPZZeVbPR9SL70v9XMgeu5Vd4YY+2lTiNOMr3fup4YjCe5P6dyfOTLQbfLdf2NYkgm702Lg
 cLymtxH6fkEtGwW15GxQJupJlPP5E9EXs3Tp2sZNfs323Sa9qGlNiHkD/whTVU+28RNEaIfhW
 IpvVUuiX6ycN2qnt4Ke7G+tko5f56uyv1IkbU6FwTtBAMI8Qb4pX8K+58Vrrfg80Ev0zAEPrz
 8tAh9JZxLf+3j8qMKSOzXkU4l0V5YGjgGAap6FmMRL1GrcMG4YHK2AjsQqVrVXe8S4FAiNWjJ
 w7Jq7vBgVGY3Yfw36IPP64RZfjR24bZiAXt8ghNls0uZIS5Tyw0jlN54Pgf8sV0TdjP4E7PsU
 Cw1TBe5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This will be needed to avoid freopen() in `git format-patch`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/shortlog.c | 13 ++++++++-----
 shortlog.h         |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index bfc082e..39d74fe 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -229,6 +229,7 @@ void shortlog_init(struct shortlog *log)
 	log->wrap = DEFAULT_WRAPLEN;
 	log->in1 = DEFAULT_INDENT1;
 	log->in2 = DEFAULT_INDENT2;
+	log->file = stdout;
 }
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
@@ -310,22 +311,24 @@ void shortlog_output(struct shortlog *log)
 	for (i = 0; i < log->list.nr; i++) {
 		const struct string_list_item *item = &log->list.items[i];
 		if (log->summary) {
-			printf("%6d\t%s\n", (int)UTIL_TO_INT(item), item->string);
+			fprintf(log->file, "%6d\t%s\n",
+				(int)UTIL_TO_INT(item), item->string);
 		} else {
 			struct string_list *onelines = item->util;
-			printf("%s (%d):\n", item->string, onelines->nr);
+			fprintf(log->file, "%s (%d):\n",
+				item->string, onelines->nr);
 			for (j = onelines->nr - 1; j >= 0; j--) {
 				const char *msg = onelines->items[j].string;
 
 				if (log->wrap_lines) {
 					strbuf_reset(&sb);
 					add_wrapped_shortlog_msg(&sb, msg, log);
-					fwrite(sb.buf, sb.len, 1, stdout);
+					fwrite(sb.buf, sb.len, 1, log->file);
 				}
 				else
-					printf("      %s\n", msg);
+					fprintf(log->file, "      %s\n", msg);
 			}
-			putchar('\n');
+			putc('\n', log->file);
 			onelines->strdup_strings = 1;
 			string_list_clear(onelines, 0);
 			free(onelines);
diff --git a/shortlog.h b/shortlog.h
index de4f86f..5a326c6 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -17,6 +17,7 @@ struct shortlog {
 	char *common_repo_prefix;
 	int email;
 	struct string_list mailmap;
+	FILE *file;
 };
 
 void shortlog_init(struct shortlog *log);
-- 
2.9.0.118.g0e1a633


