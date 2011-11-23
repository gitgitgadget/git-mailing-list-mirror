From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in .git/info/exclude
Date: Wed, 23 Nov 2011 18:40:34 +0700
Message-ID: <CACsJy8A7HVe8kLR5j9Ej0tJhpkxigCXRqpg9DvE9qJsfengi1Q@mail.gmail.com>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org> <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
 <20111121081701.GA7985@do> <7vk46th5bz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 12:41:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTBCU-0003Rf-7r
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 12:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab1KWLlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 06:41:08 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37523 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab1KWLlG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 06:41:06 -0500
Received: by bke11 with SMTP id 11so1478126bke.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 03:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tetBy/WyMWo2eBk3aZ1nEODJvgxU3tr5YHbFNkmnAp8=;
        b=ZUqwt/ykUuW3qd6HGkWMbG88WA8oq3SThThJKV7/x5d4XDEnlxzTVzYJ3LM1/QjwI6
         CMEUiWlUJdfFhceArxWHKf2fO4Td3MpAcnqMu5MxQoYAQ7iYLxjvPHZRe7nI8KLbW0Xi
         vSdMwWbNbDfoWaLcDEHnM0QI6S0xlAN4aasYI=
Received: by 10.204.10.81 with SMTP id o17mr23803948bko.65.1322048465127; Wed,
 23 Nov 2011 03:41:05 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 23 Nov 2011 03:40:34 -0800 (PST)
In-Reply-To: <7vk46th5bz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185842>

On Mon, Nov 21, 2011 at 10:18 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
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

"info/precious" might be a better name

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

I think we should do this regardless precious being added or not.

> If people are OK with such a behaviour, we can do without "precious".

What about git-clean to remove ignored but not precious files?

> Otherwise we would need to update excluded() in dir.c to return trist=
ate
> (ignored, precious or unspecified) instead of the current boolean (ig=
nored
> or unspecified), examine and decide for each caller what they want to=
 do
> to "precious" files.

Or do excluded() twice, the first time to check for precious files,
the second for all ignored rules. Callers are changed anyway, but this
way git-add for example will be untouched because it does not care
about precious stuff. Only unpack-trees and maybe git-clean are
changed.
--=20
Duy
