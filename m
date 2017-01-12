Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ADF320798
	for <e@80x24.org>; Thu, 12 Jan 2017 00:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762237AbdALANB (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 19:13:01 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35417 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753140AbdALANA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 19:13:00 -0500
Received: by mail-pf0-f171.google.com with SMTP id f144so2247993pfa.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 16:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2b1dq10GT+Iw1Es5Q2mHs8CX8nNY/EO8c1pOw3ZmLA=;
        b=Rhd3DaznsWgr5BguXnF0l/2xt6sFEJxiBOOFfe0z63ZAPML9e2c0UM/3tzQ+kiAihI
         jz5azZD2HZbOkYHQX3uwgwwg/qPuoQmRzyPNGHjGtdw1C7nFrbmHJpofGyWXIuajAFOK
         IxHPccd1d2RoUi8sGtvkUfIMFo0IGDj39B93IaL5N0JFTNjWefL5cgWlb3pRihXEV+0o
         Zl2SHj4edULKGWTTpvUhYLyrYvjVAtfPR4OjPoLahH2fb5RZNzOjHOug+iYZQb40d78E
         QWhjn1Fy1+XbusvX1MGqtA5I28R1tveer9o4mwhxEAWpQzY6ye99nTkyjc7B109KAyZb
         /L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2b1dq10GT+Iw1Es5Q2mHs8CX8nNY/EO8c1pOw3ZmLA=;
        b=j0BK5xWFdTN0Xl+1c4ONopx3WEnCAVzW9oxQIszBbnHQnv6Weau+0vU4AN/98jA2k8
         j3LJdmc6KDXFBqBFKTQLNoms1aYnDMTLmkwUIKJQahnFpi2zuLfzDI3yOrYu5fn1WwXF
         Y5OI+YB7CnjCwKVlWQ9FxXTtbDZak5/Ein8Btli80fk6YjE6hE8Hdjtpis+RcqZyFIO/
         bqwWWBS9qRgssntEdYoy0u7VTKoEbRvuO9Tq3bmBpH+fYzDIHIO6AZ41kC7LbMpTo+Dm
         yPUwhpCJ/Pu5bu+5DLpiTeOXydchec48MSvpC0bGonwaDyPQXO2MHzneqXO7qJAFSihJ
         Unww==
X-Gm-Message-State: AIkVDXJ7hLr8gHOumln0MpzaiboABrrR7IFq+1sDartH9VqRvbEGZiJP6HJw3oBZhEBSgWrw
X-Received: by 10.98.134.2 with SMTP id x2mr13450885pfd.158.1484179979395;
        Wed, 11 Jan 2017 16:12:59 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7d8d:4172:e393:5f49])
        by smtp.gmail.com with ESMTPSA id u3sm16356030pfk.3.2017.01.11.16.12.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Jan 2017 16:12:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/4] unpack-trees: support super-prefix option
Date:   Wed, 11 Jan 2017 16:12:53 -0800
Message-Id: <20170112001253.27679-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.259.g7b30ecf4f0
In-Reply-To: <xmqq37gpnuyi.fsf@gitster.mtv.corp.google.com>
References: <xmqq37gpnuyi.fsf@gitster.mtv.corp.google.com>
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
---

This is only patchv4 that is rerolled, patches 1-3 remain as is.

The test uses '\'' now, and the super_prefixed function is rewritten
using the flow Junio suggested.

The commit message got enhanced.

Thanks,
Stefan

 git.c                       |  2 +-
 t/t1001-read-tree-m-2way.sh |  8 ++++++++
 unpack-trees.c              | 38 +++++++++++++++++++++++++++++++++++---
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index dce529fcbf..acbabd1298 100644
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
index 7a6df99d10..0a24472359 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -52,6 +52,36 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	  ? ((o)->msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
+static const char *super_prefixed(const char *path)
+{
+	static struct strbuf buf[2] = {STRBUF_INIT, STRBUF_INIT};
+	static int super_prefix_len = -1;
+	static unsigned idx = 0;
+
+	if (super_prefix_len < 0) {
+		if (!get_super_prefix())
+			super_prefix_len = 0;
+		else {
+			int i;
+
+			super_prefix_len = strlen(get_super_prefix());
+			for (i = 0; i < ARRAY_SIZE(buf); i++)
+				strbuf_addstr(&buf[i], get_super_prefix());
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
@@ -172,7 +202,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
 			     const char *path)
 {
 	if (!o->show_all_errors)
-		return error(ERRORMSG(o, e), path);
+		return error(ERRORMSG(o, e), super_prefixed(path));
 
 	/*
 	 * Otherwise, insert in a list for future display by
@@ -196,7 +226,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
 			something_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
-			error(ERRORMSG(o, e), path.buf);
+			error(ERRORMSG(o, e), super_prefixed(path.buf));
 			strbuf_release(&path);
 		}
 		string_list_clear(rejects, 0);
@@ -1918,7 +1948,9 @@ int bind_merge(const struct cache_entry * const *src,
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
2.11.0.259.g7b30ecf4f0

