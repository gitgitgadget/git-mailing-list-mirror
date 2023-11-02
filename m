Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718519BC2
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qqV+1new"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20112F
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 07:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698934795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPpn2b9LKV3Qutf6p88mOA57XgJAA5VXEn04qBkuvJs=;
	b=qqV+1new8lUwQaYqkhqpi6FJPA45Yn6kj8H9GntCosw/6MU2eZEZOlTcPrcm6pp1Ku2uCC
	xYWG4bUmh7p6hOf0+blWZLLAYJzNmyWW6UXRiu+xSWX3AVKrT/VTEYI7M3T5KvrhCqAWbx
	ya4iVAYlOkfqheLz+ufkccgzo0w7cpBGrA5AhwWZTCWEpIxBj1H2yJSfLyns5V9gVUACLC
	pD9KohHXEFhMTPKZBSNp51Wud9lzFcATvOmXz9voL3F70yygBWlsnN66aefItjCRV2tqYw
	CXQPE7LROYSAOB2qvoXxXIsKDGkEagOoFm/HMfvgw36N2674MX1KQQw+pAUB9g==
Date: Thu, 02 Nov 2023 15:19:54 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Thomas Guyot <tguyot@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Christoph
 Anton Mitterer <calestyo@scientia.org>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <d54eedf0-7825-44f5-908c-a51541345872@gmail.com>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g> <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
 <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
 <8022dae27797bf1e1770f099ed37f5d3@manjaro.org>
 <d54eedf0-7825-44f5-908c-a51541345872@gmail.com>
Message-ID: <79cf1bf35ba6c9348735685b01e0f2f9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-11-02 14:19, Thomas Guyot wrote:
> On 2023-11-02 02:48, Dragan Simic wrote:
>> On 2023-11-02 06:48, Thomas Guyot wrote:
>>>         -c or --clear-screen ( and backward compat. -C or
>>> --CLEAR-SCREEN )
>>>                Causes full screen repaints to be painted from the top
>>> line down.  By default, full screen repaints are done by scrolling
>>> from the  bottom  of the screen.
>> 
>> AFAIK, the "-c" option is about the way screen contents is updated 
>> when
>> scrolled, and it exists to aid in resolving possible issues with some
>> terminal emulators.  To make sure, I just tested it, and "-c" doesn't
>> replace "-X".
> 
> That's correct, you need both and also -y0

Hmm, I tried the following:

     GIT_PAGER='less -R -F -X -c -y0'

In my environment (Xfce), the result after scrolling the output of "git 
log -p" up and down a bit was about 20 copies of the same screen "page" 
in the scrollback, plus a couple of blank "pages".  Not good, 
unfortunately, and actually much worse than having just "-R -F -X".

>> Huh, this confuses me a bit, quite frankly.  Isn't the "-F" option 
>> used
>> specifically to make pagination invisible in case fewer lines than one
>> full screen are displayed?
> 
> Indeed, but when less update from the bottom, it can add new lines and
> let the overflow lines scroll up into the scrollback buffer.
> 
> Then updating it from the top, it draws the whole page, top to bottom.
> That's fine for a full page but not desired for a partial one. Also
> note that on my terminal (rxvt-unicode) when less clears the screen to
> draw the first page the current screen is rolled up into scrollback -
> iirc that's a configurable option, it would be worth testing other
> terminal's behavior on that. IIRC it may also erase it when using the
> wrong termcap file.
> 
> I haven't looked at the code, but I think it could be possibly to
> start the -c behavior only after a full page is drawn, after exiting
> on partial pages, which would give us the best of both worlds.

Does the GIT_PAGER setup, as I described it above, work for you without 
the described artifacts, in any of the environments you have access to?

