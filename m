Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B6720401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbdF0S3v (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:29:51 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:42682 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdF0S3u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:29:50 -0400
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v5RITjWM000441
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 27 Jun 2017 18:29:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v5RITjGA006496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 27 Jun 2017 18:29:45 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v5RITi5T031275;
        Tue, 27 Jun 2017 18:29:44 GMT
Received: from oracle.com (/24.246.5.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Jun 2017 11:29:44 -0700
Date:   Tue, 27 Jun 2017 14:29:42 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Kebe <michael.kebe@gmail.com>,
        ?var Arnfj?r? Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
Message-ID: <20170627182942.gpug4xaek2vba7uh@oracle.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <87fuem7aw2.fsf@gmail.com>
 <CAKKM46vr2Y_Zs+EJX-nxw7XH0nbpmTyubR1jibYoiieNCDns4Q@mail.gmail.com>
 <CAKKM46sBVyTMGNwU6E9s7gq8wiBfAxrKzBFVgU=zfwj+YdAjcQ@mail.gmail.com>
 <20170627162808.p7sj3jpwum7n3hq2@oracle.com>
 <xmqq1sq52uwj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sq52uwj.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161126 (1.7.1)
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Junio C Hamano <gitster@pobox.com> [170627 13:38]:
> "Liam R. Howlett" <Liam.Howlett@Oracle.com> writes:
> 
> > How about:
> >
> > ---- 8< ----
> > diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> > index facea1bb5..ed8c63f2d 100644
> > --- a/sha1dc/sha1.c
> > +++ b/sha1dc/sha1.c
> > @@ -38,9 +38,18 @@
> >  
> >  #if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
> >  
> > +#define EMPTY_VAL(x) x ## 1
> > +#define EMPTY(x) EMPTY_VAL(x)
> > +
> > +#if (defined(_BIG_ENDIAN) && (EMPTY(_BIG_ENDIAN) == 1))
> > +#undef _BIG_ENDIAN
> > +#define _BIG_ENDIAN 4321
> > +#endif
> 
> I'd say it is a bad idea to define a symbol that you _know_ a
> platform header file defines.  Any header you may include from the
> platform after these lines still expects the symbol to be defined in
> a way it defines without getting molested and will misbehave.

Okay.  Thanks.  I thought a c file would be safe, especially after the
includes but there is indeed a possible include (ifdef'ed) later.

This compressed logic is causing a lot of issues.  Could we just rewrite
it as a whole lot of #if/#else, statements to avoid running across the
issue where the precompiler does not short-circuit the checks?  Would
this cause any other issues?

Alternatively, we can replace the undef/define with the define of
SHA1DC_BIGENDIAN and make this an #if/#else..

A third option is to compile a small test and just -DSHA1DC_BIGENDIAN in
the Makefile.

Cheers,
Liam

