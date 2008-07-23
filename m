From: Junio C Hamano <gitster@pobox.com>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 10:59:10 -0700
Message-ID: <7vy73seb2p.fsf@gitster.siamese.dyndns.org>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann>
 <20080723140441.GA9537@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:00:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLidQ-0000j5-Bl
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbYGWR7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 13:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYGWR7T
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:59:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbYGWR7S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2008 13:59:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 64F993402E;
	Wed, 23 Jul 2008 13:59:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0CCF63402B; Wed, 23 Jul 2008 13:59:12 -0400 (EDT)
In-Reply-To: <20080723140441.GA9537@elte.hu> (Ingo Molnar's message of "Wed,
 23 Jul 2008 16:04:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 11694662-58E1-11DD-9D89-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89724>

Ingo Molnar <mingo@elte.hu> writes:

> * SZEDER G=C3=A1bor <szeder@ira.uka.de> wrote:
>
>> you cound use 'git branch --no-merged' to list only those branches
>> that have not been merged into your current HEAD.
>
> hm, it's very slow:

Yeah, --no-merged and --merged were done in a quite na=C3=AFve way.

The patch needs to be cleaned up by splitting it into multiple steps:

 (1) discard everything outside refs/heads and refs/remotes in append_r=
ef();
     why do we even have code to deal with refs/tags to begin with???

 (2) change ref_item->sha1 to ref_item->commit (and make has_commit() t=
ake
     struct commit);

 (3) teach merge_filter code not to do has_commit() for each ref, but u=
se
     revision traversal machinery to compute everything in parallel and=
 in
     one traversal.

but other than that, this seems to pass the tests, and is obviously
correct ;-)

With an artificial repository that has "master" and 1000 test-$i branch=
es
where they were created by "git branch test-$i master~$i":

(with patch)
$ /usr/bin/time git-branch --no-merged master >/dev/null
0.12user 0.02system 0:00.15elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
0inputs+0outputs (0major+1588minor)pagefaults 0swaps

$ /usr/bin/time git-branch --no-merged test-200 >/dev/null
0.15user 0.03system 0:00.18elapsed 100%CPU (0avgtext+0avgdata 0maxresid=
ent)k
0inputs+0outputs (0major+1711minor)pagefaults 0swaps

(without patch)
$ /usr/bin/time git-branch --no-merged master >/dev/null
0.69user 0.03system 0:00.72elapsed 100%CPU (0avgtext+0avgdata 0maxresid=
ent)k
0inputs+0outputs (0major+2229minor)pagefaults 0swaps

$ /usr/bin/time git-branch --no-merged test-200 >/dev/null
0.58user 0.03system 0:00.61elapsed 100%CPU (0avgtext+0avgdata 0maxresid=
ent)k
0inputs+0outputs (0major+2248minor)pagefaults 0swaps

---

 builtin-branch.c |   68 ++++++++++++++++++++++++++++++++--------------=
-------
 1 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index b885bd1..788e70a 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -13,6 +13,8 @@
 #include "remote.h"
 #include "parse-options.h"
 #include "branch.h"
+#include "diff.h"
+#include "revision.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -181,25 +183,21 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds)
 struct ref_item {
 	char *name;
 	unsigned int kind;
-	unsigned char sha1[20];
+	struct commit *commit;
 };
=20
 struct ref_list {
+	struct rev_info revs;
 	int index, alloc, maxwidth;
 	struct ref_item *list;
 	struct commit_list *with_commit;
 	int kinds;
 };
