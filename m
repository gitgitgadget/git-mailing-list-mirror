From: Jeff King <peff@peff.net>
Subject: [PATCH 9/9] clone: run check_everything_connected
Date: Mon, 25 Mar 2013 16:26:27 -0400
Message-ID: <20130325202627.GI16019@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 21:26:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDys-0005P2-OI
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500Ab3CYU0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:26:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39358 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab3CYU0a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:26:30 -0400
Received: (qmail 27983 invoked by uid 107); 25 Mar 2013 20:28:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:28:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:26:27 -0400
Content-Disposition: inline
In-Reply-To: <20130325201427.GA15798@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219087>

When we fetch from a remote, we do a revision walk to make
sure that what we received is connected to our existing
history. We do not do the same check for clone, which should
be able to check that we received an intact history graph.

The upside of this patch is that it will make clone more
resilient against propagating repository corruption. The
downside is that we will now traverse "rev-list --objects
--all" down to the roots, which may take some time (it is
especially noticeable for a "--local --bare" clone).

Note that we need to adjust t5710, which tries to make such
a bogus clone. Rather than checking after the fact that our
clone is bogus, we can simplify it to just make sure "git
clone" reports failure.

Signed-off-by: Jeff King <peff@peff.net>
---
The slowdown is really quite terrible if you try "git clone --bare
linux-2.6.git". Even with this, the local-clone case already misses blob
corruption. So it probably makes sense to restrict it to just the
non-local clone case, which already has to do more work.

Even still, it adds a non-trivial amount of work (linux-2.6 takes
something like a minute to check). I don't like the idea of declaring
"git clone" non-safe unless you turn on transfer.fsckObjects, though. It
should have the same safety as "git fetch".

 builtin/clone.c              | 26 ++++++++++++++++++++++++++
 t/t1060-object-corruption.sh |  2 +-
 t/t5710-info-alternate.sh    |  8 +-------
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 7d48ef3..eceaa74 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,6 +23,7 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
+#include "connected.h"
 
 /*
  * Overall FIXMEs:
@@ -485,12 +486,37 @@ static void update_remote_refs(const struct ref *refs,
 	}
 }
 
+static int iterate_ref_map(void *cb_data, unsigned char sha1[20])
+{
+	struct ref **rm = cb_data;
+	struct ref *ref = *rm;
+
+	/*
+	 * Skip anything missing a peer_ref, which we are not
+	 * actually going to write a ref for.
+	 */
+	while (ref && !ref->peer_ref)
+		ref = ref->next;
+	/* Returning -1 notes "end of list" to the caller. */
+	if (!ref)
+		return -1;
+
+	hashcpy(sha1, ref->old_sha1);
+	*rm = ref->next;
+	return 0;
+}
+
 static void update_remote_refs(const struct ref *refs,
 			       const struct ref *mapped_refs,
 			       const struct ref *remote_head_points_at,
 			       const char *branch_top,
 			       const char *msg)
 {
+	const struct ref *rm = mapped_refs;
+
+	if (check_everything_connected(iterate_ref_map, 0, &rm))
+		die(_("remote did not send all necessary objects"));
+
 	if (refs) {
 		write_remote_refs(mapped_refs);
 		if (option_single_branch)
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 05ba4e7..fd314ef 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -79,7 +79,7 @@ test_expect_success 'clone --no-local --bare detects missing object' '
 	test_must_fail git clone --no-local --bare missing missing-transport
 '
 
-test_expect_failure 'clone --no-local --bare detects misnamed object' '
+test_expect_success 'clone --no-local --bare detects misnamed object' '
 	test_must_fail git clone --no-local --bare misnamed misnamed-transport
 '
 
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 5a6e49d..8956c21 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -58,13 +58,7 @@ git clone -l -s F G &&
 git clone -l -s D E &&
 git clone -l -s E F &&
 git clone -l -s F G &&
-git clone --bare -l -s G H'
-
-test_expect_success 'invalidity of deepest repository' \
-'cd H && {
-	test_valid_repo
-	test $? -ne 0
-}'
+test_must_fail git clone --bare -l -s G H'
 
 cd "$base_dir"
 
-- 
1.8.2.13.g0f18d3c
