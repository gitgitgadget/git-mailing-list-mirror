From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3 0/3] js/maint-receive-pack-symref-alias
Date: Mon, 19 Apr 2010 18:08:29 -0400
Message-ID: <1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junio@kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 00:09:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3z9R-0005kn-Gv
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 00:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab0DSWJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 18:09:00 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:58619 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0DSWI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 18:08:59 -0400
Received: by yxe1 with SMTP id 1so3250987yxe.33
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bt4b3j217VcKF3Ri3q3K+BeKlfgoSPfko3lMkV9+fLA=;
        b=nOUP+HfVLZNzBhvGknR76im1r5gWbL1g6r3UvexE2DANT3Uh5jFltOxFhCRsrrs7LK
         n+iwMVnrSLV2cRBVpkn6/Vp2yKjHL+HC3cGS5jJW0CqRWSI9K20jM9h4t1HZfT14v4fm
         FuzKE1zwdikscDhhy2Zj/fZaCzP09Drqaukyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Uk//pSVbRAaPQU0n0uFrn85lOlnxLltem/C+zuOrKOhJqxe47poPmgZ/k4mVlSpGMZ
         H5aXIvQeDXDruO5nEtcLLqcUIf6kJ+zidJb9+rPY2WLWMjnyjudwYdjs/Drcdyaun7KX
         3LysqI0ePdwDqmPTvL+HKcH8m81mHzYxtim2Y=
Received: by 10.100.235.26 with SMTP id i26mr13884861anh.82.1271714933975;
        Mon, 19 Apr 2010 15:08:53 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id b10sm50193427ana.6.2010.04.19.15.08.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 15:08:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.436.g2b878
In-Reply-To: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145334>

- Incorporated Junio's feedback from v1 and v2.
- Rebuilt on-top of f78683f, which is where v1 was applied in pu.
- Added an additional patch to the series to reformat the tests in
  t5516-fetch-push.sh to use a consistent style, per Junio's tweaks to the
  test I wrote for v1.

Jay Soffian (3):
  receive-pack: switch global variable 'commands' to a parameter
  t5516-fetch-push.sh: style cleanup
  receive-pack: detect aliased updates which can occur with symrefs

 builtin-receive-pack.c |  128 ++++++++++++++++++++++++++++++++++--------------
 t/t5516-fetch-push.sh  |  118 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 186 insertions(+), 60 deletions(-)

interdiff from what's in pu:
 builtin-receive-pack.c |   76 +++++++++++++++++++++++++------------
 t/t5516-fetch-push.sh  |   98 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 126 insertions(+), 48 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index a2e3bc8..bb34757 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -130,6 +130,7 @@ static void write_head_info(void)
 struct command {
 	struct command *next;
 	const char *error_string;
+	unsigned int skip_update;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
 	char ref_name[FLEX_ARRAY]; /* more */
@@ -487,30 +488,67 @@ static void run_update_post_hook(struct command *commands)
 	}
 }
 
-static int aliased_ref(struct command *cmd, struct string_list *list)
+static void check_aliased_update(struct command *cmd, struct string_list *list)
 {
 	struct string_list_item *item;
+	struct command *dst_cmd;
 	unsigned char sha1[20];
+	char cmd_oldh[41], cmd_newh[41], dst_oldh[41], dst_newh[41];
 	int flag;
 
 	const char *dst_name = resolve_ref(cmd->ref_name, sha1, 0, &flag);
 
 	if (!(flag & REF_ISSYMREF))
-		return 0;
+		return;
+
+	if ((item = string_list_lookup(dst_name, list)) == NULL)
+		return;
+
+	cmd->skip_update = 1;
+
+	dst_cmd = (struct command *) item->util;
+
+	if (!hashcmp(cmd->old_sha1, dst_cmd->old_sha1) &&
+	    !hashcmp(cmd->new_sha1, dst_cmd->new_sha1))
+		return;
+
+	dst_cmd->skip_update = 1;
+
+	strcpy(cmd_oldh, find_unique_abbrev(cmd->old_sha1, DEFAULT_ABBREV));
+	strcat(cmd_newh, find_unique_abbrev(cmd->new_sha1, DEFAULT_ABBREV));
+	strcpy(dst_oldh, find_unique_abbrev(dst_cmd->old_sha1, DEFAULT_ABBREV));
+	strcat(dst_newh, find_unique_abbrev(dst_cmd->new_sha1, DEFAULT_ABBREV));
+	rp_error("refusing inconsistent update between symref '%s' (%s..%s) and"
+		 " its target '%s' (%s..%s)",
+		 cmd->ref_name, cmd_oldh, cmd_newh,
+		 dst_cmd->ref_name, dst_oldh, dst_newh);
 
-	if ((item = string_list_lookup(dst_name, list)) != NULL) {
-		struct command *other_cmd = (struct command *) item->util;
-		return (!(hashcmp(cmd->old_sha1, other_cmd->old_sha1) &&
-			hashcmp(cmd->new_sha1, other_cmd->new_sha1)));
+	cmd->error_string = dst_cmd->error_string =
+		"inconsistent aliased update";
+}
+
+static void check_aliased_updates(struct command *commands)
+{
+	struct command *cmd;
+	struct string_list ref_list = { NULL, 0, 0, 0 };
+
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		struct string_list_item *item =
+			string_list_append(cmd->ref_name, &ref_list);
+		item->util = (void *)cmd;
 	}
-	return 0;
+	sort_string_list(&ref_list);
+
+	for (cmd = commands; cmd; cmd = cmd->next)
+		check_aliased_update(cmd, &ref_list);
+
+	string_list_clear(&ref_list, 0);
 }
 
 static void execute_commands(struct command *commands, const char *unpacker_error)
 {
 	struct command *cmd;
 	unsigned char sha1[20];
-	struct string_list ref_list = { NULL, 0, 0, 0 };
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
@@ -524,27 +562,19 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 		return;
 	}
 
