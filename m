Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8850A1F513
	for <e@80x24.org>; Fri, 27 Apr 2018 17:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758762AbeD0RSX (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:18:23 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:40930 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758271AbeD0RSW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:18:22 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id D92C5335C7F;
        Fri, 27 Apr 2018 17:18:19 +0000 (UTC)
Message-ID: <1524849496.1125.30.camel@gentoo.org>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Marc Branchaud <marcnarc@xiplink.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Date:   Fri, 27 Apr 2018 19:18:16 +0200
In-Reply-To: <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
References: <20180413170129.15310-1-mgorny@gentoo.org>
         <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
         <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
         <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
         <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
         <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
Organization: Gentoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu śro, 25.04.2018 o godzinie 11∶18 -0400, użytkownik Marc Branchaud
napisał:
> On 2018-04-25 04:48 AM, Junio C Hamano wrote:
> > "Robin H. Johnson" <robbat2@gentoo.org> writes:
> > 
> > > In the thread from 6 years ago, you asked about tar's behavior for
> > > mtimes. 'tar xf' restores mtimes from the tar archive, so relative
> > > ordering after restore would be the same, and would only rebuild if the
> > > original source happened to be dirty.
> > > 
> > > This behavior is already non-deterministic in Git, and would be improved
> > > by the patch.
> > 
> > But Git is not an archiver (tar), but is a source code control
> > system, so I do not think we should spend any extra cycles to
> > "improve" its behaviour wrt the relative ordering, at least for the
> > default case.  Only those who rely on having build artifact *and*
> > source should pay the runtime (and preferrably also the
> > maintainance) cost.
> 
> Anyone who uses "make" or some other mtime-based tool is affected by 
> this.  I agree that it's not "Everyone" but it sure is a lot of people.
> 
> Are we all that sure that the performance hit is that drastic?  After 
> all, we've just done write_entry().  Calling utime() at that point 
> should just hit the filesystem cache.
> 
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
> 
> But consider:
> 
> * Symlinks can cause the wrong file to be touched.  (Granted, Michał's 
> proposed patch also doesn't deal with symlinks.)  Let's assume that a 
> hook can be crafted will all possible sophistication.  There are still 
> some fundamental problems:
> 
> * In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are 
> identical so the above loop does nothing.  Offhand I'm not even sure how 
> a hook might get the right files in this case.
> 
> * The hook has to be set up in every repo and submodule (at least until 
> something like Ævar's experiments come to fruition).
> 
> * A fresh clone can't run the hook.  This is especially important when 
> dealing with submodules.  (In one case where we were bit by this, make 
> though that half of a fresh submodule clone's files were stale, and 
> decided to re-autoconf the entire thing.)
> 
> 
> I just don't think the hook approach can completely solve the problem.
> 

There's also the performance aspect.  If we deal with checkouts that
include 1000+ files on a busy system (i.e. when mtimes really become
relevant), calling utime() instantly has a good chance of hitting warm
cache.  On the other hand, post-checkout hook has a greater risk of
running cold cache, i.e. writing to all inodes twice.

-- 
Best regards,
Michał Górny

