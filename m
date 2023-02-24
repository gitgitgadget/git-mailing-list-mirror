Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E76C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 21:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBXVlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 16:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBXVle (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 16:41:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE02199E9
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 13:41:33 -0800 (PST)
Received: (qmail 11788 invoked by uid 109); 24 Feb 2023 21:41:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 21:41:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6292 invoked by uid 111); 24 Feb 2023 21:41:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 16:41:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 16:41:31 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
Message-ID: <Y/kvC9+VVo80npe3@coredump.intra.peff.net>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net>
 <CAJoAoZmMQ-ROdCp0=4oaFa836-PqxwYntnRSBSzzJc5chp16eQ@mail.gmail.com>
 <Y/ACqlhtLMjfgJFQ@tapette.crustytoothpaste.net>
 <CAJoAoZkMR9Acy7thVs-_e=Fz8wwjoDGDKb46wmwn8yxk0ODGow@mail.gmail.com>
 <Y/ZuR9zs3peUfO0g@coredump.intra.peff.net>
 <CAJoAoZknYizS4peYgR4Zy5KUMEpFUbj5eREZoC_K5vUDXnAhng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZknYizS4peYgR4Zy5KUMEpFUbj5eREZoC_K5vUDXnAhng@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 12:31:16PM -0800, Emily Shaffer wrote:

> > One thing that strategy doesn't help with, though, that your
> > libification might want: it's not very machine-readable. The error
> > reporters would still fundamentally be working with strings. So a
> > libified process can know "OK, writing this ref failed, and I have some
> > error messages in a buffer". But the calling code can't know specifics
> > like "it failed because we tried to open file 'foo' and it got EPERM".
> > We _could_ design an error context that stores individual errno values
> > or codes in a list, but having each caller report those specific errors
> > is a much bigger job (and ongoing maintenance burden as we catalogue and
> > give an identifier to each error).
> 
> Is there a reason not to use this kind of struct and provide
> library-specific error code enums, though, I wonder? You're right that
> parsing the error string is really bad for the caller, for anything
> besides just logging it. But it seems somewhat reasonable to expect
> that any call from config library returning an integer error code is
> referring to enum config_errors...

Right, you could definitely layer the two approaches by storing the
enums in the struct. And that might be a good thing to do in the long
run. But I think it's a much harder change, as it implies assigning
those codes (and developing a taxonomy of errors). But that can also be
done incrementally, especially if it's done on top of human-readable
strings.

I.e., I can imagine a world where low-level code reports an error like:

   int read_foo(const char *path, struct error_context *err)
   {
           fd = open(path, ...);
           if (fd < 0)
                   return report_errno(&err, ERR_FOO_OPEN, "unable to open foo file '%s'", path);
           ...read and parse...
           if (some_unexpected_format)
                   return report(&err, ERR_FOO_FORMAT, "unable to parse foo file '%s'", path);
   }

and then the caller has many options:

  - pass in a context that just dumps the human readable errors to
    stderr

  - collect the error strings in a buffer to report by some other
    mechanism

  - check err.type to act on ERR_FOO_OPEN, etc, including errno (which
    I'd imagine report_errno() to record)

The details above are just a sketch, of course. Rather than FOO_OPEN,
callers may actually want to think of things more like a stack of
errors that would mirror the callstack. You could imagine something
like:

  type=ERR_REF_WRITE
  type=ERR_GET_LOCK
  type=ERR_OPEN, errno=EPERM

I do think it's possible to over-engineer this to the point of
absurdity, and end up creating a lot of work. Which is why I'd probably
start with uniformly trying to use an error context struct with strings,
after which adding on fancier features gets easier (and again, is
possibly something that can be done incrementally as various subsystems
support it).

-Peff
