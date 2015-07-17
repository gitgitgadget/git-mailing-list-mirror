From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 18/18] rerere: un-nest merge() further
Date: Fri, 17 Jul 2015 15:24:40 -0700
Message-ID: <1437171880-21590-19-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE4G-0004Hr-Fj
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219AbbGQWZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:14 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36754 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbbGQWZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:25:10 -0400
Received: by pdjr16 with SMTP id r16so69018554pdj.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=86ETIFIfgmYOz3tiXFxQZQaGy26AgZZRb0LC9uVDi0I=;
        b=w6O6yOm/8SHXWirqJRxsPck3PgCg8G/mRmJOd+oeMYP/FsorVbLeTErvP9hrq0TDyf
         lhfuFijJHRtb+TP/a/Gp/d6Zx0IRgATfE15FsOIJ6I06c87jMvQw+3ZxiSTHef+fRHRK
         LWt04Q1E6ZxXJj8nrC3PCO4xruiU8kIRDQjKRaRlQD+WVoVbuhiin89Qmk+VTHmPApFA
         ijfQeBpMoji0071+XH2dGOduaCN1UTpFVbaCs79xJwN8BHAW6iDJC0CT6d/ctLqLzffe
         PiG5N+FgKrA4qx7xTDS3ml1iPwXc3rkTzl/T4/G+4HcMeJ7tIpEiZ+fdsGi6rqznJAAr
         1QYQ==
X-Received: by 10.69.27.33 with SMTP id jd1mr33618828pbd.34.1437171910063;
        Fri, 17 Jul 2015 15:25:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id iv7sm12291837pbc.81.2015.07.17.15.25.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:25:09 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274118>

By consistently using "upon failure, set 'ret' and jump to out"
pattern, flatten the function further.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/rerere.c b/rerere.c
index 469d8a8..e8d8c02 100644
--- a/rerere.c
+++ b/rerere.c
@@ -571,6 +571,7 @@ int rerere_remaining(struct string_list *merge_rr)
  */
 static int merge(const struct rerere_id *id, const char *path)
 {
+	FILE *f;
 	int ret;
 	mmfile_t cur = {NULL, 0}, base = {NULL, 0}, other = {NULL, 0};
 	mmbuffer_t result = {NULL, 0};
@@ -579,8 +580,10 @@ static int merge(const struct rerere_id *id, const char *path)
 	 * Normalize the conflicts in path and write it out to
 	 * "thisimage" temporary file.
 	 */
-	if (handle_file(path, NULL, rerere_path(id, "thisimage")) < 0)
-		return 1;
+	if (handle_file(path, NULL, rerere_path(id, "thisimage")) < 0) {
+		ret = 1;
+		goto out;
+	}
 
 	if (read_mmfile(&cur, rerere_path(id, "thisimage")) ||
 	    read_mmfile(&base, rerere_path(id, "preimage")) ||
@@ -594,29 +597,28 @@ static int merge(const struct rerere_id *id, const char *path)
 	 * low-level merge driver settings.
 	 */
 	ret = ll_merge(&result, path, &base, NULL, &cur, "", &other, "", NULL);
-	if (!ret) {
-		FILE *f;
+	if (ret)
+		goto out;
 
-		/*
-		 * A successful replay of recorded resolution.
-		 * Mark that "postimage" was used to help gc.
-		 */
-		if (utime(rerere_path(id, "postimage"), NULL) < 0)
-			warning("failed utime() on %s: %s",
-				rerere_path(id, "postimage"),
-				strerror(errno));
-
-		/* Update "path" with the resolution */
-		f = fopen(path, "w");
-		if (!f)
-			return error("Could not open %s: %s", path,
-				     strerror(errno));
-		if (fwrite(result.ptr, result.size, 1, f) != 1)
-			error("Could not write %s: %s", path, strerror(errno));
-		if (fclose(f))
-			return error("Writing %s failed: %s", path,
-				     strerror(errno));
-	}
+	/*
+	 * A successful replay of recorded resolution.
+	 * Mark that "postimage" was used to help gc.
+	 */
+	if (utime(rerere_path(id, "postimage"), NULL) < 0)
+		warning("failed utime() on %s: %s",
+			rerere_path(id, "postimage"),
+			strerror(errno));
+
+	/* Update "path" with the resolution */
+	f = fopen(path, "w");
+	if (!f)
+		return error("Could not open %s: %s", path,
+			     strerror(errno));
+	if (fwrite(result.ptr, result.size, 1, f) != 1)
+		error("Could not write %s: %s", path, strerror(errno));
+	if (fclose(f))
+		return error("Writing %s failed: %s", path,
+			     strerror(errno));
 
 out:
 	free(cur.ptr);
-- 
2.5.0-rc2-340-g0cccc16
