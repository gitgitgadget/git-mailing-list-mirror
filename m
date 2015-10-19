From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/34] mailinfo: do not let handle_boundary() touch global "line" directly
Date: Mon, 19 Oct 2015 00:28:25 -0700
Message-ID: <1445239731-10677-9-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4u5-0003YO-Kr
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbbJSH3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:07 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33821 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbJSH3E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:04 -0400
Received: by padhk11 with SMTP id hk11so21768061pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=trpHd/vZI86Mt7XPMRSbCUJOqa8FlbscMxL8iNcaNew=;
        b=uicjc4g6+K+DJlhv3BO4KH1EQZhsWU1jkFK32h8/JjFJTcZA41oVWd4g+rCtIQqvcP
         YcGpqklwAtzDad/CTplWK2LAaZ96qgGr9o3fbICz25oz0oAmGNOQtmpd5K21Uix69pew
         DubOuTkfNUK5QGBMo54+YaLDETtRgAH9C/VNwtG+WDVFTH4dgzb2qyEjKCAUWgFbaE8R
         1EtvuqYgCLrDk+UdD0k6rrp1cBjQRxwYyp5+WRbGz6ctcoUtpV6k56cGDgJk3Yn0Lxvo
         0t3tGpXx6fJEI1HGK/+duyzx7GRUDBKxi+250neJ0t4IXHvSfcs/Ae9Pq/xVHywAByCK
         9tLg==
X-Received: by 10.68.228.101 with SMTP id sh5mr32954700pbc.157.1445239743555;
        Mon, 19 Oct 2015 00:29:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id ci2sm34467963pbc.66.2015.10.19.00.29.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:03 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279861>

This function has a single caller, and called with the global "line"
holding the multi-part boundary line the caller saw while processing
the e-mail body.  The function then goes into a loop to process each
line of the input, and fills the same global "line" variable from
the input as it needs to read more lines to process the multi-part
headers.

Let the caller explicitly pass a pointer to this global "line"
variable as an argument, and have the function itself use that
strbuf throughout, instead of referring to the global "line" itself.

There still is a helper function that this function calls that still
touches the global directly; it will be updated as the series progresses.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 52be7db..cab1235 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -797,14 +797,14 @@ static int find_boundary(void)
 	return 0;
 }
 
-static int handle_boundary(int *filter_stage, int *header_stage)
+static int handle_boundary(struct strbuf *line, int *filter_stage, int *header_stage)
 {
 	struct strbuf newline = STRBUF_INIT;
 
 	strbuf_addch(&newline, '\n');
 again:
-	if (line.len >= (*content_top)->len + 2 &&
-	    !memcmp(line.buf + (*content_top)->len, "--", 2)) {
+	if (line->len >= (*content_top)->len + 2 &&
+	    !memcmp(line->buf + (*content_top)->len, "--", 2)) {
 		/* we hit an end boundary */
 		/* pop the current boundary off the stack */
 		strbuf_release(*content_top);
@@ -833,14 +833,14 @@ again:
 	strbuf_reset(&charset);
 
 	/* slurp in this section's info */
-	while (read_one_header_line(&line, fin))
-		check_header(&line, p_hdr_data, 0);
+	while (read_one_header_line(line, fin))
+		check_header(line, p_hdr_data, 0);
 
 	strbuf_release(&newline);
 	/* replenish line */
-	if (strbuf_getline(&line, fin, '\n'))
+	if (strbuf_getline(line, fin, '\n'))
 		return 0;
-	strbuf_addch(&line, '\n');
+	strbuf_addch(line, '\n');
 	return 1;
 }
 
@@ -864,7 +864,7 @@ static void handle_body(struct strbuf *line)
 				handle_filter(&prev, &filter_stage, &header_stage);
 				strbuf_reset(&prev);
 			}
-			if (!handle_boundary(&filter_stage, &header_stage))
+			if (!handle_boundary(line, &filter_stage, &header_stage))
 				goto handle_body_out;
 		}
 
-- 
2.6.2-383-g144b2e6
