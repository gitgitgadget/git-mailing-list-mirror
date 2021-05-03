Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0D2C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1514610A0
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhECPDH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 3 May 2021 11:03:07 -0400
Received: from mail.ammonit.com ([213.172.126.10]:51010 "EHLO mail.ammonit.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhECPDG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 11:03:06 -0400
Received: from Ex16.Ammonoidea.Ammonit.de (192.168.12.213) by
 Ex16.Ammonoidea.Ammonit.de (192.168.12.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id
 15.1.2176.2; Mon, 3 May 2021 17:02:10 +0200
Received: from Ex16.Ammonoidea.Ammonit.de ([fe80::c134:fd63:d13b:8207]) by
 Ex16.Ammonoidea.Ammonit.de ([fe80::c134:fd63:d13b:8207%12]) with mapi id
 15.01.2176.012; Mon, 3 May 2021 17:02:10 +0200
From:   Daniel Carpenter <dc@ammonit.com>
To:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: http.sslVersion only specifies minimum TLS version, later
 versions are allowed
Thread-Topic: http.sslVersion only specifies minimum TLS version, later
 versions are allowed
Thread-Index: AQHXQBNc19Bi3sI+yUWZmtIg+syeH6rRpkiAgAAELQCAACueQg==
Date:   Mon, 3 May 2021 15:02:10 +0000
Message-ID: <ed63aa37ef0547bd97a5d965fb5e123f@ammonit.com>
References: <8f664b07d1df45bcb6b3f787f42bd046@ammonit.com>
 <87pmy7x6le.fsf@evledraar.gmail.com>,<YJAEVMeY9v/j6PeS@coredump.intra.peff.net>
In-Reply-To: <YJAEVMeY9v/j6PeS@coredump.intra.peff.net>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.12.4]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, May 03, 2021 at 03:55:31PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > On Mon, May 03 2021, Daniel Carpenter wrote:
> >
> > > When I run: "GIT_SSL_VERSION=tlsv1.2 GIT_CURL_VERBOSE=T git clone https://github.com/git/git.git"
> > >
> > > I see: "SSL connection using TLS1.3 / ECDHE_RSA_AES_128_GCM_SHA256", but I was expecting to see "TLS1.2".
> >
> > I think you're right per the documentation, but I wonder if the current
> > behavior isn't more useful for most users. I.e. are there really users
> > who want exactly 1.2 and not 1.3, 1.4 etc. in the future that aren't
> > dealing with an issue like what you're encountering?
> >
> > I.e. the "better security in the future by default" seems like a
> > better/more common case than "pin to this forever" in this case, no?
> >
> > We should of course have a way to pin it, but given the current behavior
> > I wonder if we shouldn't just change the documentation, and introduce
> > support for e.g. "=tlsv1.1" etc, or a http.pinSSLVersion=tls1.1 or
> > something...
> 
> Just looking at how the curl binary does it, "--tlsv1.2" means "1.2 or
> greater" (which is not at all surprising; the library interface tends to
> mirror their command-line and vice versa, and our behavior is influenced
> by the library interface here).  But that implies to me that curl folks
> considered this and though the "or greater" behavior was useful (which
> makes sense -- the main goal is probably to avoid insecurities in older
> versions of the protocol).
> 
> Anyway, the binary also has --tls-max for capping the maximum version.
> That seems more flexible in general than "use this version exactly" (if
> you only care that 1.3 is broken, then setting "max=1.2" lets you talk
> to servers that support 1.1 or 1.2).
> 
> -Peff

I agree that the current behaviour is better for most users, and that some kind of separate "max" config option would work for anyone in my situation.

Another idea would be to keep the current behaviour for `http.sslVersion`, but use an exact match with the environment variable only. That already takes priority, and I imagine its main appeal over the config option is for users that want to try something with a specific TLS version.
