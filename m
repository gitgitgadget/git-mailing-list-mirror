From: Junio C Hamano <junkio@cox.net>
Subject: Re: A note on merging conflicts..
Date: Fri, 07 Jul 2006 01:26:47 -0700
Message-ID: <7vejwx3jnc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 10:27:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fylfp-0000RA-R6
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 10:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWGGI0t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 04:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWGGI0t
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 04:26:49 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:55204 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750716AbWGGI0s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 04:26:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707082648.EIND8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 04:26:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23415>

Linus Torvalds <torvalds@osdl.org> writes:

> One thing that is _very_ useful to do is to do when you have a conflict is 
> this:
>
> 	git log -p HEAD MERGE_BASE..MERGE_HEAD -- conflicting-filename
>
> so that I wouldn't have to type that by hand ever again, and doing a
>
> 	git log -p --merge drivers/
>
> would automatically give me exactly that for all the unmerged files in 
> drivers/.
>
> Anybody want to try to make me happy, and learn some git internals at the 
> same time?

I was hoping somebody else would come forward, but it's been a
week, so here it is.

-- >8 --
[PATCH] git log -p --merge [[--] paths...]

This adds Linus's wish, "--merge" flag, which makes the above
expand to a rough equivalent to:

	git log -p HEAD MERGE_HEAD ^$(git-merge-base HEAD MERGE_HEAD) \
		-- $(git-ls-files -u [paths...] | cut -f2 | uniq)

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 revision.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 27fc1e3..e7128f2 100644
--- a/revision.c
+++ b/revision.c
@@ -548,6 +548,49 @@ static void add_pending_commit_list(stru
 	}
 }
 
+static void prepare_show_merge(struct rev_info *revs)
+{
+	struct commit_list *bases;
+	struct commit *head, *other;
+	unsigned char sha1[20];
+	const char **prune = NULL;
+	int i, prune_num = 1; /* counting terminating NULL */
+
+	if (get_sha1("HEAD", sha1) || !(head = lookup_commit(sha1)))
+		die("--merge without HEAD?");
+	if (get_sha1("MERGE_HEAD", sha1) || !(other = lookup_commit(sha1)))
+		die("--merge without MERGE_HEAD?");
+	add_pending_object(revs, &head->object, "HEAD");
+	add_pending_object(revs, &other->object, "MERGE_HEAD");
+	bases = get_merge_bases(head, other, 1);
+	while (bases) {
+		struct commit *it = bases->item;
+		struct commit_list *n = bases->next;
+		free(bases);
+		bases = n;
+		it->object.flags |= UNINTERESTING;
+		add_pending_object(revs, &it->object, "(merge-base)");
+	}
+
+	if (!active_nr)
+		read_cache();
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (!ce_stage(ce))
+			continue;
+		if (ce_path_match(ce, revs->prune_data)) {
+			prune_num++;
+			prune = xrealloc(prune, sizeof(*prune) * prune_num);
+			prune[prune_num-2] = ce->name;
+			prune[prune_num-1] = NULL;
+		}
+		while ((i+1 < active_nr) &&
+		       ce_same_name(ce, active_cache[i+1]))
+			i++;
+	}
+	revs->prune_data = prune;
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -557,7 +600,7 @@ static void add_pending_commit_list(stru
  */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
 {
-	int i, flags, seen_dashdash;
+	int i, flags, seen_dashdash, show_merge;
 	const char **unrecognized = argv + 1;
 	int left = 1;
 
@@ -574,7 +617,7 @@ int setup_revisions(int argc, const char
 		break;
 	}
 
-	flags = 0;
+	flags = show_merge = 0;
 	for (i = 1; i < argc; i++) {
 		struct object *object;
 		const char *arg = argv[i];
@@ -641,6 +684,10 @@ int setup_revisions(int argc, const char
 				def = argv[i];
 				continue;
 			}
+			if (!strcmp(arg, "--merge")) {
+				show_merge = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--topo-order")) {
 				revs->topo_order = 1;
 				continue;
@@ -861,6 +908,8 @@ int setup_revisions(int argc, const char
 		object = get_reference(revs, arg, sha1, flags ^ local_flags);
 		add_pending_object(revs, object, arg);
 	}
+	if (show_merge)
+		prepare_show_merge(revs);
 	if (def && !revs->pending.nr) {
 		unsigned char sha1[20];
 		struct object *object;
-- 
1.4.1.g4d2af
