Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA701F404
	for <e@80x24.org>; Fri, 24 Aug 2018 19:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeHXXff (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 19:35:35 -0400
Received: from waltz.apk.li ([185.177.140.48]:59295 "EHLO waltz.apk.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeHXXff (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 19:35:35 -0400
Received: from continuum.iocl.org (localhost [IPv6:::1])
        by waltz.apk.li (Postfix) with ESMTP id 5FC4859804E;
        Fri, 24 Aug 2018 21:59:30 +0200 (CEST)
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id w7OJx6V22062;
        Fri, 24 Aug 2018 21:59:06 +0200
Date:   Fri, 24 Aug 2018 21:59:05 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: clone, hardlinks, and file modes (and CAP_FOWNER)
Message-ID: <20180824195905.GA19781@inner.h.apk.li>
References: <20180824121407.GA19597@inner.h.apk.li> <87tvnjes6y.fsf@evledraar.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvnjes6y.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Aug 2018 16:48:37 +0000, Ævar Arnfjörð Bjarmason wrote:
...
> I don't understand how this hardlink approach would work (doesn't mean
> it won't, just that I don't get it).

I just detect whether there is insufficient sharing (df is quite handy
here; 'df this/.git that/.git' tells the unshared part of that/.git only).

When I detect 'unsharedness', I just hardlink the biggest .pack and the
corresponding .idx into the target repo, create a .keep file for that,
run 'git gc', and remove the .keep file. Effect: repack uses the .kept
file and only creates a small additional pack file for the remaining
objects, thus the biggest part of the objects are now shared between
the cache and the target repo.

This is going to be run once a week over all the repos on a machine
(that were created by our tooling and thus have known locations),
to avoid eventual repacks of repos to gradually and completely
lose the sharedness of the objects/packs.

> If you have such a tightly coupled approach isn't --reference closed to
> what you want in that case?

Close, but not. --reference et al. all need the promise that the
referenced repo isn't going away, and I don't want to rely on this
(if someone thinks he can drop the cache this should not lead to
breakage in the work repos).

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
