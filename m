Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD80D2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 12:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934758AbcIOMTF (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 08:19:05 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:40716 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933940AbcIOMTE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 08:19:04 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bkVd6-0000Ka-7x; Thu, 15 Sep 2016 14:19:00 +0200
Date:   Thu, 15 Sep 2016 14:18:58 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH 4/2] use actual start hashes for submodule push check instead
 of local refs
Message-ID: <20160915121858.GB96648@book.hvoigt.net>
References: <20160824173017.24782-1-sbeller@google.com>
 <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
 <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
 <20160914173124.GA7613@sandbox>
 <xmqqwpiep10i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwpiep10i.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Push knows the actual revision range it is actually pushing to a remote.
Let's use the start revisions to reduce the amount of checked revisions
instead of the locally cached remote refs which might be out of date.

This actually changes behavior as it now can also properly handle pushes
with URLs. That is also the reason why we change some tests. When
passing the remote as URL the push is made unconditionally in on-demand.
This is wrong since on-demand should only push the submodule if its SHA1
reference got changed in the superproject history that is getting pushed.
The reason behind that is that the exclusion list for revisions was
reduced by using the parameters "--not --remotes=<remote name>" to
reduce the amount of revisions for the revision walk. In case of an URL
this does not match anything and thus we would always do a full revision
walk until the root commit.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
And here is another one which makes the check more correct. For push
--recurse-submodules=check|on-demand with URLs this is also a
performance improvement since at the moment we iterate over all
revisions unconditionally as explained above.

This patch changes the behavior (now its how its supposed to be) so
there may be fallout from users complaining that their submodules do not
get pushed with on-demand anymore. This is only for users using URL for
pushing though.

Cheers Heiko

BTW: Peff, thanks for the good diagnosis of all these problems.

 submodule.c                    | 12 ++++++------
 submodule.h                    |  6 +++---
 t/t5531-deep-submodule-push.sh | 24 ++++++++++++++++++------
 transport.c                    | 40 ++++++++++++++++++++++++++++++----------
 4 files changed, 57 insertions(+), 25 deletions(-)

diff --git a/submodule.c b/submodule.c
index 28bb74e..1f82974 100644
--- a/submodule.c
+++ b/submodule.c
@@ -639,8 +639,8 @@ static void free_submodules_sha1s(struct string_list *submodules)
 	string_list_clear(submodules, 1);
 }
 
-int find_unpushed_submodules(struct sha1_array *hashes,
-		const char *remotes_name, struct string_list *needs_pushing)
+int find_unpushed_submodules(struct sha1_array *old_hashes,
+		struct sha1_array *new_hashes, struct string_list *needs_pushing)
 {
 	struct rev_info rev;
 	struct commit *commit;
@@ -652,9 +652,9 @@ int find_unpushed_submodules(struct sha1_array *hashes,
 
 	/* argv.argv[0] will be ignored by setup_revisions */
 	argv_array_push(&argv, "find_unpushed_submodules");
-	sha1_array_for_each_unique(hashes, append_hash_to_argv, &argv);
+	sha1_array_for_each_unique(new_hashes, append_hash_to_argv, &argv);
 	argv_array_push(&argv, "--not");
-	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
+	sha1_array_for_each_unique(old_hashes, append_hash_to_argv, &argv);
 
 	setup_revisions(argv.argc, argv.argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
@@ -700,12 +700,12 @@ static int push_submodule(const char *path)
 	return 1;
 }
 
-int push_unpushed_submodules(struct sha1_array *hashes, const char *remotes_name)
+int push_unpushed_submodules(struct sha1_array *old_hashes, struct sha1_array *new_hashes)
 {
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
-	if (!find_unpushed_submodules(hashes, remotes_name, &needs_pushing))
+	if (!find_unpushed_submodules(old_hashes, new_hashes, &needs_pushing))
 		return 1;
 
 	for (i = 0; i < needs_pushing.nr; i++) {
diff --git a/submodule.h b/submodule.h
index 065b2f0..55c6c91 100644
--- a/submodule.h
+++ b/submodule.h
@@ -63,9 +63,9 @@ int submodule_uses_gitfile(const char *path);
 int ok_to_remove_submodule(const char *path);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20], int search);
-int find_unpushed_submodules(struct sha1_array *hashes, const char *remotes_name,
-		struct string_list *needs_pushing);
-int push_unpushed_submodules(struct sha1_array *hashes, const char *remotes_name);
+int find_unpushed_submodules(struct sha1_array *old_hashes,
+		struct sha1_array *new_hashes, struct string_list *needs_pushing);
+int push_unpushed_submodules(struct sha1_array *old_hashes, struct sha1_array *new_hashes);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 int parallel_submodules(void);
 
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 198ce84..a5b8ef6 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -154,6 +154,8 @@ test_expect_success 'push recurse-submodules on command line overrides config' '
 		git fetch ../pub.git &&
 		git diff --quiet FETCH_HEAD master &&
 		(cd gar/bage && git diff --quiet origin/master master^) &&
+		# Since this push was executed reset to previous state
+		(git push -f ../pub.git master^:master) &&
 
 		# Ensure that we can override check in the config to
 		# disable submodule recursion entirely (alternative form)
@@ -161,6 +163,8 @@ test_expect_success 'push recurse-submodules on command line overrides config' '
 		git fetch ../pub.git &&
 		git diff --quiet FETCH_HEAD master &&
 		(cd gar/bage && git diff --quiet origin/master master^) &&
+		# Since this push was executed reset to previous state
+		(git push -f ../pub.git master^:master) &&
 
 		# Ensure that we can override check in the config to
 		# push the submodule too
@@ -198,11 +202,15 @@ test_expect_success 'push recurse-submodules last one wins on command line' '
 		git diff --quiet FETCH_HEAD master &&
 		# Check that the submodule commit did not get there
 		(cd gar/bage && git diff --quiet origin/master master^) &&
+		# Since this push was executed reset to previous state
+		(git push -f ../pub.git master^:master) &&
 
 		# should result in "no"
 		git push --recurse-submodules=on-demand --no-recurse-submodules ../pub.git master &&
 		# Check that the submodule commit did not get there
 		(cd gar/bage && git diff --quiet origin/master master^) &&
+		# Since this push was executed reset to previous state
+		(git push -f ../pub.git master^:master) &&
 
 		# But the options in the other order should push the submodule
 		git push --recurse-submodules=check --recurse-submodules=on-demand ../pub.git master &&
@@ -249,9 +257,11 @@ test_expect_success 'push succeeds if submodule commit disabling recursion from
 		git fetch ../pub.git &&
 		git diff --quiet FETCH_HEAD master &&
 		# But that the submodule commit did not
-		( cd gar/bage && git diff --quiet origin/master master^ ) &&
-		# Now push it to avoid confusing future tests
-		git push --recurse-submodules=on-demand ../pub.git master
+		(cd gar/bage &&
+			git diff --quiet origin/master master^ &&
+			# Now push it to avoid confusing future tests
+			git push
+		)
 	)
 '
 
@@ -271,9 +281,11 @@ test_expect_success 'push succeeds if submodule commit disabling recursion from
 		git fetch ../pub.git &&
 		git diff --quiet FETCH_HEAD master &&
 		# But that the submodule commit did not
-		( cd gar/bage && git diff --quiet origin/master master^ ) &&
-		# Now push it to avoid confusing future tests
-		git push --recurse-submodules=on-demand ../pub.git master
+		(cd gar/bage &&
+			git diff --quiet origin/master master^ &&
+			# Now push it to avoid confusing future tests
+			git push
+		)
 	)
 '
 
