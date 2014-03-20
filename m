From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: [PATCH] diff: optimise parse_dirstat_params() to only compare strings when necessary
Date: Thu, 20 Mar 2014 02:07:56 +0200
Message-ID: <1395274076-6720-1-git-send-email-dragos.foianu@gmail.com>
Cc: Dragos Foianu <dragos.foianu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 01:08:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQQX2-0003NG-OI
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 01:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbaCTAIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 20:08:20 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:52978 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933813AbaCTAIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 20:08:20 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so57958eek.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 17:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=l0t2s5Wl9+YBTXb4HmZYu/MFkE4i6oRpz+mb8nrMWsU=;
        b=NI9QRTny0W4Bmuj51dx2HDOkp2I00FAputsWeoTJsB6kYp6td/ugrx/20pVup2pKCD
         ETRlFtfPKhUB07xmQuci9aiEcQi7K6x3YHT0ohdFlbpZnK0tDhVVHsdLlENgCq1rDOdv
         EDWwxaqUFEoD67UPaha95I9kE3Tg8P4HmL9zABNxQF98HyF90YLBBlN04c4EJyNVmJLE
         0XuEwmOjUr7AHnWxQMnQ1j71O8dLaFd+lAbsuDpVIKjDonLXRv01K5YgzKe9vliuzjVr
         E7UABCaRbfn+3UeNGo7jMnArlLrJv9JYj5SGCoq7K72VVnyrW7Z3puNNuVrpMNAQGeDM
         Iuww==
X-Received: by 10.14.213.135 with SMTP id a7mr38732819eep.57.1395274097904;
        Wed, 19 Mar 2014 17:08:17 -0700 (PDT)
Received: from localhost.localdomain ([109.100.93.176])
        by mx.google.com with ESMTPSA id 48sm327214eei.24.2014.03.19.17.08.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Mar 2014 17:08:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244508>

parse_dirstat_params() goes through a chain of if statements using
strcmp to parse parameters. When the parameter is a digit, the
value must go through all comparisons before the function realises
it is a digit. Optimise this logic by only going through the chain
of string compares when the parameter is not a digit.

Signed-off-by: Dragos Foianu <dragos.foianu@gmail.com>
---
 diff.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/diff.c b/diff.c
index e343191..733764e 100644
--- a/diff.c
+++ b/diff.c
@@ -84,20 +84,25 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 		string_list_split_in_place(&params, params_copy, ',', -1);
 	for (i = 0; i < params.nr; i++) {
 		const char *p = params.items[i].string;
-		if (!strcmp(p, "changes")) {
-			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
-			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
-		} else if (!strcmp(p, "lines")) {
-			DIFF_OPT_SET(options, DIRSTAT_BY_LINE);
-			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
-		} else if (!strcmp(p, "files")) {
-			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
-			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
-		} else if (!strcmp(p, "noncumulative")) {
-			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
-		} else if (!strcmp(p, "cumulative")) {
-			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
-		} else if (isdigit(*p)) {
+		if (!isdigit(*p)) {
+			if (!strcmp(p, "changes")) {
+				DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
+				DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
+			} else if (!strcmp(p, "lines")) {
+				DIFF_OPT_SET(options, DIRSTAT_BY_LINE);
+				DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
+			} else if (!strcmp(p, "files")) {
+				DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
+				DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
+			} else if (!strcmp(p, "noncumulative")) {
+				DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
+			} else if (!strcmp(p, "cumulative")) {
+				DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
+			} else {
+				strbuf_addf(errmsg, _("  Unknown dirstat parameter '%s'\n"), p);
+				ret++;
+			}
+		} else  {
 			char *end;
 			int permille = strtoul(p, &end, 10) * 10;
 			if (*end == '.' && isdigit(*++end)) {
@@ -114,11 +119,7 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 					    p);
 				ret++;
 			}
-		} else {
-			strbuf_addf(errmsg, _("  Unknown dirstat parameter '%s'\n"), p);
-			ret++;
 		}
-
 	}
 	string_list_clear(&params, 0);
 	free(params_copy);
-- 
1.8.3.2