=20
-static int has_commit(const unsigned char *sha1, struct commit_list *w=
ith_commit)
+static int has_commit(struct commit *commit, struct commit_list *with_=
commit)
 {
-	struct commit *commit;
-
 	if (!with_commit)
 		return 1;
-	commit =3D lookup_commit_reference_gently(sha1, 1);
-	if (!commit)
-		return 0;
 	while (with_commit) {
 		struct commit *other;
=20
@@ -215,6 +213,7 @@ static int append_ref(const char *refname, const un=
signed char *sha1, int flags,
 {
 	struct ref_list *ref_list =3D (struct ref_list*)(cb_data);
 	struct ref_item *newitem;
+	struct commit *commit;
 	int kind =3D REF_UNKNOWN_TYPE;
 	int len;
 	static struct commit_list branch;
@@ -226,13 +225,15 @@ static int append_ref(const char *refname, const =
unsigned char *sha1, int flags,
 	} else if (!prefixcmp(refname, "refs/remotes/")) {
 		kind =3D REF_REMOTE_BRANCH;
 		refname +=3D 13;
-	} else if (!prefixcmp(refname, "refs/tags/")) {
-		kind =3D REF_TAG;
-		refname +=3D 10;
-	}
+	} else
+		return 0;
+
+	commit =3D lookup_commit_reference_gently(sha1, 1);
+	if (!commit)
+		return error("branch '%s' does not point at a commit", refname);
=20
 	/* Filter with with_commit if specified */
-	if (!has_commit(sha1, ref_list->with_commit))
+	if (!has_commit(commit, ref_list->with_commit))
 		return 0;
=20
 	/* Don't add types the caller doesn't want */
@@ -243,30 +244,25 @@ static int append_ref(const char *refname, const =
unsigned char *sha1, int flags,
 		branch.item =3D lookup_commit_reference_gently(sha1, 1);
 		if (!branch.item)
 			die("Unable to lookup tip of branch %s", refname);
-		if (merge_filter =3D=3D SHOW_NOT_MERGED &&
-		    has_commit(merge_filter_ref, &branch))
-			return 0;
-		if (merge_filter =3D=3D SHOW_MERGED &&
-		    !has_commit(merge_filter_ref, &branch))
-			return 0;
+		add_pending_object(&ref_list->revs,
+				   (struct object *)branch.item, refname);
 	}
=20
 	/* Resize buffer */
 	if (ref_list->index >=3D ref_list->alloc) {
 		ref_list->alloc =3D alloc_nr(ref_list->alloc);
 		ref_list->list =3D xrealloc(ref_list->list,
-				ref_list->alloc * sizeof(struct ref_item));
+					  ref_list->alloc * sizeof(struct ref_item));
 	}
=20
 	/* Record the new item */
 	newitem =3D &(ref_list->list[ref_list->index++]);
 	newitem->name =3D xstrdup(refname);
 	newitem->kind =3D kind;
-	hashcpy(newitem->sha1, sha1);
+	newitem->commit =3D commit;
 	len =3D strlen(newitem->name);
 	if (len > ref_list->maxwidth)
 		ref_list->maxwidth =3D len;
-
 	return 0;
 }
=20
@@ -309,7 +305,13 @@ static void print_ref_item(struct ref_item *item, =
int maxwidth, int verbose,
 {
 	char c;
 	int color;
-	struct commit *commit;
+	struct commit *commit =3D item->commit;
+
+	if (merge_filter !=3D NO_FILTER) {
+		int is_merged =3D !!(item->commit->object.flags & UNINTERESTING);
+		if (is_merged !=3D (merge_filter =3D=3D SHOW_MERGED))
+			return;
+	}
=20
 	switch (item->kind) {
 	case REF_LOCAL_BRANCH:
@@ -337,7 +339,7 @@ static void print_ref_item(struct ref_item *item, i=
nt maxwidth, int verbose,
 		strbuf_init(&subject, 0);
 		stat[0] =3D '\0';
=20
-		commit =3D lookup_commit(item->sha1);
+		commit =3D item->commit;
 		if (commit && !parse_commit(commit)) {
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
 					    &subject, 0, NULL, NULL, 0, 0);
@@ -350,7 +352,7 @@ static void print_ref_item(struct ref_item *item, i=
nt maxwidth, int verbose,
 		printf("%c %s%-*s%s %s %s%s\n", c, branch_get_color(color),
 		       maxwidth, item->name,
 		       branch_get_color(COLOR_BRANCH_RESET),
-		       find_unique_abbrev(item->sha1, abbrev),
+		       find_unique_abbrev(item->commit->object.sha1, abbrev),
 		       stat, sub);
 		strbuf_release(&subject);
 	} else {
@@ -363,22 +365,34 @@ static void print_ref_list(int kinds, int detache=
d, int verbose, int abbrev, str
 {
 	int i;
 	struct ref_list ref_list;
+	struct commit *head_commit =3D lookup_commit_reference_gently(head_sh=
a1, 1);
=20
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds =3D kinds;
 	ref_list.with_commit =3D with_commit;
+	if (merge_filter !=3D NO_FILTER)
+		init_revisions(&ref_list.revs, NULL);
 	for_each_ref(append_ref, &ref_list);
+	if (merge_filter !=3D NO_FILTER) {
+		struct commit *filter;
+		filter =3D lookup_commit_reference_gently(merge_filter_ref, 0);
+		filter->object.flags |=3D UNINTERESTING;
+		add_pending_object(&ref_list.revs,
+				   (struct object *) filter, "");
+		ref_list.revs.limited =3D 1;
+		prepare_revision_walk(&ref_list.revs);
+	}
=20
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp=
);
=20
 	detached =3D (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached && has_commit(head_sha1, with_commit)) {
+	if (detached && head_commit && has_commit(head_commit, with_commit)) =
{
 		struct ref_item item;
 		item.name =3D xstrdup("(no branch)");
 		item.kind =3D REF_LOCAL_BRANCH;
-		hashcpy(item.sha1, head_sha1);
+		item.commit =3D head_commit;
 		if (strlen(item.name) > ref_list.maxwidth)
-			      ref_list.maxwidth =3D strlen(item.name);
+			ref_list.maxwidth =3D strlen(item.name);
 		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1);
 		free(item.name);
 	}
