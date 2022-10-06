Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13DFC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 12:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJFMQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 08:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJFMQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 08:16:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6F79AFFA
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 05:16:25 -0700 (PDT)
Received: (qmail 11852 invoked by uid 109); 6 Oct 2022 12:16:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Oct 2022 12:16:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25505 invoked by uid 111); 6 Oct 2022 12:16:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Oct 2022 08:16:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Oct 2022 08:16:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Aleajndro R =?utf-8?Q?Sede=C3=B1o?= <asedeno@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated only takes a message
 in GCC 4.5+
Message-ID: <Yz7HGAThrOcPdmjm@coredump.intra.peff.net>
References: <20221003212318.3092010-1-asedeno@google.com>
 <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
 <CAOO-Oz2WnodBnw86mi2GZ+jLGoGy_saX=kCpwPdm2xohDO1s_Q@mail.gmail.com>
 <Yz2afjRezq5oGN4g@coredump.intra.peff.net>
 <221006.86lepts927.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221006.86lepts927.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2022 at 09:29:11AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > This will cause some mild hardships, as later patches will need to
> > #define UNUSED in other spots, as well, in order to get full coverage of
> > the code base (I have written those annotation patches, but they're not
> > applied upstream yet).
> 
> Sorry about any trouble in having to rebase those on UNUSED.

That part was not too bad, and is already done.

The trickiest part is that the headers get included in odd orders, and
if the macros don't match, the compiler will complain (this has to do
with compat/ headers which don't necessarily start by including
git-compat-util.h).

But if the definition gets much more complicated, then it's probably
worth pulling it out rather than repeating it.

> If you're taking requests it would be really useful to prioritize
> changes to shared headers and the like, e.g. DEVOPTS=extra-all on pretty
> much any file will start with:
> 	
> 	git-compat-util.h: In function ‘precompose_argv_prefix’:
> 	git-compat-util.h:313:54: error: unused parameter ‘argc’ [-Werror=unused-parameter]
> 	  313 | static inline const char *precompose_argv_prefix(int argc, const char **argv, const char *prefix)
> 	      |                                                  ~~~~^~~~
> 	git-compat-util.h:313:73: error: unused parameter ‘argv’ [-Werror=unused-parameter]
> 	  313 | static inline const char *precompose_argv_prefix(int argc, const char **argv, const char *prefix)
> 	      |                                                            ~~~~~~~~~~~~~^~~~
> 	git-compat-util.h: In function ‘git_has_dos_drive_prefix’:
> 	git-compat-util.h:423:56: error: unused parameter ‘path’ [-Werror=unused-parameter]
> 	  423 | static inline int git_has_dos_drive_prefix(const char *path)
> 	      |                                            ~~~~~~~~~~~~^~~~
> 	git-compat-util.h: In function ‘git_skip_dos_drive_prefix’:
> 	git-compat-util.h:431:52: error: unused parameter ‘path’ [-Werror=unused-parameter]
> 	  431 | static inline int git_skip_dos_drive_prefix(char **path)

Yeah, those are near the top of my list. I have a group classified as
"trivial": functions which are compat placeholders and have no body.
I'll be mostly offline for about a week, but I hope to send another
round of unused-mark patches when I get back. (Of course it is not
really useful until _all_ of the patches are there anyway).

-Peff
