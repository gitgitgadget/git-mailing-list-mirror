From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/4] stripspace: Implement --count-lines option
Date: Mon, 19 Oct 2015 15:24:05 -0400
Message-ID: <CAPig+cR4wyumSfzXjptCfniuN0QC8TErL1X9LDPMsCD8wHP_kA@mail.gmail.com>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
	<1445008605-16534-4-git-send-email-tklauser@distanz.ch>
	<CAPig+cQ=8FO8yFY4sHUwr0mYuyvMu4d-eizHZeadE9f0BgpXpQ@mail.gmail.com>
	<xmqqwpukayde.fsf@gitster.mtv.corp.google.com>
	<20151019134633.GL2468@distanz.ch>
	<CAP8UFD2pqg_J36V9wZkAR0b-L421gHFi9SbRqFwBbZ1LMVOKSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 21:24:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoG2Y-0002In-Ex
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 21:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbbJSTYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 15:24:08 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35447 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbbJSTYH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 15:24:07 -0400
Received: by vkfw189 with SMTP id w189so26525494vkf.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wZWoRilL3l5g9wVFPlQu0oAONNj0LA6+4RzuKtPJvPM=;
        b=wHrzqyGPWBTCcOflZL+8AebUd5eMTTORCQw0k3B+mIct68UuaTRW3tUnpLB+fmdtAM
         0RxzV9qKiUUO7mUQ13iDQd5S7NXEXe+ftFM4YPTY3UmC4I+p8oP+XItBTDGnmk9H68+4
         itaIat3yiNeB2kChaeCPzVfs72I3YiwaOVMoHWwn8z/hjEt8iZxWZ+X3oZRSC4k3+RhM
         UGSGOEWwCFNTJ2NYm0ZuOQ/o4/fvh1D5xsfgLxcHjyXAv323EO0oJ9rH7NJHEOQ39DUU
         pbyPU5A3G4fw4RpbbQ2o0Xo/Mi/XYyRRcTCocJJeK85KzBV2Vb3g6P6Cdr1qERIqAsp/
         FpjA==
X-Received: by 10.31.8.131 with SMTP id 125mr20185216vki.45.1445282645774;
 Mon, 19 Oct 2015 12:24:05 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Mon, 19 Oct 2015 12:24:05 -0700 (PDT)
In-Reply-To: <CAP8UFD2pqg_J36V9wZkAR0b-L421gHFi9SbRqFwBbZ1LMVOKSg@mail.gmail.com>
X-Google-Sender-Auth: akMbPFUvvi5IHCSfEuikAXxrfGw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279886>

On Mon, Oct 19, 2015 at 1:03 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Oct 19, 2015 at 3:46 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
>> On 2015-10-18 at 19:18:53 +0200, Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> > Is there any application beyond git-rebase--interactive where a
>>> > --count-lines options is expected to be useful? It's not obvious from
>>> > the commit message that this change is necessarily a win for later
>>> > porting of git-rebase--interactive to C since the amount of extra code
>>> > and support material added by this patch probably outweighs the amount
>>> > of code a C version of git-rebase--interactive would need to count the
>>> > lines itself.
>>> >
>>> > Stated differently, are the two or three instances of piping through
>>> > 'wc' in git-rebase--interactive sufficient justification for
>>> > introducing extra complexity into git-stripspace and its documentation
>>> > and tests?
>>>
>>> Interesting thought.  When somebody rewrites "rebase -i" in C,
>>> nobody needs to count lines in "stripspace" output.  The rewritten
>>> "rebase -i" would internally run strbuf_stripspace() and the question
>>> becomes what is the best way to let that code find out how many lines
>>> the result contains.
>>>
>>> When viewed from that angle, I agree that "stripspace --count" does
>>> not add anything to further the goal of helping "rebase -i" to move
>>> to C.  Adding strbuf_count_lines() that counts the number of lines
>>> in the given strbuf (if there is no such helper yet; I didn't check),
>>> though.
>>
>> I check before implementing this series and didn't find any helper. I
>> also didn't find any other uses of line counting in the code.
>
> This shows that implementing "git stripspace --count-lines" could
> indirectly help porting "git rebase -i" to C as you could implement
> strbuf_count_lines() for the former and it could then be reused in the
> latter.

In this project, where all user-facing functionality must be supported
for the life of the project, each new command, command-line option,
configuration setting, and environment variable exacts additional
costs beyond the initial implementation cost. With this in mind, my
question was also indirectly asking whether there was sufficient
justification of the long-term cost of a --count-lines option. The
argument that --count-lines would help test a proposed
strbuf_count_lines() likely does not outweigh that cost.

>>> >> +test_expect_success '--count-lines with newline only' '
>>> >> +       printf "0\n" >expect &&
>>> >> +       printf "\n" | git stripspace --count-lines >actual &&
>>> >> +       test_cmp expect actual
>>> >> +'
>>> >
>>> > What is the expected behavior when the input is an empty file, a file
>>> > with content but no newline, a file with one or more lines but lacking
>>> > a newline on the final line? Should these cases be tested, as well?
>>>
>>> Good point here, too.  If we were to add strbuf_count_lines()
>>> helper, whoever adds that function needs to take a possible
>>> incomplete line at the end into account.
>>
>> Yes, makes more sense like this (even though it doesn't correspond to
>> what 'wc -l' does).
>
> Tests for "git stripspace --count-lines" would test
> strbuf_count_lines() which would also help when porting git rebase -i
> to C.

Rather than saddling the project with the cost of a new user-facing,
but otherwise unneeded option, a more direct way to test the proposed
strbuf_count_lines() would be to add a test-strbuf program, akin to
test-config, test-string-list, etc. This has the added benefit of
providing a home for strbuf-based tests beyond line counting.
