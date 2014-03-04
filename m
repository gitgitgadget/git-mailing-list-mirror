From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4] commit.c: use skip_prefix() instead of starts_with()
Date: Tue,  4 Mar 2014 13:06:30 -0800
Message-ID: <1393967190-3181-1-git-send-email-tanayabh@gmail.com>
Cc: mhagger@alum.mit.edu, gitster@pobox.com, max@quendi.de,
	Tanay Abhra <tanayabh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 22:07:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKwYb-000406-EG
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 22:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbaCDVHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 16:07:15 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:45493 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbaCDVHK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 16:07:10 -0500
Received: by mail-pd0-f172.google.com with SMTP id p10so82149pdj.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 13:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dEd6U4ypUhGq/egPSgnIlAQVGQdxwGIc88Ea370aUyA=;
        b=D4cq2g1R5Xru9rMCIOWDbpzUH4I/IvTP4bUZm43X3GQwMn91ld0mNKQoOjCR6CGaco
         9uWXgkaNlu0liCgWPoJPuSzERxptp0xzC6px+4icv5Vy5WaTXRBueEt1gE5Pna2+A8oI
         4qqkE8Z7bDxcze7spCEBR3r32EyXkxKStx+VPbdkpQE4eoI8smv54T2HpKXCkhGFgb3Y
         jHAWueEr1wRIpQD/uXEM+qBksE7oRrCN+nm4qglBvuM2T8RX0UpAOtskd1NZEI/nYQFI
         5bHjtCOJb9pt7/cm70kToRVDRBEysDx5kz3pTxKyAAiFrovWjOi/obno3VnLY9xonr4F
         r3Cw==
X-Received: by 10.66.11.66 with SMTP id o2mr2020346pab.142.1393967229391;
        Tue, 04 Mar 2014 13:07:09 -0800 (PST)
Received: from localhost.localdomain ([59.178.54.54])
        by mx.google.com with ESMTPSA id z3sm653458pas.15.2014.03.04.13.07.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 13:07:08 -0800 (PST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243391>

In record_author_date() & parse_gpg_output(), the callers of
starts_with() not just want to know if the string starts with the
prefix, but also can benefit from knowing the string that follows
the prefix.

By using skip_prefix(), we can do both at the same time.

Helped-by: Max Horn <max@quendi.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Patch V4 Identation improved, removed useless comment. [1]
		Thanks to Junio C Hamano and Max Horn.
[1] http://article.gmane.org/gmane.comp.version-control.git/243388

Patch V3 Variable naming improved, removed assignments inside conditionals.
        Thanks to Junio C Hamano and Max Horn.

Patch V2 Corrected email formatting ,reapplied the implementation according to suggestions.
        Thanks to Michael Haggerty.

This is in respect to GSoC microproject #10.

In record_author_date(), extra and useless calls to strlen due to using starts_with()
were removed by using skip_prefix(). Extra variable "ident_line" was used as "buf" is used in
for loop update check.

Other usages of starts_with() in the same file can be found with,

$ grep -n starts_with commit.c

1116:           else if (starts_with(line, gpg_sig_header) &&
1196:           if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {

The starts_with() in line 1116 was left as it is, as strlen values were pre computed as
global variables, and replacing may hamper the clarity.
The starts_with() in line 1196 was replaced as it abstracts way the skip_prefix part by
directly using the function.
Also skip_prefix() is inline when compared to starts_with().

 commit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..01526f7 100644
--- a/commit.c
+++ b/commit.c
@@ -548,7 +548,7 @@ define_commit_slab(author_date_slab, unsigned long);
 static void record_author_date(struct author_date_slab *author_date,
 			       struct commit *commit)
 {
-	const char *buf, *line_end;
+	const char *buf, *line_end, *ident_line;
 	char *buffer = NULL;
 	struct ident_split ident;
 	char *date_end;
@@ -566,14 +566,14 @@ static void record_author_date(struct author_date_slab *author_date,
 	     buf;
 	     buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
-		if (!starts_with(buf, "author ")) {
+		ident_line = skip_prefix(buf, "author ");
+		if (!ident_line) {
 			if (!line_end[0] || line_end[1] == '\n')
 				return; /* end of header */
 			continue;
 		}
 		if (split_ident_line(&ident,
-				     buf + strlen("author "),
-				     line_end - (buf + strlen("author "))) ||
+				    		 ident_line, line_end - ident_line) ||
 		    !ident.date_begin || !ident.date_end)
 			goto fail_exit; /* malformed "author" line */
 		break;
@@ -1193,10 +1193,8 @@ static void parse_gpg_output(struct signature_check *sigc)
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
1.9.0
