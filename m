From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 00/16] git-send-email cleanups
Date: Thu, 30 Sep 2010 15:11:43 +0000
Message-ID: <AANLkTikDFJ8jWnuSc9U3hZCRSA971h5Zc2FfJmNiqTUN@mail.gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
	<18E0A903-D625-4C7A-A575-AC5C5EF448C9@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 17:16:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1KsR-00051l-OJ
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 17:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab0I3PLp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 11:11:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33166 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab0I3PLo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 11:11:44 -0400
Received: by iwn5 with SMTP id 5so2550618iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y+28bH7UgD/l2YYnK94qNDk+OrJWA1ia/uegB8fjhos=;
        b=jckzoSOSivRZRDdINoywBZ2+9XZkTvqvj1hTK5UhHxNeqzeyfqDKhPLHpvPxFjrvST
         x8JbJyWPNvt9kP8uznL+Pn8QYecFgixmDYebHCfbOI/a2YsBQ72e9MvFMu6PqI8vyAVC
         ILsDndSs1/UVybD0YgvYELwBLzMhFXzOTGHe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VcplG4dEiQoIGSYOgQQwTQUT96/n5wxcEunlUl+M7GQf4WhpSXATBCEuj+gn1+XXWV
         f1UYfOAppOi8MCe58xBZeNwVA5E9HpJy2vxORAPrFbGsfUgolr+dXlWB7IAqgU8+MtFT
         T0jKm0eBGB8dyAQ9F6uBPbXSyfySMdv6P4aTs=
Received: by 10.231.30.193 with SMTP id v1mr3879846ibc.87.1285859503757; Thu,
 30 Sep 2010 08:11:43 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 30 Sep 2010 08:11:43 -0700 (PDT)
In-Reply-To: <18E0A903-D625-4C7A-A575-AC5C5EF448C9@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157678>

On Thu, Sep 30, 2010 at 14:30, Brian Gernhardt
<brian@gernhardtsoftware.com> wrote:

> None of these subroutines strictly need the prototype, but it does
> allow Perl to warn us if we send incorrect arguments. =C2=A0Why remov=
e
> them? =C2=A0Are they causing problems somewhere?

As Jeff pointed out prototypes are troublesome. If you want to be
warned about too many arguments a better way is:

    sub foo {
        warn sprintf "You gave me %d arguments", scalar @_ if @_ !=3D 1=
;

Or something like that, but there's no reason to do that for these
subs in particular. There are 32 subroutines in git-send-email.perl,
these weren't in any way more special than the rest.

They probably had prototypes in the first place because they were
added by someone who was under the mistaken impression that Perl
prototypes were remotely similar to C-like prototypes, they're not.

The purpose of Perl prototypes is to rewrite the *caller* code, so
that e.g. if you have:

    sub blah ($$) { ... }

Perl will rewrite this call:

    blah @foo, @bar;

As:

    blah(scalar(@foo), scalar(@bar))

While a blah without prototypes would just be:

    blah(@foo, @bar);

Using prototypes superfluously like this makes it harder to read the
code, because you end up checking every call site for every subroutine
call that uses prototypes to see if rewriting the argument list like
this is producing some unexpected logic error.
