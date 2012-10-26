From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule status: properly pass options with --recursive
Date: Fri, 26 Oct 2012 21:26:33 +0200
Message-ID: <508AE3E9.6000304@web.de>
References: <5089BB2D.90400@web.de> <20121026131507.GA2747@sigill.intra.peff.net> <CABURp0op2+QUvusUmAFUxT8s8c02bB9V3=ag9gTTSiiN4t96OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:26:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRpYW-0003S3-Tw
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966150Ab2JZT0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:26:44 -0400
Received: from mout.web.de ([212.227.15.3]:52085 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966098Ab2JZT0o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:26:44 -0400
Received: from [192.168.178.41] ([79.193.90.117]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LudP2-1TIn0b3vbU-010Kxv; Fri, 26 Oct 2012 21:26:35
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CABURp0op2+QUvusUmAFUxT8s8c02bB9V3=ag9gTTSiiN4t96OA@mail.gmail.com>
X-Provags-ID: V02:K0:A7KFsf7uI4SNZWUpf0D3Dy01aIfHI4dlOBobU41vDw3
 GZFJQaRYHU16VWs/MxBTWNDtc4y/wK7CWY0HaSTsP1ExvrAywf
 VcMSPm3Qa3PpVxg11RBHsfALbHedKwUzYOR8XWzMo8wuuozqlV
 VsewcQE6saRhJkNHur1jLf45gbnwCQpzCapzH+zm64Lum0J7Ew
 vOasaeSZXc8L/SR69tiQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208482>

Am 26.10.2012 21:07, schrieb Phil Hord:
> On Fri, Oct 26, 2012 at 9:15 AM, Jeff King <peff@peff.net> wrote:
>> On Fri, Oct 26, 2012 at 12:20:29AM +0200, Jens Lehmann wrote:
>>
>>> When renaming orig_args to orig_flags in 98dbe63d (submodule: only
>>> preserve flags across recursive status/update invocations) the call site
>>> of the recursive cmd_status was forgotten. At that place orig_args is
>>> still passed into the recursion, which is always empty now. This clears
>>> all options when recursing, as that variable is never set.
>>>
>>> Fix that by renaming orig_args to orig_flags there too and add a test to
>>> catch that bug.
>>
>> Thanks. I back-ported your patch on top of 98dbe63d so it can go to
>> 'maint'. I'm curious, though: why didn't the test right before (which
>> checks recursion for --cached) catch this?
> 
> I was wondering the same thing about why 'git submodule sync
> --recursive --quiet' succeeded, so I checked on it.  The answer is
> that "--quiet" sets GIT_QUIET=1, which is then inherited by the
> recursive call. Indeed, Jens' new test passes even without the
> accompanying fix.  :-\

Dang, you're right! At least that explains why nobody noticed that
so far ... (and that's what you get for skipping the "does the test
fail without your fix?" part because the fix is so obvious :-( )

> The 'status --recursive --cached' test passes for two reasons.  The
> first is that the test is checking for a cached change in a level-1
> submodule, but it is the level-2+ submodules which do not get the
> flags passed down correctly in "$@".  The 2nd reason is that the
> $cached variable is _also_ inherited by the recursive call to
> cmd_status, specifically because it is a call to cmd_status() and not
> to '$SHELL git submodule status', where the latter would have cleared
> the flags at startup, but the former does not.
> 
> I'm a bit wary about "fixing" the flags for the recursion machinery.
> I'm starting to think $orig_flags is moot in almost all cases.  It
> looks like clearing all the flags on each iteration would break 'git
> submodule foreach --recursive --quiet' because it does not use
> $orig_flags at all.  Who knows what other surprises lurk there.

I agree, it looks like ripping out the orig_flags would be the way
to go.
