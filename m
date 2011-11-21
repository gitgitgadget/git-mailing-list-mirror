From: Bertrand BENOIT <projettwk@users.sourceforge.net>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in .git/info/exclude
Date: Mon, 21 Nov 2011 16:44:51 +0100
Message-ID: <CAPRVejf71ke-RcbQQfiPUFAdzyBMAGCKnmBuaF2mOneuBF-TYQ@mail.gmail.com>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
	<7vehx2ijf8.fsf@alter.siamese.dyndns.org>
	<20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
	<7vzkfqgn91.fsf@alter.siamese.dyndns.org>
	<4EC9FC81.3080306@viscovery.net>
	<20111121081701.GA7985@do>
	<7vk46th5bz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 16:44:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSW3F-0003rg-Ss
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 16:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab1KUPox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Nov 2011 10:44:53 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53620 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab1KUPow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 10:44:52 -0500
Received: by vbbfc21 with SMTP id fc21so2656579vbb.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 07:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K2UI40MwGyrIoAfsmF/6OMBlSEI4YquMEr2H5o0wBUo=;
        b=W5fYF4wFF1Z8ID5KR0bEnSWeo8umakOvypf+kf5XzupX4C55MxagSX7yO2rrucMryV
         LAIGivSKSlYc9bf2ImwCmJLeJkVsqiFdMjCVbl5HDC6dt5oNEOhbYf+zwO6FXlihGN29
         wCKn1cGashnoFAb8x4dxsSo9Fmw3cfaILwy2o=
Received: by 10.182.2.136 with SMTP id 8mr3101033obu.71.1321890291848; Mon, 21
 Nov 2011 07:44:51 -0800 (PST)
Received: by 10.182.15.133 with HTTP; Mon, 21 Nov 2011 07:44:51 -0800 (PST)
In-Reply-To: <7vk46th5bz.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: Fhwk_VuK_ZqGcj2vVM1DqtKoGW4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185749>

2011/11/21 Junio C Hamano <gitster@pobox.com>:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> If you want to keep this accident (which is a bug to me), you may wa=
nt
>> to add the reason: callers to unpack_trees() are supposed to also
>> setup exclude rules in .git/info/exclude before calling
>> unpack_trees(), which they don't.
>>
>> So .git/info/exclude is entirely dismissed.
>
> Ohh, thanks for this and also for digging this through in your other
> message.
>
> I think it is the right thing to do to make sure .gitignore and
> info/exclude behave the same way regardless of the original issue in =
this
> topic.
>
> In the medium term, I think one reasonable way forward solving the "T=
ODO
> that used to be tracked but now untracked and ignored" issue is to
> introduce "info/exclude-override" that comes between command line and
> in-tree patterns. The info/exclude file is designed as the fallback
> definition to be used when all other sources are too lax, and comes n=
ear
> the precedence stack; the "TODO" situation however calls for an overr=
ide
> that is stronger than the in-tree patterns.
>
> In the longer term, we should carefully determine if we need "preciou=
s" in
> the first place. The last time this was brought up there were people =
who
> argued they are OK with having to remove the ignored file by hand whe=
n
> checking out another branch (i.e. we switch the semantics of "ignored=
" so
> that they are "not tracked but all precious").
>
> I think it matters in two cases.
>
> =C2=A0(1) If you change an untracked "cruft" file on branch A into a =
directory
> =C2=A0 =C2=A0 with tracked files in it on another branch B. If you ar=
e on branch A,
> =C2=A0 =C2=A0 have that "cruft" file (perhaps it is a build product a=
fter running
> =C2=A0 =C2=A0 "make"), and try to checkout branch B, such an updated =
"git checkout"
> =C2=A0 =C2=A0 will start erroring out telling you that "cruft" will b=
e lost.
>
> =C2=A0(2) If you have a directory on branch A, underneath of which th=
ere are
> =C2=A0 =C2=A0 untracked "cruft" files (e.g. think "build/" directory =
that is full
> =C2=A0 =C2=A0 of "*.o" files and ".gitignore" to mark object files as=
 ignored but
> =C2=A0 =C2=A0 is otherwise empty), and another branch B that has the =
same path as a
> =C2=A0 =C2=A0 file. If you are on branch A, have "cruft" files in tha=
t directory,
> =C2=A0 =C2=A0 and try to checkout branch B, such an updated "git chec=
kout" will
> =C2=A0 =C2=A0 start erroring out telling you that "cruft" will be los=
t.
>
> If people are OK with such a behaviour, we can do without "precious".
>
> Otherwise we would need to update excluded() in dir.c to return trist=
ate
> (ignored, precious or unspecified) instead of the current boolean (ig=
nored
> or unspecified), examine and decide for each caller what they want to=
 do
> to "precious" files.

IMO, as user, I think that erroring out telling you that 'cruft' will
be lost, is enough to avoid data loss.
However, in addition the tristate system (with a dedicated syntax in
=2Egitattributes and/or .gitignore files) would give more freedom,
without having to move 'untracked but precious' files between each
updated 'git checkout'.
