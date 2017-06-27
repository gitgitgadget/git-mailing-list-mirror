Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB8E20401
	for <e@80x24.org>; Tue, 27 Jun 2017 19:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbdF0Tiv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 27 Jun 2017 15:38:51 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:26934 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdF0Tit (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 15:38:49 -0400
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v5RJceuq010934
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 27 Jun 2017 19:38:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v5RJcePu025246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 27 Jun 2017 19:38:40 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v5RJcbgg031103;
        Tue, 27 Jun 2017 19:38:38 GMT
Received: from oracle.com (/24.246.5.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Jun 2017 12:38:37 -0700
Date:   Tue, 27 Jun 2017 15:38:36 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ?var Arnfj?r? Bjarmason <avarab@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
Message-ID: <20170627193835.goix6woeil3hfkhe@oracle.com>
References: <20170627121718.12078-1-avarab@gmail.com>
 <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <20170627121718.12078-2-avarab@gmail.com>
 <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
 <xmqqefu52znl.fsf@gitster.mtv.corp.google.com>
 <87wp7xjo5x.fsf@gmail.com>
 <xmqq7ezx1c31.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <xmqq7ezx1c31.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161126 (1.7.1)
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Junio C Hamano <gitster@pobox.com> [170627 15:10]:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > Because in the current code is, abbreviated:
> >
> >     #if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
> >     #if /* byte order is bendian */
> >     #define SHA1DC_BIGENDIAN
> >     #endif
> >     #else
> >     #if /*some processor tests/* || defined(__sparc))
> >     #define SHA1DC_BIGENDIAN
> >     #endif
> >
> > And since Solaris defines _BYTE_ORDER we never get to checking __sparc,
> > and in fact the "/* byte order is bendian */" test errors out.
> >
> > This is fixed by my patch, where we first check gcc settings, then
> > glibc, then processors, and finally _BYTE_ORDER (but as discussed that
> > last bit could be adjusted to sun && _BYTE_ORDER, if we can find what
> > "sun" is.
> 
> Well, if Solaris defines _BYTE_ORDER, doesn't that mean they define
> two constants _BIG_ENDIAN and _LITTLE_ENDIAN to compare it with?  If
> that is the case, I suspect that the change to make "comparison
> between __BYTE_ORDER and __BIG_ENDIAN for GCC only" is going in a
> wrong direction, as it wants to take the same approach as GCC, but
> just uses a slightly different symbol.

That's not the case.  _BIG_ENDIAN is defined but not to a value.  I
believe _BYTE_ORDER is defined as 4321, but _BIG_ENDIAN is just defined.
This is why I proposed detecting the empty state of _BIG_ENDIAN.  If
_BIG_ENDIAN is defined but not to a value, then we already know it's big
endian.  I believe your approach below can be altered slightly to
account for this issue.

> 
> I wonder if the approach like the following might be cleaner to
> extend as we find other oddball platforms.
> 
>     #undef __SHA1DC_BYTE_ORDER
>     #if defined(_BYTE_ORDER)
>     #define __SHA1DC_BYTE_ORDER _BYTE_ORDER
>     #elif defined(__BYTE_ORDER)
>     #define __SHA1DC_BYTE_ORDER __BYTE_ORDER
>     #elif defined(__BYTE_ORDER__))
>     #define __SHA1DC_BYTE_ORDER __BYTE_ORDER__
>     #endif
> 
>     #ifdef __SHA1DC_BYTE_ORDER
>      #undef __SHA1DC_BIG_ENDIAN
>      /* do the same for variations of BIG_ENDIAN constant */
>      #if defined(_BIG_ENDIAN)
> 	...
>      #endif
> 
>      #if __SHA1DC_BYTE_ORDER == __SHA1DC_BIG_ENDIAN
>      #define SHA1DC_BIGENDIAN
>      #endif
>     #else
>      /* 
>       * as the platform does not use "compare BYTE-ORDER with
>       * BIG_ENDIAN macro" strategy, defined-ness of BIG_ENDIAN
>       * may be usable as a sign that it is a big-endian box.
>       */
>     #endif
> 
