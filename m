Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CBCE20401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdFXMVA (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:21:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:51776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751272AbdFXMU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:20:59 -0400
Received: (qmail 1279 invoked by uid 109); 24 Jun 2017 12:20:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 12:20:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23528 invoked by uid 111); 24 Jun 2017 12:21:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 08:21:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 08:20:57 -0400
Date:   Sat, 24 Jun 2017 08:20:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] sha1_name: cache readdir(3) results in
 find_short_object_filename()
Message-ID: <20170624122057.ndmlsa7e7dksejg3@sigill.intra.peff.net>
References: <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
 <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net>
 <xmqqd1a0vb2t.fsf@gitster.mtv.corp.google.com>
 <d06fb033-294e-f364-3dde-394624e83cd6@web.de>
 <20170622231041.2zdjypviwmndjnsb@sigill.intra.peff.net>
 <97a8def3-d2ed-9212-4d87-8767de6f2695@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97a8def3-d2ed-9212-4d87-8767de6f2695@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 02:12:30PM +0200, René Scharfe wrote:

> > That's redundant with "subdir_nr". Should we push that logic down into
> > the function, and basically do:
> > 
> >    if (subdir_nr < 0 || subdir_nr > 256)
> > 	BUG("object subdir number out of range");
> 
> Hmm.  I don't expect many more callers, so do we really need this safety
> check?  It's cheap compared to the readdir(3) call, of course.

To me it's as much about documenting the assumptions as it is about
catching buggy callers. I'd be OK with a comment, too.

> But wouldn't it make more sense to use an unsigned data type to avoid
> the first half?  And an unsigned char specifically to only accept valid
> values, leaving the overflow concern to the caller?  It warrants a
> separate patch in any case IMHO.

Using unsigned makes sense. Using "char" because you know it only goes
to 256 is a bit too subtle for my taste. And yes, I'd do it in a
preparatory patch (or follow-on if you prefer).

> -- >8 --
> Subject: [PATCH] sha1_file: let for_each_file_in_obj_subdir() handle subdir names
> 
> The function for_each_file_in_obj_subdir() takes a object subdirectory
> number and expects the name of the same subdirectory to be included in
> the path strbuf.  Avoid this redundancy by letting the function append
> the hexadecimal subdirectory name itself.  This makes it a bit easier
> and safer to use the function -- it becomes impossible to specify
> different subdirectories in subdir_nr and path.

Yeah, this is what I had in mind.

>  	for (i = 0; i < 256; i++) {
> -		strbuf_addf(path, "/%02x", i);
>  		r = for_each_file_in_obj_subdir(i, path, obj_cb, cruft_cb,
>  						subdir_cb, data);
> -		strbuf_setlen(path, baselen);

One side effect of the original code is that this trailing setlen()
would catch any early-exits from for_each_file_in_obj_subdir() which
forgot to reset the strbuf. If any exist, that's a bug that should be in
fixed in that function, though. I double-checked, and there aren't any
(your patch already handles the extra setlen required when opendir
fails).

-Peff
