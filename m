From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH V2] commit.c: Use skip_prefix() instead of starts_with()
Date: Mon,  3 Mar 2014 07:59:58 -0800
Message-ID: <1393862398-2989-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 17:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKVJ9-0001FW-0V
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 17:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbaCCQB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 11:01:28 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:44907 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbaCCQB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 11:01:27 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so1827013pde.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IX0a4MUoU2TRhVMe1gRfkaGOmfx5Z0KYnKDr0xLZhXQ=;
        b=sy39t4d9/7w3CpwQXbVqCb67cB3iuWeBPuZCo0nAeS0bdEBaD4AczgfLO7l036YoNj
         P/NEEBgFF0KvcVgsbEyWcZGU+uJGC3KzEJsoFya8V2ryeOfPrQRh2SeXzh/NHlQlN9g+
         x7iQW1Ybb1zlxQKHCbbXSCGATLBViy4hwnRJFpJDg9v7M+kulirvUp5JNbDjKCCnV56R
         zRgD50Q3A51Twjxfy/m52klB3Za2yieZ6BoQvUT29LGXybAaTjwqQn3oodujHSTeClCy
         i0cDMXPNeZc7KQAOeEG3GGDTgYq5nCv2wQ9hARM4M0tP3ZbVldAm8yvmnIzdE4fi/W0L
         EY4g==
X-Received: by 10.68.191.200 with SMTP id ha8mr20423768pbc.66.1393862486135;
        Mon, 03 Mar 2014 08:01:26 -0800 (PST)
Received: from localhost.localdomain ([59.178.141.216])
        by mx.google.com with ESMTPSA id yx3sm10987494pbb.6.2014.03.03.08.01.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Mar 2014 08:01:25 -0800 (PST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243231>

In record_author_date() & parse_gpg_output() ,using skip_prefix() instead of
starts_with() is more elegant and abstracts away the details.

Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
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

 commit.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..668c703 100644
--- a/commit.c
+++ b/commit.c
@@ -548,7 +548,7 @@ define_commit_slab(author_date_slab, unsigned long);
 static void record_author_date(struct author_date_slab *author_date,
 			       struct commit *commit)
 {
-	const char *buf, *line_end;
+	const char *buf, *line_end, *skip;
 	char *buffer = NULL;
 	struct ident_split ident;
 	char *date_end;
@@ -566,14 +566,15 @@ static void record_author_date(struct author_date_slab *author_date,
 	     buf;
 	     buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
-		if (!starts_with(buf, "author ")) {
+		if (!(skip = skip_prefix(buf, "author "))) {
 			if (!line_end[0] || line_end[1] == '\n')
 				return; /* end of header */
 			continue;
 		}
+		buf = skip;
 		if (split_ident_line(&ident,
-				     buf + strlen("author "),
-				     line_end - (buf + strlen("author "))) ||
+				     buf,
+				     line_end - buf) ||
 		    !ident.date_begin || !ident.date_end)
 			goto fail_exit; /* malformed "author" line */
 		break;
@@ -1193,9 +1194,9 @@ static void parse_gpg_output(struct signature_check *sigc)
 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 		const char *found, *next;
 
-		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
+		if (found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1)) {
 			/* At the very beginning of the buffer */
-			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
+			;
 		} else {
 			found = strstr(buf, sigcheck_gpg_status[i].check);
 			if (!found)
-- 
1.9.0
