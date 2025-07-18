Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD40C214A9E
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831559; cv=none; b=N7Y30OpkW88yuduUnJv9GYYxb2PzMBQNNAsxvsSp8UYVy+2dwwhd2wcv7opuP9km22aZNc7wq47SuLzjtPiUovh5YWrjpbFh0/qdLaAjoI5CyC51GXPQU4IHGO2ktt6BZsdzWoyBD6vKyTLeNznFvgaczT/zc/WTlIbb3rFc5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831559; c=relaxed/simple;
	bh=myDJjb5jYg08LAmg2msPMXR8jDqbfPZV0HRQq5gIZoY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ht6oEbIClB9SM+lZVqatfg6rk2awZ5DZrcgfdTlN8jJjQ+etoHLQUAavYbBpbQLg9idum8nKRKGErnGBNP94mMED3lI3te5F8eTPwCF6c0nYXs6CQpzv4/6eKKc02DYnX5G402w8q+fv5gZWMG4XctVOn6SOmulAD7VRCnD/x9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=JAy15O4T; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="JAy15O4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752831547; x=1753436347; i=l.s.r@web.de;
	bh=OE8A+arT7BUR79p5SE64cCw0Yx37nNAG/RFrZGUXIqs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JAy15O4T64UsjcoaypiKkQINt/Y5Yh+sWkQI4rYQUeNdKujQSF7VPqJM+ayCh7vz
	 J/1kvXsF5pn8RzwQ0G0qVM7RzIJHVaslZqPhbWMwTEowDMY3Z+05/177+BS9djHpC
	 o52/P+QH7cCUQ4K4+Tmft7+gDABPHQ7yG/sgWLaDiVM7AE7+PA2TM3euzxZT5boPY
	 JJ4AuoBbUtuZ1JrFvdkquoQL9ANnSYRCDCahz+XlAbLIPVys7wZQ5wasDWJ4onoss
	 Bog6U+PMon4VVjhk9a5ay7HGVlXWKqurArYKGW6B6qZkYMQrcMxLQa8ZHOKzv3zY6
	 GYDSexTzStuSxXp7Hw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MvKXV-1uumdf3OEL-014lH8; Fri, 18
 Jul 2025 11:39:06 +0200
Message-ID: <5d7c631a-ae94-4a59-b4ee-8161b5136d86@web.de>
Date: Fri, 18 Jul 2025 11:39:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/3] commit: convert pop_most_recent_commit() to prio_queue
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Justin Tobler <jltobler@gmail.com>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
Content-Language: en-US
In-Reply-To: <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1J+sdANjyHiZ+CVH7S3615QOMvjOfN3/TURE7w1o1ldkNNh1gpr
 aV5y6mbdJLB6Sa1djFfH/2UWyDIXKgL6fepT4nbxwrYNyKXow9EznTAujOaeoBu4vvWFy6m
 8KTDyXe9Eor44aZWsAmzVh9t9uRAzc1+8uaGqIaTzArIaUaCZPAGVmtf17sKvExouFofpFN
 5GyD712/JSTCJvAUxLnZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RdSLkeGVseY=;VCSxMYRp2Hnio2qjeSGF/5Xh6ze
 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

pop_most_recent_commit() calls commit_list_insert_by_date() for parent
commits, which is itself called in a loop.  This can lead to quadratic
complexity if there are many merges.  Replace the commit_list with a
prio_queue to ensure logarithmic worst case complexity and convert all
three users.

Add a performance test that exercises one of them using a pathological
history that consists of 50% merges and 50% root commits to demonstrate
the speedup:

Test                          v2.50.1           HEAD
=2D---------------------------------------------------------------------
1501.2: rev-parse ':/65535'   2.48(2.47+0.00)   0.20(0.19+0.00) -91.9%

Alas, sane histories don't benefit from the conversion much, and
traversing Git's own history takes a 1% performance hit on my machine:

   $ hyperfine -w3 -L git ./git_2.50.1,./git '{git} rev-parse :/^Initial.r=
