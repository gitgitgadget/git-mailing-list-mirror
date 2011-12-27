From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH 1/5] add central method for prompting a user using
 GIT_ASKPASS or SSH_ASKPASS
Date: Tue, 27 Dec 2011 23:12:04 +0000
Message-ID: <CA+39Oz5J82GVyLfzWbWz20VS=Gp=8q9WsHQY33GuOKT1PyFCbQ@mail.gmail.com>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ECC0.606@tu-clausthal.de> <7vwr9h68t9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 28 00:12:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfgC2-0001DT-GT
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 00:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab1L0XMW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Dec 2011 18:12:22 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:38545 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751775Ab1L0XMV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 18:12:21 -0500
Received: by obcwo16 with SMTP id wo16so7697027obc.19
        for <git@vger.kernel.org>; Tue, 27 Dec 2011 15:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=x7nTzI7miA3qEm7qHgURpr+1gaQ5X6eEBW81lxFODbg=;
        b=xDfBDxU0WY8nbrFMMCYl+7gL5NPNTtRucBwL/o+Os/Y8LwBtfSnFkpseTSsTbso7Gu
         P+bEnCmbkAQ6tXuCBa06FGUXxpuxTfESWvsvTniWlnj8igiP2X2F2KhqEWYQs+1UzG2V
         HxNNiIyA/SCORPnonTH8MZajl4lsZT82+xstc=
Received: by 10.182.167.36 with SMTP id zl4mr22037046obb.54.1325027540340;
 Tue, 27 Dec 2011 15:12:20 -0800 (PST)
Received: by 10.182.44.104 with HTTP; Tue, 27 Dec 2011 15:12:04 -0800 (PST)
In-Reply-To: <7vwr9h68t9.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: YdQAd-Q6ayRxapMjIa6EIXd66eY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187735>

On 27 December 2011 20:47, Junio C Hamano <gitster@pobox.com> wrote:
> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
>> +sub askpass_prompt {
>> + =C2=A0 =C2=A0 my ($self, $prompt) =3D _maybe_self(@_);
>> + =C2=A0 =C2=A0 if (exists $ENV{'GIT_ASKPASS'}) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return _askpass_prompt($=
ENV{'GIT_ASKPASS'}, $prompt);
>> + =C2=A0 =C2=A0 } elsif (exists $ENV{'SSH_ASKPASS'}) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return _askpass_prompt($=
ENV{'SSH_ASKPASS'}, $prompt);
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return undef;
>
> Two problems with this if/elsif/else cascade.
>
> =C2=A0- If _askpass_prompt() fails to open the pipe to ENV{'GIT_ASKPA=
SS'}, it
> =C2=A0 will return 'undef' to us. Don't we want to fall back to SSH_A=
SKPASS in
> =C2=A0 such a case?
>
> =C2=A0- The last "return undef" makes all callers of this method to i=
mplement a
> =C2=A0 fall-back way somehow. I find it very likely that they will wa=
nt to use

Not only that, "return undef" will have nasty side-effects if this
subroutine is called in list-context -- it's usually discouraged to
have explicit returns of "undef", where in scalar context that might
be OK, but in list context, the caller will see:

(undef)

and not:

()

i.e., the empty list.

-- Thomas Adam
