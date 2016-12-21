Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6EA1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 10:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761862AbcLUKAl (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 05:00:41 -0500
Received: from continuum.iocl.org ([217.140.74.2]:58497 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756937AbcLUKAi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 05:00:38 -0500
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id uBLA0Xl08874;
        Wed, 21 Dec 2016 11:00:33 +0100
Date:   Wed, 21 Dec 2016 11:00:33 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Races on ref .lock files?
Message-ID: <20161221100033.GB1206@inner.h.apk.li>
References: <20161216164751.GA12174@inner.h.apk.li> <xmqqpokru6yg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpokru6yg.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 16 Dec 2016 09:20:07 +0000, Junio C Hamano wrote:
...
> >   error: cannot lock ref 'stash-refs/pull-requests/18978/to': Unable to create '/opt/apps/..../repositories/68/stash-refs/pull-requests/18978/to.lock': File exists.
...
> I think (and I think you also think) these messages come from the
> Bitbucket side, not your "git push" (or "git fetch").

I *know* that this is the case - we don't have refs like that
on the local side. (Our users are more scared about them.)

...
> when there are locked refs.  I'd naively think that unless you are
> pushing to that ref you showed an error message for, the receiving
> end shouldn't care if the ref is being written by somebody else, but
> who knows ;-) They may have their own reasons wanting to lock that
> ref that we think would be irrelevant for the operation, causing
> errors.

Possible. I'm going Byrans way for now, disabling the gc there.

But:

In a different instance, we have a simple bare git repo that we
use for backup purposes. Which means there are lots of pushes
going there (all to disjunct refs), and I now cared to look
into those logfiles:

----snip
Wed Dec 21 05:08:14 CET 2016
fatal: Unable to create '/data/git-backup/backup.git/packed-refs.lock': File exists.

If no other git process is currently running, this probably means a
git process crashed in this repository earlier. Make sure no other git
process is running and remove the file manually to continue.
error: failed to run pack-refs
To git-backup-user@socrepo.advantest.com:backup.git
 + 8aac9ae...2df6d56 refs/zz/current -> refs/backup/socvm217/ZworkspacesZsocvm217ZjohanabtZws-release_tools.Ycurr (forced update)
----snip

I interpret this as "I updated the refs files, but packing them
didn't work because someone else was also packing right now."

Is that happening as designed, or do I need to be afraid
that some refs didn't make the push?

To ask differently, is git relying on people reading such
messages and following up on them? And thus isn't that
easy to use in automated processes? (Additional problem:
The user in question, besides being an automat, doesn't
have the capability to work in the target repository.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
