Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1569B2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 14:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbdFBOql convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 2 Jun 2017 10:46:41 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:39376 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdFBOqj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 10:46:39 -0400
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v52EkQGa012764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Jun 2017 14:46:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v52EkQ51002874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Jun 2017 14:46:26 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v52EkPGC018836;
        Fri, 2 Jun 2017 14:46:25 GMT
Received: from oracle.com (/24.246.5.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Jun 2017 07:46:25 -0700
Date:   Fri, 2 Jun 2017 10:46:23 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     ?var Arnfj?r? Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin ?gren <martin.agren@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: Unaligned accesses in sha1dc
Message-ID: <20170602144622.xottin6efikpkdel@oracle.com>
References: <mvm4lw0un5n.fsf@suse.de>
 <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com>
 <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
 <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
 <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
 <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
 <xmqq37bj454a.fsf@gitster.mtv.corp.google.com>
 <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* ?var Arnfj?r? Bjarmason <avarab@gmail.com> [170602 04:53]:
> On Fri, Jun 2, 2017 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Martin Ågren <martin.agren@gmail.com> writes:
> >
> >> I looked into this some more. It turns out it is possible to trigger
> >> undefined behavior on "next". Here's what I did:
> >> ...
> >>
> >> This "fixes" the problem:
> >> ...
> >> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> >> index 3dff80a..d6f4c44 100644
> >> --- a/sha1dc/sha1.c
> >> +++ b/sha1dc/sha1.c
> >> @@ -66,9 +66,9 @@
> >> ...
> >> With this diff, various tests which seem relevant for SHA-1 pass,
> >> including t0013, and the UBSan-error is gone. The second diff is just
> >> a monkey-patch. I have no reason to believe I will be able to come up
> >> with a proper and complete patch for sha1dc. And I guess such a thing
> >> would not really be Git's patch to carry, either. But at least Git
> >> could consider whether to keep relying on undefined behavior or not.
> >>
> >> There's a fair chance I've mangled the whitespace. I'm using gmail's
> >> web interface... Sorry about that.
> >
> > Thanks.  I see Marc Stevens is CC'ed in the thread, so I'd expect
> > that the final "fix" would come from his sha1collisiondetection
> > repository via Ævar.
> >
> > In the meantime, I am wondering if it makes sense to merge the
> > earlier update with #ifdef ALLOW_UNALIGNED_ACCESS and #ifdef
> > SHA1DC_FORCE_LITTLEENDIAN for the v2.13.x maintenance track, which
> > would at least unblock those on platforms v2.13.0 did not work
> > correctly at all.
> >
> > Ævar, thoughts?
> 
> I think we're mixing up several things here, which need to be untangled:
> 
> 1) The sha1dc works just fine on most platforms even with undefined
> behavior, as evidenced by 2.13.0 working.
> 
> 2) There was a bug in practice with unaligned access on SPARC. It's
> not clear to me whether anyone (Andreas, Liam?) still has any issues
> in practice on any platform without specifying compile flags like what
> Martin Ågren suggested above.
> 
> Andreas: Is your initial report of unaligned access here fixed in the
> next branch with my "sha1dc: update from upstream" commit? You didn't
> say what platform you were on.
> 
> Liam: How about your issue on SPARC?

2.13.0 is very much broken for me on SPARC.
{maint//git} $ make -j120
[...]
{maint//git} $ ./git log
[1]    1004506 bus error (core dumped)  ./git log

This is with b06d36431 (maint).

The same thing happens on v2.13.0-384-g826c06412 (master).

v2.13.0-539-g4b9c06c7d (next) works for me, as did following the
instructions on upgrading the sha1dc code myself.

> 
> 3) Now we have another issue reported by Martin Ågren here, which is
> that while the code works in practice on most platforms it's using
> undefined behavior. On my GCC 7.1.1 it's sufficient to:

My platforms gcc is older than 7.1.1.

> 
>     make -j8 CFLAGS="-fsanitize=undefined
> -fsanitize-recover=undefined" LDFLAGS="-fsanitize=undefined
> -fsanitize-recover=undefined" all
> 
> And then run e.g.:
> 
>     ./t0020-crlf.sh -v

These tests pass With my older gcc - which those flags are not
recognized.

# passed all 35 test(s)


> 
> To get spiel like:
> 
>     sha1dc/sha1.c:346:2: runtime error: load of misaligned address
> 0x5610bf16d005 for type 'const uint32_t', which requires 4 byte
> alignment
>     0x5610bf16d005: note: pointer points here
>      65 6e 74 20 66 30 34  66 61 39 37 36 36 64 62  62 38 65 34 63 37
> 33 38  34 37 30 61 31 36 63 61  62
> 
> I think that this is definitely something worth looking into /
> coordinating with upstream, but I haven't seen anything to suggest
> that we need to be rushing to get a patch in to fix this given 1) and
> nobody saying yet that 2) doesn't solve their issue as long as they're
> not supplying some -fsanitize=* flags.
> 
> Now, stepping a bit back from this whole thing: I didn't read the
> entire discussion back in February when sha1dc was integrated, but I
> really don't see given all this churn / bug reporting we're getting
> now why another acceptable solution wouldn't be to just revert
> e6b07da278 ("Makefile: make DC_SHA1 the default", 2017-03-17) &
> release 2.13.1 with that.
> 
> Clearly there are outstanding issues with it, and needing to do a
> memcpy() as my `next` patch does will harm performance on some
> platforms, and something like Martin's patch on top will slow it down
> even more.
> 
> It seems to me that we should give it more time to cook, and better
> understand the various trade-offs involved. The shattered attack is
> very unlikely to impact anything in practice, and users who are
> paranoid about it can opt-in to this extra protection.

I have not seen issues with DC_SAH1 with the newer code base on SPARC.

Thanks,
Liam
