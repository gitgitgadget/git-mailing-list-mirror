Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53E1C35254
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 12:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECF521741
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 12:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBEMYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:24:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:52988 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726597AbgBEMYi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 07:24:38 -0500
Received: (qmail 16354 invoked by uid 109); 5 Feb 2020 12:24:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Feb 2020 12:24:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7055 invoked by uid 111); 5 Feb 2020 12:32:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Feb 2020 07:32:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Feb 2020 07:24:37 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 3/6] create .git/refs in files-backend.c
Message-ID: <20200205122437.GA55322@coredump.intra.peff.net>
References: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
 <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <5b7060cb2fc25fc1c71b7c70864ebf758b59aa90.1580848060.git.gitgitgadget@gmail.com>
 <20200205114210.GL10482@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200205114210.GL10482@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 05, 2020 at 12:42:10PM +0100, SZEDER Gábor wrote:

> On Tue, Feb 04, 2020 at 08:27:37PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> > From: Han-Wen Nienhuys <hanwen@google.com>
> > 
> > This prepares for supporting the reftable format, which will want
> > create its own file system layout in .git
> 
> This breaks 'git init', and, consequently, the whole test suite:
> 
>   $ ./git init /tmp/foo
>   /tmp/foo/.git/refs/tmp/foo/.git/refs/heads: No such file or directory

Yeah, this is one of the fixes in the patch I sent earlier in the
thread. The issue is here:

> > @@ -3158,6 +3158,11 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
> >  		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
> >  	struct strbuf sb = STRBUF_INIT;
> >  
> > +	files_ref_path(refs, &sb, "refs");
> > +	safe_create_dir(sb.buf, 1);
> > +        /* adjust permissions even if directory already exists. */
> > +	adjust_shared_perm(sb.buf);
> > +
> >  	/*
> >  	 * Create .git/refs/{heads,tags}
> >  	 */

Right after this context, we call files_ref_path() with "sb" again.
There needs to be a strbuf_reset() beforehand.

-Peff
