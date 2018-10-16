Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B111F453
	for <e@80x24.org>; Tue, 16 Oct 2018 00:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbeJPIHb (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 04:07:31 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:47536 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeJPIHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 04:07:31 -0400
Received: by mail-oi1-f201.google.com with SMTP id w65-v6so14683714oif.14
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4ExBztJif9Jgs5zzu1XWwfkv0Qi9c2OkQjYwnfKPMGI=;
        b=Rp19OvgPI85Fw9HBoVEgd0DladtBxGhZRqy9J8RcjAnwW2PXVY5ReKpEtindm9UpVE
         PJ3xSVvuwoADxcTPEO6cxCWg/obG/KjhffK/Tv2MGcvD3rj8sod/Ak2xc++yl0nw1Hvd
         UoP79pcGMT8F5D+wZL/iKbQLaYSfsNXCGzUkaXM2cdnuOwBGUtmNQfmQA3kgFSgdcAQ4
         jt2Etg/BGvIcP7k2s9VLB8Tp89lQKVJB4npxVOE/Ux8sgYJsCkAVWo0UE5CNEnbfRIVs
         0o84H13HZng0SUaAg3t4kNiOnMLWvZ9o0grBO2fIdOg62f8k6LWDyU0tFG3bWo/vzvjV
         Clpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4ExBztJif9Jgs5zzu1XWwfkv0Qi9c2OkQjYwnfKPMGI=;
        b=Qq9fiTeOm1Wmik/UNh09albP+yYKqARqAVLRBiWWVBqGzYYUlLbHe1COz1GR8UyhFg
         YhV+/uyNYJNEhkpEEGylksQB3CAXG8KNNut24rtU87OhBqyh7HK1FxwXctmXmVwzrkOA
         QKIzQszIHDrvm92V0xgV6Jvo+edE6XUhlTGSMk2qI05MSnjfIneo+pIi81lpIT6N7zot
         /uZCkPp6HeiLXXh2Wr7K5HbuKJmzsfXtJHlMnguICdwRYz+RUMSmyrp9wblCRSeWZteC
         Kfjgr9/wwHe2YfebEjr1CxFd/t++0ad6jMaDAoiUadTmHdQJKTBR+wD6Wgfn/9h76v6s
         P7zA==
X-Gm-Message-State: ABuFfoi3g13wPDV5gm0DUtfuO5mkHslga6bEVZlBd9ISJHU/4Gcpa2Tn
        3vQu1mCOty4lT4TU7jEtvck/sUzgH6Ip
X-Google-Smtp-Source: ACcGV604kqy9Slr5JgbphtPUApvSWAdgKwFZYEQt2WFFroH1+FIDY2qbVdB9dZaBlFgPbaUoGoCQx853W++6
X-Received: by 2002:a9d:4585:: with SMTP id x5mr16717859ote.67.1539649192962;
 Mon, 15 Oct 2018 17:19:52 -0700 (PDT)
Date:   Mon, 15 Oct 2018 17:19:49 -0700
In-Reply-To: <20181012215314.44266-1-sbeller@google.com>
Message-Id: <20181016001949.173333-1-sbeller@google.com>
Mime-Version: 1.0
References: <20181012215314.44266-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] submodule helper: convert relative URL to absolute URL if needed
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule helper update_clone called by "git submodule update",
clones submodules if needed. As submodules used to have the URL indicating
if they were active, the step to resolve relative URLs was done in the
"submodule init" step. Nowadays submodules can be configured active without
calling an explicit init, e.g. via configuring submodule.active.

When trying to obtain submodules that are set active this way, we'll
fallback to the URL found in the .gitmodules, which may be relative to the
superproject, but we do not resolve it, yet:

    git clone https://gerrit.googlesource.com/gerrit
    cd gerrit && grep url .gitmodules
	url = ../plugins/codemirror-editor
	...
    git config submodule.active .
    git submodule update
