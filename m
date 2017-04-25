Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C127B1FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 19:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1432250AbdDYTNu (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 15:13:50 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34851 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1432239AbdDYTNt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 15:13:49 -0400
Received: by mail-io0-f178.google.com with SMTP id r16so216059947ioi.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qdARXrOgeAgfg8cUJLJDd0jExt1gRky9jWiZGF+KPiY=;
        b=BXg7Pp957hKMpm/i/gwxUNH/H/5OJ9YoT4OKZRJuuB0pd4SBavECEQ8FWOnt9+3b16
         CfS2dIVNEcl1HZOKCgPHDI2jPzOSPPMylh7ptxvVQFV2j7fCPfGhU16X4olNuNOk8gmC
         8jn9EqbeYszgYu7n/f6NFYiX3RdZsaCeROgI8FgPlgL1PGwX3zIHhEaFmiL8xp8f/Dcv
         pI++UF0Rod1kfZCuCNZJvE7zgKLvDNsxMQYQB7m2R5tDCqFFcTz3Zzk5ePuKxfFADzJt
         RJUNpGxAASs44iew7hEnvhEUP+tNiTuY1qBO8QyzVGDQVJCungY6r/pjoRqrjK8B4j7I
         GHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qdARXrOgeAgfg8cUJLJDd0jExt1gRky9jWiZGF+KPiY=;
        b=uYu/16ITGPFO8k4WYYp/tm0vlarhYgBH1OWLinD0YIk00GcSTY/CAaCor+aye/GAzN
         2JbJ274FnNt23/A7nm+7eZxRf3CBWQX4aRp4rWZqtWIaGJjfntTnTtY5SJ191O3ySmgx
         PABvfiLGUyR9AG/bXC9aLSiFfB+Zl+mxD/LuV6BGka+q6Gbca0VVoY6CPdRp7yA9MJCv
         lKKLEO7TElbHBEXfXdkQ+ShiOrFt4+/Egv2dDI92KzLsLOYMP52rovVzWiGmWqWWIhM1
         yr0CwV8X2aFbEQKQ2ngpDX1sni1Xp3o5iXVgIuo4b5a1ZaBgcSvjeEYb1Fkm9/3RKono
         N8LA==
X-Gm-Message-State: AN3rC/448W3387PBei7Gw6OaT0lvDPFD03Y6ePyJ5SGM+rWF3RQDQkWK
        Q1seB8fOhjfbTMUqqb4N2x6FaAMT5CJ/PLk=
X-Received: by 10.107.138.9 with SMTP id m9mr18428276iod.80.1493147628398;
 Tue, 25 Apr 2017 12:13:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 25 Apr 2017 12:13:27 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 25 Apr 2017 21:13:27 +0200
Message-ID: <CACBZZX5u5fF4fJBJ3CwH0DmLBw4D32jN5o=Om-iqwQdPG93DFg@mail.gmail.com>
Subject: BUG: wildmatches like foo/**/**/bar don't match properly due to
 internal optimizations
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thought I'd just start another thread for this rather than tack it
onto the pathalogical case thread.

In commit 4c251e5cb5 ("wildmatch: make /**/ match zero or more
directories", 2012-10-15) Duy added support for ** in globs.

One test-case for this is:

    match 1 0 'foo/baz/bar' 'foo/**/**/bar'

I.e. foo/**/**/bar matches foo/baz/bar. However due to some
pre-pruning we do in pathspec/ls-tree we can't ever match it, because
the first thing we do is peel the first part of the path/pattern off,
i.e. foo/, and then match baz/bar against **/**/bar.

The monkeypatch at the end of this mail makes this case work, but
breaks some others, and more importantly now e.g. on git.git we have
to call wildmatch() ~3K times for all the files we track, instead of
just for stuff in my foo/ folder.

So I don't think this needs to be made to work, being able to prune
patterns like this is very useful, but:

a) the wildmatch tests are lacking because they just call the
low-level function without a helper, but that's not actually how it
gets invoked by anything that matters

b) If we're going to be using wildmatch but implicitly not supporting
some of its very expensive optimization-beating syntax we should
probably make that an error explicitly.

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a6c70dbe9e..4285a09ccc 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -235,3 +235,3 @@ static void show_ce_entry(const char *tag, const
struct cache_entry *ce)
        struct strbuf name = STRBUF_INIT;
-       int len = max_prefix_len;
+       int len = 0;
        if (super_prefix)
@@ -640,2 +640,3 @@ int cmd_ls_files(int argc, const char **argv,
const char *cmd_prefix)
        max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
+       max_prefix_len = 0;

diff --git a/dir.c b/dir.c
index f451bfa48c..b4399f042c 100644
--- a/dir.c
+++ b/dir.c
@@ -86,3 +86,3 @@ int git_fnmatch(const struct pathspec_item *item,
                return wildmatch(pattern, string,
-                                item->magic & PATHSPEC_ICASE ? WM_CASEFOLD : 0,
+                                item->magic & PATHSPEC_ICASE ?
WM_CASEFOLD : WM_PATHNAME,
                                 NULL);
@@ -316,3 +316,3 @@ static int match_pathspec_item(const struct
pathspec_item *item, int prefix,
            !git_fnmatch(item, match, name,
-                        item->nowildcard_len - prefix))
+                        prefix))
                return MATCHED_FNMATCH;
