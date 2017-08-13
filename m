Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40F21F667
	for <e@80x24.org>; Sun, 13 Aug 2017 19:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbdHMTRJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 15:17:09 -0400
Received: from avasout06.plus.net ([212.159.14.18]:37494 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdHMTRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 15:17:09 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id wjH61v00C18PUFB01jH7Jr; Sun, 13 Aug 2017 20:17:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=mhb2F0Gq5HUpnSjw8dsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC] clang-format: outline the git project's coding style
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
 <87y3qsg7ni.fsf@gmail.com>
 <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
 <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
 <20170811175237.GC59325@google.com>
 <20170811211845.tpgmafenhahus77o@sigill.intra.peff.net>
 <xmqq378xxuvk.fsf@gitster.mtv.corp.google.com>
 <20170813044145.xz4o47oog3z5eycg@sigill.intra.peff.net>
 <26bebb5b-857f-1501-5139-a5513d9875ec@ramsayjones.plus.com>
 <xmqqy3qnwexy.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d58118f7-e9d2-e74f-30be-7d66477b128b@ramsayjones.plus.com>
Date:   Sun, 13 Aug 2017 20:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqy3qnwexy.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/08/17 18:33, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>> Hmm, on reflection, it may be a bit too crude! :-D
> 
> As you already saw in the output from this, I think this is a good
> illustration that shows why we want an incremental tool that works
> on the changes, not on full file contents.  Contributors who want
> their changes accepted and want to help the review process by
> avoiding trivial coding style violations in their patches should not
> have to find _their_ piece from an output about the whole file
> contents, most of which is likely to have been inherited from the
> original.  They are not working on Git to produce unnecessary code
> churn whose only purpose is to make existing and otherwise dormant
> code conform to the style tool's liking.  That's not their focus.
> 
> IOW I was expecting something that works on the output from "git
> diff HEAD" or "git format-patch --stdout @{u}.."

Yes, I had already tried the following, which maybe more workable,
but it is only lightly tested. (we may want to create our own version
of checkpatch.pl, which is written specifically for the kernel ...)

$ git diff
diff --git a/Makefile b/Makefile
index 461c845d3..a25028e68 100644
--- a/Makefile
+++ b/Makefile
@@ -2440,6 +2440,15 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
+STYLE_REVS = HEAD
+STYLE_IGNORES = NEW_TYPEDEFS,INLINE
+
+.PHONY: style
+style:
+       @git diff $(STYLE_REVS) -- '*.[ch]' | \
+               checkpatch.pl -q --no-tree --show-types \
+               --ignore=$(STYLE_IGNORES) --patch - 2>/dev/null || true
+
 check: common-cmds.h
        @if sparse; \
        then \
$ make style  # I don't have any changes to *.[ch] files!
$ make STYLE_REVS=HEAD~3 style
WARNING:LONG_LINE: line over 80 characters
#181: FILE: git.c:320:
+		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&

WARNING:LONG_LINE: line over 80 characters
#221: FILE: revision.c:2317:
+	if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {

total: 0 errors, 2 warnings, 206 lines checked
$ 

I suspect this closer to what you had in mind. ;-)
(although the --ignore list may need adding to).

ATB,
Ramsay Jones