evision'
   Benchmark 1: ./git_2.50.1 rev-parse :/^Initial.revision
     Time (mean =C2=B1 =CF=83):      1.071 s =C2=B1  0.004 s    [User: 1.0=
52 s, System: 0.017 s]
     Range (min =E2=80=A6 max):    1.067 s =E2=80=A6  1.078 s    10 runs

   Benchmark 2: ./git rev-parse :/^Initial.revision
     Time (mean =C2=B1 =CF=83):      1.079 s =C2=B1  0.003 s    [User: 1.0=
60 s, System: 0.017 s]
     Range (min =E2=80=A6 max):    1.074 s =E2=80=A6  1.083 s    10 runs

   Summary
     ./git_2.50.1 rev-parse :/^Initial.revision ran
       1.01 =C2=B1 0.00 times faster than ./git rev-parse :/^Initial.revis=
ion

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c                          |  7 +--
 commit.h                          |  8 ++--
 fetch-pack.c                      | 13 +++---
 object-name.c                     | 10 ++---
 t/meson.build                     |  1 +
 t/perf/p1501-rev-parse-oneline.sh | 71 +++++++++++++++++++++++++++++++
 walker.c                          | 11 +++--
 7 files changed, 100 insertions(+), 21 deletions(-)
 create mode 100755 t/perf/p1501-rev-parse-oneline.sh

diff --git a/commit.c b/commit.c
index 15115125c3..f4712ad9a7 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -31,6 +31,7 @@
 #include "parse.h"
 #include "object-file.h"
 #include "object-file-convert.h"
+#include "prio-queue.h"
=20
 static struct commit_extra_header *read_commit_extra_header_lines(const c=
har *buf, size_t len, const char **);
=20
@@ -739,17 +740,17 @@ void commit_list_sort_by_date(struct commit_list **l=
ist)
 	commit_list_sort(list, commit_list_compare_by_date);
 }
