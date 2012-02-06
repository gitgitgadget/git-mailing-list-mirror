From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Mon, 6 Feb 2012 14:14:56 +0200
Message-ID: <CAMP44s1RN+_UK9rAk_m9Z=YaJJtwHLyiCu2stMMDEWqZN9260g@mail.gmail.com>
References: <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
	<7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
	<7vehuboe5g.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
	<20120204182611.GA31091@sigill.intra.peff.net>
	<7v39aphw85.fsf@alter.siamese.dyndns.org>
	<7vipjlezas.fsf@alter.siamese.dyndns.org>
	<20120205234750.GA28735@sigill.intra.peff.net>
	<7vehu8dcc8.fsf@alter.siamese.dyndns.org>
	<20120206030339.GA29123@sigill.intra.peff.net>
	<7vy5sgaby1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 13:15:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuNTM-00066M-1a
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 13:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab2BFMO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 07:14:58 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46376 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754282Ab2BFMO5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 07:14:57 -0500
Received: by lagu2 with SMTP id u2so2979318lag.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 04:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=o3FFUKx0zBPecSanBlOp+oIaey5CQ0gNJpnFqmLFTKY=;
        b=Vwluv7wJ/yYgAMurg4UXRTx+N8RBtSwf4SgaGo86NWGg44kdriygTMSCgQOPz+HYFl
         SBN8eoX/zNMkmegmPA+BKQPURFiMKXKJArMeeB2XicBG0bDHvDRdU67Cgjl8K3WctE+k
         EXos+FF24GaJSL12TdPRCMfmQT7GyfQ+YXH0Y=
Received: by 10.112.28.169 with SMTP id c9mr4660700lbh.42.1328530496076; Mon,
 06 Feb 2012 04:14:56 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Mon, 6 Feb 2012 04:14:56 -0800 (PST)
In-Reply-To: <7vy5sgaby1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190068>

On Mon, Feb 6, 2012 at 5:16 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jeff King <peff@peff.net> writes:
>
>> Ugh, yeah. I was thinking about how it would improve this call site,=
 but
>> I don't want to get into auditing the others. Let's drop it and go w=
ith
>> your patch.
>
> In any case, here is what I queued for tonight.
>
> -- >8 --
> Subject: [PATCH] mailmap: do not leave '>' in the output when answeri=
ng "we did something"

This subject doesn't explain the *purpose* of the patch: always return
a plain mail address from map_user()

That would be enough for most readers.

I think the immediate problem should be here:

Currently 'git blame -e' would add an extra '>' if map_user() returns
true, which would end up as '<foo@bar.com>>'. This is because
map_user() sometimes modifies, the mail string, but sometimes not. So
let's always modify it.

At this point a lot of readers can skip the rest of the explanation.

> The callers of map_user() give email and name to it, and expect to ge=
t an
> up-to-date versions of email and/or name to be used in their output. =
The
> function rewrites the given buffers in place. To optimize the majorit=
y of
> cases, the function returns 0 when it did not do anything, and it ret=
urns
> 1 when the caller should use the updated contents.
>
> The 'email' input to the function is terminated by '>' or a NUL (whic=
hever
> comes first) for historical reasons, but when a rewrite happens, the =
value
> is replaced with the mailbox inside the <> pair. =C2=A0However, it fa=
iled to
> meet this expectation when it only rewrote the name part without rewr=
iting
> the email part, and the email in the input was terminated by '>'.

With the above explanation I suggested, I think this can be summarized =
as:

As of right now most of the callers of map_user() give a plan address,
and expect a plain address, however, 'git blame -e' passes along a
mail address that ends with >, and uses the return value to determine
if a transformation was made, and adds the missing '>'. This is
because when map_user() does the transformation, it returns a plan
address.

This might have worked in previous versions of map_user(), but now not
only does it transforms mail addresses, but also the name (phrase). So
now callers can't use the return value to know if they need to add an
extra '>', or not. So lets always remove the '>', so they can.

> This causes an extra '>' to appear in the output of "blame -e", becau=
se the
> caller does send in '>'-terminated email, and when the function retur=
ned 1
> to tell it that rewriting happened, it appends '>' that is necessary =
when
> the email part was rewritten.

It took too long to reach the problem. As a reader, that's the first
thing I would expect.

> The patch looks bigger than it actually is, because this change makes=
 a
> variable that points at the end of the email part in the input 'p' li=
ve
> much longer than it used to, deserving a more descriptive name.

This is a *separate* logically independent patch. And you yourself
mention, makes the review of the patch more difficult, as of right now
it's difficult to spot the functional change, because it's mixed with
non-functional changes.

I find it peculiar how patches in the Linux kernel are truly logically
independent, but Git has a tendency to squash many things: cleanups,
fixes, documentation, tests, extra tests, remove unused code, etc.

Cheers.

--=20
=46elipe Contreras
