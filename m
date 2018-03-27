Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 374701F404
	for <e@80x24.org>; Tue, 27 Mar 2018 19:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeC0Tzn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 15:55:43 -0400
Received: from vsmx012.vodafonemail.xion.oxcs.net ([153.92.174.90]:17205 "EHLO
        vsmx012.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751101AbeC0Tzl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Mar 2018 15:55:41 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Mar 2018 15:55:41 EDT
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id DA70D8CE098;
        Tue, 27 Mar 2018 19:48:48 +0000 (UTC)
Received: from [10.0.0.19] (unknown [188.22.127.143])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 8F547CD6B6;
        Tue, 27 Mar 2018 19:48:44 +0000 (UTC)
From:   Peter Oberndorfer <kumbayo84@arcor.de>
Subject: git submodule deinit resulting in BUG:
 builtin/submodule--helper.c:1045: module_list_compute should not choke on
 empty pathspec
To:     git@vger.kernel.org
Cc:     Prathamesh Chavan <pc44800@gmail.com>
Message-ID: <9e22b49e-6732-17c7-76fe-0ce241787db9@arcor.de>
Date:   Tue, 27 Mar 2018 21:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-VADE-STATUS: LEGIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

i tried to run "git submodule deinit xxx"
on a submodule that was recently removed from the Rust project.
But git responded with a BUG/Core dump (and also did not remove the submodule directory from the checkout).

~/src/rust/rust$ git submodule deinit src/rt/hoedown/
error: pathspec 'src/rt/hoedown/' did not match any file(s) known to git.
BUG: builtin/submodule--helper.c:1045: module_list_compute should not choke on empty pathspec
Aborted (core dumped)

I had a short look at submodule--helper.c and module_list_compute() is called from multiple places.
Most of them handle failure by return 1;
Only module_deinit() seems to calls BUG() on failure.

This leaves me with 2 questions:
1) Should this code path just ignore the error and also return 1 like other code paths?
2) Should "git submodule deinit" work on submodules that were removed by upstream already?

For more debugging information please see below.

Thanks,
Greetings Peter



~/src/rust/rust$ git --version
git version 2.17.0.rc1.47.g9f57127417.dirty
(this should basically be 90bbd502d54fe920356fa9278055dc9c9bfe9a56 + some Makefile adjustments)

Git Gui reports
src/rt/hoedown
Untracked, not staged
* Git Repository (subproject)


~/src/rust/rust$ git status
On branch fix_literal_attribute_doc
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        src/rt/


~/src/rust/rust$ cat .git/config
...
[submodule "src/rt/hoedown"]
        url = https://github.com/rust-lang/hoedown.git
...
-> there is no "active = true" in this hoedown section
which is present on some (not all) other submodules


~/src/rust/rust$ cat .gitmodules
-> does not contain any references to hoedown anymore as they were remove by upstream


~/src/rust/rust$ cat src/rt/hoedown/.git
gitdir: ../../../.git/modules/src/rt/hoedown


~/src/rust/rust/src/rt/hoedown$ git status
HEAD detached at da282f1
nothing to commit, working tree clean

-> so there is a working git repository at src/rt/hoedown


~/src/rust/rust$ git submodule status
 9b2dcac06c3e23235f8997b3c5f2325a6d3382df src/dlmalloc (heads/master)
 b889e1e30c5e9953834aa9fa6c982bb28df46ac9 src/doc/book (remotes/origin/ch10-edits-137-gb889e1e3)
 6a8f0a27e9a58c55c89d07bc43a176fdae5e051c src/doc/nomicon (remotes/origin/HEAD)
 76296346e97c3702974d3398fdb94af9e10111a2 src/doc/reference (remotes/origin/HEAD)
 d5ec87eabe5733cc2348c7dada89fc67c086f391 src/doc/rust-by-example (remotes/origin/HEAD)
 1f5a28755e301ac581e2048011e4e0ff3da482ef src/jemalloc (3.6.0-775-g1f5a2875)
 263a703b10351d8930e48045b4fd09768991b867 src/libcompiler_builtins (remotes/origin/auto-10-g263a703)
 ed04152aacf5b4798f78ff13396f3c04c0a77144 src/liblibc (0.2.37-29-ged04152aac)
 6ceaaa4b0176a200e4bbd347d6a991ab6c776ede src/llvm (remotes/origin/rust-llvm-release-6-0-0)
-2717444753318e461e0c3b30dacd03ffbac96903 src/llvm-emscripten
 bcb720e55861c38db47f2ebdf26b7198338cb39d src/stdsimd ((null))
 311a5eda6f90d660bb23e97c8ee77090519b9eda src/tools/cargo (0.14.0-2144-g311a5eda)
 eafd09010815da43302ac947afee45b0f5219e6b src/tools/clippy (v0.0.189-21-geafd0901)
 b87873eaceb75cf9342d5273f01ba2c020f61ca8 src/tools/lld ((null))
 d4712ca37500f26bbcbf97edcb27820717f769f7 src/tools/miri (remotes/origin/hack_branch_for_miri_do_not_delete_until_merged)
 f5a0c91a39368395b1c1ad322e04be7b6074bc65 src/tools/rls (0.125-131-gf5a0c91)
 118e078c5badd520d18b92813fd88789c8d341ab src/tools/rust-installer (remotes/origin/HEAD)
 374dba833e22cc8df8e16e19cccbde61c69d9aed src/tools/rustfmt (0.4.1-35-g374dba83)

-> strangely I get (null) for the current branch/commit in some submodules?
