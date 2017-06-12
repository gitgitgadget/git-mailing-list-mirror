Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CAA320401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbdFLW6d (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:58:33 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36826 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbdFLW6c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:58:32 -0400
Received: by mail-lf0-f47.google.com with SMTP id o83so59035966lff.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jaE4Wi+DniXF5R16/5x5gN+1vSZdMBd2D5+aec9ptTM=;
        b=aLagcdhtQ+cYRbc8IFS9qhUoCrLLvMrYgm6Y7ROX+fcW+XLHDxqgGsFxkVhFYIqUk9
         nohwohquiVo/f9jJIkhPv49NAi7JI17vJNWYqZN2dgGRqhhxngNtOLlJdcnP168zaUkW
         jC2v6t21EOPVGIIvOtyCXHfOWPvzvUOUerE8fFeUYijfISWCUDYPgZ/Fupuvmh13lfJQ
         0WsBxmrgyNURk0z7qsWVR+vKWdcXTwYDdVgJJS0NxHL5zytdMXjX/2SJmMEPxixA5eNa
         FmgXc9RCBvZ3+k/3dUrOAepNzTygRZdK1011ABiMNk6la6WjWLq0jFbhMM7JY7J8BVpK
         rxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jaE4Wi+DniXF5R16/5x5gN+1vSZdMBd2D5+aec9ptTM=;
        b=BJXVqwCghU103hffX4v5Vu/R7fg2LRkIKDvSMlNY9nCQNfmABMsmyfJ36iKTVltC9x
         stpSn7drh8V1u7d0XAR/c772B1WxSedYk3vyGuW3Q1SQnDYmV/4LlmCxXR6kKteZ0dvz
         c+AW4+YOoRyTUIEHteTTQVf8I3vm5Wc/lMbOa8n7t6YwD9gOoHjIjpghuhDFacPuuTHg
         62YaEM7YnEG3HC6NI0WhK/uFI3ljRIeg6HQ+vpMh1qsYN+GVRoPEKcszTfnnqeOisGKQ
         xJj7M9Idu/FDe5V2orlmmvVY5ZTnvFY+E1y2anPl9wwvbBcD0zR6K+D1FeCIoKCYk6oU
         yqtA==
X-Gm-Message-State: AODbwcB83SYeCotwVObZi9rQaFEQuEeECymIPkJaqMq0zGdChpFsTn9T
        2NviN7pFhX3mIzpcEcNELFfiC+kNFmrI
X-Received: by 10.25.24.99 with SMTP id o96mr18346039lfi.143.1497308310356;
 Mon, 12 Jun 2017 15:58:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.79.17 with HTTP; Mon, 12 Jun 2017 15:58:09 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 12 Jun 2017 15:58:09 -0700
Message-ID: <CA+P7+xrMX+gxQrsB9kcy3RkDL=eDXb_TQ-V+2vH+ir0Sbef8Xg@mail.gmail.com>
Subject: proposal for how to share other refs as part of refs/tracking/*
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

There's no actual code yet, (forgive me), but I've been thinking back
to a while ago about attempting to find a way to share things like
refs/notes, and similar refs which are usually not shared across a
remote.

By default, those refs are not propagated when you do a push or a
pull, and this makes using them in any project which has more then one
repository quite difficult.

I'm going to focus the discussion primarily on refs/notes as this is
what I am most interested in, but I think similar issues exist for
refs/grafts and refs/replace, and maybe other sources?

For branches, we already have a system to share the status of remote
branches, called "refs/remotes/<remote-name>/<branch-name>"

This hierarchy unfortunately does not keep space for non-branches,
because you can't simply add a "refs/remotes/notes/<>" or
"refs/remotes/<name>/notes" to this as it would be ambiguous.

Now, you might just decide to push the refs/notes directly, ie:

git push origin refs/notes/...:refs/notes/...

Unfortunately, this has problems because it leaves no standard way to
distinguish your local work from what is on the remote, so you can't
easily merge the remote work into yours.

For example, if Alice creates a new note and pushes it, then Bob
creates a different note on the same commit, he needs to be able to
merge Alice's changes into his note, just like one would do when two
people commit to the same branch.

Today, he must pull the remote notes into a separate location, (since
pulling directly into refs/notes will overwrite his work), and then
update, and then push.

Because this is not standardized, it becomes unwieldy to actually
perform on a day to day basis.

I propose that we add a new "refs/tracking" hierarchy which will be
used to track these type of refs

We could even (long term) migrate refs/remotes into refs/tracking
instead, or provide both with the refs/remotes being pointers or
something like that..

Essentially, refs/notes would be pulled into
refs/tracking/<remote>/notes/* or something along these lines.

Then, git notes would be modified to be able to have commands to
"pull" and "push" notes which would fetch the remote, and then attempt
a merge into the local notes, while a push would update the remote.

I chose "tracking" because it sort of fits the concept and does not
include things like "remote-notes" or "remotes-v2" which are a bit
weird.

I'm posting this on the mailing list prior to having code because I
wanted to get a sense of how people felt about the question and
whether others still felt it was an issue.

Essentially the goal is to standardize how any refs namespace can be
shared in such a way that local copies can tell what the remote had at
a fetch time, in order to allow easier handling of conflicts between
local and remote changes, just like we do for branches (heads) but
generalized so that other refs namespaces can get the same ability to
handle conflicts.

Thanks,
Jake
