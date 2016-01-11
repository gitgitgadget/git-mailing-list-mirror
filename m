From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] checkout,clone: check return value of create_symref
Date: Mon, 11 Jan 2016 10:49:35 -0500
Message-ID: <20160111154935.GA22778@sigill.intra.peff.net>
References: <20160111154651.GA25338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 16:49:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIej0-0007Ad-BN
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 16:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760151AbcAKPti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 10:49:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:51224 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760084AbcAKPti (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 10:49:38 -0500
Received: (qmail 32105 invoked by uid 102); 11 Jan 2016 15:49:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 10:49:37 -0500
Received: (qmail 707 invoked by uid 107); 11 Jan 2016 15:49:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 10:49:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jan 2016 10:49:35 -0500
Content-Disposition: inline
In-Reply-To: <20160111154651.GA25338@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283658>

It's unlikely that we would fail to create or update a
symbolic ref (especially HEAD), but if we do, we should
notice and complain. Note that there's no need to give more
details in our error message; create_symref will already
have done so.

While we're here, let's also fix a minor memory leak in
clone.

Signed-off-by: Jeff King <peff@peff.net>
---
This patch could go to maint. I don't know if it's worth the trouble. I
was unable to figure out a way to trigger this reliably (hence no
tests). The two ways I considered were:

  - "chmod -w .git", but it results in a die() already

  - the bug I'm fixing in 2/2; but we don't want to rely on that in our
    test suite, since I'm about to fix it. :-/

 builtin/checkout.c |  3 ++-
 builtin/clone.c    | 11 +++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

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
-- 
2.7.0.368.g04bc9ee
