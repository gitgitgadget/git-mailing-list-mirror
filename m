Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6226220133
	for <e@80x24.org>; Fri,  3 Mar 2017 16:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbdCCQhx (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 11:37:53 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34249 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdCCQht (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 11:37:49 -0500
Received: by mail-yw0-f196.google.com with SMTP id 203so10413653ywz.1
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=77Qyf17Gk5zBinSsRIrxGw4YLMGJNdF53ZCt6JQNQRE=;
        b=qkWWc1JBFco47MNX8rbCZhNI28Hqq40bW1CsZ9mJfAVElCf/lxAa74JxLUWeY98JwJ
         44O37Gm7+vePnUyBWB2BmduWpX8SzHkSvOgSGZMPe2vO2lYhDMfzC9uTIOJN4/2Hr6Ff
         3tlXEBB4iqMwTkkDT8H+JnApfOTk90JshfD4GRIkyF0Dm4MpXNis/Xzn4IkhrbtGqS0d
         8q3pgWG07qIWwrmIQvaRykQS2v1BYEA6kwDTksFTXfk/YBrd+SK1lmXu1mTvSYpZp/oI
         L/jcTQEFyRN6XYc8ux4LL6KP36aJ2/0oqrYqoRAodDbbulAdDUIsTL1G/E6Xx9TQHjHK
         C/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=77Qyf17Gk5zBinSsRIrxGw4YLMGJNdF53ZCt6JQNQRE=;
        b=a3rVJNymQod4QF2cYVLPqVcyzacqnG6hjoIfqmyHIzofuslBybjoY502cyI+0FCU/d
         4zi61au9u9aFOnCFHa8odLuhYM+u8H/uM21INZVbQJaoTyRHsmOf6cxd8H0kbomz13Oa
         iqQ5SDrzIEaLqYRrk0sCNiea8H54uCb8Qej61B5HV3V2b8xKpxrs3YOkJM37BEd0m9OK
         ddtenZQL0amQsmaEYrHZhGFiyqUzCgHDyGQ2aa7ErgqIeDhmXTMTGKmr/tOYIvZDqG+S
         ovqZeuYDVHZ3xDUE+9GdmZFIyeo8lGGEuZHC95nttWE9ctKqXf+gaBWgQJj7c0j5tzW4
         +qng==
X-Gm-Message-State: AMke39lwtkr7tMUzgstEtFwPB0hc+eWM3j30ysr7j3i+EP8JYuvRDL7ux82o86PTLSATNBZU/tF1kfcGZ3RiFQ==
X-Received: by 10.37.170.49 with SMTP id s46mr2408330ybi.21.1488559049006;
 Fri, 03 Mar 2017 08:37:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.195.2 with HTTP; Fri, 3 Mar 2017 08:37:28 -0800 (PST)
From:   Laszlo Kiss <kisslas.git@gmail.com>
Date:   Fri, 3 Mar 2017 16:37:28 +0000
Message-ID: <CAO0LFki4PN8zz2xpoSpjTHJGS=NG_suQYR27EcmzEMiaCw9kuA@mail.gmail.com>
Subject: rebase: confusing behaviour since --fork-point
To:     git@vger.kernel.org
Cc:     ldubox-coding101@yahoo.co.uk
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

This will be a bit long, sorry in advance.

I've hit a problem with how rebase works since the introduction of the
--fork-point option. I initially thought it was a bug until the kind
folks over at git-for-windows patiently told me otherwise.

Consider the following:

-------8<-------
# On branch master which is at origin/master
# hack hack hack

git commit -am'First topic commit'
# optionally followed by more commits

# realize I want all this on a different branch instead
# (maybe I just forgot to create one; would be typical)

git checkout -b topic --track
git branch -f master origin/master

# optionally add more commits to 'topic' and/or update 'master'
# with changes to 'origin/master', then finally:

git rebase    # or git pull --rebase
------->8-------

What happens is that 'First topic commit' is discarded because rebase,
with this syntax, defaults to --fork-point, which then works out from
master's reflog that the commit in question was previously part of the
upstream branch. The rebase is then carried out under the assumption
that, even though that specific commit is no longer in master,
something equivalent to it or superseding it is, or else it is meant to
be dropped - which would likely be the case if a complicated history
rewrite happened, but is not the case here.

There are two reasons why I think this is confusing and should be
changed:

(1) My mental model of git after some 5 years of using it is such that
    I view the reflog as auxiliary information for purposes of mining
    history or recovering from mistakes, and I rely only on the
    contents and parent-child relationships of commits to work out what
    a command I'm about to run will do. I would expect the vast
    majority of users to have a similar mental model, in which case the
    fact that the same commits can be rebased differently depending on
    the data in the reflog will be equally confusing to those users.

(2) Most people don't like to rebase too often, consequently the time
    elapsed from a user creating the topic branch and resetting its
    upstream until actually rebasing it can be days or weeks, by the
    end of which they are unlikely to remember the circumstances of
    creating the branch. Even more alarmingly, they may have committed
    dozens of further changes, and therefore may not even notice that
    the first few of those silently disappeared. (I'm not making this
    up: see discussion links below in PS.)

I believe the correct design would be to always make --no-fork-point
the default for rebase, and only use --fork-point when explicitly
specified. This would potentially be inconvenient for those who rebase
on top of complicated history rewrites, but said inconvenience would be
mitigated by several factors:
- Anyone doing rebases like that will already know that they can go
  wrong in a million ways.
- Perhaps more crucially, they will have a way of noticing if it went
  wrong, with all relevant information in short-term memory, so would
  recover easily.
- If the rebase turns out to be really complex, they are likely to
  resort to rebase -i, which shows full details of what is about to
  happen, moreover it seems relatively simple to enhance the contents
  of the rebase-todo file so that full information about the merge-base
  and fork-point is readily available.

If changing the default is not an option, e.g. because of backwards
compatibility concerns, then some configurability could still be
helpful, e.g. rebase.useForkPoint = never / auto / always (default
auto, to keep the current behaviour). Although I suspect this would
just lead to everyone suggesting setting this to 'never'. In any case
this would provide a way to ensure that any git newbies in my
organization don't spend days trying to figure this out like I've just
done.

Assuming there is agreement to do one of the above (I don't even know
whose agreement is required), what's the process for getting it
implemented? Sorry, that probably counts as a dumb question, but I've
never been around open-source projects much & need someone to show me
the ropes.

Many thanks
Laszlo

PS. Further reading about the same topic if anyone is interested:
- http://marc.info/?l=git&m=140991293402880&w=2 (from this same mailing
  list 2+ years ago, but I can see no clear conclusion)
- https://github.com/git-for-windows/git/issues/1076 (my bug report
  where contacting this list was suggested)
- http://stackoverflow.com/questions/22790765 and
  http://stackoverflow.com/questions/35320740 (various SO users being
  confused and asking about / discussing the same thing)
