From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7 p2 1/2] fast-export: don't handle uninteresting refs
Date: Fri, 30 Nov 2012 06:57:18 +0100
Message-ID: <CAMP44s08Jfu08oeABHcy=xPtn=LZfKTdbaRZuDbf7g+RiP7xAA@mail.gmail.com>
References: <1354141440-26534-1-git-send-email-felipe.contreras@gmail.com>
	<1354141440-26534-2-git-send-email-felipe.contreras@gmail.com>
	<8FA492C2-71B0-44AB-B816-AFB6C91DC01C@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Max Horn <postbox@quendi.de>
X-From: git-owner@vger.kernel.org Fri Nov 30 06:57:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeJbS-0005JO-EK
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 06:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab2K3F5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 00:57:19 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45003 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab2K3F5S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2012 00:57:18 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so96185obb.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 21:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wR+0J53Eu2/9CMYN3eKqr1BPDx5Ambq9K5tp7exnZg4=;
        b=OOnM79c1K1u7TEtEiG/ld1mB1IrfWhdbnv8gZOAa9rbbee6U46ih5MNKPXAULK+gry
         X2RHDPTDZGIW3FRZgE/ztxR4Ucr1xaVwti3Ir0Yd88OpsUAnKYM8wNfBiBjlWuRFgjCy
         GW7kJakuSEBJH0T07763//z8l1wffe+uDu0kzonwnoUcfoC0WnKrfbscEgXuPEPa7GaT
         dQJICVG26HiOaaReZzptyzmkxVIaOfPSrJ0tmumblnVQIbZ262x1WHvXH7+Ts9eIWz6v
         pdMle/W1jf2xCk6e+GZD4xA93QwD6CGbFldfNaiYZpID6M0aRFt4C4yqjPP3V87wcs2+
         agFQ==
Received: by 10.60.1.169 with SMTP id 9mr106306oen.93.1354255038225; Thu, 29
 Nov 2012 21:57:18 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Thu, 29 Nov 2012 21:57:18 -0800 (PST)
In-Reply-To: <8FA492C2-71B0-44AB-B816-AFB6C91DC01C@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2012 at 2:16 AM, Max Horn <postbox@quendi.de> wrote:
>
> On 28.11.2012, at 23:23, Felipe Contreras wrote:
>
>> They have been marked as UNINTERESTING for a reason, lets respect that.
>>
>> Currently the first ref is handled properly, but not the rest:
>>
>>  % git fast-export master ^uninteresting ^foo ^bar
>
> All these refs are assumed to point to the same object, right? I think it would be better if the commit message stated that explicitly. To make up for the lost space, you could then get rid of one of the four refs, I think three are sufficient to drive the message home ;-).

Yeah, they point to the same object.

> <snip>
>
>> The reason this happens is that before traversing the commits,
>> fast-export checks if any of the refs point to the same object, and any
>> duplicated ref gets added to a list in order to issue 'reset' commands
>> after the traversing. Unfortunately, it's not even checking if the
>> commit is flagged as UNINTERESTING. The fix of course, is to do
>> precisely that.
>
> Hm... So this might be me being a stupid n00b (I am not yet that familiar with the internal rep of things in git and all...)... but I found the "precisely that" par very confusing, because right afterwards, you say:

Yeah, the next part was added afterwards.

>> However, in order to do it properly we need to get the UNINTERESTING flag
>> from the command line ref, not from the commit object.
>
> So this sounds like you are saying "we do *precisely* that, except we don't, because it is more complicated, so we actually don't do this *precisely*, just manner of speaking..."

Well, we do check fro the UNINTERESTING flag, but on the ref, not on the commit.

> Some details here are beyond my knowledge, I am afraid, so I have to resort to guess: In particular it is not clear to me why the "however" part pops up: Reading it makes it sound as if the commit object also carries an UNINTERESTING flag, but we can't use it because of some reason (perhaps it doesn't have the semantics we need?), so we have to look at revs.pending instead. Right? Wrong? Or is it because the commit objects actually do *not* carry the UNINTERESTING bits, hence we need to look at revs.pending. Or is it due to yet another reason?

It's actually revs.cmdline, I typed the wrong one.

If you have two refs pointing to the same object, and you do 'one
^two', the object (e.g. 8c7a786) will get the UNINTERESTING flag, but
that doesn't tell us anything about the ref being a positive or a
negative one, and revs.pending only has the object flags. On the other
hand revs.cmdline does have the flags for the refs.

Does that explain it?

> Anyway, other than these nitpicky questions, this whole thing looks very logical to me, description and code alike. I also played around with tons of "fast-export" invocations, with and without this patch, and it seems to do what the description says. Finally, I went to the various long threads discussion prior versions of this patch, in particular those starting at
>   http://thread.gmane.org/gmane.comp.version-control.git/208725
> and
>   http://thread.gmane.org/gmane.comp.version-control.git/209355/focus=209370
>
> These contained some concerns. Sadly, several of those discussions ultimately degenerated into not-so-pleasant exchanges :-(, and my impression is that as a result some people are not so inclined to comment on these patches anymore at all. Which is a pity :-(. But overall, it seems this patch makes nothing worse, but fixes some things; and it is simple enough that it shouldn't make future improvements harder.
>
> So *I* at least am quite happy with this, it helps me! My impression is that Felipe's latest patch addresses most concerns people raised by means of an improved description. I couldn't find any in those threads that I feel still applies -- but of course those people should speak for themselves, I am simply afraid they don't want to be part of this anymore :-(.

Indeed. For all the concerns given I made a response to how that
either is not true, or doesn't really matter, and in the case of the
latter, I asked for examples where it would matter, only to receive
nothing. For whatever reason involved people are not responding, not a
single valid concern has been raised and remained.

So I think it's good.

Cheers.

-- 
Felipe Contreras
