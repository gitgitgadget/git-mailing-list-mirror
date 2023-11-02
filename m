Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255831867
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Zg6W2V8B"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC0C123
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698907722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHxJ9Ozi2o5i+v/sRBW5neOWtD3LLfzkdU5JPtDFB9c=;
	b=Zg6W2V8BlIf1cwRtfGkM5POG0SKdrSbledhuLEEGYm8IQeWeDBd9UE7HMjbsglZuPci4Y3
	5Gdckn6KAumn1hwPZLsJN4wkHd6xklvL05NLxQkxkHU5xDiFNfLyx7h+5bVsLgBADubJPK
	wJTmV5qjIG9WpIQbtBf7ajd304W6bxn+iG+gylksczKElCPRL/FYk2fhKt/jz7d3fKNezb
	sHYsZut/sxlEcevUyOPu5jjzBHVRTxsVlMiicLTunL82iRkbTZCxA3zNqE9xMRo3Or9rtq
	XnzVYlNhP+nam/J5fgWP+/L9R91ok+2WoambuGcok2InvOXYHNhMdjACgSdlzQ==
Date: Thu, 02 Nov 2023 07:48:42 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Thomas Guyot <tguyot@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Christoph
 Anton Mitterer <calestyo@scientia.org>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g> <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
 <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
Message-ID: <8022dae27797bf1e1770f099ed37f5d3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-11-02 06:48, Thomas Guyot wrote:
> On 2023-10-13 16:12, Dragan Simic wrote:
>> On 2023-10-12 18:19, Junio C Hamano wrote:
>>> Dragan Simic <dsimic@manjaro.org> writes:
>>>> Please note that dropping "-X" and leaving "-F" would actually
>>>> introduce the inconsistency that I already mentioned.  To reiterate,
>>>> short outputs would then remain displayed on screen, while long
>>>> outputs would disappear after exiting less(1).
>>> 
>>> Good point.
>> 
>> I've been thinking about this, and a rather elegant, 
>> backward-compatible
>> solution is possible, but it requires some improvements to be made to
>> less(1) first.  I'll reach out to the author of less(1) and propose 
>> that
>> new feature, and I'll let you know his opinion about it.
> 
>  Hey there...

Hello!

> I'm clearly late to the party but I'm wondering, has anyone tested
> adding -cy0 ? From the manpage (slightly edited):
> 
>        -c or --clear-screen ( and backward compat. -C or
> --CLEAR-SCREEN )
>               Causes full screen repaints to be painted from the top
> line down.  By default, full screen repaints are done by scrolling
> from the  bottom  of the screen.

AFAIK, the "-c" option is about the way screen contents is updated when 
scrolled, and it exists to aid in resolving possible issues with some 
terminal emulators.  To make sure, I just tested it, and "-c" doesn't 
replace "-X".

>        -yn or --max-forw-scroll=n
>               Specifies  a  maximum  number of lines to scroll
> forward.  If it is necessary to scroll forward more than n lines, the
> screen is repainted in‐
>               stead.  The -c or -C option may be used to repaint from
> the top of the screen if desired.  By default, any forward movement
> causes scrolling.

This option is, I'd guess, also about aiding in resolving possible 
issues with some terminal emulators.  Or maybe even with some actual 
terminals as pieces of hardware, who knows, which may be too slow to 
scroll many lines at once.

> I actually have one major issue with it, it's that displaying anything
> less than a full page will fill the screen with ~ on the bottom, just
> like when scrolling up on a partial page  without -F. I can see this
> being a major annoyance when using for ex. git log -1, git show --stat
> or --name-only, etc. as I  usually do it to keep the latest history
> within the current screen (and there's likely even commands that I
> never seen using the pager because I never exceeded the page height).

Huh, this confuses me a bit, quite frankly.  Isn't the "-F" option used 
specifically to make pagination invisible in case fewer lines than one 
full screen are displayed?

> OTOH by repainting from the top, the scrollback buffer is never
> affected. only the last displayed page remains on the terminal.

Just to clarify, it's the "-X" option that creates all the issues, and 
the "--redraw-on-quit" option is already there to replace it with no 
associated issues, but the trouble is that only newer versions of 
less(1) support the "--redraw-on-quit" option.  IOW, it's all about 
improving less(1) to avoid complex workarounds required to handle 
different versions, such as the workarounds used in bat(1).

> If less could only enable this behavior after the first full page
> draw, that would be perfect!

Could you, please, elaborate a bit on that?

> Dragan, that may be useful if you're discussing with less
> developers...

We've basically reached some kind of an agreement about the need for a 
good solution, which turned out to be rather complex as a result of 
being quite universal and extensible, which was required for it to, 
hopefully, be accepted into less(1).  Also, the author of less(1) seems 
to be quite busy with some other things, and he prefers to implement new 
features himself.

We've also agreed on another new feature for less(1), hopefully, which 
isn't exactly related, but should be quite useful.  It's about the 
secure mode for less(1).
