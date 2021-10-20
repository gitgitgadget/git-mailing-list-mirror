Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F075C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 02:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DDF61359
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 02:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhJTCW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 22:22:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:42168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhJTCW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 22:22:56 -0400
Received: (qmail 8160 invoked by uid 109); 20 Oct 2021 02:20:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Oct 2021 02:20:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18037 invoked by uid 111); 20 Oct 2021 02:20:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Oct 2021 22:20:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Oct 2021 22:20:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] for-each-ref: delay parsing of --sort=<atom> options
Message-ID: <YW98+Lj9xVsR9u9Q@coredump.intra.peff.net>
References: <xmqqv91uw5dl.fsf@gitster.g>
 <YW9EP5UNX0f+eOke@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YW9EP5UNX0f+eOke@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 19, 2021 at 06:18:40PM -0400, Jeff King wrote:

> > @@ -86,8 +86,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> >  
> >  	packet_trace_identity("ls-remote");
> >  
> > -	UNLEAK(sorting);
> > -
> >  	if (argc > 1) {
> >  		int i;
> >  		CALLOC_ARRAY(pattern, argc);
> > @@ -139,8 +137,13 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> >  		item->symref = xstrdup_or_null(ref->symref);
> >  	}
> >  
> > -	if (sorting)
> > +	if (sorting_options.nr) {
> > +		struct ref_sorting *sorting;
> > +		UNLEAK(sorting);
> > +
> > +		sorting = ref_sorting_options(&sorting_options);
> >  		ref_array_sort(sorting, &ref_array);
> > +	}
> 
> I wondered at first about pulling this UNLEAK() down, but it's because
> you move the "sorting" variable itself into the smaller scope. So this
> makes sense (and calling UNLEAK() before the pointer is set is perfectly
> fine, since it takes the address of the auto variable). It is a shame
> you can't just ref_sorting_free() afterwards, but we don't have that
> function yet. And adding it is way out of scope here. :)

Actually, I think I was wrong here. UNLEAK() will look at &sorting, but
it will snapshot its data at the time of the call. So it won't do
anything when the variable doesn't yet have a value.

You can demonstrate with:

  $ make SANITIZE=leak
  $ ./git ls-remote --sort=refname .

which will complain. Bumping it down like this:

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1e6017cdaa..a94a220256 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -139,10 +139,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	if (sorting_options.nr) {
 		struct ref_sorting *sorting;
-		UNLEAK(sorting);
 
 		sorting = ref_sorting_options(&sorting_options);
 		ref_array_sort(sorting, &ref_array);
+		UNLEAK(sorting);
 	}
 
 	for (i = 0; i < ref_array.nr; i++) {

clears it up. Note that there are other similar "leaks" (e.g., if you
give a pattern in argv[1]) which should be punted to another topic, but
I think you'd want to deal with this one since you're moving the
UNLEAK() around.

-Peff
