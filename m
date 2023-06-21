Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7203CEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 08:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFUI5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 04:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjFUI5T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 04:57:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F7B1FEC
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 01:55:28 -0700 (PDT)
Received: (qmail 19925 invoked by uid 109); 21 Jun 2023 08:55:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jun 2023 08:55:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14122 invoked by uid 111); 21 Jun 2023 08:55:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jun 2023 04:55:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jun 2023 04:55:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: bug in en/header-split-cache-h-part-3, was Re: What's cooking in
 git.git (Jun 2023, #05; Tue, 20)
Message-ID: <20230621085526.GA920315@coredump.intra.peff.net>
References: <xmqqedm5k7dx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedm5k7dx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 05:04:42PM -0700, Junio C Hamano wrote:

> * en/header-split-cache-h-part-3 (2023-05-16) 29 commits
>   (merged to 'next' on 2023-06-15 at 76ebce0b7a)
>  + fsmonitor-ll.h: split this header out of fsmonitor.h
>  + hash-ll, hashmap: move oidhash() to hash-ll
>  + object-store-ll.h: split this header out of object-store.h
>  + khash: name the structs that khash declares
>  + merge-ll: rename from ll-merge
>  + git-compat-util.h: remove unneccessary include of wildmatch.h
>  + builtin.h: remove unneccessary includes
>  + list-objects-filter-options.h: remove unneccessary include
>  + diff.h: remove unnecessary include of oidset.h
>  + repository: remove unnecessary include of path.h
>  + log-tree: replace include of revision.h with simple forward declaration
>  + cache.h: remove this no-longer-used header
>  + read-cache*.h: move declarations for read-cache.c functions from cache.h
>  + repository.h: move declaration of the_index from cache.h
>  + merge.h: move declarations for merge.c from cache.h
>  + diff.h: move declaration for global in diff.c from cache.h
>  + preload-index.h: move declarations for preload-index.c from elsewhere
>  + sparse-index.h: move declarations for sparse-index.c from cache.h
>  + name-hash.h: move declarations for name-hash.c from cache.h
>  + run-command.h: move declarations for run-command.c from cache.h
>  + statinfo: move stat_{data,validity} functions from cache/read-cache
>  + read-cache: move shared add/checkout/commit code
>  + add: modify add_files_to_cache() to avoid globals
>  + read-cache: move shared commit and ls-files code
>  + setup: adopt shared init-db & clone code
>  + init-db, clone: change unnecessary global into passed parameter
>  + init-db: remove unnecessary global variable
>  + init-db: document existing bug with core.bare in template config
>  + Merge branch 'en/header-split-cache-h-part-2' into en/header-split-cache-h-part-3
>  (this branch is used by js/cmake-wo-cache-h.)
> 
>  Originally merged to 'next' on 2023-06-13
> 
>  Header files cleanup.
> 
>  Will merge to 'master' together with its fix-up in js/cmake-wo-cache-h
>  source: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>

I think this series has a bug with finding the correct templates dir. If
I check out 76ebce0b7a (Merge branch 'en/header-split-cache-h-part-3'
into next, 2023-06-15) and run:

  make prefix=/tmp/foo install && /tmp/foo/bin/git init /tmp/bar

I get:

  warning: templates not found in /usr/share/git-core/templates

Whereas if I go to 76ebce0b7a^, that warning does not appear (and
presumably the templates come from /tmp/foo/share, but I didn't check).

Our tests can't notice because they always specify the in-repo template
dir directly in the bin-wrappers script (and other users might not even
get the warning if they have another git installed in /usr; it would
just silently use the wrong template).

  Side note: I'm using the merge along 'next' there because much to my
  surprise, the tip of en/header-split-cache-h-part-3 does not build by
  itself! It needs the evil merge result from ccd12a3d6c (Merge branch
  'en/header-split-cache-h-part-2', 2023-05-09). I wonder if it got
  applied on the wrong base. It does work when merged to 'next' (and
  should with 'master' as well), but it hurts bisectability.

After rebasing on 'master' to make it buildable on its own, I bisected
my make/init command above, which shows the template problem appearing
in 3f85c72fad (setup: adopt shared init-db & clone code, 2023-05-16).

I guess the problem is the movement of the code from init-db.c to
setup.c, and we'd want something like this:

diff --git a/Makefile b/Makefile
index e440728c24..b09c8165d0 100644
--- a/Makefile
+++ b/Makefile
@@ -2742,8 +2742,8 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
 
-builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
-builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
+setup.sp setup.s setup.o: GIT-PREFIX
+setup.sp setup.s setup.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
 config.sp config.s config.o: GIT-PREFIX


It does make me wonder if we should also just do this:

diff --git a/setup.c b/setup.c
index f8e1296766..6e7282e680 100644
--- a/setup.c
+++ b/setup.c
@@ -1718,10 +1718,6 @@ int daemonize(void)
 #endif
 }
 
-#ifndef DEFAULT_GIT_TEMPLATE_DIR
-#define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
-#endif
-
 #ifdef NO_TRUSTABLE_FILEMODE
 #define TEST_FILEMODE 0
 #else

Since the Makefile always provides that value, having a baked-in
fallback does not make much sense. And in this case it masked a real bug
which should have been a compilation error, and instead silently used
the wrong value.

So I think we'd at least want to fix the Makefile before graduating this
topic any further. But IMHO it would also be worth adjusting the topic's
start point so that we don't have a big chunk of commits which fail to
build in the final history.

-Peff