-	head_name = resolve_ref("HEAD", sha1, 0, NULL);
+	check_aliased_updates(commands);
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		struct string_list_item *item =
-			string_list_append(cmd->ref_name, &ref_list);
-		item->util = (void *)cmd;
-	}
-	sort_string_list(&ref_list);
+	head_name = resolve_ref("HEAD", sha1, 0, NULL);
 
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!aliased_ref(cmd, &ref_list))
+	for (cmd = commands; cmd; cmd = cmd->next)
+		if (!cmd->skip_update)
 			cmd->error_string = update(cmd);
-	}
-	string_list_clear(&ref_list, 0);
 }
 
 static struct command *read_head_info(void)
 {
 	struct command *commands = NULL;
 	struct command **p = &commands;
-
 	for (;;) {
 		static char line[1000];
 		unsigned char old_sha1[20], new_sha1[20];
@@ -573,12 +603,10 @@ static struct command *read_head_info(void)
 			if (strstr(refname + reflen + 1, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 		}
-		cmd = xmalloc(sizeof(struct command) + len - 80);
+		cmd = xcalloc(1, sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
 		memcpy(cmd->ref_name, line + 82, len - 81);
-		cmd->error_string = NULL;
-		cmd->next = NULL;
 		*p = cmd;
 		p = &cmd->next;
 	}
@@ -671,8 +699,8 @@ static const char *unpack(void)
 
 static void report(struct command *commands, const char *unpack_status)
 {
-	struct strbuf buf = STRBUF_INIT;
 	struct command *cmd;
+	struct strbuf buf = STRBUF_INIT;
 
 	packet_buf_write(&buf, "unpack %s\n",
 			 unpack_status ? unpack_status : "ok");
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 350e734..f0813e0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -64,13 +64,13 @@ check_push_result () {
 
 test_expect_success setup '
 
-	: >path1 &&
+	>path1 &&
 	git add path1 &&
 	test_tick &&
 	git commit -a -m repo &&
 	the_first_commit=$(git show-ref -s --verify refs/heads/master) &&
 
-	: >path2 &&
+	>path2 &&
 	git add path2 &&
 	test_tick &&
 	git commit -a -m second &&
@@ -483,8 +483,10 @@ git config --remove-section remote.there
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
-	(cd testrepo &&
-	 old_commit=$(git show-ref -s --verify refs/heads/master)) &&
+	(
+		cd testrepo &&
+		old_commit=$(git show-ref -s --verify refs/heads/master)
+	) &&
 	git push --dry-run testrepo &&
 	check_push_result $old_commit heads/master
 '
@@ -493,10 +495,13 @@ test_expect_success 'push updates local refs' '
 
 	mk_test heads/master &&
 	mk_child child &&
-	(cd child &&
+	(
+		cd child &&
 		git pull .. master &&
 		git push &&
-	test $(git rev-parse master) = $(git rev-parse remotes/origin/master))
+		test $(git rev-parse master) = \
+			$(git rev-parse remotes/origin/master)
+	)
 
 '
 
@@ -506,10 +511,13 @@ test_expect_success 'push updates up-to-date local refs' '
 	mk_child child1 &&
 	mk_child child2 &&
 	(cd child1 && git pull .. master && git push) &&
-	(cd child2 &&
+	(
+		cd child2 &&
 		git pull ../child1 master &&
 		git push &&
-	test $(git rev-parse master) = $(git rev-parse remotes/origin/master))
+		test $(git rev-parse master) = \
+			$(git rev-parse remotes/origin/master)
+	)
 
 '
 
@@ -517,9 +525,11 @@ test_expect_success 'push preserves up-to-date packed refs' '
 
 	mk_test heads/master &&
 	mk_child child &&
-	(cd child &&
+	(
+		cd child &&
 		git push &&
-	! test -f .git/refs/remotes/origin/master)
+		! test -f .git/refs/remotes/origin/master
+	)
 
 '
 
@@ -530,11 +540,13 @@ test_expect_success 'push does not update local refs on failure' '
 	mkdir testrepo/.git/hooks &&
 	echo exit 1 >testrepo/.git/hooks/pre-receive &&
 	chmod +x testrepo/.git/hooks/pre-receive &&
-	(cd child &&
+	(
+		cd child &&
 		git pull .. master
 		test_must_fail git push &&
 		test $(git rev-parse master) != \
-			$(git rev-parse remotes/origin/master))
+			$(git rev-parse remotes/origin/master)
+	)
 
 '
 
@@ -575,34 +587,41 @@ test_expect_success 'push --delete refuses src:dest refspecs' '
 
 test_expect_success 'warn on push to HEAD of non-bare repository' '
 	mk_test heads/master
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git checkout master &&
-		git config receive.denyCurrentBranch warn) &&
+		git config receive.denyCurrentBranch warn
+	) &&
 	git push testrepo master 2>stderr &&
 	grep "warning: updating the current branch" stderr
 '
 
 test_expect_success 'deny push to HEAD of non-bare repository' '
 	mk_test heads/master
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git checkout master &&
-		git config receive.denyCurrentBranch true) &&
+		git config receive.denyCurrentBranch true
+	) &&
 	test_must_fail git push testrepo master
 '
 
 test_expect_success 'allow push to HEAD of bare repository (bare)' '
 	mk_test heads/master
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git checkout master &&
 		git config receive.denyCurrentBranch true &&
-		git config core.bare true) &&
+		git config core.bare true
+	) &&
 	git push testrepo master 2>stderr &&
 	! grep "warning: updating the current branch" stderr
 '
 
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 	mk_test heads/master
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git checkout master &&
 		git config receive.denyCurrentBranch false
 	) &&
