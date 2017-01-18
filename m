Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E338A20756
	for <e@80x24.org>; Wed, 18 Jan 2017 01:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdARBFb (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 20:05:31 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33326 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdARBF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 20:05:28 -0500
Received: by mail-pg0-f50.google.com with SMTP id 204so28908665pge.0
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 17:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tXzCUEbVcJxMTMTe3Xn5tO7f94KFdsJyZiwljEE4oIE=;
        b=FVNLzRfnVjRUG0MO8ax4AAKDmn46rICndta5vJ70FfB+L5feKI1zNoHW8Q0J9Ko9RQ
         b0QxiVjXFZw6kDBLopJszu52WHI1FtDUZe+/r9ZyDePCAYqyBmhOQReudNom4XWsxtjL
         OYu74G1vEoJu1kUYUIqzLY70hkoZDLn7ifhirNcNNY7KoRj2CkY+ZMTGs2zLjJQT8D8C
         sZa1vaUdUFZIhCCy6MtOH9OR4aHrvPyUdm1VXmeBAAiqMC8AuVYC3XL4PkBCPJxUzOO+
         xN8MLxlNNuGi5B6T8RguweXRIUDDVmtn9z78PlO7AIUzCEC2QI6YNak5QS08K6bzeDeA
         BgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tXzCUEbVcJxMTMTe3Xn5tO7f94KFdsJyZiwljEE4oIE=;
        b=C3AjyqWCy6PubY5wEq6KhqFJy9GwjX9KrKICZdpD1S+9crSuGzSmIzE9QnPnR5E/Um
         DEJPsmsyW/k+OeYUlonWv7j46oOp64IBmirovazYHF8Uruq8XUdQVM9Nk/anMcF/PQ29
         WvNxQmQvMo4kwN1uxZ0MTmcHmo6czg2UsRgzUffahvoJyUQovVkcYtNc1uG9qwEQYNxH
         jSXuc/VHFyma2UqWyivHNAvN9WbYZJrmFNC8v/sFL21pYUnqlyZ2iEraLLP8hczM6gqt
         yhqX2fShw7/ppKVQEm5Cl5qU3Fvh33lvx1TGRIGNnZLHwk14lNzK4x3Fn4265Xow1Ui2
         pU0w==
X-Gm-Message-State: AIkVDXLP0XgnkAfshAN+ydV67LuS1q9KCw+3YFOkmyCZvEa/SpF8H3XbvdBtj7+LaqsaxQxp
X-Received: by 10.84.173.195 with SMTP id p61mr915885plb.158.1484701527968;
        Tue, 17 Jan 2017 17:05:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:871:ca27:8566:e7e])
        by smtp.gmail.com with ESMTPSA id x81sm58470504pff.69.2017.01.17.17.05.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Jan 2017 17:05:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/4] unpack-trees: support super-prefix option
Date:   Tue, 17 Jan 2017 17:05:20 -0800
Message-Id: <20170118010520.8804-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future we want to support working tree operations within submodules,
e.g. "git checkout --recurse-submodules", which will update the submodule
to the commit as recorded in its superproject. In the submodule the
unpack-tree operation is carried out as usual, but the reporting to the
user needs to prefix any path with the superproject. The mechanism for
this is the super-prefix. (see 74866d757, git: make super-prefix option)

Add support for the super-prefix option for commands that unpack trees
by wrapping any path output in unpacking trees in the newly introduced
super_prefixed function. This new function prefixes any path with the
super-prefix if there is one.  Assuming the submodule case doesn't happen
in the majority of the cases, we'd want to have a fast behavior for no
super prefix, i.e. no reallocation/copying, but just returning path.

Another aspect of introducing the `super_prefixed` function is to consider
who owns the memory and if this is the right place where the path gets
modified. As the super prefix ought to change the output behavior only and
not the actual unpack tree part, it is fine to be that late in the line.
As we get passed in 'const char *path', we cannot change the path itself,
which means in case of a super prefix we have to copy over the path.
We need two static buffers in that function as the error messages
contain at most two paths.

For testing purposes enable it in read-tree, which has no output
of paths other than an unpack-trees.c. These are all converted in
this patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

This replaces the last two commits (squash and unpack-trees:
support super-prefix option) of sb/unpack-trees-super-prefix.

