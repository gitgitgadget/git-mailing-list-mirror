From: Jeff King <peff@peff.net>
Subject: Re: A local shared clone is now much slower
Date: Mon, 8 Jul 2013 03:30:41 -0400
Message-ID: <20130708073041.GA25072@sigill.intra.peff.net>
References: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus <torvalds@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: git-owner@vger.kernel.org Mon Jul 08 09:30:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw5uO-0008JN-0p
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 09:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761Ab3GHHas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 03:30:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:55187 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab3GHHar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 03:30:47 -0400
Received: (qmail 6819 invoked by uid 102); 8 Jul 2013 07:31:59 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Jul 2013 02:31:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jul 2013 03:30:41 -0400
Content-Disposition: inline
In-Reply-To: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229826>

On Mon, Jul 08, 2013 at 01:03:55PM +1000, Stephen Rothwell wrote:

> So commit 0433ad128c59 ("clone: run check_everything_connected") (which
> turned up with v1.8.3) added a large traversal to clone which (as the
> comment said) makes a clone much slower.  It is especially noticeable on
> "git clone -s -l -n" which I use every day and used to be almost
> instant.  Is there any thought to making it fast again, please?
> 
> The above clone is very useful for working with different branches in one
> tree without touching every file in the main branch you are working
> with (and consequent issues with rebuilding at least).  As linux-next
> maintainer, you can imagine that I do this a bit.

Yeah, I have noticed it is somewhat annoying, as well, because the
proportion of time taken for the check is so much larger compared to the
relatively instant time taken for the local shared clone.

The point of that commit is to add the same safety checks to clone that
we do for fetching. But in the local shared-repo case, I really feel
like all safety bets are off anyway. You are not creating a verified
redundant copy at all, and there are still corruptions that can sneak
through (e.g., bit corruptions of blob objects).

So maybe this:

-- >8 --
Subject: [PATCH] clone: drop connectivity check for local clones

Commit 0433ad1 (clone: run check_everything_connected,
2013-03-25) added the same connectivity check to clone that
we use for fetching. The intent was to provide enough safety
checks that "git clone git://..." could be counted on to
detect bit errors and other repo corruption, and not
silently propagate them to the clone.

For local clones, this turns out to be a bad idea, for two
reasons:

  1. Local clones use hard linking (or even shared object
     stores), and so complete far more quickly. The time
     spent on the connectivity check is therefore
     proportionally much more painful.

  2. Local clones do not actually meet our safety guarantee
     anyway. The connectivity check makes sure we have all
     of the objects we claim to, but it does not check for
     bit errors. We will notice bit errors in commits and
     trees, but we do not load blob objects at all. Whereas
     over the pack transport, we actually recompute the sha1
     of each object in the incoming packfile; bit errors
     change the sha1 of the object, which is then caught by
     the connectivity check.

This patch drops the connectivity check in the local case.
Note that we have to revert the changes from 0433ad1 to
t5710, as we no longer notice the corruption during clone.

We could go a step further and provide a "verify even local
clones" option, but it is probably not worthwhile. You can
already spell that as "cd foo.git && git fsck && git clone ."
or as "git clone --no-local foo.git".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c           | 22 +++++++++++++---------
 t/t5710-info-alternate.sh |  8 +++++++-
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 14b1323..dafb6b5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -545,17 +545,20 @@ static void update_remote_refs(const struct ref *refs,
 			       const struct ref *remote_head_points_at,
 			       const char *branch_top,
 			       const char *msg,
-			       struct transport *transport)
+			       struct transport *transport,
+			       int check_connectivity)
 {
 	const struct ref *rm = mapped_refs;
 
-	if (0 <= option_verbosity)
-		printf(_("Checking connectivity... "));
-	if (check_everything_connected_with_transport(iterate_ref_map,
-						      0, &rm, transport))
-		die(_("remote did not send all necessary objects"));
-	if (0 <= option_verbosity)
-		printf(_("done\n"));
+	if (check_connectivity) {
+		if (0 <= option_verbosity)
+			printf(_("Checking connectivity... "));
+		if (check_everything_connected_with_transport(iterate_ref_map,
+							      0, &rm, transport))
+			die(_("remote did not send all necessary objects"));
+		if (0 <= option_verbosity)
+			printf(_("done\n"));
+	}
 
 	if (refs) {
 		write_remote_refs(mapped_refs);
@@ -963,7 +966,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_fetch_refs(transport, mapped_refs);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
-			   branch_top.buf, reflog_msg.buf, transport);
+			   branch_top.buf, reflog_msg.buf, transport,
+			   !is_local);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 8956c21..5a6e49d 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -58,7 +58,13 @@ git clone -l -s F G &&
 git clone -l -s D E &&
 git clone -l -s E F &&
 git clone -l -s F G &&
-test_must_fail git clone --bare -l -s G H'
+git clone --bare -l -s G H'
+
+test_expect_success 'invalidity of deepest repository' \
+'cd H && {
+	test_valid_repo
+	test $? -ne 0
+}'
 
 cd "$base_dir"
 
-- 
1.8.3.rc3.24.gec82cb9
