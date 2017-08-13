Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381151F667
	for <e@80x24.org>; Sun, 13 Aug 2017 19:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751175AbdHMTgZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 15:36:25 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37447 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdHMTgX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 15:36:23 -0400
Received: by mail-it0-f66.google.com with SMTP id 77so6832563itj.4
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=QqHRMlk5Aw+IIowiXwC9gCB8NFS+yOYWUfflHPH56h0=;
        b=B8WEcF3U651qSn4nI21V6uarIzZl4gZYjdObn1Lj/4RdQqO46Jn+Agvi1/PG3hof5p
         2yY0fKXLCts0F6nGq51NhAUyzV3OsuW+3w8bZfyHBbzzOAK2BPrGvqnJxpSRbG/0i29I
         s47Bu6lgU8/UO2Q6G9z5SnjFJY4/81YnMjP0/CQ3Re1+1Ru3lhXrYCf9pC3C+DkifDI3
         YZy0uHGciYwfyRgzooB4gyM7HaeKm0nZRw/ezjWDrFMlQtBtvUPgnxAOKOdlMSVFMVUZ
         bqL+9Vp75Yb38azM4uAngWOApbbGfs2kJ1OEUrLrAL4sbwi6aS7SbWybGJt/cL5sufgv
         TmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=QqHRMlk5Aw+IIowiXwC9gCB8NFS+yOYWUfflHPH56h0=;
        b=qmURSodb3PZvC4LVs36IOhvdLbF7Z3YK9PVa74XaeNK/mr+s4TT3WArl+G28oGryFr
         s01tf9IztbFAwFPbgWFy96IcZr5KTxqt3tpz1Eol4zgP8e9mVGbmBOlauMgISMTeRbEn
         vtGAlMqL/nG1VNERP1pjzXOshEFIKMajFrTiqaNKQMaORNNuPD0MhlUGno8IHRODtgib
         Y3JROgUUP9+ZbbYfwMP6RN4XkWFd/kC+tqkDwZmBPb8jkeZOOUkUn6rmqJC6syueG0Xt
         mOAkF9Azx5eYqM7I/aTfQ0/vRnauDbPRhRSF7AOna+yqJAlTDj4KDVKsWrs3YEEI2vMh
         WoRQ==
X-Gm-Message-State: AHYfb5jzd+E+lLZca8awWEnExqKZpzhgYvcEcBQUnvzhGifGlvVVOCFV
        J5tFDa47C7jforJZd4M=
X-Received: by 10.36.60.74 with SMTP id m71mr3896035ita.105.1502652982843;
        Sun, 13 Aug 2017 12:36:22 -0700 (PDT)
Received: from localhost.localdomain ([192.252.136.182])
        by smtp.gmail.com with ESMTPSA id s66sm2045678ita.9.2017.08.13.12.36.22
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Aug 2017 12:36:22 -0700 (PDT)
From:   Richard Maw <richard.maw@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 0/7] Implement ref namespaces as a ref storage backend
Date:   Sun, 13 Aug 2017 20:36:04 +0100
Message-Id: <20170813193611.4233-1-richard.maw@gmail.com>
X-Mailer: git-send-email 2.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forewarning: I don't consider this work complete
and am unlikely to find time to finish it any time soon.
I've mostly sent this because it may include valuable feedback
on how well the ref storage backends works
from trying to use it to change how git namespaces work.

Introduction
============

I work on a git server called Gitano,
and I'd like to add support for git namespaces to:

1.  Allow administrative content to be kept out of the default namespace.

    Gitano keeps some repository configuration in a ref in the repository.
    I'd like to be able to hide it in a namespace
    to make fetching all the content easier, such as for mirroring.

2.  Implement repository forking backed by namespaces in the same repo.

    I'd like to be able to add a logical vs physical repository separation
    so that forking a repository just copies the refs into a namespace.

3.  Any other inventive uses users could think of.


It's possible with some hackery to do all this with the existing namespace code
but we like to integrate with a web frontend, and a web frontend needs to do
more than just let you push and pull the repository.

Unfortunately namespace handling was never implemented for any other part of git
and at least gitolite makes use of namespaces,
and will have to work around it not being implemented fully,
but implementing it more fully will break work-arounds.

Instead of continuing to do work-arounds I tried to add support into libgit,
since as well as making it less code in the web frontend to work around it,
it would become common code that other git servers may make use of.


This is not my first attempt to improve the git namespace handling in git.
I tried last year, but it took me so long that all the ref handling code changed
and I would have had to start from scratch.

Fortunately the pluggable ref backends work provided an easier starting point.

The included patches work for the use-cases I need to support in gitano,
but I don't want it to end up like GIT_NAMESPACE and not be fixable,
so I've tried to make it work such that everything in the git test suite works.

I was not successful with this due to time constraints
but it helped me find many issues and I've listed known issues.

Technical description
=====================