>>> OTOH by repainting from the top, the scrollback buffer is never
>>> affected. only the last displayed page remains on the terminal.
>> 
>> Just to clarify, it's the "-X" option that creates all the issues, and
>> the "--redraw-on-quit" option is already there to replace it with no
>> associated issues, but the trouble is that only newer versions of
>> less(1) support the "--redraw-on-quit" option.  IOW, it's all about
>> improving less(1) to avoid complex workarounds required to handle
>> different versions, such as the workarounds used in bat(1).
> 
> TBH I haven't tested --redraw-on-quit, even on Debian Bookworm which
> was just released a couple months ago this option isn't available. I
> suspect that the issue isn't -X, but the scrolling behavior controlled
> by -y and the full redraw controlled by -c.

When you get into the terminfo entry definitions, the root cause is that 
the terminal initialization sequences contain switching to alternate 
screen, which causes screen contents to be lost when less(1) exits.  
Thus, "-X" has been actually abused in the pager setups to skip the 
terminal initialization sequences, which may also result in other 
issues.

One of the solutions is to edit the terminfo entry manually and remove 
the escape codes that cause the switching to and from alternate screen, 
which I tested, but that also introduced another issue -- the screen 
contents was always present after less(1) exited, which isn't always the 
desired behavior.

> Actually I just tested my
> solution on xfce4-terminal and it doesn't work, the terminal still
> push up stuff above on redraw (noteworthy is with rxvt-unicode the
> first draw pushes the current screen contents up but no other redraw
> does, which is what makes it work so well - I haven't tried to find
> out what is being done exactly... OTOH the redraw on scroll down is
> slightly noticeable there, while impossible to see on xfce4-terminal.
> I'll install the latest less and see what happens with --redraw on

Please test the "--redraw-on-quit" option, so far it's the best 
available solution, IMHO.

>>> If less could only enable this behavior after the first full page
>>> draw, that would be perfect!
>> 
>> Could you, please, elaborate a bit on that?
> 
> I mentioned it slightly above, to be clear it would mean that:
> 
> 1. less starts by just writing lined down as usual, making any lines
> above scroll up and overflow into the scrollback buffer as usual
> 2.  If less draws less than a page, exits as before - the effective
> result is as if pager was cat
> 3. If less reaches a full page and still has lines to write, it turns
> on -c's behavior and further updates happen from the top of the
> screen, preventing scroll up (at least on rxvt-unicode)
> 
> Now, if all other terms misbehave here, that's an issue, making this
> suggestion mostly useless. And considering the number of Windows users
> we absolutely need to test Windows Terminal, and should probably test
> MacOS's term too (whatever that is).

Quite frankly, I think that such a solution would be like "fixing the 
fix, which is actually an abuse", as I described it above, eventually 
introducing even more issues, instead of solving the original issue.

>>> Dragan, that may be useful if you're discussing with less
>>> developers...
>> 
>> We've basically reached some kind of an agreement about the need for a
>> good solution, which turned out to be rather complex as a result of
>> being quite universal and extensible, which was required for it to,
>> hopefully, be accepted into less(1).  Also, the author of less(1) 
>> seems
>> to be quite busy with some other things, and he prefers to implement 
>> new
>> features himself.
>> 
>> We've also agreed on another new feature for less(1), hopefully, which
>> isn't exactly related, but should be quite useful.  It's about the
>> secure mode for less(1).
> 
> Feel free to cc me on your next correspondence. If there are mailing
> lists archives for the thread I'll fetch them as needed. We have at
> least one working term/switch combination, which IMO is a better start
> than nothing :)

Please test the "--redraw-on-quit" option, AFAICT that's all we need 
(plus the already mentioned other improvements to less(1), to avoid the 
version-dependent workarounds), and the distributions will eventually 
catch up with the newer versions of less(1).  If the whole thing has 
worked for decades as-is, it can continue working that way for a year or 
two until the packages get updated.

There's actually no two-way mailing list for less(1), the entire project 
is pretty much a one-man show, so to speak.  There's a GitHub page that 
allows issues to be submitted, but I didn't use that, so I exchanged a 
few private email messages instead with the author.  I've already summed 
up the important parts of those messages.
