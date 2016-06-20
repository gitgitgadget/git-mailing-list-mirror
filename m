Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999FD20179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbcFTK7n (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:59:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:58824 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545AbcFTK7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:59:36 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MWwp6-1arpS11OL6-00Vu80; Mon, 20 Jun 2016 12:59:05
 +0200
Date:	Mon, 20 Jun 2016 12:55:43 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/7] shortlog: support outputting to streams other than
 stdout
In-Reply-To: <cover.1466420060.git.johannes.schindelin@gmx.de>
Message-ID: <c9990c2ac84f43e76afc52e5cca5d8876715e004.1466420060.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SWIYeH4i0G4xqRqwcv55l8ZPa8IWzhLNQ0cQKRWRmrsZs+RMPI+
 fFquKODbxcZMKteBxDoAanJP1WP8NXl1eAePCaniRkDIJ936/83hpc974xKlIr/g1KjDAK6
 Wu9OeFT+nA6dG6c+Dc/FGPnVf6Rw+PWOeeXW79wW1rTwMuSoryl5CWODk+xLjM5kZb6CBLb
 FpjiWfJ6kYuLrxdz7Xt9g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uMEmgsd0X20=:6kA9K5fKJ3lRVgpFgWffjR
 DGHiklK4fz3uRxDXvKzKC/fC+gSICy7jBqgoZUF3ij2BljcA4rBNXwqoj+NckKAv6yq1ut66V
 HwNsBnMoBoysaK3pFkBs7Ed2TQImK97v0X92i9xtQM+mgt1JKJ+CT/aqKYO8NC627DcRCYuSx
 L7pWMa6jHHID+e4GkvGpupOmM5Ihf9s8fP3boARrOvUuF32ycFOFA9KJAiSl32hQjTdeLb14f
 ZCjS5FFiTq5oDbwGTWhvqRNoQGG/vZfqBrI1fsnXzhhjVnD8U52/9mUOvJxSv7NSbyD9YG5Yo
 oW4z1c4FKoad8IMeMS222aY1DBJVzI64fKKDtBg7V8HRoTKzQ+9dwdZmYGdF6JZEwhsa3sv/b
 9k+ZkGCSDJru0UhRwvAwP7WbLLejycdrDeAZeZvedEN8lwOs/5dIuETFEt0KZzvHwSJnLFYS0
 wqAURAEnpveZxdClFXKcbOnFps88xyfjv5aL4MYS6A9sc1BNCZNFFPbQUENmuYZmkTt9Uv7tD
 HvabOowzWQ7vY7iqUDPxa+4tTmMbfVwAkmlKcFZlHl2lSURFHZhZ2Yh4u2GZqanjyoRR4mKQy
 9+jGXJYH9KnQOkOt5r9RVlDaAfBVHSGbAOWhmCaiMFAaTSJICbUt9+aZGpl6fpYD2pi9mkgZW
 BSoKqtuiVOVe+lY2vI2Jq00XVtb9iqQvM0Q8UAp8zIldzp5djoiYN8houk8sGxeH4fONlkUOY
 GOg5OKSOqcJDITkRUkY1QoNjExHXgwvb/PZzVcTZKHDQfoX1uzOnm8Os7UY+/YuQyy1xi8z+T
 bdMmM6Z
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
index bfc082e..4c68ba7 100644
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
+			fputc('\n', log->file);
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
2.9.0.119.g370c5a9