This patch series adds a new refs backend, stacking on top of the files backend,
based on whether `core.namespace` is set in git config.

Since config can be done on the command-line or in config files,
both per-repo or global, it's a reasonable approach.

This allows the default namespace of a repository to be changed
so that operations such as fetch only show refs of that namespace,
or a smarter git server to intercept the repository path
and redirect it to a different repository with a namespace set.

It also mostly works for local git operations,
but I've no real idea what they would be useful for
beyond what's needed for a git server's web frontend.

It may make sense in future to allow remotes to have namespaces
so you can push to a namespace on the server without it being namespace aware,
but that's not the goal of this series,
and may be possible to handle without modification by changing the refspecs.

The majority of what the namespaced refs backend does
is to prepend the namespace to requests before the files backend sees them
and strip namespaces off returned refs before the caller sees them.

Issues
======

Having core.namespace set in a repository namespaces the fetch results.
If the source repository is local then setting -c core.namespace
to fetch the content into a different namespace will break the source namespace
since the upload-pack also obeys the -c core.namespace on the command-line.

Supporting `clone --namespace` instead of `git -c` might resolve this,
but I can't think of an appropriate use-case for wanting to do so
which makes it hard to consider what API would be appropriate.

Bugs
----

Most boil down to how special refs like HEAD are handled.

1.  Logged messages display the namespaced path,
    which a human may deal with but confuses the test suite.

2.  Reflogs for namespaced HEAD are not updated.

    This is because resolving HEAD to split the transaction's updates
    to add a log only update to HEAD works by transaction_prepare resolving HEAD
    using its own ref store rather than the main one,
    so the namespace translation isn't performed.
    See split_head_update.

    The fix for this may be to move the transaction mangling out of the backend,
    unless it should be implied that every backend implementation
    must be responsible for symbolic ref reflog updates implicitly.

3.  git init always says Reinitialized repository.

    This is because create_default_files checks for whether HEAD already exists
    directly via fs access rather than through the refs backend,
    but then creates the symbolic ref using it.

    Without a workaround this causes clones to fail because they don't recognise
    that the repository is initialized because .git/HEAD is missing.
    By working around this and creating .git/HEAD during the init_db callback
    instead create_default_files thinks it's a reinitialisation
    since it expected to create HEAD itself,
    and fails to actually create HEAD.
    The implemented workaround for that is for the namespaced backend's init_db
    to create both .git/HEAD and the namespaced HEAD.

    This could be fixed by:

    1.  Make create_default_files check whether HEAD exists via the refs backend

        This wouldn't fix .git/HEAD being missing in other cases,
        but allows namespaced_init_db to only create .git/HEAD
        and would fix the reinitialisation message.

        I attempted to do this, but running the test suite on the change
        caused it to corrupt my repository,
        so I haven't dared try it again.

    2.  Making backends responsible for creating HEAD in init_db.

        I'm unsure whether creating HEAD is the responsibility of the workspace
        or the responsibility of the refs backend.

4.  delete-refs won't remove namespaced symbolic refs.

    The files backend's delete_refs calls back into refs_delete_ref,
    which normally bypasses the backend to delete pseudorefs,
    whether the NODEREF option has been passed or not.

    (see t1405-main-ref-store for a test that triggers this)

    This could be fixed by changing is_pseudoref_syntax to strip any namespace
    off the front before checking whether it's outside of refs/ and is all caps,
    however this would then mean that anywhere that calls ref_delete
    would delete the pseudoref without namespace translation.

    Fixing this requires one of:

    1.  A work-around in the namespaced ref backend
        so that if it looks like a pseudoref after the namespace is stripped
        then the NODEREF flag is implicitly added to any deletes.
    2.  Ref backends to be given domain over pseudorefs.
    3.  Pseudoref backends.

5.  Per-workspace namespaced refs don't work.

    refs/bisect/ gets moved to refs/namespaces/foo/refs/bisect,
    but those refs can't be found in iteration
    because the files backend walks the refs in the common dir
    rather than the refs in the git dir,
    and the simple workaround in loose_fill_ref_dir doesn't work.

Richard Maw (7):
  Expose expand_namespace API
  Add git_configset_add_standard
  Add helper for skipping namespace prefixes
  Autocreate reflogs for namespaced refs
  Treat namespaced HEAD and refs/bisect as per-worktree
  Add namespaced ref backend
  Plumb in namespaced ref store

 Makefile                  |   1 +
 cache.h                   |   1 +
 config.c                  |   7 +-
 config.h                  |   1 +
 environment.c             |   2 +-
 git-compat-util.h         |  19 ++
 refs.c                    |   7 +-
 refs/namespaced-backend.c | 619 ++++++++++++++++++++++++++++++++++++++++++++++
 refs/refs-internal.h      |   1 +
 9 files changed, 654 insertions(+), 4 deletions(-)
 create mode 100644 refs/namespaced-backend.c

-- 
2.9.0

