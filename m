From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH/RFC 2/3] rerere: make recording of the preimage reusable
Date: Sat, 21 Nov 2009 20:01:06 +0100
Message-ID: <200911212001.06207.j6t@kdbg.org>
References: <200911211958.40872.j6t@kdbg.org> <200911212000.19326.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 21:56:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwsI-00041R-AO
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbZKUTBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 14:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbZKUTBK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 14:01:10 -0500
Received: from [93.83.142.38] ([93.83.142.38]:62852 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753967AbZKUTBK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 14:01:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3FD4419F6A3;
	Sat, 21 Nov 2009 20:01:06 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <200911212000.19326.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133409>

This factors the code that computes the conflict hash and records the
preimage into a helper function.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 rerere.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/rerere.c b/rerere.c
index 84d0bb7..11fef88 100644
--- a/rerere.c
+++ b/rerere.c
@@ -229,6 +229,25 @@ static int find_conflict(struct string_list *conflict)
 	return 0;
 }
 
+static int record_preimage(struct string_list *rr, const char *path, int force)
+{
+	unsigned char sha1[20];
+	char *hex;
+	int ret;
+
+	ret = handle_file(path, sha1, NULL);
+	if (ret < 1)
+		return -1;
+
+	hex = xstrdup(sha1_to_hex(sha1));
+	string_list_insert(path, rr)->util = hex;
+	if (mkdir(git_path("rr-cache/%s", hex), 0755) && !force)
+		return -1;
+
+	handle_file(path, NULL, rerere_path(hex, "preimage"));
+	return 0;
+}
+
 static int merge(const char *name, const char *path)
 {
 	int ret;
@@ -310,17 +329,8 @@ static int do_plain_rerere(struct string_list *rr,
 	for (i = 0; i < conflict.nr; i++) {
 		const char *path = conflict.items[i].string;
 		if (!string_list_has_string(rr, path)) {
-			unsigned char sha1[20];
-			char *hex;
-			int ret;
-			ret = handle_file(path, sha1, NULL);
-			if (ret < 1)
-				continue;
-			hex = xstrdup(sha1_to_hex(sha1));
-			string_list_insert(path, rr)->util = hex;
-			if (mkdir(git_path("rr-cache/%s", hex), 0755))
+			if (record_preimage(rr, path, 0))
 				continue;
-			handle_file(path, NULL, rerere_path(hex, "preimage"));
 			fprintf(stderr, "Recorded preimage for '%s'\n", path);
 		}
 	}
-- 
1.6.5.2.182.ge039a
