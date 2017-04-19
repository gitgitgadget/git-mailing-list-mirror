Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DB81FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 15:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937740AbdDSPui convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 19 Apr 2017 11:50:38 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:38670 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937736AbdDSPug (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 11:50:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 976B7100082;
        Wed, 19 Apr 2017 15:50:35 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d6IuWmVKtaeh; Wed, 19 Apr 2017 15:50:35 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 857548002E;
        Wed, 19 Apr 2017 15:50:35 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Wed, 19 Apr 2017 15:50:35 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Wed, 19 Apr 2017 15:50:35 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Junio C Hamano' <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "l.s.r@web.de" <l.s.r@web.de>
Subject: RE: [PATCH v3 2/2] xgethostname: handle long hostnames
Thread-Topic: [PATCH v3 2/2] xgethostname: handle long hostnames
Thread-Index: AQHSuLfL9Q6yqt0HKEmBknmyVJ/JJqHM04Ww
Date:   Wed, 19 Apr 2017 15:50:34 +0000
Message-ID: <0701e70b52fe4bdd8e04e4c6918aab7a@exmbdft7.ad.twosigma.com>
References: <20170418215743.18406-1-dturner@twosigma.com>
        <20170418215743.18406-3-dturner@twosigma.com>
        <20170419013552.GB28740@aiede.svl.corp.google.com>
 <xmqq4lxlcdpf.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq4lxlcdpf.fsf@gitster.mtv.corp.google.com>
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
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, April 18, 2017 10:51 PM
> To: Jonathan Nieder <jrnieder@gmail.com>
> Cc: David Turner <David.Turner@twosigma.com>; git@vger.kernel.org;
> l.s.r@web.de
> Subject: Re: [PATCH v3 2/2] xgethostname: handle long hostnames
> 
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Hi,
> >
> > David Turner wrote:
> >
> >> If the full hostname doesn't fit in the buffer supplied to
> >> gethostname, POSIX does not specify whether the buffer will be
> >> null-terminated, so to be safe, we should do it ourselves.  Introduce
> >> new function, xgethostname, which ensures that there is always a \0
> >> at the end of the buffer.
> >
> > I think we should detect the error instead of truncating the hostname.
> > That (on top of your patch) would look like the following.
> >
> > Thoughts?
> > Jonathan
> >
> > diff --git i/wrapper.c w/wrapper.c
> > index d837417709..e218bd3bef 100644
> > --- i/wrapper.c
> > +++ w/wrapper.c
> > @@ -660,11 +660,13 @@ int xgethostname(char *buf, size_t len)  {
> >  	/*
> >  	 * If the full hostname doesn't fit in buf, POSIX does not
> > -	 * specify whether the buffer will be null-terminated, so to
> > -	 * be safe, do it ourselves.
> > +	 * guarantee that an error will be returned. Check for ourselves
> > +	 * to be safe.
> >  	 */
> >  	int ret = gethostname(buf, len);
> > -	if (!ret)
> > -		buf[len - 1] = 0;
> > +	if (!ret && !memchr(buf, 0, len)) {
> > +		errno = ENAMETOOLONG;
> > +		return -1;
> > +	}
> 
> Hmmmm.  "Does not specify if the buffer will be NUL-terminated"
> would mean that it is OK for the platform gethostname() to stuff
> sizeof(buf)-1 first bytes of the hostname in the buffer and then truncate by
> placing '\0' at the end of the buf, and we would not notice truncation with the
> above change on such a platform, no?

My read of the docs is that not only is that OK, but it is also permitted
for the platform to put sizeof(buf) bytes into the buffer and *not* 
put \0 at the end.

So in order to do a dynamic approach, we would have to allocate some
buffer, then run gethostname, then check if the penultimate element 
of the buffer was written to, and if so, allocate a larger buffer.  Yucky,
but possible.

