From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 4/4] bundle: use a strbuf to scan the log for boundary commits
Date: Thu, 23 Feb 2012 10:42:24 +0100
Message-ID: <97490978be559ba10466c90ed499fd8fc64a9d8b.1329988335.git.trast@student.ethz.ch>
References: <cover.1329988335.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 10:42:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0VCC-0007ak-6M
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 10:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab2BWJmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 04:42:38 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:34756 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab2BWJme (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 04:42:34 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 23 Feb
 2012 10:42:32 +0100
Received: from thomas.inf.ethz.ch (129.132.209.211) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 23 Feb
 2012 10:42:33 +0100
X-Mailer: git-send-email 1.7.9.1.430.g4998543
In-Reply-To: <cover.1329988335.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.209.211]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191340>

The first part of the bundle header contains the boundary commits, and
could be approximated by

  # v2 git bundle
  $(git rev-list --pretty=oneline --boundary <ARGS> | grep ^-)

git-bundle actually spawns exactly this rev-list invocation, and does
the grepping internally.

There was a subtle bug in the latter step: it used fgets() with a
1024-byte buffer.  If the user has sufficiently long subjects (e.g.,
by not adhering to the git oneline-subject convention in the first
place), the 'oneline' format can easily overflow the buffer.  fgets()
then returns only the first part of the line _without a \n_, and it
would be printed as such, turning the next line into trailing garbage.
On top of that, fgets() returns the rest of the line in the next
call(s).  If one of these remaining parts starts with '-', git-bundle
would mistakenly insert it into the boundary list.

Fix it by using strbuf_getwholeline() instead, which handles arbitrary
line lengths correctly.

Note that on the receiving side in parse_bundle_header() we were
already using strbuf_getwholeline_fd(), so that part is safe.

Thanks to Peff, Johannes Sixt and Junio for suggestions.

Reported-by: Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 bundle.c          |   15 ++++++++-------
 t/t5704-bundle.sh |   16 ++++++++++++++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/bundle.c b/bundle.c
index 313de42..7a760db 100644
--- a/bundle.c
+++ b/bundle.c
@@ -234,7 +234,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
 	const char **argv_pack = xmalloc(6 * sizeof(const char *));
 	int i, ref_count = 0;
-	char buffer[1024];
+	struct strbuf buf = STRBUF_INIT;
 	struct rev_info revs;
 	struct child_process rls;
 	FILE *rls_fout;
@@ -266,20 +266,21 @@ int create_bundle(struct bundle_header *header, const char *path,
 	if (start_command(&rls))
 		return -1;
 	rls_fout = xfdopen(rls.out, "r");
-	while (fgets(buffer, sizeof(buffer), rls_fout)) {
+	while (strbuf_getwholeline(&buf, rls_fout, '\n') != EOF) {
 		unsigned char sha1[20];
-		if (buffer[0] == '-') {
-			write_or_die(bundle_fd, buffer, strlen(buffer));
-			if (!get_sha1_hex(buffer + 1, sha1)) {
+		if (buf.len > 0 && buf.buf[0] == '-') {
+			write_or_die(bundle_fd, buf.buf, buf.len);
+			if (!get_sha1_hex(buf.buf + 1, sha1)) {
 				struct object *object = parse_object(sha1);
 				object->flags |= UNINTERESTING;
-				add_pending_object(&revs, object, buffer);
+				add_pending_object(&revs, object, buf.buf);
 			}
-		} else if (!get_sha1_hex(buffer, sha1)) {
+		} else if (!get_sha1_hex(buf.buf, sha1)) {
 			struct object *object = parse_object(sha1);
 			object->flags |= SHOWN;
 		}
 	}
+	strbuf_release(&buf);
 	fclose(rls_fout);
 	if (finish_command(&rls))
 		return error("rev-list died");
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index f35f559..a51c8b0 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -42,4 +42,20 @@ test_expect_success 'empty bundle file is rejected' '
 	test_must_fail git fetch empty-bundle
 '
 
+# This triggers a bug in older versions where the resulting line (with
+# --pretty=oneline) was longer than a 1024-char buffer.
+test_expect_success 'ridiculously long subject in boundary' '
+	: >file4 &&
+	test_tick &&
+	git add file4 &&
+	printf "%01200d\n" 0 | git commit -F - &&
+	test_commit fifth &&
+	git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
+	git bundle list-heads long-subject-bundle.bdl >heads &&
+	test -s heads &&
+	git fetch long-subject-bundle.bdl &&
+	sed -n "/^-/{p;q}" long-subject-bundle.bdl >boundary &&
+	grep "^-$_x40 " boundary
+'
+
 test_done
-- 
1.7.9.1.430.g4998543