diff --git a/transport.c b/transport.c
index 76e1daf..475faaf 100644
--- a/transport.c
+++ b/transport.c
@@ -845,6 +845,28 @@ static int run_pre_push_hook(struct transport *transport,
 	return ret;
 }
 
+static void collect_new_old_hashes(struct ref *ref, struct sha1_array *new_hashes,
+		struct sha1_array *old_hashes)
+{
+	for (; ref; ref = ref->next) {
+		if (!is_null_oid(&ref->new_oid)) {
+			/* Just need to handle non-null oid's. If there
+			 * is no new we are handling a deletion and do
+			 * not need to check
+			 */
+			sha1_array_append(new_hashes, ref->new_oid.hash);
+
+			/* if the old id is null we are handling an new
+			 * ref and can simply skip appending the oid
+			 * since they are used to reduce the amount of
+			 * checked revisions.
+			 */
+			if (!is_null_oid(&ref->old_oid))
+				sha1_array_append(old_hashes, ref->old_oid.hash);
+		}
+	}
+}
+
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
 		   unsigned int *reject_reasons)
@@ -903,13 +925,12 @@ int transport_push(struct transport *transport,
 
 		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
-			struct sha1_array hashes = SHA1_ARRAY_INIT;
+			struct sha1_array new_hashes = SHA1_ARRAY_INIT;
+			struct sha1_array old_hashes = SHA1_ARRAY_INIT;
 
-			for (; ref; ref = ref->next)
-				if (!is_null_oid(&ref->new_oid))
-					sha1_array_append(&hashes, ref->new_oid.hash);
+			collect_new_old_hashes(ref, &new_hashes, &old_hashes);
 
-			if (!push_unpushed_submodules(&hashes, transport->remote->name))
+			if (!push_unpushed_submodules(&old_hashes, &new_hashes))
 				die ("Failed to push all needed submodules!");
 		}
 
@@ -917,13 +938,12 @@ int transport_push(struct transport *transport,
 			      TRANSPORT_RECURSE_SUBMODULES_CHECK)) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
-			struct sha1_array hashes = SHA1_ARRAY_INIT;
+			struct sha1_array new_hashes = SHA1_ARRAY_INIT;
+			struct sha1_array old_hashes = SHA1_ARRAY_INIT;
 
-			for (; ref; ref = ref->next)
-				if (!is_null_oid(&ref->new_oid))
-					sha1_array_append(&hashes, ref->new_oid.hash);
+			collect_new_old_hashes(ref, &new_hashes, &old_hashes);
 
-			if (find_unpushed_submodules(&hashes, transport->remote->name,
+			if (find_unpushed_submodules(&old_hashes, &new_hashes,
 						&needs_pushing))
 				die_with_unpushed_submodules(&needs_pushing);
 		}
-- 
2.10.0.133.g13017a3

