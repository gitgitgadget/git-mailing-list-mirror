From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2] commit.c: Replace starts_with() with skip_prefix()
Date: Wed,  5 Mar 2014 19:36:12 +0530
Message-ID: <1394028372-29990-1-git-send-email-karthik.188@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 15:07:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLCTL-00015q-9A
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 15:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbaCEOGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 09:06:55 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44813 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbaCEOGy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 09:06:54 -0500
Received: by mail-pb0-f46.google.com with SMTP id rq2so1109085pbb.33
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 06:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OEaOQnMZj40bDOS+ino94AIJttNUQp8Rtk+nX/IugKI=;
        b=l/st44izNbvJwXHSmrFE2Ngz9xVjyL1rwGfP8WV3BlKqBHkc9+Twq7+rNGApL0nIxs
         kQ2EtzK0ZRpjRjE+vaSS0WwBDBBbXS+f54sLMmrGkPVwOA7w+FwQFsYZz1/9WUMPZesK
         h8ZHlN3APiM0Mb/iEEV5QZlKXhI2+B+rsPyu0PMdCmrcM2gYJgguG7R9d6Qe+EFY3+3e
         osBWd5B2c8BzSoLFhLKoLT2aWXGl5aN4cpFhDrfGXQaakJyMZ0yQqXhIy0aMa1VX6JGv
         26PHOTd+xb3pOfHhxYRVnjgki/EfisOcVjxDp3Zp6WohAK1oUn/Rpk0whpnx1TdDCl96
         7fkA==
X-Received: by 10.66.27.202 with SMTP id v10mr6971437pag.127.1394028413576;
        Wed, 05 Mar 2014 06:06:53 -0800 (PST)
Received: from localhost.localdomain ([106.51.111.210])
        by mx.google.com with ESMTPSA id j3sm8775155pbh.38.2014.03.05.06.06.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Mar 2014 06:06:52 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243437>

Replaces all instances of starts_with() by skip_prefix(),
which can not only be used to check presence of a prefix,
but also used further on as it returns the string after the prefix,
if the prefix is present.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Hey Eric,
Here are the changes i have made in this Patch v2:
1. Edited the variables names to fit their usage
2. set my emacs to indent 8 tabs, so proper indentation
3. fixed my error where i increased the value by 1 in parse_signed_commit().
Thanks again for your patience.

---
 commit.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..f006490 100644
--- a/commit.c
+++ b/commit.c
@@ -553,6 +553,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	struct ident_split ident;
 	char *date_end;
 	unsigned long date;
+	const char *buf_split;
 
 	if (!commit->buffer) {
 		unsigned long size;
@@ -562,18 +563,19 @@ static void record_author_date(struct author_date_slab *author_date,
 			return;
 	}
 
+	buf_split = skip_prefix(buf, "author ");
+
 	for (buf = commit->buffer ? commit->buffer : buffer;
 	     buf;
 	     buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
-		if (!starts_with(buf, "author ")) {
+		if (!buf_split) {
 			if (!line_end[0] || line_end[1] == '\n')
 				return; /* end of header */
 			continue;
 		}
-		if (split_ident_line(&ident,
-				     buf + strlen("author "),
-				     line_end - (buf + strlen("author "))) ||
+		if (split_ident_line(&ident, buf_split,
+				     line_end - buf_split) ||
 		    !ident.date_begin || !ident.date_end)
 			goto fail_exit; /* malformed "author" line */
 		break;
@@ -1098,6 +1100,7 @@ int parse_signed_commit(const unsigned char *sha1,
 	char *buffer = read_sha1_file(sha1, &type, &size);
 	int in_signature, saw_signature = -1;
 	char *line, *tail;
+	const char *line_split;
 
 	if (!buffer || type != OBJ_COMMIT)
 		goto cleanup;
@@ -1111,11 +1114,11 @@ int parse_signed_commit(const unsigned char *sha1,
 		char *next = memchr(line, '\n', tail - line);
 
 		next = next ? next + 1 : tail;
+		line_split = skip_prefix(line, gpg_sig_header);
 		if (in_signature && line[0] == ' ')
 			sig = line + 1;
-		else if (starts_with(line, gpg_sig_header) &&
-			 line[gpg_sig_header_len] == ' ')
-			sig = line + gpg_sig_header_len + 1;
+		else if (line_split && line_split[0] == ' ')
+			sig = line_split + 1;
 		if (sig) {
 			strbuf_add(signature, sig, next - sig);
 			saw_signature = 1;
@@ -1193,10 +1196,8 @@ static void parse_gpg_output(struct signature_check *sigc)
 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 		const char *found, *next;
 
-		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
-			/* At the very beginning of the buffer */
-			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
-		} else {
+		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
+		if(!found) {
 			found = strstr(buf, sigcheck_gpg_status[i].check);
 			if (!found)
 				continue;
-- 
1.9.0.138.g2de3478
