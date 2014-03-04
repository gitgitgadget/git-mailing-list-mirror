From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] [PATCH] commit.c: Replace starts_with() with skip_prefix()
Date: Tue,  4 Mar 2014 21:24:05 +0530
Message-ID: <1393948445-24689-1-git-send-email-karthik.188@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 16:56:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKrhw-0005xL-AE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 16:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbaCDP4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 10:56:35 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:51321 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbaCDP4e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 10:56:34 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so5392814pbb.28
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VdLGfoQGPQ+uEc27v+e9Ko3NDmyVYP1KAv/BM1bT0ao=;
        b=RgZX/dUMEv61O+FS873z1aciajGAxiPIPh1FYXmcONGzVdDMNz8u7LnOrMM7oIdR32
         5xVgBtiYJNbr7qcF40Am1F4blFmE8mMcQ4+6AIw06VgmJyJh6HrXU+iVJoYfK3hNPkpM
         7OwI1+aWZ90vm3kilIrsW5IF3ujSRB94aN3JHAh72btS0c00QaQDQ2ofh8fAEO6OzCON
         Vji3gLld3ELHFCSzjblpC62eoLbsT0xJkNUvhQhrgW7mu/ht1gvOmmZU9Wd5etEiULtU
         1XEpYyinyGaOD45oPcLoZMZiXCd1bQum0uw9CGnGnsy6FyaZK2Rn51ygMAGvshN/ikyf
         fEUg==
X-Received: by 10.66.150.69 with SMTP id ug5mr208829pab.55.1393948592497;
        Tue, 04 Mar 2014 07:56:32 -0800 (PST)
Received: from localhost.localdomain ([106.51.65.86])
        by mx.google.com with ESMTPSA id f5sm107726763pat.11.2014.03.04.07.56.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Mar 2014 07:56:31 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243351>

In record_author_date() :
Replace "buf + strlen(author )" by skip_prefix(), which is
saved in a new "const char" variable "indent_line".

In parse_signed_commit() :
Replace "line + gpg_sig_header_len" by skip_prefix(), which
is saved in a new "const char" variable "indent_line".

In parse_gpg_output() :
Replace "buf + strlen(sigcheck_gpg_status[i].check + 1)" by
skip_prefix(), which is saved in already available
variable "found".

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 commit.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..71a03e3 100644
--- a/commit.c
+++ b/commit.c
@@ -553,6 +553,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	struct ident_split ident;
 	char *date_end;
 	unsigned long date;
+	const char *indent_line;
 
 	if (!commit->buffer) {
 		unsigned long size;
@@ -562,18 +563,19 @@ static void record_author_date(struct author_date_slab *author_date,
 			return;
 	}
 
+	indent_line = skip_prefix(buf, "author ");
+
 	for (buf = commit->buffer ? commit->buffer : buffer;
 	     buf;
 	     buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
-		if (!starts_with(buf, "author ")) {
+		if (!indent_line) {
 			if (!line_end[0] || line_end[1] == '\n')
 				return; /* end of header */
 			continue;
 		}
-		if (split_ident_line(&ident,
-				     buf + strlen("author "),
-				     line_end - (buf + strlen("author "))) ||
+		if (split_ident_line(&ident, indent_line,
+							 line_end - indent_line) ||
 		    !ident.date_begin || !ident.date_end)
 			goto fail_exit; /* malformed "author" line */
 		break;
@@ -1098,6 +1100,7 @@ int parse_signed_commit(const unsigned char *sha1,
 	char *buffer = read_sha1_file(sha1, &type, &size);
 	int in_signature, saw_signature = -1;
 	char *line, *tail;
+	const char *indent_line;
 
 	if (!buffer || type != OBJ_COMMIT)
 		goto cleanup;
@@ -1111,11 +1114,11 @@ int parse_signed_commit(const unsigned char *sha1,
 		char *next = memchr(line, '\n', tail - line);
 
 		next = next ? next + 1 : tail;
+		indent_line = skip_prefix(line, gpg_sig_header);
 		if (in_signature && line[0] == ' ')
 			sig = line + 1;
-		else if (starts_with(line, gpg_sig_header) &&
-			 line[gpg_sig_header_len] == ' ')
-			sig = line + gpg_sig_header_len + 1;
+		else if (indent_line && indent_line[1] == ' ')
+			sig = indent_line + 2;
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
+		found = skip_prefix(buf, sigcheck_gpg_status[i].check +1);
+		if(!found) {
 			found = strstr(buf, sigcheck_gpg_status[i].check);
 			if (!found)
 				continue;
-- 
1.9.0.138.g2de3478

Hey Eric,
As per your suggestion in the previous mail :
http://article.gmane.org/gmane.comp.version-control.git/243316
I have made necessary changes:
1. Better Naming of variables as per suggestion
2. Proper replacement of skip_prefix() over starts_with() .
