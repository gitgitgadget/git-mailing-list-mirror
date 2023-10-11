Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09FCCDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbjJKWSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjJKWSs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:18:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A309BB8
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:18:46 -0700 (PDT)
Received: (qmail 20153 invoked by uid 109); 11 Oct 2023 22:18:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 22:18:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10587 invoked by uid 111); 11 Oct 2023 22:18:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 18:18:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 18:18:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: move process_address_list earlier to avoid,
 uninitialized address error
Message-ID: <20231011221844.GB518221@coredump.intra.peff.net>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
 <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
 <ZRGdvRQuj4zllGnm@pobox.com>
 <20230925161748.GA2149383@coredump.intra.peff.net>
 <ZSal-mQIZAUBaq6g@debian.me>
 <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
 <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
 <xmqq1qe0lui2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qe0lui2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 02:27:49PM -0700, Junio C Hamano wrote:

> Michael Strawbridge <michael.strawbridge@amd.com> writes:
> 
> > @@ -799,6 +799,10 @@ sub is_format_patch_arg {
> >  
> >  $time = time - scalar $#files;
> >  
> > +@initial_to = process_address_list(@initial_to);
> > +@initial_cc = process_address_list(@initial_cc);
> > +@initial_bcc = process_address_list(@initial_bcc);
> > +
> 
> This does not look OK.  If we trace how @initial_to gets its value,
> 
>  - it first gets its value from @getopt_to and @config_to
> 
>  - if that is empty, and there is no $to_cmd, the end-user is
>    interactively asked.
> 
>  - then process_address_list() is applied.
> 
> But this patch just swapped the second one and the third one, so
> process_address_list() does not process what the end-user gave
> interactively, no?

Yep, that is the issue I found when I dug into this earlier.

> >  if ($validate) {
> >         # FIFOs can only be read once, exclude them from validation.
> >         my @real_files = ();
> 
> It almost feels like what need to move is not the setting of these
> address lists, but the code that calls int validation callchain that
> needs access to these address lists---the block that begins with the
> above "if ($validate) {" needs to move below ...

Yes, though then we have the problem that we've asked the user some
interactive questions before validating if the input files are bogus or
not. Which would be annoying if they aren't valid, because when we barf
they've wasted time typing.

Which of course implies that we're not (and cannot) validate what
they're typing at this step, but I think that's OK because we feed it
through extract_valid_address_or_die(). IOW, I think there are actually
two distinct validation steps hidden here:

  1. We want to validate that the patch files we were fed are OK.

  2. We want to validate that the addresses, etc, fed by the user are
     OK.

And after Michael's original patch, we are accidentally hitting some of
that validation code for (2) while doing (1).

This is actually a weird split if you think about it. We are feeding to
the validate hook in (1), so surely it would want to see the full set of
inputs from the user, too? Which argues for pushing the "if ($validate)"
down as you suggest. And then either:

  a. We accept that the user experience is a little worse if validation
     fails after the user typed.

  b. We split (1) into "early" validation that just checks if the files
     are OK, but doesn't call the hook. And then later on we do the full
     validation.

I don't have a strong opinion myself (I don't even use send-email
myself, and if I did, I'd probably mostly be feeding it with "--to" etc
on the command line, rather than interactively).

-Peff
