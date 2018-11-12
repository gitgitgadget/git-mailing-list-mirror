Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373DF1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 20:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbeKMGLN (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 01:11:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:36298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725861AbeKMGLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 01:11:13 -0500
Received: (qmail 8975 invoked by uid 109); 12 Nov 2018 20:16:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 20:16:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14163 invoked by uid 111); 12 Nov 2018 20:15:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 15:15:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 15:16:24 -0500
Date:   Mon, 12 Nov 2018 15:16:24 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Geert Jansen <gerardu@amazon.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 7/9] object-store: provide helpers for loose_objects_cache
Message-ID: <20181112201623.GB7598@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145056.GG7400@sigill.intra.peff.net>
 <a766f9c6-4df9-c249-2b7b-89a2f4ccf405@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a766f9c6-4df9-c249-2b7b-89a2f4ccf405@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 08:24:59PM +0100, René Scharfe wrote:

> > +void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +
> > +	if (subdir_nr < 0 ||
> 
> Why not make subdir_nr unsigned (like in for_each_file_in_obj_subdir()), and
> get rid of this first check?

I stole the use of "int" from your code. ;)

More seriously, though, I wondered if callers might have sign issues
assigning from a "signed char". Usually we hold object ids in an
"unsigned char", but what happens if I do:

  signed char foo[] = { 1, 2, 3, 4 };
  odb_load_loose_cache(foo[0]);

when the parameter is "unsigned"?

I'll admit I get lost in all of the integer promotion rules there, but
are we sure there's no way we can end up with a funky truncation?

If the answer is no, then I agree that your suggestion is a strict
improvement.

> > +	    subdir_nr >= ARRAY_SIZE(odb->loose_objects_subdir_seen))
> 
> Using unsigned char for subdir_nr would allow removing the second check as
> well, but might hide invalid values in implicit conversions, I guess.

Yeah, I know that one could be a dangerous truncation.

I also considered just taking an object_id, which would make the
function "load the cache such that this oid would be valid". And it's
not necessarily the caller's business how much we load.

But that's OK for OBJECT_INFO_QUICK, but it's pretty darn subtle for the
abbrev code. That code doesn't care about just one object, but wants all
objects that share its prefix. That works now because we know that the
prefix is always at least 2 hex chars, so it's OK to load just that
subset.

> > +		BUG("subdir_nr out of range");
> 
> Showing the invalid value (like in for_each_file_in_obj_subdir()) would make
> debugging easier in case the impossible actually happens.

Good suggestion.

> > +	strbuf_addstr(&buf, odb->path);
> > +	for_each_file_in_obj_subdir(subdir_nr, &buf,
> > +				    append_loose_object,
> > +				    NULL, NULL,
> > +				    &odb->loose_objects_cache);
> > +	odb->loose_objects_subdir_seen[subdir_nr] = 1;
> 
> About here would be the ideal new home for ...
> [...]
> > -
> > -	strbuf_release(&buf);
> 
> ... this line.

Oops, thanks. I toyed with making the strbuf here static, which is why I
dropped the release. But since we only use it on a cache miss, I decided
it was better to avoid the hidden global (and then of course forgot to
re-add the release).

-Peff
