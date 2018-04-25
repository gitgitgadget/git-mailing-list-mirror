Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897F81F424
	for <e@80x24.org>; Wed, 25 Apr 2018 20:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750949AbeDYUHO (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 16:07:14 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:37122 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750814AbeDYUHN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 16:07:13 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 02CC1335C60
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 20:07:12 +0000 (UTC)
Received: (qmail 2624 invoked by uid 10000); 25 Apr 2018 20:07:11 -0000
Date:   Wed, 25 Apr 2018 20:07:11 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Message-ID: <robbat2-20180425T173507-286694375Z@orbis-terrarum.net>
References: <20180413170129.15310-1-mgorny@gentoo.org>
 <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
 <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
 <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 11:18:26AM -0400, Marc Branchaud wrote:
> > The best approach to do so is to have those people do the "touch"
> > thing in their own post-checkout hook.  People who use Git as the
> > source control system won't have to pay runtime cost of doing the
> > touch thing, and we do not have to maintain such a hook script.
> > Only those who use the "feature" would.
> 
> The post-checkout hook approach is not exactly straightforward.
> 
> Naively, it's simply
> 
> 	for F in `git diff --name-only $1 $2`; do touch "$F"; done
Even this naive attempt gets it wrong: successive files have increasing
times.  You need to capture the time at the start, and use it as the time
for the files.
  touch /tmp/ref && \
  for F in `git diff --name-only $1 $2`; do touch -r /tmp/ref "$F"; done && \
  rm /tmp/ref
(or pass a fixed time into touch).

> But consider:
> 
> * Symlinks can cause the wrong file to be touched.  (Granted, Michał's 
> proposed patch also doesn't deal with symlinks.) 
Yes, it blindly touches the file, and rather than trying to do
utimensat's AT_SYMLINK_NOFOLLOW flag.

> Let's assume that a 
> hook can be crafted will all possible sophistication.  There are still 
> some fundamental problems:
>
> * In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are 
> identical so the above loop does nothing.  Offhand I'm not even sure how 
> a hook might get the right files in this case.
Yes, this would need to be a new hook that knows more than post-checkout
presently does.

post-checkout right now runs AFTER the worktree has been updated, and
only gets the refs of old/new HEAD and if the branch was changed.
It does NOT know which files were actually modified, and since it

If a hook is added for that, then this behavior can be implemented in
the hook. Alternatively adding a pre-checkout hook to absorb some state
of the unmodified worktree (this could be a bit expensive).

> * The hook has to be set up in every repo and submodule (at least until 
> something like Ævar's experiments come to fruition).
> 
> * A fresh clone can't run the hook.  This is especially important when 
> dealing with submodules.  (In one case where we were bit by this, make 
> though that half of a fresh submodule clone's files were stale, and 
> decided to re-autoconf the entire thing.)
The fresh clone case really matters for my usage, where new clones are
firing in CI/CD processes.

> I just don't think the hook approach can completely solve the problem.
> 
> I appreciate Ævar's concern that there are more than just two mtime 
> requests floating around.  But I think git's users are best served by a 
> built-in approach, with a config setting to control the desired mtime 
> handling (defaulting to the current behaviour).  People who want a 
> different mtime solution will at least have a clear place in the code to 
> propose a patch.
+1 as long as we can set the behavior during the clone.

-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
