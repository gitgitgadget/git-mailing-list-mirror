From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] checkout,clone: check return value of create_symref
Date: Tue, 12 Jan 2016 04:57:34 -0500
Message-ID: <20160112095734.GA16501@sigill.intra.peff.net>
References: <20160112095638.GA4773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 10:57:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIvhu-0006mC-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 10:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761405AbcALJ5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 04:57:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:52003 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753204AbcALJ5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 04:57:37 -0500
Received: (qmail 21210 invoked by uid 102); 12 Jan 2016 09:57:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 04:57:37 -0500
Received: (qmail 11539 invoked by uid 107); 12 Jan 2016 09:57:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 04:57:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 04:57:34 -0500
Content-Disposition: inline
In-Reply-To: <20160112095638.GA4773@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283783>

It's unlikely that we would fail to create or update a
symbolic ref (especially HEAD), but if we do, we should
notice and complain. Note that there's no need to give more
details in our error message; create_symref will already
have done so.

While we're here, let's also fix a minor memory leak in
clone.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c               |  3 ++-
 builtin/clone.c                  | 11 +++++++----
 t/t2011-checkout-invalid-head.sh |  6 ++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e8110a9..5af84a3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -661,7 +661,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
 	} else if (new->path) {	/* Switch branches. */
-		create_symref("HEAD", new->path, msg.buf);
+		if (create_symref("HEAD", new->path, msg.buf) < 0)
+			die("unable to update HEAD");
 		if (!opts->quiet) {
 			if (old->path && !strcmp(new->path, old->path)) {
 				if (opts->new_branch_force)
diff --git a/builtin/clone.c b/builtin/clone.c
index a0b3cd9..a7c8def 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -636,9 +636,11 @@ static void update_remote_refs(const struct ref *refs,
 		struct strbuf head_ref = STRBUF_INIT;
 		strbuf_addstr(&head_ref, branch_top);
 		strbuf_addstr(&head_ref, "HEAD");
-		create_symref(head_ref.buf,
-			      remote_head_points_at->peer_ref->name,
-			      msg);
+		if (create_symref(head_ref.buf,
+				  remote_head_points_at->peer_ref->name,
+				  msg) < 0)
+			die("unable to update %s", head_ref.buf);
+		strbuf_release(&head_ref);
 	}
 }
 
@@ -648,7 +650,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	const char *head;
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
-		create_symref("HEAD", our->name, NULL);
+		if (create_symref("HEAD", our->name, NULL) < 0)
+			die("unable to update HEAD");
 		if (!option_bare) {
 			update_ref(msg, "HEAD", our->old_oid.hash, NULL, 0,
 				   UPDATE_REFS_DIE_ON_ERR);
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index 300f8bf..d444d5e 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -19,4 +19,10 @@ test_expect_success 'checkout master from invalid HEAD' '
 	git checkout master --
 '
 
+test_expect_success 'checkout notices failure to lock HEAD' '
+	test_when_finished "rm -f .git/HEAD.lock" &&
+	>.git/HEAD.lock &&
+	test_must_fail git checkout -b other
+'
+
 test_done
-- 
2.7.0.368.g04bc9ee
