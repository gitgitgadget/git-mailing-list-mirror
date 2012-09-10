From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
Date: Mon, 10 Sep 2012 19:26:26 +0200
Message-ID: <k2l7s5$gl9$1@ger.gmane.org>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de> <1347124173-14460-2-git-send-email-jengelh@inai.de> <7v1uicuyqi.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.01.1209082119320.18369@frira.zrqbmnf.qr> <20120910142100.GB7906@sigill.intra.peff.net> <k2ku26$jld$1@ger.gmane.org> <20120910155006.GA8737@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 19:26:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB7l4-0002OC-TL
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 19:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876Ab2IJR0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 13:26:43 -0400
Received: from plane.gmane.org ([80.91.229.3]:46687 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056Ab2IJR0m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 13:26:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TB7kx-0002IJ-D9
	for git@vger.kernel.org; Mon, 10 Sep 2012 19:26:43 +0200
Received: from dsdf-4db54003.pool.mediaways.net ([77.181.64.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 19:26:43 +0200
Received: from jojo by dsdf-4db54003.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 19:26:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db54003.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205152>

Jeff King wrote:
> On Mon, Sep 10, 2012 at 04:38:58PM +0200, Joachim Schmitz wrote:
>
>>> More importantly, though, is it actually portable? I thought it was
>>> added in C99, and we try to stick to C89 to support older compilers
>>> and systems. My copy of C99 is vague (it says only that the "bool"
>>> macro was added via stdbool.h in C99, but nothing about the "true"
>>> and "false" macros), and I don't have a copy of C89 handy.
>>> Wikipedia does claim the header wasn't standardized at all until
>>> C99:
>>>
>>> https://en.wikipedia.org/wiki/C_standard_library
>>
>> Indeed stdbool is not part of C89, but inline isn't either and used
>> extensively in git (could possible be defined away),
>
> You can define INLINE in the Makefile to disable it (or set it to
> something more appropriate for your system).

That's what I meant.

>> as are non-const array intializers, e.g.:
>>
>>                const char *args[] = { editor, path, NULL };
>>                                               ^
>> ".../git/editor.c", line 39: error(122): expression must have a
>> constant value
>>
>> So git source is not plain C89 code (anymore?)
>
> I remember we excised a whole bunch of non-constant initializers at
> some point because somebody's compiler was complaining. But I suppose
> this one has slipped back in, because non-constant initializers are
> so damn useful. And nobody has complained, which I imagine means
> nobody has bothered building lately on those older systems that
> complained.

OK, record my complaint then ;-)
At least some older release of HP NonStop only have C89 and are still in use

And tying to compile in plain C89 mode revealed several other problems too 
(e.g. size_t seems not to be typedef'd?)

> My "we stick to C89" is a little bit of a lie. We do not care about
> specific standards. We do care about running everywhere on reasonable
> systems. So something that is C99 might be OK if realistically
> everybody has it. And something that is POSIX is not automatically OK
> if there are many real-world systems that do not have it.
>
> Since there is no written standard, there tends to be an organic ebb
> and flow in which features we use. Somebody will use a feature that
> is not portable because it's useful to them, and then somebody whose
> system will no longer build git will complain, and then we'll fix it
> and move on. As reviewers, we try to anticipate those breakages and
> stop them early (especially if they are ones we have seen before and
> know are a problem), but we do not always get it right. And sometimes
> it is even time to revisit old decisions (the line you mentioned is 2
> years old, and nobody has complained; maybe all of the old systems
> have become obsolete, and we no longer need to care about constant
> initializers).
>
> Getting back to the patch at hand, it may be that stdbool is
> practically available everywhere. Or that we could trivially emulate
> it by defining a "true" macro in this case. But it is also important
> to consider whether that complexity is worth it. This would be the
> first and only spot in git to use "true". Why bother?
>
> -Peff 
