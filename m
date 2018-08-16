Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68AE1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 16:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeHPT6O (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 15:58:14 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:59704 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbeHPT6O (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Aug 2018 15:58:14 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Aug 2018 15:58:14 EDT
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
        by resqmta-po-11v.sys.comcast.net with ESMTP
        id qJTYfKBXoJ7OtqLTefMr84; Thu, 16 Aug 2018 16:50:26 +0000
Received: from [IPv6:2601:646:c101:c8a2:97f:6088:8686:d247] ([IPv6:2601:646:c101:c8a2:97f:6088:8686:d247])
        by resomta-po-18v.sys.comcast.net with ESMTPA
        id qLTdfkDC9f1URqLTdfTFY9; Thu, 16 Aug 2018 16:50:25 +0000
Subject: Re: "less -F" is broken
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, bug-less@gnu.org
References: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
 <87k1orqpxj.fsf@evledraar.gmail.com>
 <CA+55aFxjUsvhHwQGthGiLr537BGHkd-LECXVv8KzBTMMCo1bKQ@mail.gmail.com>
From:   Mark Nudelman <markn@greenwoodsoftware.com>
Message-ID: <e7fb0ae0-b3e3-d7ad-7f6e-c114ee563d59@greenwoodsoftware.com>
Date:   Thu, 16 Aug 2018 09:50:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFxjUsvhHwQGthGiLr537BGHkd-LECXVv8KzBTMMCo1bKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfF9kZ4WmkbnUEKPBVf29pNr0sxlzM9vkRlPmNPEF26NuFuYuP6LuOltBertuc2Y150Kp5p2fhNp2/T4sPsiSMetbDWMwqCTShZuAIdJufMHyb79bvX8e
 PU/M8iEnXv7m3wXp5IZvslHsonZqmbpIMdclVTmsAdA4nUeNjuNrjBiwk53UdKinf/NTs/8MkOhs2XnLDtJtnx8s5cG1aisd+HdR5FGixin/c+q1OI7iG5Mz
 svpu+vU4VVOng6JISXEA64tKiN8kTcHhE+xtX1LiTZ4xJVeOodvHD+NB1a9Ivf+M4Z0yfY0vt8XrbUrzcq5jq19JPS6pzD4aH1pDSY5ymPdZuyFvAWQNjNwi
 8kNS4ODc3/Vj8+KktqHWHIJ4XXfKNtkMp4iozE1TsvEj9eZt5uvE2QLy7PPKTj3yPbAYHhiI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-X is a workaround for the previous behavior of -F, but it's not a great 
solution.  By not sending the terminal init sequence, some things can be 
broken, depending on the terminal.  For example, some terminals send the 
"wrong" sequences for the arrow keys when the terminal doesn't receive 
the init sequence.  For that reason and similar ones, I've never liked 
-X.  The change in behavior for -F was to deal with some other types of 
(arguably broken) terminals that switch to an alternate screen when they 
receive the init sequence.  This makes -F fairly useless on such 
terminals.  However this does change the behavior to the one Linus 
objected to, where the first page is not output until we know whether it 
fits on the screen, so any delays in the first screen will delay all 
output.  (Note that this doesn't happen for delays that occur after the 
first screen has been displayed.)

So I'm not sure what the best solution is.  Linus's proposal to disable 
the line counting stuff if -X is set seems reasonable.  I will look into 
that and see if there are any issues with it.

--Mark

On 8/15/2018 2:57 PM, Linus Torvalds wrote:
> On Wed, Aug 15, 2018 at 2:29 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Downloading & trying versions of it locally reveals that it's as of
>> version 520, not 530. The last version before 520 is 487. Presumably
>> it's covered by this item in the changelog:
>>
>>      Don't output terminal init sequence if using -F and file fits on one
>>      screen[1]
> 
> Side note: that's sad, because we already use X in the default exactly
> for that reason.
> 
> So apparently "less" was broken for us to fix something that we
> already had long solved. The code basically tried to do "automatic X
> when F is set".
> 
> And all that line_count stuff (which is what breaks) is pointless when
> -X is already given.
> 
> That does give a possible fix: just stop doing the line_count thing if
> no_init is set.
> 
> So "-F" would continue to be broken, but "-FX" would work.
> 
> Something like the attached patch, perhaps?
> 
>              Linus
> 
