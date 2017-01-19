Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68AB20756
	for <e@80x24.org>; Thu, 19 Jan 2017 11:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdASL4I (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 06:56:08 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:33749 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdASL4H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 06:56:07 -0500
Received: by mail-it0-f48.google.com with SMTP id d9so4074401itc.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 03:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lmcpSMILm+0TpsU7fIejfXxnCg2cFZ79MktkE6R+Auk=;
        b=lpio1fPFp+CdTn5mw5HjhWBJROkdwhWSeaezWtDzviPkpLuUagH7J9RBJJ0bEW9ZBy
         Oak+Cpc8T9ZAWdkWzT8+05Vgoi8m9tQDxZWE1VwTdtOcihdS2yIZa6RJaH8S0lQUsZO1
         Bqp37weIEvT5uKtoER5pn1UM3tDYNM3T6RDV5D4PBP4+L9ETp6/UiEpqBRUckwN1Ah74
         4y1F2KOT0bxfDZwop7+MYlYHtIgJLEdaHNfjDlW1o9tN+uXeMD9XXLJJMzm4golY7YLc
         ApvqWcYxPgUH1SbZq+9EoD6DO9axNzr7DPCk4gZyk9m0A/k3Met1x6OfzD1LZbBNovLU
         ADFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lmcpSMILm+0TpsU7fIejfXxnCg2cFZ79MktkE6R+Auk=;
        b=RQ1alTqac7jOUMuFM9KZpl8kV9NknndeAMIiUxRi4ucryCQd4fk/dM7uPcXG1qYpYw
         ohdKbqwtYgqszBN4u57DVE+lYPx3em/PVGbNeforHwPz4NNrrhggnmvIZMPz4xFSUswy
         2XcteymAIb3bJeaAgAs3JyHE7nMTA6MA9/7IzoWLw9+Gpne9tTVtWDCdBBWEqTOYzJ+g
         ofPQBtP/eZXt/fkRley7h7p7u1hmn4i3jAuifeKcxOl4fNYIJzI2/WBc+6nPdMLzcQLf
         2lqpsIvWxXYEcq0RpFRM81yrT7vKZvrU1fg8Pkf6UrlFxe7gcN1BHRXxa9GjpNkiEsgg
         uupA==
X-Gm-Message-State: AIkVDXIdsstdvqZ0O02k3hyromvK/ojCoXHKTzwapJyZOJJ/GK2Kt9nyFbS6ugP+DCgeH4q51TtK4Pw8NFyMJw==
X-Received: by 10.36.122.131 with SMTP id a125mr14483966itc.3.1484826961067;
 Thu, 19 Jan 2017 03:56:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 19 Jan 2017 03:55:30 -0800 (PST)
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 19 Jan 2017 18:55:30 +0700
Message-ID: <CACsJy8CHoroX2k9GqOFmXkvvPCPN4SBeCg+6aC2WSWNSKVmWQw@mail.gmail.com>
Subject: The design of refs backends, linked worktrees and submodules
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've started working on fixing the "git gc" issue with multiple
worktrees, which brings me back to this. Just some thoughts. Comments
are really appreciated.

In the current code, files backend has special cases for both
submodules (explicitly) and linked worktrees (hidden behind git_path).
But if a backend has to handle this stuff, all future backends have to
too. Which does not sound great. Imagine we have "something" in
addition to worktrees and submodules in future, then all backends have
to learn about it.

So how about we move worktree and submodule support back to front-end?

The backend deals with refs, period. The file-based backend will be
given a directory where refs live in and it work on that. Backends do
not use git_path(). Backends do not care about $GIT_DIR. Access to odb
(e.g. sha-1 validation) if needed is abstracted out via a set of
callbacks. This allows submodules to give access to submodule's
separate odb. And it's getting close to the "struct repository"
mentioned somewhere in refs "TODO" comments, even though we are
nowhere close to introducing that struct.

How does that sound? In particular, is there anything wrong, or
unrealistic, with that?

For that to work, I'll probably need to add a "composite" ref_store
that combines two file-based backends (for per-repo and per-worktree
refs) to represent a unified ref store. I think your work on ref
iterator makes way for that. A bit worried about transactions though,
because I think per-repo and per-worktree updates will be separated in
two transactions. But that's probably ok because future backends, like
lmdb, will have to go through the same route anyway.
-- 
Duy
