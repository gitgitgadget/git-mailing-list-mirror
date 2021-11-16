Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF9BC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F29F61BF5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhKPVJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 16:09:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:60506 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229899AbhKPVJK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 16:09:10 -0500
Received: (qmail 21264 invoked by uid 109); 16 Nov 2021 21:06:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Nov 2021 21:06:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2698 invoked by uid 111); 16 Nov 2021 21:06:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 16:06:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 16:06:12 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Generate temporary files using a CSPRNG
Message-ID: <YZQdRC9nAA/CbMyM@coredump.intra.peff.net>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <211116.864k8bq0xm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211116.864k8bq0xm.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 09:35:59PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I tried testing this codepath real quick now with:
>     
>     diff --git a/wrapper.c b/wrapper.c
>     index 36e12119d76..2f3755886fb 100644
>     --- a/wrapper.c
>     +++ b/wrapper.c
>     @@ -497,6 +497,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>                             v /= num_letters;
>                     }
>      
>     +               BUG("%s", pattern);
>                     fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
>                     if (fd >= 0)
>                             return fd;
>     
> And then doing:
> 
>     grep BUG test-results/*.out
> 
> And the resulting output is all of the form:
> 
>     .git/objects/9f/tmp_obj_FOzEcZ
>     .git/objects/pack/tmp_pack_fJC0RI
> 
> And a couple of:
> 
>     .git/info/refs_Lctaew
> 
> I.e. these are all cases where we're creating in-repo tempfiles, we're
> not racing someone in /tmp/ for these, except perhaps in some cases I've
> missed (but you allude to) where we presumably should just move those
> into .git/tmp/, at least by default.

Your patch is way too aggressive. By bailing via BUG(), most commands
will fail, so we never get to the interesting ones (e.g., we would not
ever get to the point of writing out a tag signature for gpg to verify,
because we'd barf when trying to create the tag in the first place).

Try:

diff --git a/wrapper.c b/wrapper.c
index 36e12119d7..5218a4b3bd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -497,6 +497,10 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 			v /= num_letters;
 		}
 
+		{
+			static struct trace_key t = TRACE_KEY_INIT(TEMPFILE);
+			trace_printf_key(&t, "%s", pattern);
+		}
 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
 		if (fd >= 0)
 			return fd;

And then:

  GIT_TRACE_TEMPFILE=/tmp/foo make test
  grep ^/tmp /tmp/foo | wc -l

turns up hundreds of hits.

> If there are cases where we actually need this hardening because we're
> writing in a shared /tmp/ and not .git/, then surely we're better having
> those API users call a differently named function, or to move those
> users to using a .git/tmp/ unless they configure things otherwise?

Assuming you can write to .git/tmp means that conceptually read-only
operations (like verifying tags) require write access to the repository.

-Peff
