Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB14C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 22:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjHKW3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 18:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHKW3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 18:29:45 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5ED1FCF
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:29:44 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 92FDA242A2;
        Fri, 11 Aug 2023 18:29:41 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qUadZ-n7J-00; Sat, 12 Aug 2023 00:29:41 +0200
Date:   Sat, 12 Aug 2023 00:29:41 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] format-patch: add --description-file option
Message-ID: <ZNa2VQQzZmaMzM4C@ugly>
References: <xmqqttta9h6a.fsf@gitster.g>
 <20230809171530.2564724-1-oswald.buddenhagen@gmx.de>
 <xmqq1qg9qmyq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq1qg9qmyq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 02:38:05PM -0700, Junio C Hamano wrote:
>> +	if (strbuf_read_file(buf, desc_file, 2000) < 0)
>
>You would probably want to do "2000" -> "0" here.
>
hmm, yeah, i wonder where i got it from, given that there is no 
precedent. i suppose i simply thought that 2k is a reasonably expectable 
max size for a description. if you think the default 8k hint is a better 
idea, then let's go with it.

>>  static void prepare_cover_text(struct pretty_print_context *pp,
>> +			       const char *description_file,
>>  			       const char *branch_name,
>
>This is kind of suboptimal, but let's let it pass.
>
>A better design is to pass the description string itself to this
>function and the make_cover_letter() function, and have the higher
>level callers of the callchain prepare the either read_desc_file()
>or read_branch_desc() to prepare that string before calling into the
>callchain. 
>
there is only one caller, and doing this change would essentially result 
in inlining prepare_cover_text(). probably not the best outcome.

>Such a division of labor between the callers and this
>function will allow us to more easily add another option to the
>command, to feed the description string itself (instead of having to
>create a temporary file and storing the description in it).
>
that's a good point. in fact, passing in the description directly would 
probably fit my use case better ... i just happened to already have the 
code for creating that temp file anyway (for editing), so i didn't give 
it a second thought. i can add both options in the same go, given that 
it's almost no code.

regards
