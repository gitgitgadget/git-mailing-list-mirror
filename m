Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5A11F406
	for <e@80x24.org>; Mon, 15 Jan 2018 23:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750764AbeAOXrh (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 18:47:37 -0500
Received: from mxin.vub.ac.be ([134.184.129.114]:13511 "EHLO mxin.vub.ac.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbeAOXrh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 18:47:37 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2018 18:47:36 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FwAQCPOl1a/wsxuIZcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUbj1KPbRRokTiHDgqFOwKFFBQBAQEBAQEBAQEDaCiFJAEBAQM?=
 =?us-ascii?q?BJxM/BQsLDgoJJQ8FKCGKPgipfTqJSwEBAQEBAQQBAQEBJIgogWmCeDaIaoIUI?=
 =?us-ascii?q?AWjZJU+giaJezeHRUiWXYE8NiOBUEwgGIJohFdAjgYBAQE?=
X-IPAS-Result: =?us-ascii?q?A2FwAQCPOl1a/wsxuIZcGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?bj1KPbRRokTiHDgqFOwKFFBQBAQEBAQEBAQEDaCiFJAEBAQMBJxM/BQsLDgoJJ?=
 =?us-ascii?q?Q8FKCGKPgipfTqJSwEBAQEBAQQBAQEBJIgogWmCeDaIaoIUIAWjZJU+giaJeze?=
 =?us-ascii?q?HRUiWXYE8NiOBUEwgGIJohFdAjgYBAQE?=
Received: from igwe11.vub.ac.be (HELO igwe.rave.org) ([134.184.49.11])
  by smtp.vub.ac.be with ESMTP/TLS/AES128-GCM-SHA256; 16 Jan 2018 00:37:51 +0100
Received: from kgybels by igwe.rave.org with local (Exim 4.84_2)
        (envelope-from <kgybels@infogroep.be>)
        id 1ebEK7-00014s-6f; Tue, 16 Jan 2018 00:37:51 +0100
Date:   Tue, 16 Jan 2018 00:37:51 +0100
From:   Kim Gybels <kgybels@infogroep.be>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] packed_ref_cache: don't use mmap() for small files
Message-ID: <20180115233751.GA1781@infogroep.be>
References: <20180113161149.9564-1-kgybels@infogroep.be>
 <20180115211505.GA4778@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115211505.GA4778@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On (15/01/18 16:15), Jeff King wrote:

> On Sat, Jan 13, 2018 at 05:11:49PM +0100, Kim Gybels wrote:
> 
> > Take a hint from commit ea68b0ce9f8ce8da3e360aed3cbd6720159ffbee and use
> > read() instead of mmap() for small packed-refs files.
> > 
> > This also fixes the problem[1] where xmmap() returns NULL for zero
> > length[2], for which munmap() later fails.
> > 
> > Alternatively, we could simply check for NULL before munmap(), or
> > introduce an xmunmap() that could be used together with xmmap().
> 
> This looks good to me, and since it's a recent-ish regression, I think
> we should take the minimal fix here.

The minimal fix being a simple NULL check before munmap()?

> But it does make me wonder whether xmmap() ought to be doing this "small
> mmap" optimization for us. Obviously that only works when we do
> MAP_PRIVATE and never write to the result. But that's how we always use
> it anyway, and we're restricted to that to work with the NO_MMAP wrapper
> in compat/mmap.c.

Maybe I should have left the optimization for small files out of the patch for
the zero length regression. After all, read() vs mmap() performance might
depend on other factors than just size.

> > @@ -489,21 +491,21 @@ static int load_contents(struct snapshot *snapshot)
> >  		die_errno("couldn't stat %s", snapshot->refs->path);
> >  	size = xsize_t(st.st_size);
> >  
> > -	switch (mmap_strategy) {
> > -	case MMAP_NONE:
> > +	if (!size) {
> > +		snapshot->buf = NULL;
> > +		snapshot->eof = NULL;
> > +		snapshot->mmapped = 0;
> > +	} else if (size <= SMALL_FILE_SIZE || mmap_strategy == MMAP_NONE) {
> >  		snapshot->buf = xmalloc(size);
> >  		bytes_read = read_in_full(fd, snapshot->buf, size);
> >  		if (bytes_read < 0 || bytes_read != size)
> >  			die_errno("couldn't read %s", snapshot->refs->path);
> >  		snapshot->eof = snapshot->buf + size;
> >  		snapshot->mmapped = 0;
> 
> If the "!size" case is just lumped in with "size <= SMALL_FILE_SIZE",
> then we'd try to xmalloc(0), which is guaranteed to work (we fallback to
> a 1-byte allocation if necessary). Would that make things simpler and
> more consistent for the rest of the code to always have snapshot->buf be
> a valid pointer (just based on seeing Michael's follow-up patches)?

Indeed, all those patches are to avoid using the NULL pointers in ways that are
undefined. We could also copy index_core's way of handling the zero length
case:
ret = index_mem(sha1, "", size, type, path, flags);

Point to some static memory instead of NULL, then all the pointer arithmetic is defined.

-Kim
