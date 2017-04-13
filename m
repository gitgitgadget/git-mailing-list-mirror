Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2122820960
	for <e@80x24.org>; Thu, 13 Apr 2017 22:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbdDMW3x convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 13 Apr 2017 18:29:53 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:42960 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdDMW3v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 18:29:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 8C21A100080;
        Thu, 13 Apr 2017 22:29:50 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pGRcbJAuBzfF; Thu, 13 Apr 2017 22:29:50 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 799BE8002E;
        Thu, 13 Apr 2017 22:29:50 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Thu, 13 Apr 2017 22:29:50 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Thu, 13 Apr 2017 22:29:50 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jonathan Nieder' <jrnieder@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] xgethostname: handle long hostnames
Thread-Topic: [PATCH] xgethostname: handle long hostnames
Thread-Index: AQHStKIM9oaSVVsbVkGBPndl8UE44qHD3INw
Date:   Thu, 13 Apr 2017 22:29:50 +0000
Message-ID: <b53099edc57947329f826f05de5303af@exmbdft7.ad.twosigma.com>
References: <20170413192335.20679-1-dturner@twosigma.com>
 <20170413220524.GE10084@aiede.mtv.corp.google.com>
In-Reply-To: <20170413220524.GE10084@aiede.mtv.corp.google.com>
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
> From: Jonathan Nieder [mailto:jrnieder@gmail.com]
> Sent: Thursday, April 13, 2017 6:05 PM
> To: David Turner <David.Turner@twosigma.com>
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] xgethostname: handle long hostnames
> 
> Hi,
> 
> David Turner wrote:
> 
> > If the full hostname doesn't fit in the buffer supplied to
> > gethostname, POSIX does not specify whether the buffer will be
> > null-terminated, so to be safe, we should do it ourselves.
> [...]
> > +++ b/wrapper.c
> > @@ -655,3 +655,16 @@ void sleep_millisec(int millisec)  {
> >  	poll(NULL, 0, millisec);
> >  }
> > +
> > +int xgethostname(char *buf, size_t len) {
> > +	/*
> > +	 * If the full hostname doesn't fit in buf, POSIX does not
> > +	 * specify whether the buffer will be null-terminated, so to
> > +	 * be safe, do it ourselves.
> > +	 */
> > +	int ret = gethostname(buf, len);
> > +	if (!ret)
> > +		buf[len - 1] = 0;
> > +	return ret;
> 
> I wonder if after null-terminating we would want to report this as an error,
> instead of silently using a truncated result.  I.e. something like
> 
> > +	if (!ret)
> > +		buf[len - 1] = 0;
> > +	if (strlen(buf) >= len - 1) {
> > +		errno = ENAMETOOLONG;
> > +		return -1;
> > +	}
>
> (or EINVAL --- either is equally descriptive).

Looking at the users of this function, I think most would be happier with a truncated buffer than an error:
gc.c: used to see if we are the same machine as the machine that locked the repo. Unlikely that two machines have hostnames that differ only in the 256th-or-above character.
fetch-pack.c, receive-pack.c: similar to gc.c; the hostname is a note in the .keep file
Ident.c: used to make up a fake email address. On my laptop, gethostname returns "corey" (no domain part), so the email address is not likely to be valid anyway.

> Also POSIX requires that hostnames are <= 255 bytes.  Maybe we can force the
> buffer to be large enough.

That is now how I read it.  I read the limit as HOST_NAME_MAX, which has a *minimum* value of 255, but which might be larger.

The existing hostname buffers are 128, 256, and 1024 bytes, so they're pretty arbitrary.  

