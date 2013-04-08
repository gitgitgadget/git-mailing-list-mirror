From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 1/2] progress: create public humanize() to show sizes
Date: Mon,  8 Apr 2013 20:18:20 +0200
Message-ID: <1365445101-10425-1-git-send-email-apelisse@gmail.com>
References: <CALWbr2wgJmY86Fic-eE9AbtP=HMPddTO=LDp5RGYmt6_kFawpg@mail.gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 20:18:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGeW-0005R5-R6
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935114Ab3DHSSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:18:44 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43287 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935446Ab3DHSSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:18:43 -0400
Received: by mail-we0-f174.google.com with SMTP id u12so4654259wey.33
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 11:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=c66spjDs9qEMm02u7ssRAn1XWK2lyXRBkQ8W6vhQP5c=;
        b=Yhrc1a7gYjkx+8Ti2AX6dD8eSOPws5Q65gptyO2ttwyLxiRCQIcQaBh0yL4KYIfBC/
         nDbqdz466MCNEzEHlNXEpEz0yR+WrfEtbr3Rqb/hqet0gQJdp6mIaycSED0RLs7rQlMw
         FwpstXmnd14ElmTkTIPo9nF7U0A3Yx64hzIKg6Yzr0RU/OIvcYSZrmZ5Ud8R+fjXNzMr
         HX62sgpJrr2BJx5ICVo4wvysKvCOojKvHyxYJ6OaoyTu5DsbRFxJhTIMOU1GWhAEx5J6
         zE2V8GbombEkUHLVISlwXHFWOLQl2hrxSFRMI1UcetEFUEtZtwTh/O0CpI45VIZi/nxz
         r2qw==
X-Received: by 10.194.122.131 with SMTP id ls3mr405614wjb.55.1365445122185;
        Mon, 08 Apr 2013 11:18:42 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id n2sm21221855wiy.6.2013.04.08.11.18.40
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 11:18:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CALWbr2wgJmY86Fic-eE9AbtP=HMPddTO=LDp5RGYmt6_kFawpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220479>

Currently, humanization of downloaded size is done in the same function
as text formatting. This is an issue if anyone else wants to use this.

Separate text formatting from size simplification and make the function
public so that it can easily be used by other clients.

We now can use humanize() for both downloaded size and download speed
calculation. One of the drawbacks is that speed will no look like this
when download is stalled: "0 bytes/s" instead of "0 KiB/s".

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 progress.c |   60 ++++++++++++++++++++++++++++++++++--------------------------
 progress.h |    2 ++
 2 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/progress.c b/progress.c
index 3971f49..76c1e42 100644
--- a/progress.c
+++ b/progress.c
@@ -8,8 +8,11 @@
  * published by the Free Software Foundation.
  */
 
+#include <string.h>
+
 #include "git-compat-util.h"
 #include "progress.h"
+#include "strbuf.h"
 
 #define TP_IDX_MAX      8
 
@@ -112,34 +115,33 @@ static int display(struct progress *progress, unsigned n, const char *done)
 	return 0;
 }
 
-static void throughput_string(struct throughput *tp, off_t total,
-			      unsigned int rate)
+void humanize(struct strbuf *buf, off_t bytes)
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
 	} else {
-		l -= snprintf(tp->display, l, ", %u bytes", (int)total);
+		strbuf_addf(buf, "%u bytes", (int)bytes);
 	}
+}
 
-	if (rate > 1 << 10) {
-		int x = rate + 5;  /* for rounding */
-		snprintf(tp->display + sizeof(tp->display) - l, l,
-			 " | %u.%2.2u MiB/s",
-			 x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
-	} else if (rate)
-		snprintf(tp->display + sizeof(tp->display) - l, l,
-			 " | %u KiB/s", rate);
+static void throughput_string(struct strbuf *buf, off_t total,
+			      unsigned int rate)
+{
+	strbuf_addstr(buf, ", ");
+	humanize(buf, total);
+	strbuf_addstr(buf, " | ");
+	humanize(buf, rate * 1024);
+	strbuf_addstr(buf, "/s");
 }
 
 void display_throughput(struct progress *progress, off_t total)
@@ -183,6 +185,7 @@ void display_throughput(struct progress *progress, off_t total)
 	misecs += (int)(tv.tv_usec - tp->prev_tv.tv_usec) / 977;
 
 	if (misecs > 512) {
+		struct strbuf buf = STRBUF_INIT;
 		unsigned int count, rate;
 
 		count = total - tp->prev_total;
@@ -197,7 +200,9 @@ void display_throughput(struct progress *progress, off_t total)
 		tp->last_misecs[tp->idx] = misecs;
 		tp->idx = (tp->idx + 1) % TP_IDX_MAX;
 
-		throughput_string(tp, total, rate);
+		throughput_string(&buf, total, rate);
+		strncpy(tp->display, buf.buf, sizeof(tp->display));
+		strbuf_release(&buf);
 		if (progress->last_value != -1 && progress_update)
 			display(progress, progress->last_value, NULL);
 	}
@@ -253,9 +258,12 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 
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
diff --git a/progress.h b/progress.h
index 611e4c4..0e70f55 100644
--- a/progress.h
+++ b/progress.h
@@ -2,7 +2,9 @@
 #define PROGRESS_H
 
 struct progress;
+struct strbuf;
 
+void humanize(struct strbuf *buf, off_t bytes);
 void display_throughput(struct progress *progress, off_t total);
 int display_progress(struct progress *progress, unsigned n);
 struct progress *start_progress(const char *title, unsigned total);
-- 
1.7.9.5
