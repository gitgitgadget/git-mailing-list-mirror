From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 1/2] strbuf: create strbuf_humanize() to show byte sizes
Date: Wed, 10 Apr 2013 21:03:23 +0200
Message-ID: <1365620604-17851-1-git-send-email-apelisse@gmail.com>
References: <7vli8svgyo.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:03:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0JF-0004Z9-QH
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759676Ab3DJTDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:03:50 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:62506 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759380Ab3DJTDt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:03:49 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so875479wgh.12
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=weFQ7fsy0IkZaQlqZIkEt94kNCo41Vj1Y/yqgTJSbKA=;
        b=PnZYmhVYQ0NK3ps5/S3Hs5pYqh6qpzBC7VgYjHpUqz6wARNLVXvtgab78sAWoFD9gD
         +ecXULlg4mCitCfNpU56pJfM0oMmE0kVjQJXRelBUlNwjB4fDFRAS+zO/L059xO8RAaN
         QrCWnA5/tA0tv+VQknRSVBriuHl8hThroVRewLGWrBU0lGRgXMDzZ2kA1J9tLAp9zub+
         11Ptk5BfXThuGBGJGwNsy4zK6nWwgRd2zOd9jq9cPI6wmwgIM/tGueUfPfRQyuE8Ohlp
         2EQY+2W8bEHPNqv+xWZlbMza5l7hcY+m/AWaVksqnVOi/wUdBEgX+FmYYGjA/lMivNOb
         EDNA==
X-Received: by 10.180.37.166 with SMTP id z6mr20642227wij.34.1365620627593;
        Wed, 10 Apr 2013 12:03:47 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id g9sm1805788wix.1.2013.04.10.12.03.46
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 12:03:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vli8svgyo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220725>

Currently, humanization of downloaded size is done in the same
function as text formatting in 'process.c'. This is an issue if anyone
else wants to use this.

Separate text formatting from size simplification and make the function
public in strbuf so that it can easily be used by other clients.

We now can use strbuf_humanize() for both downloaded size and download
speed calculation. One of the drawbacks is that speed will now look like
this when download is stalled: "0 bytes/s" instead of "0 KiB/s".

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 Documentation/technical/api-strbuf.txt |    5 ++++
 progress.c                             |   43 +++++++++++---------------------
 strbuf.c                               |   19 ++++++++++++++
 strbuf.h                               |    1 +
 4 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 2c59cb2..7b6ecda 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -230,6 +230,11 @@ which can be used by the programmer of the callback as she sees fit.
 	destination. This is useful for literal data to be fed to either
 	strbuf_expand or to the *printf family of functions.
 
+`strbuf_humanize`::
+
+	Append the given byte size as a human-readable string (i.e. 12.23 KiB,
+	3.50 MiB).
+
 `strbuf_addf`::
 
 	Add a formatted string to the buffer.
diff --git a/progress.c b/progress.c
index 3971f49..8e09058 100644
--- a/progress.c
+++ b/progress.c
@@ -10,6 +10,7 @@
 
 #include "git-compat-util.h"
 #include "progress.h"
+#include "strbuf.h"
 
 #define TP_IDX_MAX      8
 
@@ -112,34 +113,14 @@ static int display(struct progress *progress, unsigned n, const char *done)
 	return 0;
 }
 
