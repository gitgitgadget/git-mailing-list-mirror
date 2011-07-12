From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC] control, what refs are honored by core.logAllRefUpdates
Date: Tue, 12 Jul 2011 20:15:21 +0200
Message-ID: <CAKPyHN0+BaPtrRMVrWCZQ2mbJQz_vxsOOsG4Z=Ksqc1RJvF1Ew@mail.gmail.com>
References: <CAKPyHN3_br-ndQo9oMzCcU1yOVEbAxmzvHQkwF15LgwQx12KZA@mail.gmail.com>
	<7vaacj8jq7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 20:15:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QghUV-0004DX-PX
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 20:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab1GLSPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jul 2011 14:15:23 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55312 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab1GLSPW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2011 14:15:22 -0400
Received: by vws1 with SMTP id 1so3654312vws.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=61jl7pSY54Ew4nK0bn8ZCJd8PuF6HFsltUw2abvOPn8=;
        b=XjZxUDPGp0xe6nKFEpWLCYiHfUmGgQbsdRTGmy5lyevz4i72AQQMQL7iq/R7lXJtaR
         nfOQi1UmCVcbHbmkTopeTAagrZKX1r/3Kya57GAAplfIdimmi1EZ0NzY1pJYGvAqtdNU
         5A5d9+JOwYpk2G445JKN+e1SxSft6uIl011Kc=
Received: by 10.52.76.74 with SMTP id i10mr318808vdw.128.1310494521607; Tue,
 12 Jul 2011 11:15:21 -0700 (PDT)
Received: by 10.52.185.105 with HTTP; Tue, 12 Jul 2011 11:15:21 -0700 (PDT)
In-Reply-To: <7vaacj8jq7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176961>

On Tue, Jul 12, 2011 at 19:57, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> What: Control the refs which are honored by core.logAllRefUpdates.
>>
>> How:
>>
>> Introduce a new config variable named core.autoRefLog. This variable
>> is a multi var. The default value is:
>>
>> =C2=A0 =C2=A0 [core]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 autoLogRef =3D heads
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 autoLogRef =3D remotes
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 autoLogRef =3D notes
>>
>> This list must be initialize at runtime. Because older repositories
>> won't have them in existing config files.
>
> It sounds as if you mean to update .git/config when you find a reposi=
tory
> that is missing these, which is not what we want. =C2=A0I would rephr=
ase it
> like this:

No, that was not my intention. I meant that the list is set to the
current hard-coded list. And than subsequent code.autoLogRef values
alter this list. So no 'conversion' will be done.

>
> =C2=A0- The new variable core.autoLogRef is a multi-valued configurat=
ion.
>
> =C2=A0- If core.autoLogRef is defined (to any value), core.logAllRefu=
pdates is
> =C2=A0 ignored;

I haven't though of this logic. But it sounds good. Specifying any
core.autoLogRef should be honored, regardless whether
core.logAllRefupdates is set.

>
> =C2=A0- Otherwise, the core.logAllRefUpdates variable that is set to =
true is
> =C2=A0 equivalent to having a "reasonable default" set in core.autoLo=
gRef (and
> =C2=A0 the current "reasonable default" happens to be heads, remotes =
and
> =C2=A0 notes), and the core.logAllRefUpdates variable set to false (o=
r
> =C2=A0 missing) is equivalent to having an empty string in core.autoL=
ogRef;
>
>> The value given needs to be a valid ref, without leading or trailing
>> slashes, and wildcards. The names will be prefixed with 'refs/' and
>> suffixed with '/'. The list is checked against the ref to update, if
>> any of the values is a prefix of the given ref, than the update will
>> be logged, regardless whether the log file exists.
>
> Ok, except for:
>
> =C2=A0- An empty string in core.autoLogRef does not contribute to the=
 matching
> =C2=A0 logic above.
>
>> Setting core.autoLogRef to the empty value, will reset the list.
>
> It is unclear what it is reset to. =C2=A0Do you mean it clears, e.g.
>
> =C2=A0 =C2=A0[core]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0autoLogRef =3D heads
> =C2=A0 =C2=A0 =C2=A0 =C2=A0autoLogRef =3D remotes
> =C2=A0 =C2=A0 =C2=A0 =C2=A0autoLogRef =3D notes
> =C2=A0 =C2=A0 =C2=A0 =C2=A0autoLogRef =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0autoLogRef =3D heads
>
> would first create a list of three elements, clears it and then the f=
inal
> result has only refs/heads/ in the list?
>

Exactly. I think the --notes option does have a similar semantics. (I
added Jeff to the Cc). There is --no-notes, which resets the notes
list and than subsequent --notes=3D options populate the list again.

Bert
