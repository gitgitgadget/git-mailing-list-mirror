Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8682070F
	for <e@80x24.org>; Thu, 15 Sep 2016 12:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934155AbcIOMKx (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 08:10:53 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:45659 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934145AbcIOMKu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 08:10:50 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bkVV8-000719-9N; Thu, 15 Sep 2016 14:10:46 +0200
Date:   Thu, 15 Sep 2016 14:10:44 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH 3/2] batch check whether submodule needs pushing into one call
Message-ID: <20160915121044.GA96648@book.hvoigt.net>
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

We run a command for each sha1 change in a submodule. This is
unnecessary since we can simply batch all sha1's we want to check into
one command. Lets do it so we can speedup the check when many submodule
changes are in need of checking.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Wed, Sep 14, 2016 at 03:30:53PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Sorry about the late reply. I was not able to process emails until now.
> > Here are two patches that should help to improve the situation and batch
> > up some processing. This one is for repositories with submodules, so
> > that they do not iterate over the same submodule twice with the same
> > hash.
> >
> > The second one will be the one people without submodules are interested
> > in.
> 
> Thanks.  Will take a look at later as I'm already deep in today's
> integration cycle.  Very much appreciated.

No problem. While I am at it: Here are actually another two patches that
should make life of submodule users easier (push times of big pushes).

In Numbers with the qt5[1] superproject and all submodules initialized.
The same --mirror test as before with the git repository:

# Without patch:

book:qt5 hvoigt (5.6)$
rm -rf ~/Downloads/git-test && mkdir ~/Downloads/git-test &&
   (cd ~/Downloads/git-test && git init) &&
   time git push --mirror --recurse-submodules=check ~/Downloads/git-test

real	4m0.881s
user	3m30.139s
sys	0m22.329s

Without --recurse-submodules=check

real	0m0.251s
user	0m0.218s
sys	0m0.082s


# With patch:

real	0m1.167s
user	0m0.846s
sys	0m0.262s

real	0m1.110s
user	0m0.815s
sys	0m0.247s

real	0m1.111s
user	0m0.818s
sys	0m0.251s

Without --recurse-submodules=check

real	0m0.294s
user	0m0.221s
sys	0m0.104s

real	0m0.248s
user	0m0.216s
sys	0m0.080s

real	0m0.247s
user	0m0.212s
sys	0m0.082s

[1] git://code.qt.io/qt/qt5.git

 submodule.c | 75 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/submodule.c b/submodule.c
index a15e346..28bb74e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -522,27 +522,54 @@ static int has_remote(const char *refname, const struct object_id *oid,
 	return 1;
 }
 
-static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
+static void append_hash_to_argv(const unsigned char sha1[20], void *data)
 {
-	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
+	struct argv_array *argv = (struct argv_array *) data;
+	argv_array_push(argv, sha1_to_hex(sha1));
+}
+
+static void check_has_hash(const unsigned char sha1[20], void *data)
+{
+	int *has_hash = (int *) data;
+
+	if (!lookup_commit_reference(sha1))
+		*has_hash = 0;
+}
+
+static int submodule_has_hashes(const char *path, struct sha1_array *hashes)
+{
+	int has_hash = 1;
+
+	if (add_submodule_odb(path))
+		return 0;
+
+	sha1_array_for_each_unique(hashes, check_has_hash, &has_hash);
+	return has_hash;
+}
+
+static int submodule_needs_pushing(const char *path, struct sha1_array *hashes)
+{
+	if (!submodule_has_hashes(path, hashes))
 		return 0;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
-		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
+
+		argv_array_push(&cp.args, "rev-list");
+		sha1_array_for_each_unique(hashes, append_hash_to_argv, &cp.args);
+		argv_array_pushl(&cp.args, "--not", "--remotes", "-n", "1" , NULL);
+
 		struct strbuf buf = STRBUF_INIT;
 		int needs_pushing = 0;
 
-		argv[1] = sha1_to_hex(sha1);
-		cp.argv = argv;
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
 		cp.out = -1;
 		cp.dir = path;
 		if (start_command(&cp))
-			die("Could not run 'git rev-list %s --not --remotes -n 1' command in submodule %s",
-				sha1_to_hex(sha1), path);
+			die("Could not run 'git rev-list <hashes> --not --remotes -n 1' command in submodule %s",
+					path);
 		if (strbuf_read(&buf, cp.out, 41))
 			needs_pushing = 1;
 		finish_command(&cp);
@@ -601,21 +628,6 @@ static void find_unpushed_submodule_commits(struct commit *commit,
 	diff_tree_combined_merge(commit, 1, &rev);
 }
 
-struct collect_submodule_from_sha1s_data {
-	char *submodule_path;
-	struct string_list *needs_pushing;
-};
-
-static void collect_submodules_from_sha1s(const unsigned char sha1[20],
-		void *data)
-{
-	struct collect_submodule_from_sha1s_data *me =
-		(struct collect_submodule_from_sha1s_data *) data;
-
-	if (submodule_needs_pushing(me->submodule_path, sha1))
-		string_list_insert(me->needs_pushing, me->submodule_path);
-}
-
 static void free_submodules_sha1s(struct string_list *submodules)
 {
 	int i;
@@ -627,13 +639,6 @@ static void free_submodules_sha1s(struct string_list *submodules)
 	string_list_clear(submodules, 1);
 }
 
-static void append_hash_to_argv(const unsigned char sha1[20],
-		void *data)
-{
-	struct argv_array *argv = (struct argv_array *) data;
-	argv_array_push(argv, sha1_to_hex(sha1));
-}
-
 int find_unpushed_submodules(struct sha1_array *hashes,
 		const char *remotes_name, struct string_list *needs_pushing)
 {
@@ -662,13 +667,11 @@ int find_unpushed_submodules(struct sha1_array *hashes,
 	argv_array_clear(&argv);
 
 	for (i = 0; i < submodules.nr; i++) {
-		struct string_list_item *item = &submodules.items[i];
-		struct collect_submodule_from_sha1s_data data;
-		data.submodule_path = item->string;
-		data.needs_pushing = needs_pushing;
-		sha1_array_for_each_unique((struct sha1_array *) item->util,
-				collect_submodules_from_sha1s,
-				&data);
+		struct string_list_item *submodule = &submodules.items[i];
+		struct sha1_array *hashes = (struct sha1_array *) submodule->util;
+
+		if (submodule_needs_pushing(submodule->string, hashes))
+			string_list_insert(needs_pushing, submodule->string);
 	}
 	free_submodules_sha1s(&submodules);
 
-- 
2.10.0.133.g13017a3

