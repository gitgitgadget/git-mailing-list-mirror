From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] rerere forget: do not segfault if not all stages are present
Date: Thu, 04 Apr 2013 20:41:43 +0200
Message-ID: <515DC967.3060108@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:42:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNp74-0001PI-Mn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762258Ab3DDSlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:41:49 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:19963 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762136Ab3DDSls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:41:48 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2F482130045;
	Thu,  4 Apr 2013 20:41:45 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3D53019F549;
	Thu,  4 Apr 2013 20:41:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220059>

The loop that fills in the buffers that are later passed to the merge
driver exits early when not all stages of a path are present in the index.
But since the buffer pointers are not initialized in advance, the
subsequent accesses are undefined.

Initialize buffer pointers in advance to avoid undefined behavior later.

That is not sufficient, though, to get correct operation of handle_cache().
The function replays a conflicted merge to extract the part inside the
conflict markers. As written, the loop exits early when a stage is missing.
Consequently, the buffers for later stages that would be present in the
index are not filled in and the merge is replayed with incomplete data.

Fix it by investigating all stages of the given path.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This patch conflicts trivially with js/rerere-forget-protect-against-NUL
 (both add a test case at the end).

 rerere.c                  | 15 +++++++--------
 t/t2030-unresolve-info.sh | 13 +++++++++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/rerere.c b/rerere.c
index a6a5cd5..3d22cd2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -295,7 +295,7 @@ static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
 
 static int handle_cache(const char *path, unsigned char *sha1, const char *output)
 {
-	mmfile_t mmfile[3];
+	mmfile_t mmfile[3] = {{NULL}};
 	mmbuffer_t result = {NULL, 0};
 	struct cache_entry *ce;
 	int pos, len, i, hunk_no;
@@ -314,17 +314,16 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	for (i = 0; i < 3; i++) {
 		enum object_type type;
 		unsigned long size;
+		int j;
 
-		mmfile[i].size = 0;
-		mmfile[i].ptr = NULL;
 		if (active_nr <= pos)
 			break;
 		ce = active_cache[pos++];
-		if (ce_namelen(ce) != len || memcmp(ce->name, path, len)
-		    || ce_stage(ce) != i + 1)
-			break;
-		mmfile[i].ptr = read_sha1_file(ce->sha1, &type, &size);
-		mmfile[i].size = size;
+		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
+			continue;
+		j = ce_stage(ce) - 1;
+		mmfile[j].ptr = read_sha1_file(ce->sha1, &type, &size);
+		mmfile[j].size = size;
 	}
 	for (i = 0; i < 3; i++) {
 		if (!mmfile[i].ptr && !mmfile[i].size)
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index f262065..c0610b9 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -50,8 +50,11 @@ test_expect_success setup '
 	test_commit second fi/le second &&
 	git checkout side &&
 	test_commit third fi/le third &&
+	git branch add-add &&
 	git checkout another &&
 	test_commit fourth fi/le fourth &&
+	git checkout add-add &&
+	test_commit fifth add-differently &&
 	git checkout master
 '
 
@@ -167,4 +170,14 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rerere forget (add-add conflict)' '
+	git checkout -f master &&
+	echo master >add-differently &&
+	git add add-differently &&
+	git commit -m "add differently" &&
+	test_must_fail git merge fifth &&
+	git rerere forget add-differently 2>actual &&
+	test_i18ngrep "no remembered" actual
+'
+
 test_done
-- 
1.8.2.384.g92e0289