=20
-struct commit *pop_most_recent_commit(struct commit_list **list,
+struct commit *pop_most_recent_commit(struct prio_queue *queue,
 				      unsigned int mark)
 {
-	struct commit *ret =3D pop_commit(list);
+	struct commit *ret =3D prio_queue_get(queue);
 	struct commit_list *parents =3D ret->parents;
=20
 	while (parents) {
 		struct commit *commit =3D parents->item;
 		if (!repo_parse_commit(the_repository, commit) && !(commit->object.flag=
s & mark)) {
 			commit->object.flags |=3D mark;
-			commit_list_insert_by_date(commit, list);
+			prio_queue_put(queue, commit);
 		}
 		parents =3D parents->next;
 	}
diff --git a/commit.h b/commit.h
index 70c870dae4..9630c076d6 100644
=2D-- a/commit.h
+++ b/commit.h
@@ -201,10 +201,10 @@ const char *repo_logmsg_reencode(struct repository *=
r,
=20
 const char *skip_blank_lines(const char *msg);
=20
-/** Removes the first commit from a list sorted by date, and adds all
- * of its parents.
- **/
-struct commit *pop_most_recent_commit(struct commit_list **list,
+struct prio_queue;
+
+/* Removes the first commit from a prio_queue and adds its parents. */
+struct commit *pop_most_recent_commit(struct prio_queue *queue,
 				      unsigned int mark);
=20
 struct commit *pop_commit(struct commit_list **stack);
diff --git a/fetch-pack.c b/fetch-pack.c
index 5e74235fc0..8ad5bf2931 100644
=2D-- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -34,6 +34,7 @@
 #include "commit-graph.h"
 #include "sigchain.h"
 #include "mergesort.h"
+#include "prio-queue.h"
=20
 static int transfer_unpack_limit =3D -1;
 static int fetch_unpack_limit =3D -1;
@@ -601,7 +602,7 @@ static int find_common(struct fetch_negotiator *negoti=
ator,
 	return count ? retval : 0;
 }
=20
-static struct commit_list *complete;
+static struct prio_queue complete =3D { compare_commits_by_commit_date };
=20
 static int mark_complete(const struct object_id *oid)
 {
@@ -609,7 +610,7 @@ static int mark_complete(const struct object_id *oid)
=20
 	if (commit && !(commit->object.flags & COMPLETE)) {
 		commit->object.flags |=3D COMPLETE;
-		commit_list_insert(commit, &complete);
+		prio_queue_put(&complete, commit);
 	}
 	return 0;
 }
@@ -626,9 +627,12 @@ static int mark_complete_oid(const char *refname UNUS=
ED,
 static void mark_recent_complete_commits(struct fetch_pack_args *args,
 					 timestamp_t cutoff)
 {
-	while (complete && cutoff <=3D complete->item->date) {
+	while (complete.nr) {
+		struct commit *item =3D prio_queue_peek(&complete);
+		if (item->date < cutoff)
+			break;
 		print_verbose(args, _("Marking %s as complete"),
-			      oid_to_hex(&complete->item->object.oid));
+			      oid_to_hex(&item->object.oid));
 		pop_most_recent_commit(&complete, COMPLETE);
 	}
 }
@@ -798,7 +802,6 @@ static void mark_complete_and_common_ref(struct fetch_=
negotiator *negotiator,
 		refs_for_each_rawref(get_main_ref_store(the_repository),
 				     mark_complete_oid, NULL);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
-		commit_list_sort_by_date(&complete);
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
 	}
diff --git a/object-name.c b/object-name.c
index ddafe7f9b1..41930609e3 100644
=2D-- a/object-name.c
+++ b/object-name.c
@@ -28,6 +28,7 @@
 #include "commit-reach.h"
 #include "date.h"
 #include "object-file-convert.h"
+#include "prio-queue.h"
=20
 static int get_oid_oneline(struct repository *r, const char *, struct obj=
ect_id *,
 			   const struct commit_list *);
@@ -1461,7 +1462,7 @@ static int get_oid_oneline(struct repository *r,
 			   const char *prefix, struct object_id *oid,
 			   const struct commit_list *list)
 {
-	struct commit_list *copy =3D NULL, **copy_tail =3D &copy;
+	struct prio_queue copy =3D { compare_commits_by_commit_date };
 	const struct commit_list *l;
 	int found =3D 0;
 	int negative =3D 0;
@@ -1483,9 +1484,9 @@ static int get_oid_oneline(struct repository *r,
=20
 	for (l =3D list; l; l =3D l->next) {
 		l->item->object.flags |=3D ONELINE_SEEN;
-		copy_tail =3D &commit_list_insert(l->item, copy_tail)->next;
+		prio_queue_put(&copy, l->item);
 	}
-	while (copy) {
+	while (copy.nr) {
 		const char *p, *buf;
 		struct commit *commit;
 		int matches;
@@ -1507,7 +1508,7 @@ static int get_oid_oneline(struct repository *r,
 	regfree(&regex);
 	for (l =3D list; l; l =3D l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
-	free_commit_list(copy);
+	clear_prio_queue(&copy);
 	return found ? 0 : -1;
 }
=20
@@ -2061,7 +2062,6 @@ static enum get_oid_result get_oid_with_context_1(st=
ruct repository *repo,
 			cb.list =3D &list;
 			refs_for_each_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			refs_head_ref(get_main_ref_store(repo), handle_one_ref, &cb);
-			commit_list_sort_by_date(&list);
 			ret =3D get_oid_oneline(repo, name + 2, oid, list);
=20
 			free_commit_list(list);
diff --git a/t/meson.build b/t/meson.build
index 1af289425d..660d780dcc 100644
=2D-- a/t/meson.build
+++ b/t/meson.build
@@ -1116,6 +1116,7 @@ benchmarks =3D [
   'perf/p1450-fsck.sh',
   'perf/p1451-fsck-skip-list.sh',
   'perf/p1500-graph-walks.sh',
+  'perf/p1501-rev-parse-oneline.sh',
   'perf/p2000-sparse-operations.sh',
   'perf/p3400-rebase.sh',
   'perf/p3404-rebase-interactive.sh',
diff --git a/t/perf/p1501-rev-parse-oneline.sh b/t/perf/p1501-rev-parse-on=
eline.sh
new file mode 100755
index 0000000000..538fa9c404
=2D-- /dev/null
+++ b/t/perf/p1501-rev-parse-oneline.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+test_description=3D'Test :/ object name notation'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+#
+# Creates lots of merges to make history traversal costly.  In
+# particular it creates 2^($max_level-1)-1 2-way merges on top of
+# 2^($max_level-1) root commits.  E.g., the commit history looks like
+# this for a $max_level of 3:
+#
+#     _1_
+#    /   \
+#   2     3
+#  / \   / \
+# 4   5 6   7
+#
+# The numbers are the fast-import marks, which also are the commit
+# messages.  1 is the HEAD commit and a merge, 2 and 3 are also merges,
+# 4-7 are the root commits.
+#
+build_history () {
+	local max_level=3D"$1" &&
+	local level=3D"${2:-1}" &&
+	local mark=3D"${3:-1}" &&
+	if test $level -eq $max_level
+	then
+		echo "reset refs/heads/master" &&
+		echo "from $ZERO_OID" &&
+		echo "commit refs/heads/master" &&
+		echo "mark :$mark" &&
+		echo "committer C <c@example.com> 1234567890 +0000" &&
+		echo "data <<EOF" &&
+		echo "$mark" &&
+		echo "EOF"
+	else
+		local level1=3D$((level+1)) &&
+		local mark1=3D$((2*mark)) &&
+		local mark2=3D$((2*mark+1)) &&
+		build_history $max_level $level1 $mark1 &&
+		build_history $max_level $level1 $mark2 &&
+		echo "commit refs/heads/master" &&
+		echo "mark :$mark" &&
+		echo "committer C <c@example.com> 1234567890 +0000" &&
+		echo "data <<EOF" &&
+		echo "$mark" &&
+		echo "EOF" &&
+		echo "from :$mark1" &&
+		echo "merge :$mark2"
+	fi
+}
+
+test_expect_success 'setup' '
+	build_history 16 | git fast-import &&
+	git log --format=3D"%H %s" --reverse >commits &&
+	sed -n -e "s/ .*$//p" -e "q" <commits >expect &&
+	sed -n -e "s/^.* //p" -e "q" <commits >needle
+'
+
+test_perf "rev-parse :/$(cat needle)" '
+	git rev-parse :/$(cat needle) >actual
+'
+
+test_expect_success 'verify result' '
+	test_cmp expect actual
+'
+
+test_done
diff --git a/walker.c b/walker.c
index d131af04c7..8073754517 100644
=2D-- a/walker.c
+++ b/walker.c
@@ -14,6 +14,7 @@
 #include "blob.h"
 #include "refs.h"
 #include "progress.h"
+#include "prio-queue.h"
=20
 static struct object_id current_commit_oid;
=20
@@ -78,7 +79,7 @@ static int process_tree(struct walker *walker, struct tr=
ee *tree)
 #define SEEN		(1U << 1)
 #define TO_SCAN		(1U << 2)
=20
-static struct commit_list *complete =3D NULL;
+static struct prio_queue complete =3D { compare_commits_by_commit_date };
=20
 static int process_commit(struct walker *walker, struct commit *commit)
 {
@@ -87,7 +88,10 @@ static int process_commit(struct walker *walker, struct=
 commit *commit)
 	if (repo_parse_commit(the_repository, commit))
 		return -1;
=20
-	while (complete && complete->item->date >=3D commit->date) {
+	while (complete.nr) {
+		struct commit *item =3D prio_queue_peek(&complete);
+		if (item->date < commit->date)
+			break;
 		pop_most_recent_commit(&complete, COMPLETE);
 	}
=20
@@ -233,7 +237,7 @@ static int mark_complete(const char *path UNUSED,
=20
 	if (commit) {
 		commit->object.flags |=3D COMPLETE;
-		commit_list_insert(commit, &complete);
+		prio_queue_put(&complete, commit);
 	}
 	return 0;
 }
@@ -302,7 +306,6 @@ int walker_fetch(struct walker *walker, int targets, c=
har **target,
 	if (!walker->get_recover) {
 		refs_for_each_ref(get_main_ref_store(the_repository),
 				  mark_complete, NULL);
-		commit_list_sort_by_date(&complete);
 	}
=20
 	for (i =3D 0; i < targets; i++) {
=2D-=20
2.50.1
