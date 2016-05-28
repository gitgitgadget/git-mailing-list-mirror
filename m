From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] patch-id: use starts_with() and skip_prefix()
Date: Sat, 28 May 2016 18:20:23 +0200
Message-ID: <5749C547.7040305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 18:21:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6gyy-00049b-45
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 18:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbcE1QUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 12:20:51 -0400
Received: from mout.web.de ([212.227.17.11]:59105 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829AbcE1QUu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 12:20:50 -0400
Received: from [192.168.178.36] ([79.213.120.97]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LzsGF-1bbc0Q263n-0155pM; Sat, 28 May 2016 18:20:25
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
X-Provags-ID: V03:K0:xz8MOZ6zddodU4AUknJRUriFbUa+v1a/mAmoe9vcNJzaFY9xn71
 z7glJvTmIjY5BsxfZlU0hsmbPQUu28SWIKemW4jAqj8KwWWT4IzdlMHfNRSL1/kVNsQPSNd
 GdOFdldGBghPPO/7fHVT6ZKtPHQPxhFEu9Uffv/RQZTIMRobqgUmSYUrwkkP7e9A9y2KYvb
 zHtlNRnL2Z3SOzdiNRxiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Vrd96/+8aU=:Amf3pM93NYuJHsRQmagJYa
 H4X5GCQ5pLiTOCmOdtwgVNb0ic/rIPm7DnVQUBjelVkRtDz1hVmej+9GrJgO+DM7pEP3SeOZg
 O6HQ1YNBtvVkMBTekiiQMXuyQzl4JytH9CnqNAdXceg1J5BcuzzPrizECfkVOi4EHX/weL+IH
 0C2q8npkxpEtkBrVDAmOmxMbhjcVJGNpFlkGGxV3uD0aHq+KCAiMUUh62SV0vSSGrMiZlm960
 YmDsdb0MP7lyrumRycZ5ln8lzsd3aDU5WPF2zeF8rqW9XqnT2br8RNYUdOYYzbnoCZSX8YEqa
 i6cVz74zqeLZ6jDAlBffDmQ+Q44eYpsEzZf/pcTI8KV0SrefjAbGgWgvftRmJCOpNfFLEScbX
 3H+Jl4yoA3qFgXtdMhcBnVFdoT/KZwE9D6zkM0S/iJTnc5DVPhOmZmkuokezBEpkZ5KzRgsIn
 +AP93p0vsH/8UOv24IKRoN3DcklQx/DyzM6hKlye9yEn5L0gAmwB8gHF0AYtamlPO0A7V51a7
 iBQphHEIP+6KAmLyP3JB6p+RmGULtfNiZMk5fu3XjRb4Cvuwe7TFSb5s391+YUhzuFFZ+w8n0
 1VXpajeVaVHYARrZl07pg0xY0xlFp7C8OgSwA8NDURPt+srQ+cGtuCd/RqgDVXBdcUjEk85T+
 e8vmAmkxyRzbqpjsfdfojAMlg/qLF7mvFYTa2vIKYyKyyfdnAquWrAj3gPjeOhY6ffnPlUrlg
 1h2UAbcQ9KKBgWg6WF61LzbXotxTSKqygRgaoujZVrZJzQ/WTw7L6Qkdvm+5lsCN8HJkqGZc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295829>

Get rid of magic numbers and avoid running over the end of a NUL
terminated string by using starts_with() and skip_prefix() instead
of memcmp().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/patch-id.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 366ce5a..a84d000 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -81,16 +81,13 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 
 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
 		char *line = line_buf->buf;
-		char *p = line;
+		const char *p = line;
 		int len;
 
-		if (!memcmp(line, "diff-tree ", 10))
-			p += 10;
-		else if (!memcmp(line, "commit ", 7))
-			p += 7;
-		else if (!memcmp(line, "From ", 5))
-			p += 5;
-		else if (!memcmp(line, "\\ ", 2) && 12 < strlen(line))
+		if (!skip_prefix(line, "diff-tree ", &p) &&
+		    !skip_prefix(line, "commit ", &p) &&
+		    !skip_prefix(line, "From ", &p) &&
+		    starts_with(line, "\\ ") && 12 < strlen(line))
 			continue;
 
 		if (!get_oid_hex(p, next_oid)) {
@@ -99,14 +96,14 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 		}
 
 		/* Ignore commit comments */
-		if (!patchlen && memcmp(line, "diff ", 5))
+		if (!patchlen && !starts_with(line, "diff "))
 			continue;
 
 		/* Parsing diff header?  */
 		if (before == -1) {
-			if (!memcmp(line, "index ", 6))
+			if (starts_with(line, "index "))
 				continue;
-			else if (!memcmp(line, "--- ", 4))
+			else if (starts_with(line, "--- "))
 				before = after = 1;
 			else if (!isalpha(line[0]))
 				break;
@@ -114,14 +111,14 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 
 		/* Looking for a valid hunk header?  */
 		if (before == 0 && after == 0) {
-			if (!memcmp(line, "@@ -", 4)) {
+			if (starts_with(line, "@@ -")) {
 				/* Parse next hunk, but ignore line numbers.  */
 				scan_hunk_header(line, &before, &after);
 				continue;
 			}
 
 			/* Split at the end of the patch.  */
-			if (memcmp(line, "diff ", 5))
+			if (!starts_with(line, "diff "))
 				break;
 
 			/* Else we're parsing another header.  */
-- 
2.8.3
