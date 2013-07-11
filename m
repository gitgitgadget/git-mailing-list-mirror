From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [RFC PATCH] During a shallow fetch, prevent sending over unneeded
 objects
Date: Fri, 12 Jul 2013 00:01:27 +0200
Message-ID: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 00:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxOvh-0005yi-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab3GKWBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:01:33 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:60585 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab3GKWBc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:01:32 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1UxOvX-0006IS-K3
	for git@vger.kernel.org; Fri, 12 Jul 2013 00:01:31 +0200
Received: (nullmailer pid 24205 invoked by uid 1000);
	Thu, 11 Jul 2013 22:01:27 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230134>

Hi folks,

while playing with shallow fetches, I've found that in some
circumstances running git fetch with --depth can return too many objects
(in particular, _all_ the objects for the requested revisions are
returned, even when some of those objects are already known to the
client).

This happens when a client issues a fetch with a depth bigger or equal
to the number of commits the server is ahead of the client. In this
case, the revisions to be sent over will be completely detached from any
revisions the client already has (history-wise), causing the server to
effectively ignore all objects the client has (as advertised using its
have lines) and just send over _all_ objects (needed for the revisions
it is sending over).

I've traced this down to the way do_rev_list in upload-pack.c works. If
I've poured over the code enough to understand it, this is what happens:
 - The new shallow roots are made into graft points without parents.
 - The "want" commits are added to the pending list (revs->pending)
 - The "have" commits are marked uninteresting and added to the pending list
 - prepare_revision_walk is called, which adds everything from the
   pending list into the commmit list (revs->commits)
 - limit_list is called, which traverses the history of each interesting
   commit in the commit list (i.e., all want revisions), up to excluding
   the first uninteresting commit (i.e. a have revision). The result of
   this is the new commit list.

   This means the commit list now contains all commits that the client
   wants, up to (excluding) any commits he already has or up to
   (including) any (new) shallow roots.
 - mark_edges_uninteresting is called, which marks the tree of every
   parent of each edge in the commit list as uninteresting (in practice,
   this marks the tree of each uninteresting parent, since those are by
   definition the only kinds of revisions that can be beyond the edge).
 - All trees and blobs that are referenced by trees in the commit list
   but are not marked as uninteresting, are passed to git-pack-objects
   to put into the pack.

Normally, the list of commits to send over is connected to the
client's existing commits (which are marked as uninteresting). This
means that only the trees of those uninteresting ("have") commits that
are actually (direct) predecessors of the commits to send over are
marked as uninteresting. This is probably useful, since it prevents
having to go over all trees the client has (for other branches, for
example) and instead limits to the trees that are the most likely to
contain duplicate (or similar, for delta-ing) objects.

However, in the "detached shallow fetch" case, this assumption is no
longer valid. There will be no uninteresting commits as parents for
the commit list, since all edge commits will be shallow roots (hence
have no parents).  Ideally, one would find out which of the "detached"
"have" revisions are the closest to the new shallow roots, but with the
current code these shallow roots have their parents cut off long before
this code even runs, so this is probably not feasible.

Instead, what we can do in this case, is simply mark the trees of all
"have" commits as uninteresting. This prevents all objects that are
contained in the "have" commits themselves from being sent to the
client, which can be a big win for bigger repositories. Marking them all
is is probably more work than strictly needed, but is easy to implement.

I have created a mockup patch which does this, and also adds a test case
demonstrating the problem. Right now, the above fix is applied always,
even in cases where it isn't needed.

Looking at the code, I think it would be good to let
mark_edges_uninteresting look for shallow roots in the commit list (or
perhaps just add another loop over the commit list inside do_rev_list)
and only apply the fix if any shallow roots are in the commit list
(meaning at least a part of the history to send over is detached from
the clients current history). I haven't implemented this yet, wanting to
get some feedback first.

Also, I'm not quite sure how this fits in with the concept of "thin
packs". There might be some opportunities missing here as well, though
git-pack-objects is called without --thin when shallow roots are
involved. I think this is related to the "-" prefixed commit sha's that
are sent to git-pack-objects, but I couldn't found any documentation on
what the - prefix is supposed to mean.

(On a somewhat related note, show_commit in upload-pack.c checks the
BOUNDARY flag, but AFAICS the revs->boundary flag is never set, so
BOUNDARY cannot ever be set in this case either?)

How does this patch look?

Gr.

Matthijs

---
 t/t5500-fetch-pack.sh | 11 +++++++++++
 upload-pack.c         |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index fd2598e..a022d65 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -393,6 +393,17 @@ test_expect_success 'fetch in shallow repo unreachable shallow objects' '
 		git fsck --no-dangling
 	)
 '
+test_expect_success 'fetch creating new shallow root' '
+	(
+		git clone "file://$(pwd)/." shallow10 &&
+		git commit --allow-empty -m empty &&
+		cd shallow10 &&
+		git fetch --depth=1 --progress 2> actual &&
+		# This should fetch only the empty commit, no tree or
+		# blob objects
+		grep "remote: Total 1" actual
+	)
+'
 
 test_expect_success 'setup tests for the --stdin parameter' '
 	for head in C D E F
diff --git a/upload-pack.c b/upload-pack.c
index 59f43d1..5885f33 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -122,6 +122,14 @@ static int do_rev_list(int in, int out, void *user_data)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
+	/* In case we create a new shallow root, make sure that all
+	 * we don't send over objects that the client already has just
+	 * because their "have" revisions are no longer reachable from
+	 * the shallow root. */
+	for (i = 0; i < have_obj.nr; i++) {
+		struct commit *commit = (struct commit *)have_obj.objects[i].item;
+		mark_tree_uninteresting(commit->tree);
+	}
 	if (use_thin_pack)
 		for (i = 0; i < extra_edge_obj.nr; i++)
 			fprintf(pack_pipe, "-%s\n", sha1_to_hex(
-- 
1.8.3.2.736.ge92bb95.dirty
