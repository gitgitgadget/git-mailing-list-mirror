Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B841F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936495AbcJQRQG (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:16:06 -0400
Received: from avasout03.plus.net ([84.93.230.244]:56522 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932489AbcJQRQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:16:04 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id whFz1t0040zhorE01hG0AN; Mon, 17 Oct 2016 18:16:01 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=KOo2uO0PRhKYDOKsTeoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] convert: mark a file-local symbol static
To:     Jeff King <peff@peff.net>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
 <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
 <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
 <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
 <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com>
 <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c2d5d79d-bb00-6833-28ae-bb707ffd2fa1@ramsayjones.plus.com>
Date:   Mon, 17 Oct 2016 18:15:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/10/16 03:18, Jeff King wrote:
> On Mon, Oct 17, 2016 at 02:37:58AM +0100, Ramsay Jones wrote:
> 
>> Hmm, well, you have to remember that 'make clean' sometimes
>> doesn't make clean. Ever since the Makefile was changed to only
>> remove $(OBJECTS), rather than *.o xdiff/*.o etc., you have to
>> remember to 'make clean' _before_ you switch branches. Otherwise,
>> you risk leaving some objects laying around. Since the script
>> runs 'nm' on all objects it finds, any stale ones can cause problems.
>> (Of course, I almost always forget, so I frequently have to manually
>> check for and remove stale objects!)
> 
> Gross. I would not be opposed to a Makefile rule that outputs the
> correct set of OBJECTS so this (or other) scripts could build on it.
> 
> IIRC, BSD make has an option to do this "make -V OBJECTS" or something,
> but I don't thnk there's an easy way to do so.

Hmm, I would go in the opposite direction and take a leaf out of
Ævar's book (see commit bc548efe) and this one-liner:

diff --git a/Makefile b/Makefile
index ee89c06..c08c25e 100644
--- a/Makefile
+++ b/Makefile
@@ -2506,7 +2506,7 @@ profile-clean:
 
 clean: profile-clean coverage-clean
        $(RM) *.res
-       $(RM) $(OBJECTS)
+       $(RM) $(addsuffix *.o,$(object_dirs))
        $(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
        $(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
        $(RM) $(TEST_PROGRAMS) $(NO_INSTALL)

This would actually solve my problem, but it actually isn't a
_complete_ solution. (Hint: think about what isn't in $(OBJECTS),
depending on the configuration). ;-)

> Or, since it seems to find useful results quite frequently, maybe it
> would be worth including the script inside git (and triggering it with
> an optional Makefile rule). It sounds like we'd need a way to annotate
> known false positives, but if it were in common use, it would be easier
> to get people to keep that list up to date.

Hmm, I suspect that wouldn't happen, which would reduce it usefulness
and ultimately lead to it not being used. (Updating the 'stop list' would
fast become a burden.)

I find it useful to flag these issues automatically, but I still need
to look at each symbol and decide what to do (you may not agree with
some of my choices either - take a look at the output on the master
branch!).

The way I use it, I effectively ignore the 'stop list' maintenance issues.

ATB,
Ramsay Jones


