From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] clone: add `--seed` shorthand
Date: Thu, 21 May 2015 00:16:20 -0400
Message-ID: <20150521041619.GC5196@peff.net>
References: <20150521041435.GA18978@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:16:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvHuF-0008UT-CZ
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbbEUEQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:16:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:33639 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751576AbbEUEQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:16:22 -0400
Received: (qmail 728 invoked by uid 102); 21 May 2015 04:16:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:16:22 -0500
Received: (qmail 30797 invoked by uid 107); 21 May 2015 04:16:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:16:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:16:20 -0400
Content-Disposition: inline
In-Reply-To: <20150521041435.GA18978@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269540>

The safe way to use `--reference` is to add in the recent
`--dissociate` option, which optimizes the initial clone,
but does not create any obligation to avoid pruning or
deleting the reference repository. However, it can be rather
tricky to explain why two options are necessary, and why
using `--reference` alone is unsafe.

This patch introduces a single option, `--seed`, which does
the right thing; we can steer users towards it rather than
explaining the complexities. It also provides a natural
interface if we later want to allow seeding from non-local
repositories.

Note that git-repack cannot selectively dissociate from
particular alternates. Therefore using `--reference` and
`--seed` together will dissociate from _all_ referenced
repositories. We issue a warning to the user in this case.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-clone.txt |  3 +++
 builtin/clone.c             | 12 +++++++++++-
 t/t5700-clone-reference.sh  |  6 ++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..ffeb03b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -107,6 +107,9 @@ objects from the source repository into a pack in the cloned repository.
 	transfer and stop borrowing from them after a clone is made
 	by making necessary local copies of borrowed objects.
 
+--seed <repository>::
+	A convenient shorthand for `--dissociate --reference=<repository>`.
+
 --quiet::
 -q::
 	Operate quietly.  Progress is not reported to the standard
diff --git a/builtin/clone.c b/builtin/clone.c
index a0ec1a9..dd53bbd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -49,6 +49,7 @@ static int option_verbosity;
 static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
+static struct string_list option_seed;
 static int option_dissociate;
 
 static struct option builtin_clone_options[] = {
@@ -78,6 +79,8 @@ static struct option builtin_clone_options[] = {
 			N_("reference repository")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
 		 N_("use --reference only while cloning")),
+	OPT_STRING_LIST(0, "seed", &option_seed, N_("repo"),
+			N_("reference and dissociate from repo")),
 	OPT_STRING('o', "origin", &option_origin, N_("name"),
 		   N_("use <name> instead of 'origin' to track upstream")),
 	OPT_STRING('b', "branch", &option_branch, N_("branch"),
@@ -263,6 +266,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 static void setup_reference(void)
 {
 	for_each_string_list(&option_reference, add_one_reference, NULL);
+	for_each_string_list(&option_seed, add_one_reference, NULL);
 }
 
 static void copy_alternates(struct strbuf *src, struct strbuf *dst,
@@ -884,7 +888,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
-	if (option_reference.nr)
+	if (option_seed.nr) {
+		if (option_reference.nr)
+			warning(_("--seed and --reference used together implies --dissociate"));
+		option_dissociate = 1;
+	}
+
+	if (option_reference.nr || option_seed.nr)
 		setup_reference();
 	else if (option_dissociate) {
 		warning(_("--dissociate given, but there is no --reference"));
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 3e783fc..80a794c 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -209,10 +209,12 @@ test_expect_success 'clone and dissociate from reference' '
 	) &&
 	git clone --no-local --reference=P Q R &&
 	git clone --no-local --reference=P --dissociate Q S &&
-	# removing the reference P would corrupt R but not S
+	git clone --no-local --seed=P Q T &&
+	# removing the reference P would corrupt R but not S or T
 	rm -fr P &&
 	test_must_fail git -C R fsck &&
-	git -C S fsck
+	git -C S fsck &&
+	git -C T fsck
 '
 
 test_done
-- 
2.4.1.528.g00591e3
