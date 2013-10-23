From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/15] fetch --tags: fetch tags *in addition to* other stuff
Date: Wed, 23 Oct 2013 17:50:43 +0200
Message-ID: <1382543448-2586-11-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:59:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0qN-00076U-At
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab3JWP7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:59:31 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55940 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752169Ab3JWP7a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:59:30 -0400
X-AuditID: 12074411-b7f426d000005455-ec-5267f0aca54c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 00.4E.21589.CA0F7625; Wed, 23 Oct 2013 11:52:12 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLt3009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:52:09 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqLvmQ3qQwc8WPovpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7Y+KCb8wFDyIqun9PZGtgfO/excjJISFgItHevJEJwhaTuHBvPVsXIxeHkMBlRon9164w
	QThXmCTmXXrNCFLFJqArsainGaxDREBNYmLbIRaQImaBicwSx6cvYgFJCAv4SNxf0Q3WwCKg
	KnHi5zOwOK+Ai8SRf11ANgfQOjmJh99iQcKcQOELx6ezgthCAs4SExZOZZ/AyLuAkWEVo1xi
	Tmmubm5iZk5xarJucXJiXl5qka6pXm5miV5qSukmRkjYCu5gnHFS7hCjAAejEg/vw5a0ICHW
	xLLiytxDjJIcTEqivHPepQcJ8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHdcRcox5uSWFmVWpQP
	k5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4G16D9QoWJSanlqRlplTgpBm4uAEEVwg
	G3iANsSAFPIWFyTmFmemQxSdYlSUEudtAEkIgCQySvPgBsASzCtGcaB/hHkTQap4gMkJrvsV
	0GAmoMFTlqSBDC5JREhJNTBujtuaF5ZuGMWwePPGBzfLlhTYBiROnSX8RMhdbuW2ghnGEy5b
	v7RL8HnNvTTm9kerLNeFW0uWsH1n5llfpPms8+q5B9rHHv77VKneuvT77PvZoquO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236529>

Previously, fetch's "--tags" option was considered equivalent to
specifying the refspec "refs/tags/*:refs/tags/*" on the command line;
in particular, it caused the remote.<name>.refspec configuration to be
ignored.

But it is not very useful to fetch tags without also fetching other
references, whereas it *is* quite useful to be able to fetch tags *in
addition to* other references.  So change the semantics of this option
to do the latter.

If a user wants to fetch *only* tags, then it is still possible to
specifying an explicit refspec:

    git fetch <remote> 'refs/tags/*:refs/tags/*'

Please note that the documentation prior to 1.8.0.3 was ambiguous
about this aspect of "fetch --tags" behavior.  Commit

    f0cb2f137c 2012-12-14 fetch --tags: clarify documentation

made the documentation match the old behavior.  This commit changes
the documentation to match the new behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

The change to builtin/fetch.c:get_ref_map() has the side effect of
changing the order that the (struct ref) objects are listed in
ref_map.  It seems to me that this could probably only matter in the
case of duplicates.  But later ref_remove_duplicates() is called, so
duplicates are eliminated.  However, ref_remove_duplicates() always
retains the first instance of duplicates and discards the rest.  It is
conceivable that the boolean flags (which are not inspected by
ref_remove_duplicates()) could differ among the duplicates, and that
therefore changing the order of the items in the original list has the
effect of changing the flags on the items that are retained.

I don't know this code well enough to judge whether this might be a
problem.

If it is, then the correct approach is probably either to teach
ref_remove_duplicates() to ensure that the flags are also consistent
across duplicates, or to somehow combine the flags from all duplicates
into the one that is retained.  Please let me know if this is needed.

 Documentation/fetch-options.txt          |  8 +++---
 builtin/fetch.c                          | 46 +++++++++++++++++++-------------
 git-pull.sh                              |  2 +-
 t/t5510-fetch.sh                         | 22 ++++++++++++---
 t/t5515/fetch.br-unconfig_--tags_.._.git |  1 +
 t/t5515/fetch.master_--tags_.._.git      |  1 +
 t/t5525-fetch-tagopt.sh                  | 23 ++++++++++++----
 7 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index ba1fe49..0e6d2ac 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -61,11 +61,9 @@ endif::git-pull[]
 ifndef::git-pull[]
 -t::
 --tags::
