Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169BB20984
	for <e@80x24.org>; Wed, 14 Sep 2016 17:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760295AbcINRwF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 13:52:05 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:50827 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757686AbcINRwD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 13:52:03 -0400
Received: from [84.131.240.40] (helo=sandbox)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bkELM-0000Xo-D4; Wed, 14 Sep 2016 19:51:32 +0200
Date:   Wed, 14 Sep 2016 19:51:30 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH 2/2] serialize collection of refs that contain submodule
 changes
Message-ID: <20160914175130.GB7613@sandbox>
References: <20160824173017.24782-1-sbeller@google.com>
 <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
 <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are iterating over each pushed ref and want to check whether it
contains changes to submodules. Instead of immediately checking each ref
lets first collect them and then do the check for all of them in one
revision walk.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

Sorry this was not catched earlier. This was implemented as part of
summer of code and it seems we never tested with --mirror.

This is the one which does only one revision walk instead of one for
each ref. Here are some numbers (using the my development clone of git
itself) from my local machine:

rm -rf <test-git> && mkdir <test-git> &&
(cd <test-git> && git init) &&
time git push --mirror <test-git>

   real	0m16.056s
   user	0m24.424s
   sys	0m1.380s

   real	0m15.885s
   user	0m24.204s
   sys	0m1.296s

   real	0m16.731s
   user	0m24.176s
   sys	0m1.244s

rm -rf <test-git> && mkdir <test-git> &&
(cd <test-git> && git init) &&
time git push --mirror --recurse-submodules=check <test-git>

   real	0m21.441s
   user	0m29.560s
   sys	0m1.480s

   real	0m21.319s
   user	0m29.484s
   sys	0m1.464s

   real	0m21.261s
   user	0m29.252s
   sys	0m1.592s

Without my patches and --recurse-submodules=check the numbers are
basically the same. I stopped the test with --recurse-submodules=check
after ~ 9 minutes.

Cheers Heiko

 submodule.c | 36 +++++++++++++++++++++---------------
 submodule.h |  5 +++--
 transport.c | 22 ++++++++++++++--------
 3 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/submodule.c b/submodule.c
index b04c066..a15e346 100644
--- a/submodule.c
+++ b/submodule.c
@@ -627,24 +627,31 @@ static void free_submodules_sha1s(struct string_list *submodules)
 	string_list_clear(submodules, 1);
 }
 
-int find_unpushed_submodules(unsigned char new_sha1[20],
+static void append_hash_to_argv(const unsigned char sha1[20],
+		void *data)
+{
+	struct argv_array *argv = (struct argv_array *) data;
+	argv_array_push(argv, sha1_to_hex(sha1));
+}
+
+int find_unpushed_submodules(struct sha1_array *hashes,
 		const char *remotes_name, struct string_list *needs_pushing)
 {
 	struct rev_info rev;
 	struct commit *commit;
-	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
-	int argc = ARRAY_SIZE(argv) - 1, i;
-	char *sha1_copy;
+	int i;
 	struct string_list submodules = STRING_LIST_INIT_DUP;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	struct strbuf remotes_arg = STRBUF_INIT;
-
-	strbuf_addf(&remotes_arg, "--remotes=%s", remotes_name);
 	init_revisions(&rev, NULL);
-	sha1_copy = xstrdup(sha1_to_hex(new_sha1));
-	argv[1] = sha1_copy;
-	argv[3] = remotes_arg.buf;
-	setup_revisions(argc, argv, &rev, NULL);
+
+	/* argv.argv[0] will be ignored by setup_revisions */
+	argv_array_push(&argv, "find_unpushed_submodules");
+	sha1_array_for_each_unique(hashes, append_hash_to_argv, &argv);
+	argv_array_push(&argv, "--not");
+	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
+
+	setup_revisions(argv.argc, argv.argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
 
@@ -652,8 +659,7 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
 		find_unpushed_submodule_commits(commit, &submodules);
 
 	reset_revision_walk();
-	free(sha1_copy);
-	strbuf_release(&remotes_arg);
+	argv_array_clear(&argv);
 
 	for (i = 0; i < submodules.nr; i++) {
 		struct string_list_item *item = &submodules.items[i];
@@ -691,12 +697,12 @@ static int push_submodule(const char *path)
 	return 1;
 }
 
-int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name)
+int push_unpushed_submodules(struct sha1_array *hashes, const char *remotes_name)
 {
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
-	if (!find_unpushed_submodules(new_sha1, remotes_name, &needs_pushing))
+	if (!find_unpushed_submodules(hashes, remotes_name, &needs_pushing))
 		return 1;
 
 	for (i = 0; i < needs_pushing.nr; i++) {
diff --git a/submodule.h b/submodule.h
index d9e197a..065b2f0 100644
--- a/submodule.h
+++ b/submodule.h
@@ -3,6 +3,7 @@
 
 struct diff_options;
 struct argv_array;
+struct sha1_array;
 
 enum {
 	RECURSE_SUBMODULES_CHECK = -4,
@@ -62,9 +63,9 @@ int submodule_uses_gitfile(const char *path);
 int ok_to_remove_submodule(const char *path);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20], int search);
-int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
+int find_unpushed_submodules(struct sha1_array *hashes, const char *remotes_name,
 		struct string_list *needs_pushing);
-int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
+int push_unpushed_submodules(struct sha1_array *hashes, const char *remotes_name);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 int parallel_submodules(void);
 
diff --git a/transport.c b/transport.c
index 94d6dc3..76e1daf 100644
--- a/transport.c
+++ b/transport.c
@@ -903,23 +903,29 @@ int transport_push(struct transport *transport,
 
 		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
+			struct sha1_array hashes = SHA1_ARRAY_INIT;
+
 			for (; ref; ref = ref->next)
-				if (!is_null_oid(&ref->new_oid) &&
-				    !push_unpushed_submodules(ref->new_oid.hash,
-					    transport->remote->name))
-				    die ("Failed to push all needed submodules!");
+				if (!is_null_oid(&ref->new_oid))
+					sha1_array_append(&hashes, ref->new_oid.hash);
+
+			if (!push_unpushed_submodules(&hashes, transport->remote->name))
+				die ("Failed to push all needed submodules!");
 		}
 
 		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 			      TRANSPORT_RECURSE_SUBMODULES_CHECK)) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
+			struct sha1_array hashes = SHA1_ARRAY_INIT;
 
 			for (; ref; ref = ref->next)
-				if (!is_null_oid(&ref->new_oid) &&
-				    find_unpushed_submodules(ref->new_oid.hash,
-					    transport->remote->name, &needs_pushing))
-					die_with_unpushed_submodules(&needs_pushing);
+				if (!is_null_oid(&ref->new_oid))
+					sha1_array_append(&hashes, ref->new_oid.hash);
+
+			if (find_unpushed_submodules(&hashes, transport->remote->name,
+						&needs_pushing))
+				die_with_unpushed_submodules(&needs_pushing);
 		}
 
 		push_ret = transport->push_refs(transport, remote_refs, flags);
-- 
2.0.2.832.g083c931

