From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 08/11] date: check for "local" before anything else
Date: Thu,  3 Sep 2015 22:48:58 +0100
Message-ID: <7b53c15203dadbf143239c787f43ea39b6bf28fa.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:51:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcPV-0001TG-4b
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757631AbbICVvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:51:05 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:41212 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757532AbbICVvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:51:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9B41ECDA622;
	Thu,  3 Sep 2015 22:51:03 +0100 (BST)
X-Quarantine-ID: <7WvNxQPDRCp6>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7WvNxQPDRCp6; Thu,  3 Sep 2015 22:51:00 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 7CBA086600E;
	Thu,  3 Sep 2015 22:50:45 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277269>

In a following commit we will make "local" orthogonal to the format.
Although this will not apply to "relative", which does not use the
timezone, it applies to all other formats so move the timezone
conversion to the start of the function.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 date.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/date.c b/date.c
index 8f91569..9f0a5dd 100644
--- a/date.c
+++ b/date.c
@@ -174,6 +174,9 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
 
+	if (mode->type == DATE_LOCAL)
+		tz = local_tzoffset(time);
+
 	if (mode->type == DATE_RAW) {
 		strbuf_reset(&timebuf);
 		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
@@ -189,9 +192,6 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 		return timebuf.buf;
 	}
 
-	if (mode->type == DATE_LOCAL)
-		tz = local_tzoffset(time);
-
 	tm = time_to_tm(time, tz);
 	if (!tm) {
 		tm = time_to_tm(0, 0);
-- 
2.5.0.466.g9af26fa
