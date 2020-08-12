Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26BAC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 17:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B395D2076C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 17:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHLRIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:08:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:56678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgHLRIv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 13:08:51 -0400
Received: (qmail 10484 invoked by uid 109); 12 Aug 2020 17:08:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2020 17:08:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 936 invoked by uid 111); 12 Aug 2020 17:08:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2020 13:08:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Aug 2020 13:08:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/11] renaming argv_array
Message-ID: <20200812170849.GA43566@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
 <20200812150611.GA33189@coredump.intra.peff.net>
 <20200812151038.GB33189@coredump.intra.peff.net>
 <045ea49b-7165-0f45-e670-a24bf648f880@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <045ea49b-7165-0f45-e670-a24bf648f880@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 06:23:01PM +0200, René Scharfe wrote:

> > This seems to be related to setting SPATCH_BATCH_SIZE to "0". It used to make
> > things go much faster (if you had enough memory), but now seems to just
> > consume tons of CPU. Setting it to "1" finishes the whole thing in ~13
> > minutes of CPU (~2m wall-clock).
> 
> This bit me as well, and I settled with SPATCH_BATCH_SIZE = 10.  With
> MAKEFLAGS += -j3 I get these number, which are quite similar to yours
> (except I don't dare use more cores due to cooling issues..):
> 
>   real	4m12,393s
>   user	12m15,447s
>   sys	0m10,418s

Interestingly, that was slower for me (2m47s wall-clock, with 27m of
CPU). Using "2" is slightly faster than "1". But "3" is a little less
fast, and "4" is slower than "1". So...no clue what is going on.

> > So that's at least a path forward, but in general I have been frustrated
> > with operational aspects of coccinelle like this.
> 
> And I was a bit shocked when Coccinelle's testing package became
> unmaintained for a while and I had to compile it from source.

Yeah, I've had various issues with the packaging. For a long time they
had 1.0.7 in experimental, but with no python support. I wonder if it's
worth starting to use python scriptlets in our coccinelle rules, as
described in 4d168e742a (coccinelle: use <...> for function exclusion,
2018-08-28). They're faster and IMHO easier to understand.

Of course I tried it out and got some inscrutable errors:

  SPATCH contrib/coccinelle/object_id.cocci
  init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
  Python path configuration:
    PYTHONHOME = '/lib/x86_64-linux-gnu/..'
    PYTHONPATH = '/usr/bin/../lib/coccinelle/python'
    program name = 'python3'
    isolated = 0
    environment = 1
    user site = 1
    import site = 1
    sys._base_executable = '/usr/bin/python3'
    sys.base_prefix = '/lib/x86_64-linux-gnu/..'
    sys.base_exec_prefix = '/lib/x86_64-linux-gnu/..'
    sys.executable = '/usr/bin/python3'
    sys.prefix = '/lib/x86_64-linux-gnu/..'
    sys.exec_prefix = '/lib/x86_64-linux-gnu/..'
    sys.path = [
      '/usr/bin/../lib/coccinelle/python',
      '/lib/x86_64-linux-gnu/../lib/python38.zip',
      '/lib/x86_64-linux-gnu/../lib/python3.8',
      '/lib/x86_64-linux-gnu/../lib/python3.8/lib-dynload',
    ]
  Fatal Python error: init_fs_encoding: failed to get the Python codec of the filesystem encoding
  Python runtime state: core initialized
  ModuleNotFoundError: No module named 'encodings'

Fun.

-Peff
