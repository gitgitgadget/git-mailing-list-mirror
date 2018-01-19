Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34701FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 03:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755307AbeASDkH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 18 Jan 2018 22:40:07 -0500
Received: from elephants.elehost.com ([216.66.27.132]:41956 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754836AbeASDkG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 22:40:06 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0J3duTF043854
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Jan 2018 22:39:57 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.us>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?J9CQ0LvQtdC60YHQsNC90LTRgCDQkdGD0LvQsNC10LIn?= 
        <aleks.bulaev@gmail.com>, "'Git List'" <git@vger.kernel.org>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com> <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com> <20180119024738.GA222163@genre.crustytoothpaste.net> <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
In-Reply-To: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
Subject: RE: git 2.16.0 segfaults on clone of specific repo
Date:   Thu, 18 Jan 2018 22:39:52 -0500
Message-ID: <00c701d390d7$2dc80d10$89582730$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIqZQ4r/LzJm8pBdd3mqqccac8imwJx8g2cAQISO8gBt4QNVaKjh44w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 18, 2018 10:06 PM, Eric Sunshine wrote:
> On Thu, Jan 18, 2018 at 9:47 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On Thu, Jan 18, 2018 at 07:15:56PM -0500, Eric Sunshine wrote:
> >> On Thu, Jan 18, 2018 at 3:55 PM, Александр Булаев
> >> <aleks.bulaev@gmail.com> wrote:
> >> > I found that git 2.16.0 segfaults on clone of vim-colorschemes repo.
> >>
> >> I can confirm that this crashes on MacOS; it does not crash on Linux or
> BSD.
> >>
> >> git-bisect places blame on eb0ccfd7f5 (Switch empty tree and blob
> >> lookups to use hash abstraction, 2017-11-12).
> >
> > I unfortunately don't have a macOS system to test with, and I've
> > compiled with both gcc and clang on my Debian system and, as you
> > mentioned, it doesn't fail there.
> >
> > I have a guess about what the problem might be.  Can you try this
> > patch and see if it fixes things?
> 
> That does fix the crash. Thanks for the quick diagnosis.
> 
> Can the commit message go into more detail as to why this was crashing (or
> your speculation about why)? Perhaps give more detail about what 'clone' is
> doing that led to the crash.

I'm curious as to why this worked on my platform, given how it tends to get annoyed with NULL in the wrong place.

> 
> > -- >8 --
> > From 10b690241619a452634b31fbc5ccd054a4f6e5ec Mon Sep 17 00:00:00
> 2001
> > From: "brian m. carlson" <sandals@crustytoothpaste.net>
> > Date: Sun, 14 Jan 2018 18:26:29 +0000
> > Subject: [PATCH] repository: pre-initialize hash algo pointer
> >
> > There are various git subcommands (among them, clone) which don't set
> > up the repository but end up needing to have information about the
> > hash algorithm in use.  In the future, we can add a command line
> > option for this or read it from the configuration, but until we're
> > ready to expose that functionality to the user, simply initialize the
> > repository structure to use the current hash algorithm, SHA-1.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  repository.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/repository.c b/repository.c index 998413b8bb..f66fcb1342
> > 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -5,7 +5,7 @@
> >
> >  /* The main repository */
> >  static struct repository the_repo = {
> > -       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index,
> NULL, 0, 0
> > +       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> > + &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
> >  };
> >  struct repository *the_repository = &the_repo;
> >
> > --

