Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2358420A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 12:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbeLNMat (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 07:30:49 -0500
Received: from mail-yw1-f48.google.com ([209.85.161.48]:38017 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731353AbeLNMak (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 07:30:40 -0500
Received: by mail-yw1-f48.google.com with SMTP id i20so2207866ywc.5
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 04:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=B3f+czz+stg0LoVbvIkSpWAhu3VzgLRTy888q/2hJ2M=;
        b=tj7q8a69uP87kDxjFhGU+HUbXsmIUZ6H8/xnsdPT0wk3tS9t0GMQwFQCBwxLZOpVf4
         jXWFuQvC8FWBt0J1Xz3z0UzYj1d9k1DQT1nCUcJ4LjMvATgW2gRqSKmnireOeOvVvnCV
         9RK7yv8sbhW/EFAArn+xY5N5EAZJQRkWlfeLTYQfyViLPfYgh3mbaDBtlmsFzqgs573w
         8gpr5WsndJC9OJj6EE7bnG0kgf45S4Cg16gUvtKPNzuES06kWfCgE8JMVjSH9tvc+8au
         OEm+r3P4iW25bd4oZzXWIA8wHR0GXClRKN9hNepehjBz743LXdwiSuOhNshPuzxXj6P/
         5Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=B3f+czz+stg0LoVbvIkSpWAhu3VzgLRTy888q/2hJ2M=;
        b=A4Pg4+Cr9LhjQgEXK7OzapnOmScLOixANxfadN3py7td0PS6VyCW8NrChXRW+5D9zP
         c0rqTV/BpH26R5sycCC9VN+sKiUMStK/eHmvZP2dMjRihqZ4u84aGohdbAUZAbe7TO/D
         OyQuZQ0gmTwfE6N9rzl26URFw3mH9Z24/egigpCaEn3c1AkRj1iUyzR8FNQ3aMV8cmla
         aIG1uCSPKIPP+rHzQzM7lv1RflasOpp+FEYuqx0sr/xInR1Ryeo258/2dN+vK+fzLVIE
         x2rJfmi4S3BHSYpD48oBesyyAtpniDhEL2Gu5WeTNPgFsWWu7oQC9N/cNCwWUFZninkK
         l57w==
X-Gm-Message-State: AA+aEWYb3QPHlApK5NNPuXZuUcldqaDmi78+N6s7U/K/V0eRhvImlj6r
        +ghvyT/kc8tYsojz7sLbLNWK7XmmpY0fbTzSoEnGcZIO
X-Google-Smtp-Source: AFSGD/X0+oYJIy3PmThU4xL6Fk5IQTnmTgfZi7439nIl4o0IRzEN/Y6bBKmqKuYDv4mpFHJS9a30qpOwXeMAm6XnUQ8=
X-Received: by 2002:a81:ac56:: with SMTP id z22mr2887785ywj.40.1544790639248;
 Fri, 14 Dec 2018 04:30:39 -0800 (PST)
MIME-Version: 1.0
From:   Oliver Joseph Ash <oliverjash@gmail.com>
Date:   Fri, 14 Dec 2018 12:30:28 +0000
Message-ID: <CADBHO9E7Bzk9C5ciC416S+5-cS2ANA9d+CzSjKSG+HyxwrU+2w@mail.gmail.com>
Subject: Bug: `git commit --fixup` with duplicate commit messages
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I believe I have found a bug in `git commit --fixup`.

Steps to reproduce:
1. Create a git history with two commits (A and B) with the same
commit message (e.g. foo)
2. Create a new commit using `git commit --fixup {SHA}`, referring to
the last commit SHA
3. Run an interactive rebase

Expected: the fixup commit should appear below the last commit in the todo list.

Actual: the fixup commit appears below the first commit in the todo list.

It seems that the fixup commit is moved below the most recent commit
with a matching commit message, however in this case there are
duplicate commit messages. I would expect the fixup commit to be moved
below the commit SHA I specified when I ran `git commit --fixup`.

Thanks,
Olly
