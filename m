Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714CD1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 14:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756615AbeDZOqY (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 10:46:24 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:42416 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756613AbeDZOqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 10:46:23 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 6AD45335C43;
        Thu, 26 Apr 2018 14:46:18 +0000 (UTC)
Message-ID: <1524753972.1088.9.camel@gentoo.org>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Marc Branchaud <marcnarc@xiplink.com>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Date:   Thu, 26 Apr 2018 16:46:12 +0200
In-Reply-To: <xmqqefj24v3c.fsf@gitster-ct.c.googlers.com>
References: <20180413170129.15310-1-mgorny@gentoo.org>
         <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
         <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
         <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
         <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
         <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
         <xmqqefj24v3c.fsf@gitster-ct.c.googlers.com>
Organization: Gentoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu czw, 26.04.2018 o godzinie 10∶25 +0900, użytkownik Junio C Hamano
napisał:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
> > > But Git is not an archiver (tar), but is a source code control
> > > system, so I do not think we should spend any extra cycles to
> > > "improve" its behaviour wrt the relative ordering, at least for the
> > > default case.  Only those who rely on having build artifact *and*
> > > source should pay the runtime (and preferrably also the
> > > maintainance) cost.
> > 
> > Anyone who uses "make" or some other mtime-based tool is affected by
> > this.  I agree that it's not "Everyone" but it sure is a lot of
> > people.
> 
> That's an exaggerated misrepresentation.  Only those who put build
> artifacts as well as source to SCM *AND* depend on mtime are
> affected.
> 
> A shipped tarball often contain configure.in as well as generated
> configure, so that consumers can just say ./configure without having
> the whole autoconf toolchain to regenerate it (I also heard horror
> stories that this is done to control the exact version of autoconf
> to avoid compatibility issues), but do people arrange configure to
> be regenerated from configure.in in their Makefile of such a project
> automatically when building the default target?  In any case, that is
> a tarball usecase, not a SCM one.
> 
> > Are we all that sure that the performance hit is that drastic?  After
> > all, we've just done write_entry().  Calling utime() at that point
> > should just hit the filesystem cache.
> 
> I do not know about others, but I personally am more disburbed by
> the conceptual ugliness that comes from having to have such a piece
> of code in the codebase.

For the record, we're using this with ebuilds and respective cache files
(which are expensive to generate).  We are using separate repository
which combines sources and cache files to keep the development
repository clean.  I have researched different solutions for this but
git turned out the best option for incremental updates for us.

Tarballs are out of question, unless you expect users to fetch >100 MiB
every time, and they are also expensive to update.  Deltas of tarballs
are just slow and require storing a lot of extra data.  Rsync is not
very efficient at frequent updates, and has significant overhead
on every run.  With all its disadvantages, git is still something that
lets our users fetch updates frequently with minimal network overhead.

So what did I do to deserve being called insane here?  Is it because I
wanted to use the tools that work for us?  Because I figured out that I
can improve our use case without really harming anyone in the process?

-- 
Best regards,
Michał Górny

