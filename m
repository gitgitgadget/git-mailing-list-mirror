Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB551F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 12:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfAOM5b (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 07:57:31 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35645 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbfAOM5a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 07:57:30 -0500
Received: by mail-wr1-f49.google.com with SMTP id 96so2864060wrb.2
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PZbXAuq1DGRpCuxJidHgitO85eLOT2dgOIqBzxMnnQE=;
        b=PLbgddIsqCgUXQE7B+iPH81H5CKvaYY7cFmAtdgqHWX1UMA9tsHiiISkC0Fod73Tgg
         Huuz3eplIChaYWCLoRgWk4OIB+Bx/0DwFQpddUCQiiXsMg977Ba9A5hW5OSL4H/qQWMF
         B198Rke6yPJMzhVhlnjzATn46bTnXRBgzQQkj7Yd1fGqYNHRxboZ0jQU7AL2bt8okoBZ
         pXg7lcvhSAiT0zqNoNWKg7DQbrb9vfkBDWxNA+Oxyjl4c2Z2YrGQpLwlhXKjkdwuZfeG
         sJcyHhOt83z0YiNkexfqjUZPZ9OQVl394oONNwovzMSqT9jKi3iW2qclRHZ9o3FKxP28
         0GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PZbXAuq1DGRpCuxJidHgitO85eLOT2dgOIqBzxMnnQE=;
        b=hb3RGlzLJinqhy5lsvft6gZ9H7r6x4rdo30n0rBzr3OkH7uIl3B9lknAc8IoOMggzZ
         QH4fgTFHxnug7Nlz0I7hsWA15J//qwRoUQhjbX1SvKOxwbgxLUKhZOZ1GvDRrzQF6vEB
         FZUjDGcLhWsv0lKA5MbFy7FFPW9uTkjeZtaruyh5w1h0xp8VENfgYFs7uNZxCbOpcEYT
         XRVy3DYo/pVd6zokzIp5R0flouC++bNSWTjM9Uq4YS+6yBuprNUDfSKz/EAAKxY8Ubm/
         8Xn0dG4xN8SU/Y9WOlY9Aj2xoEv8mAKqvMVrpnKYWDQlGFUcGS438Q+m5RSIlKbGoGDP
         dfyw==
X-Gm-Message-State: AJcUukdYLSVi8XQqcnYftGF26gUCbQLF2pg3z/MvAGjBWJcN/5xuIZ8A
        lGEFhfHoY6xbHei8wWXGtgny7Vh8KqlA8fQoGJdrtdX8
X-Google-Smtp-Source: ALg8bN7kYubnp/Ff/fvxGZQVUpSwuyONXPKgRFMDEGUHmYuqcf9IRgi3leF92sSzUE/uZS0MTZngwvHDdMiuIGQDdJg=
X-Received: by 2002:adf:93e2:: with SMTP id 89mr3161888wrp.129.1547557048532;
 Tue, 15 Jan 2019 04:57:28 -0800 (PST)
MIME-Version: 1.0
From:   Thibault Kruse <tibokruse@googlemail.com>
Date:   Tue, 15 Jan 2019 21:57:17 +0900
Message-ID: <CAByu6UVQgEiP1D4n1MzPe8ApCwpm_spc6apreOhLOWbExxyVXQ@mail.gmail.com>
Subject: race condition after calling git reset --keep
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

trying to wrap git, I ran into this problem using git 2.17.1 on Ubuntu 18.04.1.
When fast-forwarding like this:

    git reset --keep remotes/origin/master

sometimes git returns an error like:

    error: Entry 'foo.txt' not uptodate. Cannot merge.
    fatal: Could not reset index file to revision 'remotes/origin/master'.

...in situations where fast-forward would seem possible at a glance.

This can have different root causes as mentioned in
* https://stackoverflow.com/questions/1248029
* https://stackoverflow.com/questions/878554

We are not sure what causes this for our users, one contributing
factor seems to be git repositories that have not been updated in a
long time (maybe last update with a different git version).

In our case this can apparently often be prevented by calling e.g.

    git update-index -q --refresh

When trying to unit-test our solution I found a way to reproduce the
symptom, but I ran into what looks like a race-condition.

To reproduce, on a file that is changed on the remote branch, I run

    chmod u+x file
    git reset --keep ...
    chmod u-x file
    git reset --keep ...

This makes the both git commands fail, though occasionally the second
one succeeds (hence I assume a race condition).
I am posting this here not because I need an urgent patch, but because
this might not be intentional and thus possibly a bug, and as shown in
the stackoverflow question other users may be affected, and the
non-deterministic behavior on race conditions is of course making
matters worse.

To reproduce a git error below, a sleep is required after a first call
to git reset --keep, so that the next call to git reset --keep after a
file permission change fails.

    #! /usr/bin/env sh

    set -e

    # this script shows a race condition in git reset --keep
    # It can be repeatedly run without manual cleanup
    # it creates / deletes folders 'parent' and 'child' in /tmp

    # setup origin with two commits on file foo.txt
    cd /tmp
    git init parent
    cd parent/
    touch foo.txt
    git add foo.txt
    git commit -m foo || true
    echo 'hello' > foo.txt
    git add foo.txt
    git commit -m foo2 || true

    cd ..
    rm -rf child # cleanup previous runs

    # Clone repo master branch, reset hard to first commit, mess with
file permissions
    git clone parent child
    cd child/
    git reset --hard HEAD~1
    chmod u+x foo.txt
    # next line always fails, which seems legit
    git reset --keep remotes/origin/master || true
    # This sleep is required to make the last command fail. Without
sleep, the last git command succeeds most of the time
    sleep 1
    chmod u-x foo.txt
    # Next line should fail?   Sometimes it does, sometimes not.
    git reset --keep remotes/origin/master


regards,
  Thibault Kruse
