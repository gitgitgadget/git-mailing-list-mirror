From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/12] rerere.c: use symbolic constants to keep track of
 parsing states
Date: Fri, 29 Aug 2008 17:42:36 -0700
Message-ID: <1220056963-2352-6-git-send-email-gitster@pobox.com>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <1220056963-2352-2-git-send-email-gitster@pobox.com>
 <1220056963-2352-3-git-send-email-gitster@pobox.com>
 <1220056963-2352-4-git-send-email-gitster@pobox.com>
 <1220056963-2352-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:44:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZt-00076v-5k
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbYH3AnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYH3AnB
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:43:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbYH3AnA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:43:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5B0F57A07
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EDAA357A06 for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:58
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
In-Reply-To: <1220056963-2352-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 984AF00A-762C-11DD-B316-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94346>

These hardcoded integers make the code harder to follow than necessary;
replace them with enums to make it easier to read, before adding support
for optionally parsing "diff3 -m" style conflict markers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/rerere.c b/rerere.c
index 323e493..bf74b26 100644
--- a/rerere.c
+++ b/rerere.c
@@ -75,7 +75,10 @@ static int handle_file(const char *path,
 {
 	SHA_CTX ctx;
 	char buf[1024];
-	int hunk = 0, hunk_no = 0;
+	int hunk_no = 0;
+	enum {
+		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2,
+	} hunk = RR_CONTEXT;
 	struct strbuf one, two;
 	FILE *f = fopen(path, "r");
 	FILE *out = NULL;
@@ -98,20 +101,20 @@ static int handle_file(const char *path,
 	strbuf_init(&two,  0);
 	while (fgets(buf, sizeof(buf), f)) {
 		if (!prefixcmp(buf, "<<<<<<< ")) {
-			if (hunk)
+			if (hunk != RR_CONTEXT)
 				goto bad;
-			hunk = 1;
+			hunk = RR_SIDE_1;
 		} else if (!prefixcmp(buf, "=======") && isspace(buf[7])) {
-			if (hunk != 1)
+			if (hunk != RR_SIDE_1)
 				goto bad;
-			hunk = 2;
+			hunk = RR_SIDE_2;
 		} else if (!prefixcmp(buf, ">>>>>>> ")) {
-			if (hunk != 2)
+			if (hunk != RR_SIDE_2)
 				goto bad;
 			if (strbuf_cmp(&one, &two) > 0)
 				strbuf_swap(&one, &two);
 			hunk_no++;
-			hunk = 0;
+			hunk = RR_CONTEXT;
 			if (out) {
 				fputs("<<<<<<<\n", out);
 				fwrite(one.buf, one.len, 1, out);
@@ -127,9 +130,9 @@ static int handle_file(const char *path,
 			}
 			strbuf_reset(&one);
 			strbuf_reset(&two);
-		} else if (hunk == 1)
+		} else if (hunk == RR_SIDE_1)
 			strbuf_addstr(&one, buf);
-		else if (hunk == 2)
+		else if (hunk == RR_SIDE_2)
 			strbuf_addstr(&two, buf);
 		else if (out)
 			fputs(buf, out);
@@ -146,7 +149,7 @@ static int handle_file(const char *path,
 		fclose(out);
 	if (sha1)
 		SHA1_Final(sha1, &ctx);
-	if (hunk) {
+	if (hunk != RR_CONTEXT) {
 		if (output)
 			unlink(output);
 		return error("Could not parse conflict hunks in %s", path);
-- 
1.6.0.1.149.ga4c44
