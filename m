Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA91F1F406
	for <e@80x24.org>; Sat, 23 Dec 2017 06:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbdLWGKl (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 01:10:41 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:43353 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdLWGKl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 01:10:41 -0500
Received: by mail-io0-f177.google.com with SMTP id k202so18329274ioe.10
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 22:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=QJy5NOKNFO9ZKu6ZPwUH49nDqQjEZmd+2HpqxaKLbxc=;
        b=YmpZHR3QU80FiItPQARzVueFdWIR/VQWVw9jpYcUG9PbHdLT3SCGmBahSXP+KEp8//
         3bq+krqaFG3/vV/VWewxQDopcpapvRqS6JY8oUQY3/iFFKshl9fSfxGpy0C+GFZEIoDz
         8V2/+kgY0PETEhw3z74tz4EkCKuDozKu0K3VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QJy5NOKNFO9ZKu6ZPwUH49nDqQjEZmd+2HpqxaKLbxc=;
        b=W+2qqd78VCSq0yl2ngjQ5pqtAr8b2mUUuDj7cXInw17z/eXnWX6vE13mkVi/Lu1w7O
         6gfVgnf8rSV/WvzRfumXROZlxiJ1Dry87KVBnvX1wIAoafrHyisO/a9XjQsLdWQTa/Ti
         fYPyWPjmz71UDSSSxrKyqqMUGeeTS73CUsh+5aNLbMxMyAlLC+AY+zOIU4uMqnf3lHYp
         s+75DSxzSgGRFPl7eTDyi0JRfYLKbDSAE2uRjINJIDObbd27gGUVx2GgM22qNuhG2Erq
         twGpQWPM0HdWtUYyloXN4LLUIgUa0wwrHOFpkoIIi8HltoSlboeDXmt3qDj5jWjaX3L/
         T5RA==
X-Gm-Message-State: AKGB3mKDF3dmuFHekylg+kcuBbb3yvL2ED6OwhdnyeaFjmhY02fmIWLt
        AY773R+Fn4IgftReuhzZW8tUU7pVW6dQNLGff+iENGFR
X-Google-Smtp-Source: ACJfBoshzb0DgaC8ePfVF0S4z2/2iY2J6jzhTurTUFtLOgBxHdkMvI2e/5WTCUSlcBHiwBN0Zr0YrHrEwbLmDr3v/WM=
X-Received: by 10.107.43.75 with SMTP id r72mr20497098ior.89.1514009439938;
 Fri, 22 Dec 2017 22:10:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.153.108 with HTTP; Fri, 22 Dec 2017 22:10:19 -0800 (PST)
From:   Carl Baldwin <carl@ecbaldwin.net>
Date:   Fri, 22 Dec 2017 23:10:19 -0700
Message-ID: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
Subject: Bring together merge and rebase
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The big contention among git users is whether to rebase or to merge
changes [2][3] while iterating. I used to firmly believe that merging
was the way to go and rebase was harmful. More recently, I have worked
in some environments where I saw rebase used very effectively while
iterating on changes and I relaxed my stance a lot. Now, I'm on the
fence. I appreciate the strengths and weaknesses of both approaches. I
waffle between the two depending on the situation, the tools being
used, and I guess, to some extent, my mood.

I think what git needs is something brand new that brings the two
together and has all of the advantages of both approaches. Let me
explain what I've got in mind...

I've been calling this proposal `git replay` or `git replace` but I'd
like to hear other suggestions for what to name it. It works like
rebase except with one very important difference. Instead of orphaning
the original commit, it keeps a pointer to it in the commit just like
a `parent` entry but calls it `replaces` instead to distinguish it
from regular history. In the resulting commit history, following
`parent` pointers shows exactly the same history as if the commit had
been rebased. Meanwhile, the history of iterating on the change itself
is available by following `replaces` pointers. The new commit replaces
the old one but keeps it around to record how the change evolved.

The git history now has two dimensions. The first shows a cleaned up
history where fix ups and code review feedback have been rolled into
the original changes and changes can possibly be ordered in a nice
linear progression that is much easier to understand. The second
drills into the history of a change. There is no loss and you don't
change history in a way that will cause problems for others who have
the older commits.

Replay handles collaboration between multiple authors on a single
change. This is difficult and prone to accidental loss when using
rebase and it results in a complex history when done with merge. With
replay, collaborators could merge while collaborating on a single
change and a record of each one's contributions can be preserved.
Attempting this level of collaboration caused me many headaches when I
worked with the gerrit workflow (which in many ways, I like a lot).

I blogged about this proposal earlier this year when I first thought
of it [1]. I got busy and didn't think about it for a while. Now with
a little time off of work, I've come back to revisit it. The blog
entry has a few examples showing how it works and how the history will
look in a few examples. Take a look.

Various git commands will have to learn how to handle this kind of
history. For example, things like fetch, push, gc, and others that
move history around and clean out orphaned history should treat
anything reachable through `replaces` pointers as precious. Log and
related history commands may need new switches to traverse the history
differently in different situations. Bisect is a interesting one. I
tend to think that bisect should prefer the regular commit history but
have the ability to drill into the change history if necessary.

In my opinion, this proposal would bring together rebase and merge in
a powerful way and could end the contention. Thanks for your
consideration.

Carl Baldwin

[1] http://blog.episodicgenius.com/post/merge-or-rebase--neither/
[2] https://git-scm.com/book/en/v2/Git-Branching-Rebasing
[3] http://changelog.complete.org/archives/586-rebase-considered-harmful
