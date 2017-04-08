Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD0C20970
	for <e@80x24.org>; Sat,  8 Apr 2017 15:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbdDHPDJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 11:03:09 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:33139 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdDHPDH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 11:03:07 -0400
Received: from [192.168.42.152] (dslb-188-102-145-188.188.102.pools.vodafone-ip.de [188.102.145.188])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id 31DF8301C1C;
        Sat,  8 Apr 2017 17:03:06 +0200 (CEST)
To:     matt@mattmccutchen.net (Matt McCutchen), git@vger.kernel.org (git)
In-Reply-To: <1491617750.2149.10.camel@mattmccutchen.net>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Sat, 8 Apr 2017 17:03:06 +0200
Message-ID: <1n468u6.1jrwr611bokgfiM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> wrote:

> When I'm rewriting history, "git push --force-with-lease" is a nice
> safeguard compared to "git push --force", but it still assumes the
> remote-tracking ref gives the old state the user wants to overwrite. 
> Tools that do an implicit fetch, assuming it to be a safe operation,
> may break this assumption.  In the worst case, Visual Studio Code does
> an automatic fetch every 3 minutes by default [1], making
> --force-with-lease pretty much reduce to --force.
> 
> For a safer workflow, "git push" would check against a separate "old"
> ref that isn't updated by "git fetch", but is updated by "git push" the
> same way the remote-tracking ref is and maybe also by commands that
> update the local branch to take into account remote changes (I'm not
> sure what reasonable scenarios there are, if any).

Here's a rough proposal for how I would imagine this to work.

For every local branch that has a remote tracking branch, git maintains
a new config entry branch.*.integrated, which records the sha1 of the
last upstream commit that was integrated into the local branch.

When --force-with-lease is used without an argument, it will use the
values of "branch.*.remote:branch.*.integrated" as an argument. If
either doesn't exist, the push fails (this is essential).

Initially the "integrated" entry is created at the same time that
branch.*.merge is, i.e. with commits like "git checkout -b
name-of-remote-branch", or "git branch --set-upstream-to" and the like,
and it will be set to the sha1 that the tip of the remote tracking
branch has at that time.

Then, every command that either integrates the remote tracking branch
into the local branch, or updates the remote tracking branch to the
local branch, will update the value of the "integrated" entry. The most
obvious ones are "git pull" and "git push", or course; others that may
have to be supported are "git rebase @{u}", "git rebase --onto @{u}",
"git reset @{u}", and probably others. The nice thing about these is
that initially they don't have to be supported for the feature to still
be useful. After using one of them, push --force-with-lease will fail,
and the user can then investigate the situation and either use push -f
or manually update branch.*.integrated when they have convinced
themselves that everything is fine.

I find it essential that --force-with-lease might fail erroneously, but
never succeed erroneously, and I think this proposal would guarantee
that.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