@@ -615,7 +634,8 @@ test_expect_success 'fetch with branches' '
 	git branch second $the_first_commit &&
 	git checkout second &&
 	echo ".." > testrepo/.git/branches/branch1 &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git fetch branch1 &&
 		r=$(git show-ref -s --verify refs/heads/branch1) &&
 		test "z$r" = "z$the_commit" &&
@@ -627,7 +647,8 @@ test_expect_success 'fetch with branches' '
 test_expect_success 'fetch with branches containing #' '
 	mk_empty &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git fetch branch2 &&
 		r=$(git show-ref -s --verify refs/heads/branch2) &&
 		test "z$r" = "z$the_first_commit" &&
@@ -641,7 +662,8 @@ test_expect_success 'push with branches' '
 	git checkout second &&
 	echo "testrepo" > .git/branches/branch1 &&
 	git push branch1 &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		r=$(git show-ref -s --verify refs/heads/master) &&
 		test "z$r" = "z$the_first_commit" &&
 		test 1 = $(git for-each-ref refs/heads | wc -l)
@@ -652,7 +674,8 @@ test_expect_success 'push with branches containing #' '
 	mk_empty &&
 	echo "testrepo#branch3" > .git/branches/branch2 &&
 	git push branch2 &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		r=$(git show-ref -s --verify refs/heads/branch3) &&
 		test "z$r" = "z$the_first_commit" &&
 		test 1 = $(git for-each-ref refs/heads | wc -l)
@@ -660,7 +683,7 @@ test_expect_success 'push with branches containing #' '
 	git checkout master
 '
 
-test_expect_success 'push into aliased refs' '
+test_expect_success 'push into aliased refs (consistent)' '
 	mk_test heads/master &&
 	mk_child child1 &&
 	mk_child child2 &&
@@ -682,4 +705,31 @@ test_expect_success 'push into aliased refs' '
 	)
 '
 
+test_expect_success 'push into aliased refs (inconsistent)' '
+	mk_test heads/master &&
+	mk_child child1 &&
+	mk_child child2 &&
+	(
+		cd child1 &&
+		git branch foo &&
+		git symbolic-ref refs/heads/bar refs/heads/foo
+		git config receive.denyCurrentBranch false
+	) &&
+	(
+		cd child2 &&
+		>path2 &&
+		git add path2 &&
+		test_tick &&
+		git commit -a -m child2 &&
+		git branch foo &&
+		>path3 &&
+		git add path3 &&
+		test_tick &&
+		git commit -a -m child2 &&
+		git branch bar &&
+		test_must_fail git push ../child1 foo bar 2>stderr &&
+		grep "refusing inconsistent update" stderr
+	)
+'
+
 test_done