-static void throughput_string(struct throughput *tp, off_t total,
+static void throughput_string(struct strbuf *buf, off_t total,
 			      unsigned int rate)
 {
-	int l = sizeof(tp->display);
-	if (total > 1 << 30) {
-		l -= snprintf(tp->display, l, ", %u.%2.2u GiB",
-			      (int)(total >> 30),
-			      (int)(total & ((1 << 30) - 1)) / 10737419);
-	} else if (total > 1 << 20) {
-		int x = total + 5243;  /* for rounding */
-		l -= snprintf(tp->display, l, ", %u.%2.2u MiB",
-			      x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
-	} else if (total > 1 << 10) {
-		int x = total + 5;  /* for rounding */
-		l -= snprintf(tp->display, l, ", %u.%2.2u KiB",
-			      x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
-	} else {
-		l -= snprintf(tp->display, l, ", %u bytes", (int)total);
-	}
-
-	if (rate > 1 << 10) {
-		int x = rate + 5;  /* for rounding */
-		snprintf(tp->display + sizeof(tp->display) - l, l,
-			 " | %u.%2.2u MiB/s",
-			 x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
-	} else if (rate)
-		snprintf(tp->display + sizeof(tp->display) - l, l,
-			 " | %u KiB/s", rate);
+	strbuf_addstr(buf, ", ");
+	strbuf_humanize(buf, total);
+	strbuf_addstr(buf, " | ");
+	strbuf_humanize(buf, rate * 1024);
+	strbuf_addstr(buf, "/s");
 }
 
 void display_throughput(struct progress *progress, off_t total)
@@ -183,6 +164,7 @@ void display_throughput(struct progress *progress, off_t total)
 	misecs += (int)(tv.tv_usec - tp->prev_tv.tv_usec) / 977;
 
 	if (misecs > 512) {
+		struct strbuf buf = STRBUF_INIT;
 		unsigned int count, rate;
 
 		count = total - tp->prev_total;
@@ -197,7 +179,9 @@ void display_throughput(struct progress *progress, off_t total)
 		tp->last_misecs[tp->idx] = misecs;
 		tp->idx = (tp->idx + 1) % TP_IDX_MAX;
 
-		throughput_string(tp, total, rate);
+		throughput_string(&buf, total, rate);
+		strncpy(tp->display, buf.buf, sizeof(tp->display));
+		strbuf_release(&buf);
 		if (progress->last_value != -1 && progress_update)
 			display(progress, progress->last_value, NULL);
 	}
@@ -253,9 +237,12 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 
 		bufp = (len < sizeof(buf)) ? buf : xmalloc(len + 1);
 		if (tp) {
+			struct strbuf strbuf = STRBUF_INIT;
 			unsigned int rate = !tp->avg_misecs ? 0 :
 					tp->avg_bytes / tp->avg_misecs;
-			throughput_string(tp, tp->curr_total, rate);
+			throughput_string(&strbuf, tp->curr_total, rate);
+			strncpy(tp->display, strbuf.buf, sizeof(tp->display));
+			strbuf_release(&strbuf);
 		}
 		progress_update = 1;
 		sprintf(bufp, ", %s.\n", msg);
diff --git a/strbuf.c b/strbuf.c
index 48e9abb..8a50e66 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -528,6 +528,25 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 	strbuf_add_urlencode(sb, s, strlen(s), reserved);
 }
 
+void strbuf_humanize(struct strbuf *buf, off_t bytes)
+{
+	if (bytes > 1 << 30) {
+		strbuf_addf(buf, "%u.%2.2u GiB",
+			    (int)(bytes >> 30),
+			    (int)(bytes & ((1 << 30) - 1)) / 10737419);
+	} else if (bytes > 1 << 20) {
+		int x = bytes + 5243;  /* for rounding */
+		strbuf_addf(buf, "%u.%2.2u MiB",
+			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
+	} else if (bytes > 1 << 10) {
+		int x = bytes + 5;  /* for rounding */
+		strbuf_addf(buf, "%u.%2.2u KiB",
+			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
+	} else {
+		strbuf_addf(buf, "%u bytes", (int)bytes);
+	}
+}
+
 int printf_ln(const char *fmt, ...)
 {
 	int ret;
diff --git a/strbuf.h b/strbuf.h
index 958822c..317c5a8 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -170,6 +170,7 @@ extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
 				    int reserved);
+extern void strbuf_humanize(struct strbuf *buf, off_t bytes);
 
 __attribute__((format (printf,1,2)))
 extern int printf_ln(const char *fmt, ...);
-- 
1.7.9.5
