Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D32C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiKVTxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKVTxC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:53:02 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3257DCBB
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:53:01 -0800 (PST)
Received: (qmail 18916 invoked by uid 109); 22 Nov 2022 19:53:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Nov 2022 19:53:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6481 invoked by uid 111); 22 Nov 2022 19:53:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Nov 2022 14:53:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Nov 2022 14:53:00 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] object-file: use real paths when adding alternates
Message-ID: <Y30onDTUFmAezkSl@coredump.intra.peff.net>
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
 <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
 <221122.868rk3bxbb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221122.868rk3bxbb.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 01:56:09AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > @@ -516,12 +517,14 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
> >  	}
> >  	strbuf_addbuf(&pathbuf, entry);
> >  
> > -	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
> > +	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
> >  		error(_("unable to normalize alternate object path: %s"),
> > -		      pathbuf.buf);
> > +			pathbuf.buf);
> 
> This is a mis-indentation, it was OK in the pre-image, not now.
> 
> >  		strbuf_release(&pathbuf);
> 
> Doesn't this leak? I've just skimmed strbuf_realpath_1() but e.g. in the
> "REALPATH_MANY_MISSING" case it'll have allocated the "resolved" (the
> &tmp you pass in here) and then "does a "goto error_out".
> 
> It then *resets* the strbuf, but doesn't release it, assuming that
> you're going to pass it in again. So in that case we'd leak here, no?
> 
> I.e. a NULL return value from strbuf_realpath() doesn't mean that it
> didn't allocate in the scratch area passed to it, so we need to
> strbuf_release(&tmp) here too.

We don't use MANY_MISSING in this code path, but I didn't read
strbuf_realpath_1() carefully enough to see if that is the only case.
But regardless, I think it is a bug in strbuf_realpath(). All of the
strbuf functions generally try to leave a buffer untouched on error.

So IMHO we would want a preparatory patch with s/reset/release/ in that
function, which better matches the intent (we might be freeing an
allocated buffer, but that's OK from the caller perspective). In theory
it ought to just roll back the length for whatever it put into the
buffer, but it looks like the rest of the function is happy to clobber
what's in the buf, even on non-error. That's why we have
strbuf_add_real_path(), but of course it doesn't allow for setting the
die_on_error flag.

-Peff
