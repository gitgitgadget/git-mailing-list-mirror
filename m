Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416791F859
	for <e@80x24.org>; Sun, 28 Aug 2016 19:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755299AbcH1Tn0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 15:43:26 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34290 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbcH1TnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 15:43:25 -0400
Received: by mail-lf0-f43.google.com with SMTP id l89so87933083lfi.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=CEqNwrdeqmKFNBN5/AAoEIVlU57Ioou2TtDaa8OZSoY=;
        b=wrwYlot5fERgi5pwFdkeN9LnWfsOF6eCET7zy5Bn/QX3m8OeenCmu0UYmwevHYPQaH
         XcMk2O2uDLeXFaJSkEoJ2xyL4kGFy06Ju72lVBe70FhNjhQaY3Ry/WJrnd1qKItPUk0V
         uE8F78dZ7kg92Ztt7uXHfUhcxHGzP0PUC4dLVqggS6F9pfSq292M2sCKrpPwi5p4s55r
         GMvElhlKiRYlPYhbOJg57MOoDrPC8CqVyG/K1ciqO/LqHTJBkHHbAcDz0b7kGSbVBSnX
         6M0+j1Pksg3gOhPWPEDJVZYtMrUgojgMN2Cw6xHaDljzU2lbfqpab8yTF/NK3Nqn5Jj0
         /5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=CEqNwrdeqmKFNBN5/AAoEIVlU57Ioou2TtDaa8OZSoY=;
        b=JtbJjZdC5TFLp95zmT0ZOvWeb2kyBxv9jQHekkQM/CtIizic8fubgFskZixkvqV6+n
         SP7JTpNPG9Xqxl9zZ5V0lG9bX8/Its9/VyXUXe7nzJeVkxTAOTBhPfukJg6Ln4XXIK83
         btuVZTMyrit7of4t+eNpGJrxB41XxVlRX/NZKighlglRmmW7YBHYVMjaPHAaOKhNx96k
         C2K5xjBceU3gRWIJy4bBq+DH5uBF5r4xHvNIEZfUULHiWqwtqN3fpDon/ARMjgxxbgaF
         6HVNrbizO0ZfzP+S6ISgSrykLpXwERbvrR7nVjLOyKszGPAlvC65tl1+1YQs91ETPsSw
         JDrQ==
X-Gm-Message-State: AE9vXwO1aKE4T1X4ZOtcUG6GOgjBaC1EDL7VC7LrDWyhkqOA3dj9lDsfcN6QbS7HmEAUNXWbpnwopcUjSKL5cQ==
X-Received: by 10.25.161.12 with SMTP id k12mr3705963lfe.22.1472413403051;
 Sun, 28 Aug 2016 12:43:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.78.226 with HTTP; Sun, 28 Aug 2016 12:42:52 -0700 (PDT)
From:   "W. David Jarvis" <william.d.jarvis@gmail.com>
Date:   Sun, 28 Aug 2016 12:42:52 -0700
X-Google-Sender-Auth: RvaItFcXp3XLCw2H_t_2hGwVfxA
Message-ID: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
Subject: Reducing CPU load on git server
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all -

I've run into a problem that I'm looking for some help with. Let me
describe the situation, and then some thoughts.

The company I work for uses git. We use GitHub Enterprise as a
frontend for our primary git server. We're using Chef solo to manage a
fleet of upwards of 10,000 hosts, which regularly pull from our Chef
git repository so as to converge.

A few years ago, in order to reduce the load on the primary server,
the firm set up a fleet of replication servers. This allowed the
majority of our infrastructure to target the replication servers for
all pull-based activity rather than the primary git server.

The actual replication process works as follows:

1. The primary git server receives a push and sends a webhook with the
details of the push (repo, ref, sha, some metadata) to a "publisher"
box

2. The publisher enqueues the details of the webhook into a queue

3. A fleet of "subscriber" (replica) boxes each reads the payload of
the enqueued message. Each of these then tries to either clone the
repository if they don't already have it, or they run `git fetch`.

During the course of either of these operations we use a
repository-level lockfile. If another request comes in while the repo
is locked, we re-enqueue it. When that request comes in later, if the
push event time is earlier than the most recent successful fetch, we
don't do any further work.

---

The problem we've been running into has been that as we've continued
to add developers, the CPU load on our primary instance has gone
through the roof. We've upgraded the machine to some of the punchiest
hardware we can get and it's regularly exceeding 70% CPU load. We know
that the overwhelming drive of this CPU load is near-constant git
operations on some of our larger and more active repositories.

Migrating off of Chef solo is essentially a non-starter at this point
in time, and we've also added a considerable number of non-Chef git
dependencies such that getting rid of the replication service would be
a massive undertaking. Even if we were to kill the replication fleet,
we'd have to figure out where to point that traffic in such a way that
we didn't overwhelm the primary git server anyways.

So I'm looking for some help in figuring out what to do next. At the
moment, I have two thoughts:

1. We currently run a blanket `git fetch` rather than specifically
fetching the ref that was pushed. My understanding from poking around
the git source code is that this causes the replication server to send
a list of all of its ref tips to the primary server, and the primary
server then has to verify and compare each of these tips to the ref
tips residing on the server.

That might not be a ton of work to do on an individual fetch
operation, but some of our repositories have over 5,000 branches and
are pushed to 1,000 times a day. Algorithmically, this would suggest
that the cost of a fetch will go up in terms of both N -- branches and
M -- pushes, so we're talking about a cost of N*M, both of which will
increase when we hire developers. This implies exponential growth in
load as we add engineers, which is...not good.

Also worth noting - if we assume that the replication server should be
reasonably up-to-date (see lockfile logic description, above), we're
talking about typically packing objects for one ref, and at most a
small number (<5).

My hypothesis is that moving to fetching the specific branch rather
than doing a blanket fetch would have a significant and material
impact on server load.

If we do go down this route, we'll potentially need to do some
refactoring around how we handle "failed fetches", which relates both
to our locking logic and to the actual potential failure of a git
fetch. Discussion of the locking mechanism follows:

2. Our current locking mechanism seems to me to be un-necessary. I'm
aware that git uses a few different locking mechanisms internally, and
the use of a repo-level lockfile would seem to only guarantee that
we're using coarser-grained locking than git actually supports. But I
don't know if git supports specific fetch-level ref locking that would
permit concurrent ref fetch operations. If it does, our current
architecture would seem to prevent git from being able to take
advantage of those mechanisms.

In other words, let's imagine a world in which we ditch our current
repo-level locking mechanism entirely. Let's also presume we move to
fetching specific refs rather than using blanket fetches. Does that
mean that if a fetch for ref A and a fetch for ref B are issued at
roughly the exact same time, the two will be able to be executed at
once without running into some git-internal locking mechanism on a
granularity coarser than the ref? i.e. are fetch A and fetch B going
to be blocked on the other's completion in any way? (let's presume
that ref A and ref B are not parents of each other).

---

I'm neither a contributor nor an expert in git, so my inferences thus
far as based purely off of what I would describe as "stumbling around
the source code like a drunken baby".

The ultimate goal for us is just figuring out how we can best reduce
the CPU load on the primary instance so that we don't find ourselves
in a situation where we're not able to run basic git operations
anymore.

If I'm barking up the wrong tree, or if there are other optimizations
we should be considering, I'd be eager to learn about those as well.
Of course, if what I'm describing sounds about right, I'd like
confirmation of that from some people who actually know what they're
talking about (i.e., not me :) ).

Thanks.

 - Venantius

-- 
============
venanti.us
203.918.2328
============
