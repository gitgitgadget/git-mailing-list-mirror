Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383C1531E8
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591081; cv=none; b=N7NAQNvwwc9QUMIFjGqRpeuozttr8D8wLO5wuG5W6EYfTh5gDFk7n9KuYqUnTzksaXdcBvd6QbppMhrCCJ9Bqx9kB1LEdLGafAGZBelVfu0pGtrlumZEHCS43dxnR6+GjdFzobz3PYS9572RqJUh5VNOsUW2k21G5fGNcVnggww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591081; c=relaxed/simple;
	bh=XBiWPRc6yWfrwYLez9aePRoyPRr73BlxryGYxELNn5Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sgj8zhrKsHQkzVMwH+WvsNAutJr8WHj3g8x0wF6kMgfMRQeV0fudVHa0UxoRw9CZLPWit53KnRByKoiqPlZnM88upXAodkDTliTZU0Ld33RUhK4ZA5WyIv+tbMBV17bwPGMs/Q+y7dHgQKUu7i1E+k1RLTbOQK6CYMqgG4PwGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZxWWuESU; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZxWWuESU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752591068; x=1753195868; i=l.s.r@web.de;
	bh=z0PGCoDT+qGH5PqRdSVT2isQ0EZc+8m7Z+U7LGPQfBo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZxWWuESUyCUcIpF8vZt1XUDEw9/9UrkgD71REjF22hBfu19ugTD4Iu6JghEcRbkA
	 wPYG7swBSaZrE4NGal1fznJueIYO+95IF30zqX7pdn4MM1DUckQSbb+7w682FgVUc
	 5MZUGx8EVO9s8IgBVMas+MdbsgfMb9UMnlRBUvomCAbEB6l2QcQsuw1oRH6U8jf07
	 uisFOxg1K8vE6iwgWyXqZ5FNV6rfWo29+G3fh5NxTpdTJ2Dx5eSPttQd1gC65PKu4
	 bWOCC3kY76vkz9veFS1VHks1nH6tfwoMiXqOQeur20FOrXsjyBo6/0ldN2gC0Sf9T
	 Q/WiB08tsh8rgOPmEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3oz4-1ukWeS1uro-00tUvS; Tue, 15
 Jul 2025 16:51:08 +0200
Message-ID: <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
Date: Tue, 15 Jul 2025 16:51:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] commit: convert pop_most_recent_commit() to prio_queue
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Content-Language: en-US
In-Reply-To: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/mI8zcTkq43OZcAtJcwsnM/w8H7sSbaxYjXNjKnl26yuVa88/J2
 StCtvBJOP8z8GNiwjyLHEEEFaxlnnL61i+7NxL8tW+jP5bBcMRRQWyyShtxa+rHhuII8zfB
 rCGdhvgALC+A6BTl9v0aJ7T9pMSi23qt9YKvo4kLnQ9zmjXQ7c0UmhR/DuUtuVpo6n0PVI0
 YaDRFSphyUG7uF/dscptw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X87FvAGDEiI=;dFRd5dUfT/QHRbxGECTmVF94mWZ
 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
 h1vy/km0gyuxLA1K29xQtZ5W7jb9PilAlrv

pop_most_recent_commit() calls commit_list_insert_by_date(), which and
is itself called in a loop, which can lead to quadratic complexity.
Replace the commit_list with a prio_queue to ensure logarithmic worst
case complexity and convert all three users.

Add a performance test that exercises one of them using a pathological
history that consists of 50% merges and 50% root commits to demonstrate
the speedup:

   Test                          v2.50.1           HEAD
   ----------------------------------------------------------------------
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
 commit.c                          |  7 ++--
 commit.h                          |  8 ++---
 fetch-pack.c                      | 13 +++++---
 object-name.c                     | 10 +++---
 t/perf/p1501-rev-parse-oneline.sh | 55 +++++++++++++++++++++++++++++++
 walker.c                          | 11 ++++---
 6 files changed, 83 insertions(+), 21 deletions(-)
 create mode 100755 t/perf/p1501-rev-parse-oneline.sh

diff --git a/commit.c b/commit.c
index e915b2b9a1..0200759aaa 100644
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
@@ -738,17 +739,17 @@ void commit_list_sort_by_date(struct commit_list **l=
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
index fa4231fee7..6afe2f964e 100644
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
@@ -600,7 +601,7 @@ static int find_common(struct fetch_negotiator *negoti=
ator,
 	return count ? retval : 0;
 }
=20
-static struct commit_list *complete;
+static struct prio_queue complete =3D { compare_commits_by_commit_date };
=20
 static int mark_complete(const struct object_id *oid)
 {
@@ -608,7 +609,7 @@ static int mark_complete(const struct object_id *oid)
=20
 	if (commit && !(commit->object.flags & COMPLETE)) {
 		commit->object.flags |=3D COMPLETE;
-		commit_list_insert(commit, &complete);
+		prio_queue_put(&complete, commit);
 	}
 	return 0;
 }
@@ -625,9 +626,12 @@ static int mark_complete_oid(const char *refname UNUS=
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
@@ -797,7 +801,6 @@ static void mark_complete_and_common_ref(struct fetch_=
negotiator *negotiator,
 		refs_for_each_rawref(get_main_ref_store(the_repository),
 				     mark_complete_oid, NULL);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
-		commit_list_sort_by_date(&complete);
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
 	}
diff --git a/object-name.c b/object-name.c
index 851858975f..ab57722146 100644
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
diff --git a/t/perf/p1501-rev-parse-oneline.sh b/t/perf/p1501-rev-parse-on=
eline.sh
new file mode 100755
index 0000000000..ae0f553be5
=2D-- /dev/null
+++ b/t/perf/p1501-rev-parse-oneline.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description=3D'Test :/ object name notation'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
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
+test_perf "rev-parse ':/$(cat needle)'" "
+	git rev-parse ':/$(cat needle)' >actual
+"
+
+test_expect_success 'verify result' '
+	test_cmp expect actual
+'
+
+test_done
diff --git a/walker.c b/walker.c
index b470d43e54..c6d0e20c72 100644
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
