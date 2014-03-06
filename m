From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3] commit.c: Replace starts_with() with skip_prefix()
Date: Thu,  6 Mar 2014 22:35:21 +0530
Message-ID: <1394125521-9341-1-git-send-email-karthik.188@gmail.com>
Cc: sunshine@sunshineco.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 18:08:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLbm4-0001JN-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 18:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbaCFRH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 12:07:56 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:57488 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaCFRHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 12:07:55 -0500
Received: by mail-pb0-f51.google.com with SMTP id uo5so2873691pbc.38
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 09:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oiZHILiIK6Inv7pt1sPtYXVdJ9S0OPjF2yoSSc1Knz4=;
        b=008vsUlFJUPaIVHcb8v+lRYbvmSyc/K/0Zdz50RRhPOjQWbUlAt7WlgXVUSzwH7xSN
         e8Djtm9r64p/+qIPzLz6Ox0NPIbmNZYN8iO6jyDyb5NWaqgE0p7mPoBrmFsCgZNZlp6H
         kokoitNdTNKhiw4YX5UqfUoyI5+ZiBzaoC6ZC8hZ/RNFqIUCJaRCs97lphj2z1BCFA39
         r89My95CTHPRLh1422Q966QEePAgXA2/NVNcJoO0viCuGP2tuxkmpjwJZbU7Lqax2VSk
         xJP3jO62Ly+6Fzm5UhRjm1jKGZP9i9MXk/OIUJppvv4SbmG/ViBKFw6rjKFb80Abh7wF
         3VEA==
X-Received: by 10.68.162.1 with SMTP id xw1mr15736246pbb.128.1394125675067;
        Thu, 06 Mar 2014 09:07:55 -0800 (PST)
Received: from localhost.localdomain ([106.51.65.86])
        by mx.google.com with ESMTPSA id bc4sm21697490pbb.2.2014.03.06.09.07.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Mar 2014 09:07:54 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243522>

Replace all instances of starts_with() by skip_prefix(),
which can not only be used to check presence of a prefix,
but also used further on as it returns the string after the prefix,
if the prefix is present. And also manages to do, what the current
code does in two steps.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Hello Eric,
In this patch, I have:
1. Fixed the improper placement of buf_date , initialised to a NULL string.
2. Fixed whitespace.
3. Better naming as per your suggestion.
4. Fixed the initilisation before the if statement.
Thanks for your suggestion.
---
 commit.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..4144e00 100644
--- a/commit.c
+++ b/commit.c
@@ -553,6 +553,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	struct ident_split ident;
 	char *date_end;
 	unsigned long date;
+	const char *buf_date;
 
 	if (!commit->buffer) {
 		unsigned long size;
@@ -565,15 +566,15 @@ static void record_author_date(struct author_date_slab *author_date,
 	for (buf = commit->buffer ? commit->buffer : buffer;
 	     buf;
 	     buf = line_end + 1) {
+		buf_date = skip_prefix(buf, "author ");
 		line_end = strchrnul(buf, '\n');
-		if (!starts_with(buf, "author ")) {
+		if (!buf_date) {
 			if (!line_end[0] || line_end[1] == '\n')
 				return; /* end of header */
 			continue;
 		}
-		if (split_ident_line(&ident,
-				     buf + strlen("author "),
-				     line_end - (buf + strlen("author "))) ||
+		if (split_ident_line(&ident, buf_date,
+				     line_end - buf_date) ||
 		    !ident.date_begin || !ident.date_end)
 			goto fail_exit; /* malformed "author" line */
 		break;
@@ -1098,6 +1099,7 @@ int parse_signed_commit(const unsigned char *sha1,
 	char *buffer = read_sha1_file(sha1, &type, &size);
 	int in_signature, saw_signature = -1;
 	char *line, *tail;
+	const char *gpg_sig;
 
 	if (!buffer || type != OBJ_COMMIT)
 		goto cleanup;
@@ -1113,9 +1115,9 @@ int parse_signed_commit(const unsigned char *sha1,
 		next = next ? next + 1 : tail;
 		if (in_signature && line[0] == ' ')
 			sig = line + 1;
-		else if (starts_with(line, gpg_sig_header) &&
-			 line[gpg_sig_header_len] == ' ')
-			sig = line + gpg_sig_header_len + 1;
+		else if ((gpg_sig = skip_prefix(line, gpg_sig_header))
+			  && gpg_sig[0] == ' ')
+			sig = gpg_sig + 1;
 		if (sig) {
 			strbuf_add(signature, sig, next - sig);
 			saw_signature = 1;
@@ -1193,10 +1195,8 @@ static void parse_gpg_output(struct signature_check *sigc)
 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 		const char *found, *next;
 
-		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
-			/* At the very beginning of the buffer */
-			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
-		} else {
+		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
+		if (!found) {
 			found = strstr(buf, sigcheck_gpg_status[i].check);
 			if (!found)
 				continue;
-- 
1.9.0.138.g2de3478
