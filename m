Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F4C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 00:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLOA1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLOA1L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 19:27:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FB51E716
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 16:27:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vv4so48586884ejc.2
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 16:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nAJEEHYOW4N6f2b86BVw2YCsuFVdSRu9RAUM6HPm5Xs=;
        b=GrGU/eFg4W85A81lJ9xN3MiH/gH2yi0iG3eNe5NkN4qeXQDRj6yXRSa3PhsVC1xz4z
         aqn4SGijgyXIDATxO3wrB78/yZPn4Eye5qZ8luJ3ayP11JEzyQr8qYsdRSD3L9pBRM0Q
         9rbtwlVeCqp6vGIrzILRdkU649+yBUmuf8J2FTW4h9p51Z2lBZcQHHzk4GNUuZMghWrU
         Y/67wYNAs3gGajnm7/iCgTLw6nfF3yiu/C11TembR/obcydNFW3ZUCavJDY5ynD+EoAS
         WQtnbP6fLa6qslvdwFfMB+WrKYwfSRS9XGj8IOOyhNmClZS7aNDyFKJMB8OR+SzN5mur
         CxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAJEEHYOW4N6f2b86BVw2YCsuFVdSRu9RAUM6HPm5Xs=;
        b=wlK4d5nTEHvpqp4BpWkcA5KXhXMkli3Wx8Sqpo6ODJJ5RFvsJmwWwHNdDly8ClvwPt
         oIVqtbMWs7sU7wx7ErMQlKUSzQgWPbEAZCkKk/OHcHuZWTL9B6jbqrLJyvf4fU7NO0m+
         J0b8+xKW6EzsyeFHwM48THKPrQ0ULXBOuFxInwmDEu5f0deEMnoKHVuV4uzbmzS9gqgo
         HfikcoTCULfhFdQ+7mfDvQzKxc6L5SYpGGLAUnIxWnd/kUAqgmRDQQ+8qQMTH/8zUYSy
         Zsj0fjdZ0uCLjZJP4VHHddRS2nxQ5qxpHCvIU6pE38wT8EuuRi3Bip1XaGJXoeQ24HMc
         BXBQ==
X-Gm-Message-State: ANoB5pl/hQkbTcnRpXsJbzUE+wRkaHMwGnVbgSDDda74gEhJ6s1OxrBi
        fsVx3+zgyQq5lCBFB8q01/tHCznAsPXji5sB8St4qlWq6wvwuhg=
X-Google-Smtp-Source: AA0mqf5BRrZIWYUbehEsbKYW4S0VFWCr1FS6viWnJNwmDix5pqnwBsWv7XA1xUzk5p+ixTP6mhpAVMSN0kwmSpF7Or8=
X-Received: by 2002:a17:906:3a15:b0:7c1:b65:ad79 with SMTP id
 z21-20020a1709063a1500b007c10b65ad79mr10432375eje.402.1671064026175; Wed, 14
 Dec 2022 16:27:06 -0800 (PST)
MIME-Version: 1.0
From:   Andrew Olsen <andrew.olsen@koordinates.com>
Date:   Thu, 15 Dec 2022 13:26:54 +1300
Message-ID: <CAPJmHpWWJ4sssfG2oym7K=MsT3+KTHQP-QK88nfXNOtfcv07ew@mail.gmail.com>
Subject: [BUG] git rev-list HEAD --objects -- WILDCARD-PATHSPEC
To:     git@vger.kernel.org, Robert Coup <rcoup@koordinates.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rev-list --objects behaves strangely with certain wildcard
pathspecs, which seem to interact badly with its tree-walk recursion.
To see the weirdness, there should generally be a wildcard-star
occurring somewhere early on in the pattern - wildcards as suffixes /
wildcards filtering the name of the blob, seems to work better than
wildcards as prefixes / wildcards filtering the name of trees.
A simple example of a wildcard pathspec that doesn't work is `*/*`

== Steps to reproduce ==
1. Get a git repo with a few different files and folders that's not
too overwhelming. You could make your own, I've cloned
https://github.com/computationalmystic/toy-repository

2. Run `git rev-list HEAD --objects -- PATHSPEC`
where PATHSPEC has an early wildcard in. It will not give you the
expected results. Make sure you quote the PATHSPEC so that your shell
doesn't do any wildcard expansion, otherwise you are not testing
rev-list's wildcard expansion.

Note that whenever this is working and you match something so that it
is output, generally all of its parent-trees and child-trees/blobs are
output too. I don't know if this is working as intended or not, it's
not documented in git rev-list.

For example, here is what I found on the toy-repository I cloned.

== First the expected behaviour ==
These work since the first wildcard is towards the end and is doing
suffix-matching or matching the last blob:

Group01 -> matches all of tree Group01
Group01/ -> matches all of tree Group01
Group01/* -> matches all of tree Group01
Group01* -> matches all of tree Group01

Group0 -> doesn't match anything
Group0* -> matches Group01, Group02, Group03, etc

Group01/READ* -> matches Group01/README.md
Group01/*ME.md -> matches Group01/README.md
Group01/*.md -> matches all .md files in Group01

== Possibly expected behaviour ==
Group0*/ -> doesn't output anything.

This is a bit weird since Group01/ does match some things, and
Group0*/ looks like it should match all of those same things at least,
but I think maybe the absence of wildcards altogether means that the
pathspec is considered to also match children of the matched object,
whereas if the pathspec contains a wildcard, it is stricter - you have
to append "/*" to get the same effect.
(I observed similar behaviour when testing git diff)

== Unexpected behaviour ==
These don't work since there is a wildcard early on doing prefix
matching or trying to filter trees rather than blobs.

*/* -> should match all the blobs, but only outputs root trees
*/*.md -> should match nearly all the blobs, but only outputs root trees
*README.md -> should match all README.md blobs, but only outputs the
root README.md blob and root trees.
*/README.md -> should match all README.md blobs, but only outputs root trees
Group0*/* -> should match lots of blobs, but only outputs root trees.

== Figuring out the specification ==
You can run `git diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904..HEAD
--name-only -- PATHSPEC` to get a second opinion of what things should
match or not match your patchspec. This command seems to behave much
better with wildcard pathspecs than `git rev-list --objects`
