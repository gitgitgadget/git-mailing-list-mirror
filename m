From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] patch-id.c: use strbuf instead of a fixed buffer
Date: Wed, 21 Sep 2011 14:42:22 +0200
Message-ID: <4E79DBAE.5090505@elegosoft.com>
References: <1316541771-sup-9996@pimlott.net> <7vehzb5602.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 14:43:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6M8q-0007jL-O6
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 14:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671Ab1IUMnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 08:43:04 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:57308 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571Ab1IUMnC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 08:43:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 1742EDE81E;
	Wed, 21 Sep 2011 14:43:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y7FdMrguX2Pi; Wed, 21 Sep 2011 14:42:56 +0200 (CEST)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 2515FDE81B;
	Wed, 21 Sep 2011 14:42:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <7vehzb5602.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181842>

get_one_patchid() uses a rather dumb heuristic to determine if the
passed buffer is part of the next commit. Whenever the first 40 bytes
are a valid hexadecimal sha1 representation, get_one_patchid() returns
next_sha1.
Once the current line is longer than the fixed buffer, this will break
(provided the additional bytes make a valid hexadecimal sha1). As a result
patch-id returns incorrect results. Instead, user strbuf and read one
line at a time.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 builtin/patch-id.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index f821eb3..3cfe02d 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -56,13 +56,13 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	return 1;
 }
 
-static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
+static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct strbuf *line_buf)
 {
-	static char line[1000];
 	int patchlen = 0, found_next = 0;
 	int before = -1, after = -1;
 
-	while (fgets(line, sizeof(line), stdin) != NULL) {
+	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
+		char *line = line_buf->buf;
 		char *p = line;
 		int len;
 
@@ -133,14 +133,16 @@ static void generate_id_list(void)
 	unsigned char sha1[20], n[20];
 	git_SHA_CTX ctx;
 	int patchlen;
+	struct strbuf line_buf = STRBUF_INIT;
 
 	git_SHA1_Init(&ctx);
 	hashclr(sha1);
 	while (!feof(stdin)) {
-		patchlen = get_one_patchid(n, &ctx);
+		patchlen = get_one_patchid(n, &ctx, &line_buf);
 		flush_current_id(patchlen, sha1, &ctx);
 		hashcpy(sha1, n);
 	}
+	strbuf_release(&line_buf);
 }
 
 static const char patch_id_usage[] = "git patch-id < patch";
-- 
1.7.7.rc2.365.g55c1f
