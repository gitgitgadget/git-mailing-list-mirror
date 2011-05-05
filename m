From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Add default merge options for all branches
Date: Wed, 04 May 2011 17:42:51 -0700
Message-ID: <7vsjsuc704.fsf@alter.siamese.dyndns.org>
References: <20110503090351.GA27862@elie> <4DC1CE16.5030808@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Thu May 05 02:43:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHmeu-0002MF-3l
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 02:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab1EEAnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 20:43:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab1EEAnF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 20:43:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3FA895AF6;
	Wed,  4 May 2011 20:45:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FlHNprhDsGTOnRtIpkC7XO0b1eI=; b=rYDQ2A
	Rq/3mxzKH/OyHqKvnnaXUPA/QTfVL8QNDeNUzN6J/WBAf7paC2lbYhUPgy16UFL3
	oxIE8cP3Hsd/9OQoSQQGKsTiESOK8NWsR6AM1xRg1o5RxcRmOy+BQ1RzJ9mmq3Ua
	Ml3CJ2MweJCkzS5xaV8jZwLQzihObm5W3ISkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ORRvuDwsPVfUsnD0bzQ/Uhd0bGl2kmaf
	M9kMmMXBgzsXg//xl3SM+mY1txrH4lNA7SF7neF7LJZ0J0rrOLCMf7fZ9G1rt8jl
	PqCBXRortz1oa0pseepBMDV2ML4Pg1TIc9Ax7yO4F/7Ai6X0qsqg9/vfnh8vqM2R
	uN0FWNXIg6M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F1145AF5;
	Wed,  4 May 2011 20:45:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 69D6D5AF3; Wed,  4 May 2011
 20:44:57 -0400 (EDT)
In-Reply-To: <4DC1CE16.5030808@dailyvoid.com> (Michael Grubb's message of
 "Wed, 04 May 2011 17:07:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E92F42F0-76B0-11E0-8F3A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172782>

Thanks.

I think we still need to work on this a bit more, but I found an unrelated
and nastier issue before this patch can sanely be applied.

> +test_expect_success 'combine branch.master.mergeoptions with merge.ff' '
> +	git reset --hard c0 &&
> +	git config branch.master.mergeoptions --ff
> +	git config merge.ff false
> +	test_tick &&
> +	git merge c1 &&
> +	git config --remove-section "branch.master" &&
> +	git config --remove-section "merge" &&
> +	verify_merge file result.1 &&
> +	verify_parents "$c0"
> +'

If you insert an "exit" after this test and inspect the resulting commit,
you will see that it created a merge.

	Side note: I think verify_parents is buggy. It only makes sure
	that the earlier parents of HEAD match the commits given, and does
	not care if there actually are more parents.

In any case, your test exposed an ancient breakage ever since the
per-branch mergeoptions was introduced back when git-merge was a shell
script (aec7b36 (git-merge: add support for branch.<name>.mergeoptions,
2007-09-24).

I am not going to fix verify_parents tonight, as I have other git things
to do.

-- >8 --
Subject: [PATCH] merge: fix branch.<name>.mergeoptions

The parsing of the additional command line parameters supplied to
the branch.<name>.mergeoptions configuration variable was implemented
at the wrong stage.  If any merge-related variable came after we read
branch.<name>.mergeoptions, the earlier value was overwritten.

We should first read all the merge.* configuration, override them by
reading from branch.<name>.mergeoptions and then finally read from
the command line.

This patch should fix it, even though I now strongly suspect that
branch.<name>.mergeoptions that gives a single command line that
needs to be parsed was likely to be an ill-conceived idea to begin
with.  Sigh...

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge.c  |   39 +++++++++++++++++++++++++--------------
 t/t7600-merge.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 3aaec7b..01389a3 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -54,6 +54,7 @@ static size_t use_strategies_nr, use_strategies_alloc;
 static const char **xopts;
 static size_t xopts_nr, xopts_alloc;
 static const char *branch;
+static char *branch_mergeoptions;
 static int verbosity;
 static int allow_rerere_auto;
 
@@ -474,25 +475,33 @@ cleanup:
 	strbuf_release(&bname);
 }
 
+static void parse_branch_merge_options(char *bmo)
+{
+	const char **argv;
+	int argc;
+	char *buf;
+
+	if (!bmo)
+		return;
+	argc = split_cmdline(bmo, &argv);
+	if (argc < 0)
+		die("Bad branch.%s.mergeoptions string", branch);
+	argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
+	memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
+	argc++;
+	parse_options(argc, argv, NULL, builtin_merge_options,
+		      builtin_merge_usage, 0);
+	free(buf);
+}
+
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
 	if (branch && !prefixcmp(k, "branch.") &&
 		!prefixcmp(k + 7, branch) &&
 		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
-		const char **argv;
-		int argc;
-		char *buf;
-
-		buf = xstrdup(v);
-		argc = split_cmdline(buf, &argv);
-		if (argc < 0)
-			die("Bad branch.%s.mergeoptions string", branch);
-		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
-		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
-		argc++;
-		parse_options(argc, argv, NULL, builtin_merge_options,
-			      builtin_merge_usage, 0);
-		free(buf);
+		free(branch_mergeoptions);
+		branch_mergeoptions = xstrdup(v);
+		return 0;
 	}
 
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
@@ -918,6 +927,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
 
+	if (branch_mergeoptions)
+		parse_branch_merge_options(branch_mergeoptions);
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
 			builtin_merge_usage, 0);
 	if (verbosity < 0)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 57f6d2b..56c653d 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -372,6 +372,38 @@ test_expect_success 'merge c1 with c2 (no-commit in config)' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2 (log in config)' '
+	git config branch.master.mergeoptions "" &&
+	git reset --hard c1 &&
+	git merge --log c2 &&
+	git show -s --pretty=tformat:%s%n%b >expect &&
+
+	git config branch.master.mergeoptions --log &&
+	git reset --hard c1 &&
+	git merge c2 &&
+	git show -s --pretty=tformat:%s%n%b >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'merge c1 with c2 (log in config gets overridden)' '
+	(
+		git config --remove-section branch.master
+		git config --remove-section merge
+	)
+	git reset --hard c1 &&
+	git merge c2 &&
+	git show -s --pretty=tformat:%s%n%b >expect &&
+
+	git config branch.master.mergeoptions "--no-log" &&
+	git config merge.log true &&
+	git reset --hard c1 &&
+	git merge c2 &&
+	git show -s --pretty=tformat:%s%n%b >actual &&
+
+	test_cmp expect actual
+'
+
 test_expect_success 'merge c1 with c2 (squash in config)' '
 	git reset --hard c1 &&
 	git config branch.master.mergeoptions "--squash" &&
-- 
1.7.5.284.g84c3a8

        