fatal: repository '../plugins/codemirror-editor' does not exist
fatal: clone of '../plugins/codemirror-editor' into submodule path '/tmp/gerrit/plugins/codemirror-editor' failed
Failed to clone 'plugins/codemirror-editor'. Retry scheduled
[...]
fatal: clone of '../plugins/codemirror-editor' into submodule path '/tmp/gerrit/plugins/codemirror-editor' failed
Failed to clone 'plugins/codemirror-editor' a second time, aborting
[...]

To resolve the issue, factor out the function that resolves the relative
URLs in "git submodule init" (in the submodule helper in the init_submodule
function) and call it at the appropriate place in the update_clone helper.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Jonathan wrote:
> Ah, this is moved code. I should have used --color-moved. ;-)

Yes, any cleanup should go on top.

I extended the commit message and made sure not to leak memory.

When rerolling origin/xxx/sb-submodule-recursive-fetch-gets-the-tip-in-pu,
there will be conflicts with this series, but I can work with that.

 builtin/submodule--helper.c | 48 ++++++++++++++++++++++++-------------
 t/t7400-submodule-basic.sh  | 24 +++++++++++++++++++
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f6fb8991f3..03f5e0d03e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -584,6 +584,27 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+
+static char *compute_submodule_clone_url(const char *rel_url)
+{
+	char *remoteurl, *relurl;
+	char *remote = get_default_remote();
+	struct strbuf remotesb = STRBUF_INIT;
+
+	strbuf_addf(&remotesb, "remote.%s.url", remote);
+	free(remote);
+
+	if (git_config_get_string(remotesb.buf, &remoteurl)) {
+		warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
+		remoteurl = xgetcwd();
+	}
+	relurl = relative_url(remoteurl, rel_url, NULL);
+	strbuf_release(&remotesb);
+	free(remoteurl);
+
+	return relurl;
+}
+
 struct init_cb {
 	const char *prefix;
 	unsigned int flags;
@@ -634,21 +655,9 @@ static void init_submodule(const char *path, const char *prefix,
 		/* Possibly a url relative to parent */
 		if (starts_with_dot_dot_slash(url) ||
 		    starts_with_dot_slash(url)) {
-			char *remoteurl, *relurl;
-			char *remote = get_default_remote();
-			struct strbuf remotesb = STRBUF_INIT;
-			strbuf_addf(&remotesb, "remote.%s.url", remote);
-			free(remote);
-
-			if (git_config_get_string(remotesb.buf, &remoteurl)) {
-				warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
-				remoteurl = xgetcwd();
-			}
-			relurl = relative_url(remoteurl, url, NULL);
-			strbuf_release(&remotesb);
-			free(remoteurl);
-			free(url);
-			url = relurl;
+			char *to_free = url;
+			url = compute_submodule_clone_url(url);
+			free(to_free);
 		}
 
 		if (git_config_set_gently(sb.buf, url))
@@ -1562,8 +1571,13 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	if (repo_config_get_string_const(the_repository, sb.buf, &url))
-		url = sub->url;
+	if (repo_config_get_string_const(the_repository, sb.buf, &url)) {
+		if (starts_with_dot_slash(sub->url) ||
+		    starts_with_dot_dot_slash(sub->url))
+			url = compute_submodule_clone_url(sub->url);
+		else
+			url = sub->url;
+	}
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/.git", ce->name);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c0ffc1022a..76a7cb0af7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1224,6 +1224,30 @@ test_expect_success 'submodule update and setting submodule.<name>.active' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone active submodule without submodule url set' '
+	test_when_finished "rm -rf test/test" &&
+	mkdir test &&
+	# another dir breaks accidental relative paths still being correct
+	git clone file://"$pwd"/multisuper test/test &&
+	(
+		cd test/test &&
+		git config submodule.active "." &&
+
+		# do not pass --init flag, as the submodule is already active:
+		git submodule update &&
+		git submodule status >actual_raw &&
+
+		cut -c 1,43- actual_raw >actual &&
+		cat >expect <<-\EOF &&
+		 sub0 (test2)
+		 sub1 (test2)
+		 sub2 (test2)
+		 sub3 (test2)
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'clone --recurse-submodules with a pathspec works' '
 	test_when_finished "rm -rf multisuper_clone" &&
 	cat >expected <<-\EOF &&
-- 
2.19.0

