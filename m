Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70947C6379D
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CF9206FA
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgKWTDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:03:16 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:37926 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgKWTDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:03:14 -0500
Received: from client3368.fritz.box (i5C7462D2.versanet.de [92.116.98.210])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 2769C3C052F;
        Mon, 23 Nov 2020 20:03:13 +0100 (CET)
Subject: Re: [PATCH] git-gui: use gray selection background for inactive text
 widgets
To:     serg.partizan@gmail.com
Cc:     me@yadavpratyush.com, git@vger.kernel.org
References: <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
 <20201123114805.48800-1-stefan@haller-berlin.de>
 <JE39KQ.T4FA61XF34XT3@gmail.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <23d6eb6c-4c7b-b9dd-d0df-fe0feaa0dc17@haller-berlin.de>
Date:   Mon, 23 Nov 2020 20:03:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <JE39KQ.T4FA61XF34XT3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.11.20 14:13, serg.partizan@gmail.com wrote:
> 
> 
> On Mon, Nov 23, 2020 at 12:48, Stefan Haller <stefan@haller-berlin.de>
> wrote:
>> On 22.11.20 18:16, serg.partizan@gmail.com wrote:
>>>  I think calculating that gray color from current selection bg is too much work
>>>  for just one color.
>>>
>>>  We can just set inactiveSelectBackground to some neutral gray color like
>>>  #707070 or #909090 which will work fine with both dark and light themes.
>>
>> OK, fine with me. Here's a patch that does this (it sits on top of
>> yours). It almost works, except for one problem: on Mac, the
>> inactive selection background is white instead of lightgray, but
>> only for the diff view; for the commit editor it's correct. On
>> Windows it's also correct for both views. I can't figure out what's
>> the difference on Mac; do you have an idea what could be wrong?
>>
> I have no idea. Can confirm on linux it works as expected.

That's too bad, as I don't think the patch is acceptable with this
defect. I could maybe see if I can find something by reading the Tk
sources, but I'm not really sure where to start, to be honest. Any
suggestions appreciated.


>> diff --git a/git-gui.sh b/git-gui.sh
>> index 867b8ce..a8c5cad 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -3325,8 +3325,25 @@ if {!$use_ttk} {
>>  foreach i [list $ui_index $ui_workdir] {
>>      rmsel_tag $i
>>      $i tag conf in_diff \
>> -        -background $color::select_bg \
>> -        -foreground $color::select_fg
>> +        -background $color::inactive_select_bg \
>> +        -foreground $color::inactive_select_fg
>> +
>> +    if {$use_ttk} {
> 
> I think this check can be safely removed. This is all standard tk
> widgets, and select_bg/fg only changed if use_ttk is true.

I only added this check because I initialize the select_fg color to
lightblue in non-ttk mode, so the file lists would switch color even
though the text fields don't, and I wanted to avoid that. Of course, if
I initialize select_fg to lightgray as before, this is not an issue, and
the behavior is unchanged in non-ttk mode. I'll change that in v2.

>> +        bind $i <FocusIn> {
>> +            foreach tag [list in_diff in_sel] {
>> +                %W tag conf $tag \
>> +                    -background $color::select_bg \
>> +                    -foreground $color::select_fg
>> +            }
>> +        }
>> +        bind $i <FocusOut> {
>> +            foreach tag [list in_diff in_sel] {
> 
> This two `foreach` can be combined into one?

I don't see how; any concrete suggestions? But I have other ideas how to
simplify the code (by using one function set_selection_colors that takes
a has_focus bool and is used for both bindings).

>> +                %W tag conf $tag \
> 
> And this `%W`, probably should be `$i`?

No, $i wouldn't work because we're inside curly braces, so $i wouldn't
get expanded. It would be possible to work around this by using ""
instead of {}, but why? Using %W seems to be the idiomatic way in
bindings, we do this everywhere else too.
