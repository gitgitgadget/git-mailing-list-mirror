From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [WIP PATCH] revision-walking: allow iterating revisions multiple
	times
Date: Wed, 24 Aug 2011 23:14:31 +0200
Message-ID: <20110824211431.GH45292@book.hvoigt.net>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com> <1313791728-11328-2-git-send-email-iveqy@iveqy.com> <7vwre9yodc.fsf@alter.siamese.dyndns.org> <7vippszj70.fsf@alter.siamese.dyndns.org> <7vmxf3xnsf.fsf@alter.siamese.dyndns.org> <20110822194728.GA11745@sandbox-rc> <7vd3fxulw8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 23:14:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwKmU-0006px-LJ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 23:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab1HXVOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 17:14:34 -0400
Received: from darksea.de ([83.133.111.250]:35988 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752042Ab1HXVOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 17:14:33 -0400
Received: (qmail 5595 invoked from network); 24 Aug 2011 23:14:31 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Aug 2011 23:14:31 +0200
Content-Disposition: inline
In-Reply-To: <7vd3fxulw8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180041>

---
Hi,

On Mon, Aug 22, 2011 at 03:22:31PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Junio since you are one person listed in the api docs could you maybe
> > quickly explain to me what this flag is used for?
> 
> It is used in order to avoid walking the object we have walked already.
> 
> Which in turn means that once you walk chain of objects, unless you
> remember the ones you walked and clear the marks after you are done, you
> cannot walk the object chain for unrelated purposes.  See how functions
> like get_merge_bases_many() walk portions of graph for their own purpose
> and then avoid disrupting others by calling clear_commit_marks(). The use
> of TMP_MARK (and its clearing after the function is done with the marked
> objects) in remove_duplicate_parents() serve the same purpose.

What do you think about this approach ? Its not yet correctly collecting
revisions for all situations but it fixes the demonstrated test failure.

 revision.c  |   24 ++++++++++++++++++++++++
 revision.h  |    3 +++
 submodule.c |    3 +++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index c46cfaa..e374c4a 100644
--- a/revision.c
+++ b/revision.c
@@ -500,6 +500,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 				continue;
 			p->object.flags |= SEEN;
 			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (revs->fill_reset_list)
+				add_object_array(&p->object, NULL, &revs->walked);
 		}
 		return 0;
 	}
@@ -527,6 +529,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
 			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (revs->fill_reset_list)
+				add_object_array(&p->object, NULL, &revs->walked);
 		}
 		if (revs->first_parent_only)
 			break;
@@ -1950,6 +1954,23 @@ static void set_children(struct rev_info *revs)
 	}
 }
 
+void reset_revision_walk(struct rev_info *revs)
+{
+	int nr = revs->walked.nr;
+	struct object_array_entry *e = revs->walked.objects;
+
+	/* reset the seen flags set by prepare_revision_walk */
+	while (--nr >= 0) {
+		struct object *o = e->item;
+		o->flags &= ~(ALL_REV_FLAGS);
+		e++;
+	}
+	free(revs->walked.objects);
+	revs->walked.nr = 0;
+	revs->walked.alloc = 0;
+	revs->walked.objects = NULL;
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int nr = revs->pending.nr;
@@ -1964,6 +1985,9 @@ int prepare_revision_walk(struct rev_info *revs)
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
+				if (revs->fill_reset_list)
+					add_object_array(&commit->object, NULL,
+							 &revs->walked);
 				commit_list_insert_by_date(commit, &revs->commits);
 			}
 		}
diff --git a/revision.h b/revision.h
index 3d64ada..6a0fa99 100644
--- a/revision.h
+++ b/revision.h
@@ -28,6 +28,7 @@ struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
 	struct object_array pending;
+	struct object_array walked;
 
 	/* Parents of shown commits */
 	struct object_array boundary_commits;
@@ -72,6 +73,7 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1;
+	unsigned int	fill_reset_list:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
@@ -169,6 +171,7 @@ extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ct
 				 const char * const usagestr[]);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
 
+extern void reset_revision_walk(struct rev_info *revs);
 extern int prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
 extern char *get_revision_mark(const struct rev_info *revs, const struct commit *commit);
diff --git a/submodule.c b/submodule.c
index dc95498..410d8e4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -441,6 +441,7 @@ static int inspect_superproject_commits(unsigned char new_sha1[20], const char *
 
 	strbuf_addf(&remotes_arg, "--remotes=%s", remotes_name);
 	init_revisions(&rev, NULL);
+	rev.fill_reset_list = 1;
 	sha1_copy = xstrdup(sha1_to_hex(new_sha1));
 	argv[1] = sha1_copy;
 	argv[3] = remotes_arg.buf;
@@ -451,6 +452,8 @@ static int inspect_superproject_commits(unsigned char new_sha1[20], const char *
 	while ((commit = get_revision(&rev)) && do_continue)
 		do_continue = commit_need_pushing(commit, commit->parents, func, data);
 
+
+	reset_revision_walk(&rev);
 	free(sha1_copy);
 	strbuf_release(&remotes_arg);
 
-- 
1.7.6.553.g84dc
