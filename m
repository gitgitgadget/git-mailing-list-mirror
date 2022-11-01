Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A5AC433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 12:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKAMW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 08:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKAMW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 08:22:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670515A2E
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 05:22:26 -0700 (PDT)
Received: (qmail 5730 invoked by uid 109); 1 Nov 2022 12:22:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 12:22:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23004 invoked by uid 111); 1 Nov 2022 12:22:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 08:22:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 08:22:24 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Englund <martin@englund.nu>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Subject: Re: Git Bug Report: out of memory using git tag
Message-ID: <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 03:29:33PM -0700, Martin Englund wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> I created a signed tag (git tag -s) using a ssh-agent key and then ran
> git tag -l --format '%(contents:body)' v0.6.1
> 
> What did you expect to happen? (Expected behavior)
> I get the output
> 
> What happened instead? (Actual behavior)
> fatal: Out of memory, malloc failed (tried to allocate
> 18446744073709551266 bytes)

Thanks for the report. This looks like pointer or size_t arithmetic that
has gone negative. Here's a minimal reproduction:

  {
    echo subject
    echo "-----BEGIN PGP SIGNATURE-----"
  } | git tag -F - foo
  git tag -l --format='%(contents:body)' foo

The issue isn't unique to pgp signatures; the problem is in the parsing
done by ref-filter's find_subpos(), so any signature type exhibits the
problem. At the end of that function we do:

      *nonsiglen = sigstart - buf;

but "buf" has moved beyond "sigstart". Presumably because it uses
strstr() to look for end-of-line in buf. Since there isn't one before
the signature begins, we go to the end of the signature.

The bug bisects to 9f75ce3d8f (ref-filter: handle CRLF at end-of-line
more gracefully, 2020-10-29). Before then, I think our loop was careful
about moving past the start of the signature. Author cc'd.

-Peff
