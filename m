Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40353C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 22:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiKIWqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIWqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 17:46:10 -0500
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC2FBF5
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 14:46:09 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id stpdo28YFAajastpeoL7NP; Wed, 09 Nov 2022 22:46:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1668033967; bh=+kXwJfDWSFCTP48O5eQWNPy+fqGoI0mglcsjqc2srBw=;
        h=Date:To:Cc:From:Subject;
        b=cC+BG5ylcNzQGK7kEAfI+1/I89KIYMYNoMHXLVSwjJ1lgM4d5bU9mmAkXWhaUL6dk
         DDS+XWtlQ5yacIgxIryHNmnW2qHz5cOspCMWY0YC6o6jVOgKj1o4zW9IGPpTEffHcy
         PBrWyEeWrTZ6gWqzFzf4ZoztZBKA4mqp7rOtUGizAEYm0GAEwREJ2ouOInG8JaA+Kz
         H4StQFoDD73oIqlaUfloENzEqPR3rWQA8Quhc0JAWA/zoGzyLxhmyQIvGL7Lj9GUJ9
         SPssHufrKkX4Cc3ZmPOoEIlUVKFQHfxdnJzwmY4w475fXtPKrf6ob9e/7rF1mI8nva
         EDHFtcYxooFJg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=eI8AMVl1 c=1 sm=1 tr=0 ts=636c2daf
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=NEAV23lmAAAA:8 a=o_cCyyLnhzLE6ouQv8oA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
Date:   Wed, 9 Nov 2022 22:46:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-GB
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     Adam Dinwoodie <git@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] Makefile: fix cygwin build failure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOi+25lB4qnOS12Rc7p3NjHr0jtjUpilw1k3L2hXEM70as8Mnn74lmb2QKCadUwFlGm4DeNoaOuZighz6W/SdDqr3ikF+JuvDzwcUC1mSRqYH/IeYJ3z
 uobOzpPMSTot5emTjhbBuKk84/5dVJ0JSczxxNDQaez8T61blMQ6esAh3Jo0Q3H9ciQoc6ZF+h1TxVrlEdW3hDuLt2uGZd29RSg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit 1c97a5043f (Makefile: define "TEST_{PROGRAM,OBJS}" variables
earlier, 2022-10-31) breaks the cygwin build, like so:

    $ make
    GIT_VERSION = 2.38.1.674.gca75de31c9
        * new build flags
        CC oss-fuzz/fuzz-commit-graph.o
        CC oss-fuzz/fuzz-pack-headers.o
        CC oss-fuzz/fuzz-pack-idx.o
    make: *** No rule to make target 't/helper/test-fake-ssh', needed by 'all'.  Stop.
    $

This is caused by moving an 'all::' target higher in the Makefile,
before the 'include' of the config.mak.* files. This results in
the $X make variable having the default value (empty) rather than
a value suitable for cygwin (ie. '.exe'). Although the value of
this variable is lazily evaluated, the 'all::' target forces an
evaluation prior to it being correctly set.

In order to fix the build, move the 'all::' target lower in the
Makefile (close to where it was originally placed). Although it
could come anywhere after the 'include's, placing it here makes
the diff of the build outputs smaller (placing it directly after
the 'include's causes a change in the order of build products).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Taylor, Ævar,

I decided to spend some time tonight cleaning up my cygwin git repo (I
have _far_ too many branches scattered across history, some _very_ old,
some half done, some with no commit message etc., etc.). So, before
looking to rebase/re-work some old commits on the current version of
git, I thought it might be an idea to peek at the latest work; I have
not seen any updates to my origin repo, for the last couple of weeks,
since Junio took a break (as you may recall :) ).

So, I set up a 'git' remote:

    $ git remote get-url git
    git@github.com:git/git.git
    $ 

.. to have a peek at the updates to the 'master', 'next' and 'seen'
branches. Also, out of habit, I decided to build all three branches in
the usual way (well, apart from being on a detached HEAD, of course).

First 'git/master' failed to build! ;) It turned out that I had updated
cygwin and installed a bad update to the gettext-devel package, in
particular '/usr/bin/msgfmt.exe' was completely broken. :( (Adam, if you
haven't already run into this, you may appreciate the solution given
at [1] below).

Having fixed my cygwin installation, 'git/master' and 'git/next' built
just fine, 'git/seen' however failed to build (see commit message
above).

I'm not sure what the plans are for the 'ab/make-bin-wrappers' branch,
but if it is going to be re-rolled, could you please squash this into
the patch corresponding to commit 1c97a5043f. (Otherwise, could you
maybe add this to the tip of that branch?).

Note: this patch was created directly on top of 'git/seen'@ca75de31c9,
but I wouldn't anticipate any problem adding it to that branch.

I am a little surprised that it has taken this long to spot this build
failure, since this should also affect a (vanilla) MSYS2 build, along
with a Git-For-Windows Makefile build. Hmm, I have no way of knowing,
but this seems to indicate that nobody builds GFW using the Makefile
these days! :D

If anything in the commit message is unclear, please let me know.

Thanks!

ATB,
Ramsay Jones

[1] After a cygwin update, '/usr/bin/msgfmt.exe' refused to run, saying
that it could not locate the 'cygunistring-5.dll' file. Using cygcheck,
I found that this dll is provided by the 'libunistring5 1.1-1' package.
After installing this package, everything works just fine.

I don't know how package dependencies are specified/updated, but it
would seem the 'gettext-devel' package has a direct or indirect
dependency on the 'libunistring5' package. Looking at my setup.log file
I would guess one-or-more of the following packages needs an update to
note this dependency: 'gettext-devel 0.21.1-1', 'gettext 0.21.1-1',
'libgettextpo0 0.21.1-1', 'libintl-devel 0.21.1-1', 'libintl8 0.21.1-1',
or 'libasprintf0 0.21.1-1'.

Unfortunately, I am not subscribed to the cygwin mailinglist :(

 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index acb02f3882..03ceaf3e79 100644
--- a/Makefile
+++ b/Makefile
@@ -869,7 +869,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-tool
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
-all:: $(TEST_PROGRAMS)
 TEST_PROGRAM_OBJS += $(patsubst %,t/helper/%.o,$(TEST_PROGRAMS_NEED_X))
 .PRECIOUS: $(TEST_PROGRAM_OBJS)
 
@@ -3208,7 +3207,7 @@ $(call bin_wrappers_template,TEST_PROGRAMS_NEED_X,'$$(@F)',t/helper/,$$X)
 endef
 $(eval $(call bin_wrappers_templates))
 
-all:: $(BIN_WRAPPERS)
+all:: $(TEST_PROGRAMS) $(BIN_WRAPPERS)
 
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
-- 
2.38.0