-	This is a short-hand for giving `refs/tags/*:refs/tags/*`
-	refspec from the command line, to ask all tags to be fetched
-	and stored locally.  Because this acts as an explicit
-	refspec, the default refspecs (configured with the
-	remote.$name.fetch variable) are overridden and not used.
+	This is a short-hand requesting that all tags be fetched from
+	the remote in addition to whatever else is being fetched.  It
+	is similar to using the refspec `refs/tags/*:refs/tags/*`.
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61e8117..7edb1ea 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -271,7 +271,7 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	const struct ref *remote_refs = transport_get_remote_refs(transport);
 
-	if (refspec_count || tags == TAGS_SET) {
+	if (refspec_count) {
 		struct ref **old_tail;
 
 		for (i = 0; i < refspec_count; i++) {
@@ -279,11 +279,9 @@ static struct ref *get_ref_map(struct transport *transport,
 			if (refspecs[i].dst && refspecs[i].dst[0])
 				*autotags = 1;
 		}
-		/* Merge everything on the command line, but not --tags */
+		/* Merge everything on the command line (but not --tags) */
 		for (rm = ref_map; rm; rm = rm->next)
 			rm->fetch_head_status = FETCH_HEAD_MERGE;
-		if (tags == TAGS_SET)
-			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 
 		/*
 		 * For any refs that we happen to be fetching via command-line
@@ -334,8 +332,13 @@ static struct ref *get_ref_map(struct transport *transport,
 			tail = &ref_map->next;
 		}
 	}
-	if (tags == TAGS_DEFAULT && *autotags)
+
+	if (tags == TAGS_SET)
+		/* also fetch all tags */
+		get_fetch_map(remote_refs, tag_refspec, &tail, 0);
+	else if (tags == TAGS_DEFAULT && *autotags)
 		find_non_local_tags(transport, &ref_map, &tail);
+
 	ref_remove_duplicates(ref_map);
 
 	return ref_map;
@@ -826,31 +829,38 @@ static int do_fetch(struct transport *transport,
 		goto cleanup;
 	}
 	if (prune) {
-		/*
-		 * If --tags was specified, pretend that the user gave us
-		 * the canonical tags refspec
-		 */
+		struct refspec *prune_refspecs;
+		int prune_refspec_count;
+
+		if (ref_count) {
+			prune_refspecs = refs;
+			prune_refspec_count = ref_count;
+		} else {
+			prune_refspecs = transport->remote->fetch;
+			prune_refspec_count = transport->remote->fetch_refspec_nr;
+		}
+
 		if (tags == TAGS_SET) {
+			/*
+			 * --tags was specified.  Pretend that the user also
+			 * gave us the canonical tags refspec
+			 */
 			const char *tags_str = "refs/tags/*:refs/tags/*";
 			struct refspec *tags_refspec, *refspec;
 
 			/* Copy the refspec and add the tags to it */
-			refspec = xcalloc(ref_count + 1, sizeof(struct refspec));
+			refspec = xcalloc(prune_refspec_count + 1, sizeof(*refspec));
 			tags_refspec = parse_fetch_refspec(1, &tags_str);
-			memcpy(refspec, refs, ref_count * sizeof(struct refspec));
-			memcpy(&refspec[ref_count], tags_refspec, sizeof(struct refspec));
-			ref_count++;
+			memcpy(refspec, prune_refspecs, prune_refspec_count * sizeof(*refspec));
+			memcpy(&refspec[prune_refspec_count], tags_refspec, sizeof(*refspec));
 
-			prune_refs(refspec, ref_count, ref_map);
+			prune_refs(refspec, prune_refspec_count + 1, ref_map);
 
-			ref_count--;
 			/* The rest of the strings belong to fetch_one */
 			free_refspec(1, tags_refspec);
 			free(refspec);
-		} else if (ref_count) {
-			prune_refs(refs, ref_count, ref_map);
 		} else {
-			prune_refs(transport->remote->fetch, transport->remote->fetch_refspec_nr, ref_map);
+			prune_refs(prune_refspecs, prune_refspec_count, ref_map);
 		}
 	}
 	free_refs(ref_map);
diff --git a/git-pull.sh b/git-pull.sh
index b946fd9..dac7e1c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -172,7 +172,7 @@ error_on_no_merge_candidates () {
 	do
 		case "$opt" in
 		-t|--t|--ta|--tag|--tags)
-			echo "Fetching tags only, you probably meant:"
+			echo "It doesn't make sense to pull tags; you probably meant:"
 			echo "  git fetch --tags"
 			exit 1
 		esac
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 8328be1..02e5901 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -113,7 +113,7 @@ test_expect_success 'fetch --prune with a namespace keeps other namespaces' '
 	git rev-parse origin/master
 '
 
-test_expect_success 'fetch --prune --tags does not delete the remote-tracking branches' '
+test_expect_success 'fetch --prune --tags prunes tags and branches' '
 	cd "$D" &&
 	git clone . prune-tags &&
 	cd prune-tags &&
@@ -124,7 +124,7 @@ test_expect_success 'fetch --prune --tags does not delete the remote-tracking br
 
 	git fetch --prune --tags origin &&
 	git rev-parse origin/master &&
-	git rev-parse origin/fake-remote &&
+	test_must_fail git rev-parse origin/fake-remote &&
 	test_must_fail git rev-parse sometag
 '
 
@@ -132,10 +132,26 @@ test_expect_success 'fetch --prune --tags with branch does not delete other remo
 	cd "$D" &&
 	git clone . prune-tags-branch &&
 	cd prune-tags-branch &&
+	git tag sometag master &&
 	git update-ref refs/remotes/origin/extrabranch master &&
 
 	git fetch --prune --tags origin master &&
-	git rev-parse origin/extrabranch
+	git rev-parse origin/extrabranch &&
+	test_must_fail git rev-parse sometag
+'
+
+test_expect_success 'fetch --prune --tags with refspec prunes based on refspec' '
+	cd "$D" &&
+	git clone . prune-tags-refspec &&
+	cd prune-tags-refspec &&
+	git tag sometag master &&
+	git update-ref refs/remotes/origin/foo/otherbranch master &&
+	git update-ref refs/remotes/origin/extrabranch master &&
+
+	git fetch --prune --tags origin refs/heads/foo/*:refs/remotes/origin/foo/* &&
+	test_must_fail git rev-parse refs/remotes/origin/foo/otherbranch &&
+	git rev-parse origin/extrabranch &&
+	test_must_fail git rev-parse sometag
 '
 
 test_expect_success 'fetch tags when there is no tags' '
diff --git a/t/t5515/fetch.br-unconfig_--tags_.._.git b/t/t5515/fetch.br-unconfig_--tags_.._.git
index 1669cc4..0f70f66 100644
--- a/t/t5515/fetch.br-unconfig_--tags_.._.git
+++ b/t/t5515/fetch.br-unconfig_--tags_.._.git
@@ -1,4 +1,5 @@
 # br-unconfig --tags ../.git
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.master_--tags_.._.git b/t/t5515/fetch.master_--tags_.._.git
index 8a74935..ab473a6 100644
--- a/t/t5515/fetch.master_--tags_.._.git
+++ b/t/t5515/fetch.master_--tags_.._.git
@@ -1,4 +1,5 @@
 # master --tags ../.git
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5525-fetch-tagopt.sh b/t/t5525-fetch-tagopt.sh
index 4fbf7a1..45815f7 100755
--- a/t/t5525-fetch-tagopt.sh
+++ b/t/t5525-fetch-tagopt.sh
@@ -8,7 +8,8 @@ setup_clone () {
 	git clone --mirror . $1 &&
 	git remote add remote_$1 $1 &&
 	(cd $1 &&
-	git tag tag_$1)
+	git tag tag_$1 &&
+	git branch branch_$1)
 }
 
 test_expect_success setup '
@@ -21,21 +22,33 @@ test_expect_success setup '
 
 test_expect_success "fetch with tagopt=--no-tags does not get tag" '
 	git fetch remote_one &&
-	test_must_fail git show-ref tag_one
+	test_must_fail git show-ref tag_one &&
+	git show-ref remote_one/branch_one
 	'
 
 test_expect_success "fetch --tags with tagopt=--no-tags gets tag" '
+	(
+		cd one &&
+		git branch second_branch_one
+	) &&
 	git fetch --tags remote_one &&
-	git show-ref tag_one
+	git show-ref tag_one &&
+	git show-ref remote_one/second_branch_one
 	'
 
 test_expect_success "fetch --no-tags with tagopt=--tags does not get tag" '
 	git fetch --no-tags remote_two &&
-	test_must_fail git show-ref tag_two
+	test_must_fail git show-ref tag_two &&
+	git show-ref remote_two/branch_two
 	'
 
 test_expect_success "fetch with tagopt=--tags gets tag" '
+	(
+		cd two &&
+		git branch second_branch_two
+	) &&
 	git fetch remote_two &&
-	git show-ref tag_two
+	git show-ref tag_two &&
+	git show-ref remote_two/second_branch_two
 	'
 test_done
-- 
1.8.4
