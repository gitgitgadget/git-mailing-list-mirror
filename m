From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] pull: pass --allow-unrelated-histories to "git merge"
Date: Thu, 21 Apr 2016 12:24:58 -0700
Message-ID: <20160421192500.23563-3-gitster@pobox.com>
References: <20160421192500.23563-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 21:31:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atKJu-0008SD-L9
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 21:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbcDUTbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 15:31:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751718AbcDUTbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 15:31:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F65713197;
	Thu, 21 Apr 2016 15:25:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=TAV+
	iyRkrwfbK/603EkkUd87Bag=; b=o8Pu3TJzrd+jVR5QsRGrKTOiZsZ8sFw6To+N
	Xvu5jx2CFINqMk1CXY8yThmphOGGvw6vEWcls7p484Ml98EFSRqWD9KIds1g23Vq
	lNWjt2bZ2wGGqLqKScasUSrV4n8OeXgk6e7hkHFrfW2EZquQh3D8m/iaI60Ku4YY
	tMKID+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BM6VE3
	hYlCzx6zJqYTtk8ufWBepWEtuJ2uoUWwauh65+rGTkaOVrOkia1bF7jvcZCtQdxu
	KpEDZnkaqcaqduU1yjTuoWpKoZZrUWiWxmAXpNi3aBbGDuTi753YuxCK6x1YGPe3
	g+BHMQBG8WjN9s66ZZvOglHUrqaNwolVXACBs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 57CEF13196;
	Thu, 21 Apr 2016 15:25:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF2F313195;
	Thu, 21 Apr 2016 15:25:05 -0400 (EDT)
X-Mailer: git-send-email 2.8.1-422-g6d9b748
In-Reply-To: <20160421192500.23563-1-gitster@pobox.com>
X-Pobox-Relay-ID: C0AD457A-07F6-11E6-9A2E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292144>

An earlier commit said:

    We could add the same option to "git pull" and have it passed
    through to underlying "git merge".  I do not have a fundamental
    opposition against such a feature, but this commit does not do
    so and instead leaves it as low-hanging fruit for others,
    because such a "two project merge" would be done after fetching
    the other project into some location in the working tree of an
    existing project and making sure how well they fit together, it
    is sufficient to allow a local merge without such an option
    pass-through from "git pull" to "git merge".

Prepare a patch to make it a reality, just in case it is needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-merge.txt     | 14 +-------------
 Documentation/merge-options.txt |  8 ++++++++
 builtin/pull.c                  |  6 ++++++
 t/t5521-pull-options.sh         | 21 +++++++++++++++++++++
 4 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 689aa4c..b758d55 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
+	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
@@ -98,19 +99,6 @@ commit or stash your changes before running 'git merge'.
 'git merge --abort' is equivalent to 'git reset --merge' when
 `MERGE_HEAD` is present.
 
---allow-unrelated-histories::
-	By default, `git merge` command refuses to merge histories
-	that do not share a common ancestor.  This option can be
-	used to override this safety when merging histories of two
-	projects that started their lives independently.  As that is
-	a very rare occasion, no configuration variable to enable
-	this by default exists and will not be added, and the list
-	of options at the top of this documentation does not mention
-	this option.  Also `git pull` does not pass this option down
-	to `git merge` (instead, you `git fetch` first, examine what
-	you will be merging and then `git merge` locally with this
-	option).
-
 <commit>...::
 	Commits, usually other branch heads, to merge into our branch.
 	Specifying more than one commit will create a merge with
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index f08e9b8..dfb43d0 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -114,3 +114,11 @@ ifndef::git-pull[]
 	reporting.
 
 endif::git-pull[]
+
+--allow-unrelated-histories::
+	By default, `git merge` command refuses to merge histories
+	that do not share a common ancestor.  This option can be
+	used to override this safety when merging histories of two
+	projects that started their lives independently. As that is
+	a very rare occasion, no configuration variable to enable
+	this by default exists and will not be added.
diff --git a/builtin/pull.c b/builtin/pull.c
index 5145fc6..797932d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static char *opt_verify_signatures;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
 static char *opt_gpg_sign;
+static int opt_allow_unrelated_histories;
 
 /* Options passed to git-fetch */
 static char *opt_all;
@@ -155,6 +156,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU('S', "gpg-sign", &opt_gpg_sign, N_("key-id"),
 		N_("GPG sign commit"),
 		PARSE_OPT_OPTARG),
+	OPT_SET_INT(0, "allow-unrelated-histories",
+		    &opt_allow_unrelated_histories,
+		    N_("allow merging unrelated histories"), 1),
 
 	/* Options passed to git-fetch */
 	OPT_GROUP(N_("Options related to fetching")),
@@ -603,6 +607,8 @@ static int run_merge(void)
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_allow_unrelated_histories > 0)
+		argv_array_push(&args, "--allow-unrelated-histories");
 
 	argv_array_push(&args, "FETCH_HEAD");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 18372ca..ded8f98 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -144,4 +144,25 @@ test_expect_success 'git pull --all --dry-run' '
 	)
 '
 
+test_expect_success 'git pull --allow-unrelated-histories' '
+	test_when_finished "rm -fr src dst" &&
+	git init src &&
+	(
+		cd src &&
+		test_commit one &&
+		test_commit two
+	) &&
+	git clone src dst &&
+	(
+		cd src &&
+		git checkout --orphan side HEAD^ &&
+		test_commit three
+	) &&
+	(
+		cd dst &&
+		test_must_fail git pull ../src side &&
+		git pull --allow-unrelated-histories ../src side
+	)
+'
+
 test_done
-- 
2.8.1-422-g6d9b748
