From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3] commit.c: use skip_prefix() instead of starts_with()
Date: Tue,  4 Mar 2014 00:42:20 -0800
Message-ID: <1393922540-13156-1-git-send-email-tanayabh@gmail.com>
Cc: mhagger@alum.mit.edu, gitster@pobox.com, max@quendi.de,
	Tanay Abhra <tanayabh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 09:43:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKkwv-0005l3-VM
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 09:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499AbaCDInh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 03:43:37 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:56370 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462AbaCDIng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 03:43:36 -0500
Received: by mail-pb0-f53.google.com with SMTP id rp16so4903220pbb.26
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 00:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dK6cbgXJiO9/OoTEePS7sVp7W3OX5LA7Rj0dACotDNU=;
        b=SSiUT0r04aBPU4cA66Ao7IPGVZ0M/KXe/SjlO9pzQihL17bbUY92e9McWMDXMEgBvM
         +rcENBkeM/FHAj6PZGJNCJ/AlsDk0PJ0bAyYQXAlUIZ17pDsM0/pbT9U/vjuVXIL/t+4
         2KMrGQwBDzQYleHr7E4ot3Zw8qWSSZP8Ut2QBQvUzw25KR05FnZ6a49ia3BmxdFwBbq5
         3liRrjt4zvF4nLSimaW4BPrNOgdac/e4UBWuFXIy1iBcto8i6qlyjZ+Rr3ph4spA5+EV
         kSmF3vIY7NKl1FD/auVrMyJ9nDFcfUXg8FDQQBHBIMScXN6Aw55duPymedPAyy72wC7C
         1fQA==
X-Received: by 10.68.236.100 with SMTP id ut4mr24479870pbc.29.1393922615924;
        Tue, 04 Mar 2014 00:43:35 -0800 (PST)
Received: from localhost.localdomain ([59.178.59.170])
        by mx.google.com with ESMTPSA id af1sm101012768pad.12.2014.03.04.00.43.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 00:43:34 -0800 (PST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243329>

In record_author_date() & parse_gpg_output() ,using skip_prefix() instead of
starts_with() is a more suitable abstraction.

Helped-by: Max Horn <max@quendi.de> 
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
Patch V3 Variable naming improved, removed assignments inside conditionals.
	Thanks to Junio C Hamano and Max Horn.
	
Patch V2 Corrected email formatting ,reapplied the implementation according to suggestions.
	Thanks to Michael Haggerty.

This is in respect to GSoC microproject #10.

In record_author_date(), extra and useless calls to strlen due to using starts_with()
were removed by using skip_prefix(). Extra variable "skip" was used as "buf" is used in 
for loop update check.

Other usages of starts_with() in the same file can be found with,

$ grep -n starts_with commit.c

1116:		else if (starts_with(line, gpg_sig_header) &&
1196:		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {

The starts_with() in line 1116 was left as it is, as strlen values were pre generated as 
global variables.
The starts_with() in line 1196 was replaced as it abstracts way the skip_prefix part by
directly using the function.
Also skip_prefix() is inline when compared to starts_with().

 commit.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..6c92acb 100644
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
@@ -566,14 +566,16 @@ static void record_author_date(struct author_date_slab *author_date,
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
+		buf = ident_line;
 		if (split_ident_line(&ident,
-				     buf + strlen("author "),
-				     line_end - (buf + strlen("author "))) ||
+				     buf,
+				     line_end - buf) ||
 		    !ident.date_begin || !ident.date_end)
 			goto fail_exit; /* malformed "author" line */
 		break;
@@ -1193,10 +1195,9 @@ static void parse_gpg_output(struct signature_check *sigc)
 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 		const char *found, *next;
 
-		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
-			/* At the very beginning of the buffer */
-			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
-		} else {
+		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
+		/* At the very beginning of the buffer */
+		if(!found) {
 			found = strstr(buf, sigcheck_gpg_status[i].check);
 			if (!found)
 				continue;
-- 
1.9.0
