Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8AE20401
	for <e@80x24.org>; Tue, 27 Jun 2017 16:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbdF0Q2Q convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 27 Jun 2017 12:28:16 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:50489 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdF0Q2P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 12:28:15 -0400
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v5RGSCZB027937
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2017 16:28:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v5RGSCFp020584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2017 16:28:12 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v5RGSBUP016758;
        Tue, 27 Jun 2017 16:28:11 GMT
Received: from oracle.com (/24.246.5.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Jun 2017 09:28:11 -0700
Date:   Tue, 27 Jun 2017 12:28:09 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Michael Kebe <michael.kebe@gmail.com>
Cc:     ?var Arnfj?r? Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
Message-ID: <20170627162808.p7sj3jpwum7n3hq2@oracle.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <87fuem7aw2.fsf@gmail.com>
 <CAKKM46vr2Y_Zs+EJX-nxw7XH0nbpmTyubR1jibYoiieNCDns4Q@mail.gmail.com>
 <CAKKM46sBVyTMGNwU6E9s7gq8wiBfAxrKzBFVgU=zfwj+YdAjcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAKKM46sBVyTMGNwU6E9s7gq8wiBfAxrKzBFVgU=zfwj+YdAjcQ@mail.gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


How about:

---- 8< ----
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index facea1bb5..ed8c63f2d 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -38,9 +38,18 @@
 
 #if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
 
+#define EMPTY_VAL(x) x ## 1
+#define EMPTY(x) EMPTY_VAL(x)
+
+#if (defined(_BIG_ENDIAN) && (EMPTY(_BIG_ENDIAN) == 1))
+#undef _BIG_ENDIAN
+#define _BIG_ENDIAN 4321
+#endif
+
 #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
      (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
-     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )
+     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) || \
+     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == _BIG_ENDIAN)) )
 #define SHA1DC_BIGENDIAN
 #endif


* Michael Kebe <michael.kebe@gmail.com> [170627 02:28]:
> On the Solaris system here __BYTE_ORDER__ set to 4321 and _BIG_ENDIAN
> is defined, but has no value.
> 
> The problem is the not short circuiting macro...
> 
> -------------------------8<------------------------------
> #undef _FOO1
> #undef _FOO2
> #undef _FOO2
> 
> #undef _BAR1
> #undef _BAR2
> #undef _BAR3
> 
> #define _FOO3 42
> 
> //comment out this line or give it a value to make the preprocesser happy
> #define _BAR1
> 
> #if (defined(_FOO1) || defined(_FOO2) || defined(_FOO3))
> 
> // not short circuiting... preprocesser tries to evaluate (_FOO1 &&
> _BAR1) but _BAR1 has no value...
> #if ((defined(_FOO1) && (_FOO1 == _BAR1)) || \
>           (defined(_FOO2) && (_FOO2 == _BAR2)) || \
>           (defined(_FOO3) && (_FOO3 == BAR3)) )
> #define SHA1DC_BIGENDIAN
> #endif
> 
> #endif
> -------------------------8<------------------------------
> https://gist.github.com/michaelkebe/c963c7478b7b55ad197f0665986870d4
> 
> What do you think?
> 
> 2017-06-27 7:41 GMT+02:00 Michael Kebe <michael.kebe@gmail.com>:
> > 2017-06-26 22:27 GMT+02:00 Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
> >> Could you (or anyone else for that matter) please test it with:
> >>
> >>     git clone --branch bigend-detect-solaris-again https://github.com/avar/sha1collisiondetection.git &&
> >>     cd sha1collisiondetection &&
> >>     make test
> >
> > Still no luck.
> >
> > ~/sha1collisiondetection (bigend-detect-solaris-again *)$ CC=gcc gmake test
> > mkdir -p dep_lib && gcc -O2 -Wall -Werror -Wextra -pedantic -std=c90
> > -Ilib  -M -MF dep_lib/sha1.d lib/sha1.c
> > lib/sha1.c:63:58: error: operator '==' has no right operand
> >  #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
> >                                                           ^
> >
> > Running Solaris on sparc:
> > $ uname -a
> > SunOS er202 5.11 11.3 sun4v sparc sun4v
> >
> >
> > The isa_defs.h is available here:
> > https://gist.github.com/michaelkebe/472720cd684b5b2a504b8eeb24049870
> >
> >
> > Greetings
> > Michael
