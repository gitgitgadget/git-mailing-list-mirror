From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/18] rerere: drop want_sp parameter from is_cmarker()
Date: Fri, 17 Jul 2015 15:24:28 -0700
Message-ID: <1437171880-21590-7-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE4o-0004ZO-N9
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbbGQWZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:50 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35369 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153AbbGQWYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:52 -0400
Received: by pdrg1 with SMTP id g1so67945029pdr.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=cPnM1lwKGpyyvohyFoj/moppsZgKcIhHI3v8tMYzH9w=;
        b=PyZN/tI/MqoN1qV1I8CR1u+niUlIi/X8Zabig0ozjLhq6lHqizjZSc7kBDD6kM4Aec
         oPG9Q5CVHYQu/g+E0ADQVZbks6SqsnML7fwNuQlw1StHI0vVpmS9guIM2lHwdrLfOjIj
         5cO5/qFs9ZNPU5GoFs8LoV7wdU3HdLAuG2oEJeAKp80kd0sOr+kQpL6hnCyL6VYrSw+z
         nhq4ShJQ+yiBlJ67LaV+Oc82VIRNrZ7o8KSMp2Cr+8dCSNSpaVYNfb0gQgAZsmn9ONxx
         NjvsVTPKwzX4jPVaty0IoIqIgNy8BRWDSg8DR9tawZxOxPKqkgbytOwOEri4JmnZ6JrS
         I3HA==
X-Received: by 10.70.128.226 with SMTP id nr2mr33772951pdb.139.1437171891522;
        Fri, 17 Jul 2015 15:24:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id jt2sm12336869pbc.21.2015.07.17.15.24.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274124>

As the nature of the conflict marker line determies if there should
a SP and label after it, the caller shouldn't have to pass the
parameter redundantly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/rerere.c b/rerere.c
index 304df02..4c45f55 100644
--- a/rerere.c
+++ b/rerere.c
@@ -148,8 +148,25 @@ static int rerere_file_getline(struct strbuf *sb, struct rerere_io *io_)
 	return strbuf_getwholeline(sb, io->input, '\n');
 }
 
-static int is_cmarker(char *buf, int marker_char, int marker_size, int want_sp)
+/*
+ * Require the exact number of conflict marker letters, no more, no
+ * less, followed by SP or any whitespace
+ * (including LF).
+ */
+static int is_cmarker(char *buf, int marker_char, int marker_size)
 {
+	int want_sp;
+
+	/*
+	 * The beginning of our version and the end of their version
+	 * always are labeled like "<<<<< ours" or ">>>>> theirs",
+	 * hence we set want_sp for them.  Note that the version from
+	 * the common ancestor in diff3-style output is not always
+	 * labelled (e.g. "||||| common" is often seen but "|||||"
+	 * alone is also valid), so we do not set want_sp.
+	 */
+	want_sp = (marker_char == '<') || (marker_char == '>');
+
 	while (marker_size--)
 		if (*buf++ != marker_char)
 			return 0;
@@ -172,19 +189,19 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 		git_SHA1_Init(&ctx);
 
 	while (!io->getline(&buf, io)) {
-		if (is_cmarker(buf.buf, '<', marker_size, 1)) {
+		if (is_cmarker(buf.buf, '<', marker_size)) {
 			if (hunk != RR_CONTEXT)
 				goto bad;
 			hunk = RR_SIDE_1;
-		} else if (is_cmarker(buf.buf, '|', marker_size, 0)) {
+		} else if (is_cmarker(buf.buf, '|', marker_size)) {
 			if (hunk != RR_SIDE_1)
 				goto bad;
 			hunk = RR_ORIGINAL;
-		} else if (is_cmarker(buf.buf, '=', marker_size, 0)) {
+		} else if (is_cmarker(buf.buf, '=', marker_size)) {
 			if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
 				goto bad;
 			hunk = RR_SIDE_2;
-		} else if (is_cmarker(buf.buf, '>', marker_size, 1)) {
+		} else if (is_cmarker(buf.buf, '>', marker_size)) {
 			if (hunk != RR_SIDE_2)
 				goto bad;
 			if (strbuf_cmp(&one, &two) > 0)
-- 
2.5.0-rc2-340-g0cccc16
