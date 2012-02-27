From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: sha-1 check in rev-list --verify-objects redundant?
Date: Mon, 27 Feb 2012 07:48:11 +0700
Message-ID: <CACsJy8C9=BJvKvFB3XrSqNXV-y3=o1pTJPtFBXK3jSheBff3Uw@mail.gmail.com>
References: <CACsJy8D_BdV14dGc2YsK91FrX8S=70DJOY3cU=oH3y41N2Ar0w@mail.gmail.com>
 <7vk43af14m.fsf@alter.siamese.dyndns.org> <CACsJy8BUeedTZSq_ay=JmqUt3wrnm6n1eOcFt0WPkEo2B-1zwA@mail.gmail.com>
 <7v1uphff8o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 01:49:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1omA-0007gt-4o
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 01:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab2B0Asn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Feb 2012 19:48:43 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47960 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab2B0Asm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2012 19:48:42 -0500
Received: by wibhm11 with SMTP id hm11so975063wib.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 16:48:41 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.216.134.74 as permitted sender) client-ip=10.216.134.74;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.216.134.74 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.216.134.74])
        by 10.216.134.74 with SMTP id r52mr5734033wei.19.1330303721261 (num_hops = 1);
        Sun, 26 Feb 2012 16:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Xpja4jwuwmcU+dTGUyTatSKOjO0SQS6qrEltZNN1q9A=;
        b=BExHbjUB3Ai+7WlmhSEl+pe1DzAXj0tJxoQ1LLeXJq5SzJJL9hpHmChamEKyuEL87j
         55+Kk94fn/eF9PVCarCysl0UJJ0535SebkqTlIsmCU3pgN3URV84Um0hw7va+dkHpDkH
         GphE86MNazTj1vNQkNAKRxse2azxULcTbjGko=
Received: by 10.216.134.74 with SMTP id r52mr4578306wei.19.1330303721208; Sun,
 26 Feb 2012 16:48:41 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sun, 26 Feb 2012 16:48:11 -0800 (PST)
In-Reply-To: <7v1uphff8o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191590>

On Mon, Feb 27, 2012 at 4:37 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On the well-formedness, unless I'm mistaken, --verify-objects is
>> _always_ used in conjunction with index-pack.
>
> Hmm, you are making my head hurt. =C2=A0Is the above "always" a typo =
of
> "never"?
>
> The static check_everything_connected() function in builtin/fetch.c i=
s a
> direct callsite of "rev-list --verify-objects", and the function is u=
sed
> in two codepaths:
>
> =C2=A0* store_updated_refs() that is used after we receive and store =
objects
> =C2=A0 from the other end. =C2=A0We may or may not have run index-pac=
k in this
> =C2=A0 codepath; in either case we need to make sure the other side d=
id send
> =C2=A0 everything that is needed to complete the history between what=
 we used
> =C2=A0 to have and what they claimed to supply us, to protect us from=
 a broken
> =C2=A0 remote side.

I stand corrected. --verify-objects is _usually_ used in conjunction
with index-pack, when the media is a pack (i.e. no remote helpers)

> =C2=A0* quickfetch() that is called even before we get any object fro=
m the
> =C2=A0 other end, to optimize the transfer when we already have what =
we need.
>
> The latter is the original use to protect against unconnected island =
of
> chain I explained in the previous message, but the former is also abo=
t the
> same protection, in a different callchain.

I think we can trust what we already have, so in the latter case (and
the former when the medium is a pack), --objects should suffice.

> In both cases, the check by --verify-objects is about completeness of=
 the
> history (is everything connected to the tips of refs we have?), and i=
s
> different from integrity of individual objects (is each individual ob=
ject
> well formed and hash correctly?). =C2=A0Both kinds of sanity need to =
be
> checked, as they are orthogonal concepts.
>
> In order to check the history completeness, we need to read the objec=
ts
> that we walk during the check. I wouldn't be surprised if the codepat=
h to
> do this is written overly defensive, taking a belt-and-suspender appr=
oach,
> and check the well-formedness of an object before it reads it to find=
 out
> the other objects pointed by it.
>
> If we _know_ that we have checked the integrity of all the necessary
> individual objects before we start reading them in order to check the
> completeness of the history, there is an opportunity to optimize by
> teaching --verify-objects paths to optionally be looser than it curre=
ntly
> is, to avoid checking the object integrity twice.

Ok, will cook something. The reason I raised it is because
--verify-objects --all on git.git could take ~1m10s, but if we assume
object integrity is fine and skip it, it could drop to 10s (I suspect
--objects gives the same number).
--=20
Duy
