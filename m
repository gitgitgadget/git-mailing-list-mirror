Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC41201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 18:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdBXSXj (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 13:23:39 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36835 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdBXSXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 13:23:37 -0500
Received: by mail-pg0-f52.google.com with SMTP id s67so14288293pgb.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 10:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UhlkP4g0Ic71KeDZAiLi3Uv2JJ4FRtx7L0s1xuRVM4g=;
        b=C6uJVdElPnbReb+GLpGQaaTdH0Q0XXEusoKWKGqYwnJQTdqH0EwkL8GgcuNGuxiK9u
         0xYazhBpnunr48HXGsdVYlvMDFRmuNfJh+yaSmFWt+MxrZDOOyawMvfa+4LFoON0qZ1k
         ojTL/vCLS/rh9eGtyoe6TmbL6npUky8WCzzlI0gMnLQdIqqeBJY1HIkeGm3To3pmrO4x
         Sfm976b5Q8Nj24ccIf+a6vnbLtW6wi3tEgZ5PIxpDak3Q92+YeqNhi8w7Ug4D50qmV9F
         a+H4CQlTvE1BNE1tPiaem1HUty+xyxEQYxJhF8kb02gK28auM7hfHzVVB1z5UhCYR4dh
         S+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UhlkP4g0Ic71KeDZAiLi3Uv2JJ4FRtx7L0s1xuRVM4g=;
        b=lxrqR4g8Vn2dwIOfK+Eg7Ps1iJqefGgaRuLShDTfCLE4yH57ywxAcw8RDPyQre1rlM
         LRVKDoGn1bVYyCOgNOK3KLeZESUfk5pCRDEhel4WibpEnpn35PjkdQO8QLkLinQqHE8X
         skFMEvjDuBRC7GAUR97J9JJF5arHbB+oU+0ezwa5bVTQBxJzVvUs8RsjhIHmvr4fO2vw
         6/KsIFRJ5NbxKgAWXlYbNSbW/bvElTcvjIAWlVBHRosItTAenNxIKuCduzwIu4agYLPM
         CIywKQsnm1IL4sw2PC29gvDmo07O6fTJdnquFWjh3I2IR/j1SMT2ly9etgGwWWaoD6RY
         fMiA==
X-Gm-Message-State: AMke39n6LH4kZxrCcZxpzUkZhoL7NjOtZH6VBUjQufDRAm9nNKUhnVWNNlXxO3bdVaWE4vIe
X-Received: by 10.98.163.17 with SMTP id s17mr5116080pfe.61.1487960560100;
        Fri, 24 Feb 2017 10:22:40 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2d9e:d4fd:456:fee4])
        by smtp.gmail.com with ESMTPSA id h14sm16468432pgn.41.2017.02.24.10.22.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 10:22:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     j6t@kdbg.org
Cc:     git@vger.kernel.org, philipoakley@iee.org, gitster@pobox.com,
        sop@google.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule init: warn about falling back to a local path
Date:   Fri, 24 Feb 2017 10:22:37 -0800
Message-Id: <20170224182237.3696-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <ae377bda-0776-f98b-5b6f-afa198647400@kdbg.org>
References: <ae377bda-0776-f98b-5b6f-afa198647400@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is initialized, the config variable 'submodule.<name>.url'
is set depending on the value of the same variable in the .gitmodules
file. When the URL indicates to be relative, then the url is computed
relative to its default remote. The default remote cannot be determined
accurately in all cases, such that it falls back to 'origin'.

The 'origin' remote may not exist, though. In that case we give up looking
for a suitable remote and we'll just assume it to be a local relative path.

This can be confusing to users as there is a lot of guessing involved,
which is not obvious to the user.

So in the corner case of assuming a local autoritative truth, warn the
user to lessen the confusion.

This behavior was introduced in 4d6893200 (submodule add: allow relative
repository path even when no url is set, 2011-06-06), which shared the
code with submodule-init and then ported to C in 3604242f080a (submodule:
port init from shell to C, 2016-04-15).

In case of submodule-add, this behavior makes sense in some use cases[1],
however for submodule-init there does not seem to be an immediate obvious
use case to fall back to a local submodule. However there might be, so
warn instead of die here.

While adding the warning, also clarify the behavior of relative URLs in
the documentation.

[1] e.g. http://stackoverflow.com/questions/8721984/git-ignore-files-for-public-repository-but-not-for-private
"store a secret locally in a submodule, with no intention to publish it"

Reported-by: Shawn Pearce <spearce@spearce.org>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

* reworded sentence to not omit half of it.
* tested rendering to be correct
* warn before xgetcwd

Thanks,
Stefan

 Documentation/git-submodule.txt | 36 ++++++++++++++++++++++--------------
 builtin/submodule--helper.c     |  8 +++-----
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8acc72ebb8..b810d37aa2 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -73,13 +73,17 @@ configuration entries unless `--name` is used to specify a logical name.
 +
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
-or ../), the location relative to the superproject's origin
+or ../), the location relative to the superproject's default remote
 repository (Please note that to specify a repository 'foo.git'
 which is located right next to a superproject 'bar.git', you'll
 have to use '../foo.git' instead of './foo.git' - as one might expect
 when following the rules for relative URLs - because the evaluation
 of relative URLs in Git is identical to that of relative directories).
-If the superproject doesn't have an origin configured
++
+The default remote is the remote of the remote tracking branch
+of the current branch. If no such remote tracking branch exists or
+the HEAD is detached, "origin" is assumed to be the default remote.
+If the superproject doesn't have a default remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
@@ -118,18 +122,22 @@ too (and can also report changes to a submodule's work tree).
 
 init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
-	added and committed elsewhere) by copying submodule
-	names and urls from .gitmodules to .git/config.
-	Optional <path> arguments limit which submodules will be initialized.
-	It will also copy the value of `submodule.$name.update` into
-	.git/config.
-	The key used in .git/config is `submodule.$name.url`.
-	This command does not alter existing information in .git/config.
-	You can then customize the submodule clone URLs in .git/config
-	for your local setup and proceed to `git submodule update`;
-	you can also just use `git submodule update --init` without
-	the explicit 'init' step if you do not intend to customize
-	any submodule locations.
+	added and committed elsewhere) by copying `submodule.$name.url`
+	from .gitmodules to .git/config, resolving relative urls to be
+	relative to the default remote.
++
+Optional <path> arguments limit which submodules will be initialized.
+If no path is specified all submodules are initialized.
++
+When present, it will also copy the value of `submodule.$name.update`.
+This command does not alter existing information in .git/config.
+You can then customize the submodule clone URLs in .git/config
+for your local setup and proceed to `git submodule update`;
+you can also just use `git submodule update --init` without
+the explicit 'init' step if you do not intend to customize
+any submodule locations.
++
+See the add subcommand for the defintion of default remote.
 
 deinit [-f|--force] (--all|[--] <path>...)::
 	Unregister the given submodules, i.e. remove the whole
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 899dc334e3..15a5430c00 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -356,12 +356,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 			strbuf_addf(&remotesb, "remote.%s.url", remote);
 			free(remote);
 
-			if (git_config_get_string(remotesb.buf, &remoteurl))
-				/*
-				 * The repository is its own
-				 * authoritative upstream
-				 */
+			if (git_config_get_string(remotesb.buf, &remoteurl)) {
+				warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
 				remoteurl = xgetcwd();
+			}
 			relurl = relative_url(remoteurl, url, NULL);
 			strbuf_release(&remotesb);
 			free(remoteurl);
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

