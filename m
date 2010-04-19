From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 1/2] patch-id: extract parsing one diff out of generate_id_list
Date: Mon, 19 Apr 2010 10:46:13 +0200
Message-ID: <1271666774-11619-1-git-send-email-bonzini@gnu.org>
References: <7vfx2ubxz1.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 19 10:46:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3mca-0004rg-Qk
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 10:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab0DSIqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 04:46:18 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:38110 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab0DSIqR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 04:46:17 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.69)
	(envelope-from <bonzini@gnu.org>)
	id 1O3mcS-00021a-LB; Mon, 19 Apr 2010 04:46:16 -0400
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <7vfx2ubxz1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145282>

This simplifies a bit the next patch, since it will have more than one
condition to exit the loop.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
        On 04/17/2010 04:43 AM, Junio C Hamano wrote:
        > Paolo Bonzini<bonzini@gnu.org>  writes:
        > 
        >> I use this when I had to edit the file-being-sent, e.g. to add cover
        >> letters or an introduction to a patch series.  Since some time passes
        >> between format-patch and send-email, I want to test that the file I'm
        >> sending is exactly what I have in the repository, and that I'm not
        >> submitting the wrong series.
        > 
        > Ok, that is what I missed when I mentioned ignore-if-in-upstream, iow,
        > I thought "patch-cmp" were merely to check for failed detection of
        > duplicates by format-patch.  If you are editing the mbox file and let
        > the patches sit there while origin/master may be progressing, then
        > that is an entirely different story.

        Yes, that is exactly the point.  I sometimes have to edit the mbox file
        so I cannot use "git send-email origin/master..", and I want a double
        check that I'm not doing something stupid.

 builtin/patch-id.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index af0911e..78d24dc 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -28,16 +28,11 @@ static int remove_space(char *line)
 	return dst - line;
 }
 
-static void generate_id_list(void)
+int get_one_patchid (unsigned char *next_sha1, git_SHA_CTX *ctx)
 {
-	static unsigned char sha1[20];
 	static char line[1000];
-	git_SHA_CTX ctx;
 	int patchlen = 0;
-
-	git_SHA1_Init(&ctx);
 	while (fgets(line, sizeof(line), stdin) != NULL) {
-		unsigned char n[20];
 		char *p = line;
 		int len;
 
@@ -46,12 +41,8 @@ static void generate_id_list(void)
 		else if (!memcmp(line, "commit ", 7))
 			p += 7;
 
-		if (!get_sha1_hex(p, n)) {
-			flush_current_id(patchlen, sha1, &ctx);
-			hashcpy(sha1, n);
-			patchlen = 0;
-			continue;
-		}
+		if (!get_sha1_hex(p, next_sha1))
+			break;
 
 		/* Ignore commit comments */
 		if (!patchlen && memcmp(line, "diff ", 5))
@@ -68,9 +59,25 @@ static void generate_id_list(void)
 		/* Compute the sha without whitespace */
 		len = remove_space(line);
 		patchlen += len;
-		git_SHA1_Update(&ctx, line, len);
+		git_SHA1_Update(ctx, line, len);
+	}
+	return patchlen;
+}
+
+
+static void generate_id_list(void)
+{
+	unsigned char sha1[20], n[20];
+	git_SHA_CTX ctx;
+	int patchlen;
+
+	git_SHA1_Init(&ctx);
+	while (!feof (stdin)) {
+		memset (n, 0, 20);
+		patchlen = get_one_patchid (n, &ctx);
+		flush_current_id(patchlen, sha1, &ctx);
+		hashcpy (sha1, n);
 	}
-	flush_current_id(patchlen, sha1, &ctx);
 }
 
 static const char patch_id_usage[] = "git patch-id < patch";
-- 
1.6.6.1
