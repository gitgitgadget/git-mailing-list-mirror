Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E78207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947139AbdDTWEj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 20 Apr 2017 18:04:39 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:38109 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938900AbdDTWEi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:04:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 09DBC100145;
        Thu, 20 Apr 2017 22:04:37 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m1WMDau6ygLM; Thu, 20 Apr 2017 22:04:36 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id EC25E8003B;
        Thu, 20 Apr 2017 22:04:36 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Thu, 20 Apr 2017 22:04:36 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Thu, 20 Apr 2017 22:04:36 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] Increase core.packedGitLimit
Thread-Topic: [PATCH] Increase core.packedGitLimit
Thread-Index: AQHSuhl8+XCjOd4c/UqYMBI6F7q6BqHOzjcAgAAAKtA=
Date:   Thu, 20 Apr 2017 22:04:36 +0000
Message-ID: <4c111acb3f134aa9aef8648d75bd741f@exmbdft7.ad.twosigma.com>
References: <20170420204118.17856-1-dturner@twosigma.com>
 <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
 <alpine.DEB.2.20.1704202355230.3480@virtualbox>
In-Reply-To: <alpine.DEB.2.20.1704202355230.3480@virtualbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.13]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> -----Original Message-----
> From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de]
> Sent: Thursday, April 20, 2017 5:58 PM
> To: Jeff King <peff@peff.net>
> Cc: David Turner <David.Turner@twosigma.com>; git@vger.kernel.org
> Subject: Re: [PATCH] Increase core.packedGitLimit
> 
> Hi Peff,
> 
> On Thu, 20 Apr 2017, Jeff King wrote:
> 
> > On Thu, Apr 20, 2017 at 04:41:18PM -0400, David Turner wrote:
> >
> > > When core.packedGitLimit is exceeded, git will close packs.  If
> > > there is a repack operation going on in parallel with a fetch, the
> > > fetch might open a pack, and then be forced to close it due to
> > > packedGitLimit being hit.  The repack could then delete the pack out
> > > from under the fetch, causing the fetch to fail.
> > >
> > > Increase core.packedGitLimit's default value to prevent this.
> > >
> > > On current 64-bit x86_64 machines, 48 bits of address space are
> > > available.  It appears that 64-bit ARM machines have no standard
> > > amount of address space (that is, it varies by manufacturer), and
> > > IA64 and POWER machines have the full 64 bits.  So 48 bits is the
> > > only limit that we can reasonably care about.  We reserve a few bits
> > > of the 48-bit address space for the kernel's use (this is not
> > > strictly necessary, but it's better to be safe), and use up to the
> > > remaining 45.  No git repository will be anywhere near this large
> > > any time soon, so this should prevent the failure.
> >
> > Yep, I think this is a reasonable direction.
> >
> > > ---
> > >  git-compat-util.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > This probably needs an update to the core.packedGitLimit section of
> > Documentation/config.txt.
> >
> > > diff --git a/git-compat-util.h b/git-compat-util.h index
> > > 8a4a3f85e7..1c5de153a5 100644
> > > --- a/git-compat-util.h
> > > +++ b/git-compat-util.h
> > > @@ -616,7 +616,7 @@ extern int git_lstat(const char *, struct stat
> > > *);  #endif
> > >
> > >  #define DEFAULT_PACKED_GIT_LIMIT \
> > > -	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? 8192 : 256))
> > > +	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? (32 * 1024L *
> > > +1024L) : 256))
> >
> > I wondered if we would run afoul of integer sizes on 64-bit systems
> > where "long" is still only 32-bits (i.e., Windows). But I think it's
> > OK, because the values before we cast to size_t are in megabytes. So
> > your
> > 32*1024*1024 needs only 25 bits to store it. And then after we cast to
> > size_t, everything is in 64-bit.
> 
> Indeed, when I patch a local Git checkout accordingly, I see that
> packed_git_limit is set to 35184372088832.
> 
> The bigger problem in this regard is that users are allowed to override this via
> core.packedgitlimit but that value is parsed as an unsigned long.

We might want to think about replacing git_config_ulong with 
git_config_size_t in nearly all cases. "long" has ceased to be 
useful.  More modern versions of C prefer uint64_t, but I
think that we'll usually want size_t because these values will
be used as memory limits of various sorts.

