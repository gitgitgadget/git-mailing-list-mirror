Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3783AC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 11:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9873D212CC
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 11:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sebres.de header.i=@sebres.de header.b="esYRX3eP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgJOLyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 07:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbgJOLvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 07:51:09 -0400
Received: from sebres.de (sebres.de [IPv6:2a03:4000:3f:185::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF53C0613D2
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sebres.de;
         s=dkim; h=Message-ID:References:In-Reply-To:Cc:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OkHXzKNUIv1/wKchqmL6PrPWCy/Yhl2jC0cbJGSW2nc=; b=esYRX3eP0h2Y+Ki0IPcgMzkyfv
        VrZya4NKlaMR5yG/8v/twHXz2uJocdDtYi5WS363Z4ETCQ45fRwNXbIfv3ZyvoBYWQuQb9LGlRoXD
        1GvWos+qgLPqfAEyOfdcNGV+93MME8WNr1AaxgTvy9X5nEpjSuIoBa5pzrQdoAwfet3fEOEzftiCI
        D7b6/EI7imXjZihx4C0tVC7Rhn+zsSdJCuOo9KprhHxLk4V1xN+DEJOhdN6YIyEg1LUgAvz9Cualp
        ppjYtOi3YzTUVpYbIbQ7OxirF8+Zqsx1tCD4RrUjBX8C4sHgUIge5JhliigIXpQIe5YYaGw4hFnZt
        mT/ipDUg==;
To:     Jeff King <peff@peff.net>
Subject: Re: git fast-import leaks memory drastically, so crashes with out  of memory by attempt to import 22MB export dump
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Oct 2020 13:50:30 +0200
From:   "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>
Cc:     git@vger.kernel.org
In-Reply-To: <20201015012636.GA387901@coredump.intra.peff.net>
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
 <20201015012636.GA387901@coredump.intra.peff.net>
Message-ID: <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
X-Sender: serg.brester@sebres.de
User-Agent: Webmail/1.0.3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

well, I don't know how you were trying to reproduce it.

My first attempt with a git-repository (cloned from 
https://github.com/git/git.git) showed that immediately to me.
Here you go (I used git bash here):

```
# clone or copy git repository (we'll use it for export and import):
git clone https://github.com/git/git.git
cd git

# make 1st fast-export in order to generate marks (don't need the dump, 
only marks are needed):
git fast-export --reencode=yes --export-marks=.tmp.exp-1.tmp 
e83c5163316f89bfbde7d9ab23ca2e25604af290..dc04167d378fb29d30e1647ff6ff51dd182bc9a3 
 > /dev/null

# make 2nd fast-export in order to generate partial export dump (file 
".tmp.dump" will be ca. 87MB):
git fast-export --reencode=yes --import-marks=.tmp.exp-1.tmp 
--export-marks=.tmp.exp-2.tmp 
61addb841f2a6d74a1737a01e03df1f773e04944..master > .tmp.dump

# now try to import this dump, using first marks as import marks (we 
have all revs in git-repo):
git fast-import --import-marks=.tmp.exp-1.tmp 
--export-marks=.tmp.imp.tmp < .tmp.dump

```

And see how git-fast-import eating your whole memory and enjoy the crash 
:)

```
fatal: Out of memory, malloc failed (tried to allocate 2097152 bytes)
fast-import: dumping crash report to .git/fast_import_crash_6684
```

Regards,
Sergey

15.10.2020 03:26, Jeff King wrote:

> On Wed, Oct 14, 2020 at 11:22:03AM +0200, Dipl. Ing. Sergey Brester 
> wrote:
> 
>> I did not see any issues with (even much larger) imports, before I 
>> upgraded git to 2.28.0 (from 2.25.1, I guess).
> 
> I wasn't able to reproduce, but it sounds like there's something 
> special
> about this repo (since the dump is not that big, and you said much
> larger dumps have succeeded).
> 
> Is it possible to make either the fossil repo, or the fast-import input
> file available?
> 
> If not, since you said it works with 2.14.4, is it possible to bisect 
> in
> Git to see when it stopped working? You'll need to be able to build Git
> from source.
> 
> -Peff
