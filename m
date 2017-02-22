Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D03201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 21:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755055AbdBVVF7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 22 Feb 2017 16:05:59 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:33801 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754567AbdBVVFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 16:05:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 3FB56100143;
        Wed, 22 Feb 2017 21:04:15 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ysZ87ZrL8YFz; Wed, 22 Feb 2017 21:04:15 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 2E80880035;
        Wed, 22 Feb 2017 21:04:15 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Wed, 22 Feb 2017 21:04:14 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%23]) with mapi id
 15.00.1263.000; Wed, 22 Feb 2017 21:04:14 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Junio C Hamano' <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: RE: [PATCH] http(s): automatically try NTLM authentication first
Thread-Topic: [PATCH] http(s): automatically try NTLM authentication first
Thread-Index: AQHSjUkLCk8cFwxeyUi81jfhwIejKqF1d7vg
Date:   Wed, 22 Feb 2017 21:04:14 +0000
Message-ID: <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano [mailto:jch2355@gmail.com] On Behalf Of Junio C
> Hamano
> Sent: Wednesday, February 22, 2017 3:20 PM
> To: David Turner <David.Turner@twosigma.com>
> Cc: git@vger.kernel.org; sandals@crustytoothpaste.net; Johannes Schindelin
> <johannes.schindelin@gmx.de>; Eric Sunshine
> <sunshine@sunshineco.com>; Jeff King <peff@peff.net>
> Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
> 
> David Turner <dturner@twosigma.com> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It is common in corporate setups to have permissions managed via a
> > domain account. That means that the user does not really have to log
> > in when accessing a central repository via https://, but that the
> > login credentials are used to authenticate with that repository.
> >
> > The common way to do that used to require empty credentials, i.e.
> > hitting Enter twice when being asked for user name and password, or by
> > using the very funny notation https://:@server/repository
> >
> > A recent commit (5275c3081c (http: http.emptyauth should allow empty
> > (not just NULL) usernames, 2016-10-04)) broke that usage, though, all
> > of a sudden requiring users to set http.emptyAuth = true.
> >
> > Which brings us to the bigger question why http.emptyAuth defaults to
> > false, to begin with.
> 
> This is a valid question, and and I do not see it explicitly asked in the thread:
> 
> https://public-
> inbox.org/git/CAPig+cSphEu3iRJrkdBA+BRhi9HnopLJnKOHVuGhUqavtV1RXg
> @mail.gmail.com/#t
> 
> even though there is a hint of it already there.
> 
> > It would be one thing if cURL would not let the user specify
> > credentials interactively after attempting NTLM authentication (i.e.
> > login credentials), but that is not the case.
> >
> > It would be another thing if attempting NTLM authentication was not
> > usually what users need to do when trying to authenticate via https://.
> > But that is also not the case.
> 
> Some other possible worries we may have had I can think of are:
> 
>  - With this enabled unconditionally, would we leak some information?

I think "NTLM" is actually a misnomer here (I just copied Johannes's 
commit message). The mechanism is actually SPNEGO, if I understand this 
correctly. It seems to me that this is probably secure, since it is apparently
widely implemented in browsers.

>  - With this enabled unconditionally, would we always incur an extra
>    roundtrip for people who are not running NTLM at all?
>
> I do not think the former is the case, but what would I know (adding a few
> people involved in the original thread to CC: ;-)

Always, no.  For failed authentication (or authorization), apparently, yes.  
I tested this by  setting the variable to false and then true, and trying to 
Push to a github repository which I didn't have write access to, with 
both an empty username (https://@:github.com/...) and no username 
(http://github.com/...).   I ran this under GIT_CURL_VERBOSE=1 and
I saw two 401 responses in the "http.emptyauth=true" case and one
in the false case.  I also tried with a repo that I did have access to (first
configuring the necessary tokens for HTTPS push access), and saw two
401 responses in *both* cases.  