> * sb/unpack-trees-super-prefix (2017-01-12) 5 commits
>  - SQUASH
>  - unpack-trees: support super-prefix option
>  - t1001: modernize style
>  - t1000: modernize style
>  - read-tree: use OPT_BOOL instead of OPT_SET_INT
>
>  "git read-tree" and its underlying unpack_trees() machinery learned
>  to report problematic paths prefixed with the --super-prefix option.
>
>  Expecting a reroll.
>  The first three are in good shape.  The last one needs a better
>  explanation and possibly an update to its test.
>  cf. <CAGZ79kaHDnVLQr8WLoaD5KKs7EqeW=KbkptF=iHpU5t054Xcdw@mail.gmail.com>
>

This paragraph is for the first version of the last patch?
I reviewed what you queued and both the test is in modern
style as well as the commit message is adequate now.

I agree the SQUASH commit is a good idea, so this is a reroll
with the SQUASH squashed.  No further changes applied.

Thanks,
Stefan

 git.c                       |  2 +-
 t/t1001-read-tree-m-2way.sh |  8 ++++++++
 unpack-trees.c              | 43 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index bbaa949e9c..50e559c2a8 100644
--- a/git.c
+++ b/git.c
@@ -471,7 +471,7 @@ static struct cmd_struct commands[] = {
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
-	{ "read-tree", cmd_read_tree, RUN_SETUP },
+	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 7b70089705..5ededd8e40 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -363,6 +363,14 @@ test_expect_success 'a/b (untracked) vs a, plus c/d case test.' '
 	test -f a/b
 '
 
+test_expect_success 'read-tree supports the super-prefix' '
+	cat <<-EOF >expect &&
+		error: Updating '\''fictional/a'\'' would lose untracked files in it
+	EOF
+	test_must_fail git --super-prefix fictional/ read-tree -u -m "$treeH" "$treeM" 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'a/b vs a, plus c/d case setup.' '
 	rm -f .git/index &&
 	rm -fr a &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 7a6df99d10..eee4865804 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -52,6 +52,41 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	  ? ((o)->msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
+static const char *super_prefixed(const char *path)
+{
+	/*
+	 * It is necessary and sufficient to have two static buffers
+	 * here, as the return value of this function is fed to
+	 * error() using the unpack_*_errors[] templates we see above.
+	 */
+	static struct strbuf buf[2] = {STRBUF_INIT, STRBUF_INIT};
+	static int super_prefix_len = -1;
+	static unsigned idx = ARRAY_SIZE(buf) - 1;
+
+	if (super_prefix_len < 0) {
+		const char *super_prefix = get_super_prefix();
+		if (!super_prefix) {
+			super_prefix_len = 0;
+		} else {
+			int i;
+			for (i = 0; i < ARRAY_SIZE(buf); i++)
+				strbuf_addstr(&buf[i], super_prefix);
+			super_prefix_len = buf[0].len;
+		}
+	}
+
+	if (!super_prefix_len)
+		return path;
+
+	if (++idx >= ARRAY_SIZE(buf))
+		idx = 0;
+
+	strbuf_setlen(&buf[idx], super_prefix_len);
+	strbuf_addstr(&buf[idx], path);
+
+	return buf[idx].buf;
+}
+
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd)
 {
@@ -172,7 +207,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
 			     const char *path)
 {
 	if (!o->show_all_errors)
-		return error(ERRORMSG(o, e), path);
+		return error(ERRORMSG(o, e), super_prefixed(path));
 
 	/*
 	 * Otherwise, insert in a list for future display by
@@ -196,7 +231,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
 			something_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
-			error(ERRORMSG(o, e), path.buf);
+			error(ERRORMSG(o, e), super_prefixed(path.buf));
 			strbuf_release(&path);
 		}
 		string_list_clear(rejects, 0);
@@ -1918,7 +1953,9 @@ int bind_merge(const struct cache_entry * const *src,
 			     o->merge_size);
 	if (a && old)
 		return o->gently ? -1 :
-			error(ERRORMSG(o, ERROR_BIND_OVERLAP), a->name, old->name);
+			error(ERRORMSG(o, ERROR_BIND_OVERLAP),
+			      super_prefixed(a->name),
+			      super_prefixed(old->name));
 	if (!a)
 		return keep_entry(old, o);
 	else
-- 
2.11.0.299.g762782ba8a

