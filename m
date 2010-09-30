From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 13/16] send-email: extract_valid_address use qr// regexes
 and /o
Date: Thu, 30 Sep 2010 18:56:17 +0000
Message-ID: <AANLkTin_b6eSnHgY2YCOfN7E83gEzrOpktUD3heOnfQw@mail.gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
	<1285854189-10240-14-git-send-email-avarab@gmail.com>
	<20100930161912.GA8707@sigill.intra.peff.net>
	<7vocbfjg7x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 20:56:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1OIr-0002jD-65
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 20:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664Ab0I3S4T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 14:56:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39245 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268Ab0I3S4S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 14:56:18 -0400
Received: by iwn5 with SMTP id 5so2770464iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QTSu1rs9mhdhMWAiKIW0AvPjUN1+8cZQ2CPeXkooRTk=;
        b=n1bolmtCridAP5ZMxvzJfk34hTC/PK35KbtgnmfPOTO8AFfSdrhtTPcSoucQ/NmBCe
         p4s6FhxoGpygAYIUuZUi7mmTiIBPvxUZc01Uspp3qIVenrXb6ghZUbfDPmNnPRiGOdMy
         RLb5v0hKHeFH1CvLXRKvmmH0onMuCZU1UxHU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TW6Yo3b6BoEJyUAcoTTq3IIQ+rFG1m+vfmNJkD0+HpcHsp/wsyIqRHEgMkhb+sjXPd
         HrLS+Pt0uolmQFLGE8qykWDxJiGjxeuy27LdGiG9E+DJS676EEHhxto6pPCKAA/A20K6
         Kj1/k5n8QKGcu0LlHxYj6OKloErrIsUbgwchs=
Received: by 10.231.59.212 with SMTP id m20mr4213001ibh.130.1285872977696;
 Thu, 30 Sep 2010 11:56:17 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 30 Sep 2010 11:56:17 -0700 (PDT)
In-Reply-To: <7vocbfjg7x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157701>

On Thu, Sep 30, 2010 at 17:25, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jeff King <peff@peff.net> writes:
>
>> ...
>> But we are unnecessarily compiling the sub-regexes each time. Not th=
at
>> this is probably a performance critical piece of code, but your "/o"=
 is
>> doing very little, and this is exactly the sort perl wankery that I =
find
>> interesting.
>
> Well, isn't the _sole_ point of using qr// to optimize by avoiding
> recompilation? =C2=A0If this is not a performance critical section of=
 the code,
> what is the point of this change?
>
> This [PATCH 13/16] and also [PATCH 12/16] rewrite strings using qr// =
but
> the patterns thus compiled are used exactly once before the control l=
eaves
> the scope of the variables, so...

The point is to use Perl's data-types for what they're supposed to be
used for. In perl you *can* write:

    my $two =3D "1" + "1";

To get 2, but that's silly. You should just use integers instead of
string coercion:

    my $two =3D 1 + 1;

Similarly you *can* put regexes in strings, but perl has a first-class
datatype for it, so you should do:

    my $rx =3D qr/foo/;

Not:

    my $rx =3D "foo";

So it's just a change to use a better style. There are some tangible
advantages to using qr// over qq// (also known as ""), e.g. Emacs and
Vim will know to highlight the string as a regexp, and when the $rx is
interpolated Perl won't need to recompile it because it can just add a
pointer to the existing regex in the new pattern.

But the main reason here is to not write code that looks like it
targets Perl 5.5, but 5.8.
