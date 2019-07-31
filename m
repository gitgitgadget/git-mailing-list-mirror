Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34FFA1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 21:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfGaVLx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 17:11:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:57542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728171AbfGaVLq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 17:11:46 -0400
Received: (qmail 20744 invoked by uid 109); 31 Jul 2019 21:11:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 21:11:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21936 invoked by uid 111); 31 Jul 2019 21:13:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 17:13:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 17:11:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Gregory Szorc <gregory.szorc@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] repack: silence warnings when auto-enabled bitmaps
 cannot be built
Message-ID: <20190731211144.GA1207@sigill.intra.peff.net>
References: <20190731053703.GA16709@sigill.intra.peff.net>
 <20190731053927.GB16941@sigill.intra.peff.net>
 <xmqqftmmosrf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftmmosrf.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 01:26:12PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -3313,8 +3319,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> >  			    N_("do not hide commits by grafts"), 0),
> >  		OPT_BOOL(0, "use-bitmap-index", &use_bitmap_index,
> >  			 N_("use a bitmap index if available to speed up counting objects")),
> > -		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
> > -			 N_("write a bitmap index together with the pack index")),
> > +		OPT_SET_INT(0, "write-bitmap-index", &write_bitmap_index,
> > +			    N_("write a bitmap index together with the pack index"),
> > +			    WRITE_BITMAP_TRUE),
> > +		OPT_SET_INT_F(0, "write-bitmap-index-quiet",
> > +			      &write_bitmap_index,
> > +			      N_("write a bitmap index if possible"),
> > +			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
> 
> The receiving end of this communication is pretty easy to follow.
> I'd have named an option to trigger "if possible" behaviour after
> that "if possible" phrase and not "quiet", but this is entirely
> internal that it does not matter.

Heh, that was actually the part of this series that I struggled the most
with. I didn't like "if possible" because that is already how we behave
(we continue without bitmaps if we can't make them, even if the user
asked for them explicitly). I had "if convenient" at one point, but it
seemed too vague and too long. ;)

So I'm happy to change it, but it would require somebody coming up with
a better name.

> >  	if (write_bitmaps < 0) {
> > -		write_bitmaps = (pack_everything & ALL_INTO_ONE) &&
> > -				 is_bare_repository() &&
> > -				 keep_pack_list.nr == 0 &&
> > -				 !has_pack_keep_file();
> > +		if (!(pack_everything & ALL_INTO_ONE) ||
> > +		    !is_bare_repository() ||
> > +		    keep_pack_list.nr != 0 ||
> > +		    has_pack_keep_file())
> > +			write_bitmaps = 0;
> 
> This side of communication is a bit harder to follow, but not
> impossible ;-) We leave it "negative" to signal "the user did not
> specify, but we enabled it by default" here.

Yeah, I also noticed that was a bit subtle. Maybe a comment:

  /* leave as -1 to indicate "auto bitmaps" */

or something would help. I also thought about writing it as:

  if (write_bitmaps < 0) {
	if ((pack_everything & ALL_INTO_ONE) &&
	    is_bare_repository() &&
	    keep_pack_list.nr == 0 &&
	    !hash_pack_keep_file()) {
		write_bitmaps = -1; /* indicates auto-enabled */
	} else {
		write_bitmaps = 0;
	}
  }

Better?

-Peff
