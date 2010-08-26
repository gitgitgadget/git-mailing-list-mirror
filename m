From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [BUG] git fetch --prune --tags origin deletes all remote branches origin/*
Date: Wed, 25 Aug 2010 22:26:31 -0400
Message-ID: <AANLkTi=CEBZOK11uyb1SCF8fTc0CyWaEUxMFAv6-=MyB@mail.gmail.com>
References: <84CF7907-4493-4110-A852-B949BAE0214C@sb.org> <7vsk22ntcl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 04:27:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoSBY-0000ky-UL
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 04:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab0HZC1D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 22:27:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56265 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab0HZC1B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 22:27:01 -0400
Received: by iwn5 with SMTP id 5so1140321iwn.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 19:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=x9ovK2s6pPFjC/7ZF9QFENmlFhl6xr/FJZbvR1zTsc0=;
        b=wyAvBG1RdHXO4553N05o7bsn7FgQkjWoRgNbv1cgiWIUqlLeafiytANhb2+dHhtwmW
         SEBKvaaKcVY3RWqOGA8D/UdVqJ1sDW9zZ8GaCw9a5sldmsGRIDK2fmex/i4f1596GR5D
         tXhe8SAiavmq21BAvYIYebTXhKn7285+w9g2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RkD2nYGZEzKqjpmec2sqcNGjpCriDLa1wpupIBFwcfP0CDVjOZxKDRgLZlBWrqAKHP
         w/DDxYFWx+XXfcbL4DADY8nFC3phS0EaVx6xx5aHmv3k+XyLnLA5TCGxRtIwqnQB94vt
         aylGCLSYjhFUqHkkn7djBIPFjwlwCK7lMH1R0=
Received: by 10.231.13.77 with SMTP id b13mr9725690iba.28.1282789621195; Wed,
 25 Aug 2010 19:27:01 -0700 (PDT)
Received: by 10.231.161.199 with HTTP; Wed, 25 Aug 2010 19:26:31 -0700 (PDT)
In-Reply-To: <7vsk22ntcl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154500>

On Wed, Aug 25, 2010 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Kevin Ballard <kevin@sb.org> writes:
>
>> Running the simple command `git fetch --prune --tags origin` will de=
lete
>> every single remote branch refs/remotes/origin/*, with the sole
>> exception of refs/remotes/origin/HEAD. This is wildly unexpected
>> behavior. This was reproduced on the tip of the next branch, with
>> version git version 1.7.2.2.440.g49ea7.
>
> I suspect "--prune --tags" behaved like that from the very beginning =
of
> the appearance of "--prune",

Indeed. The logic was refactored from "git remote prune" which doesn't
support --tags. The quick fix would be to make --prune --tags and
unsupported combination. However:

> and also it is not limited to --tags. =C2=A0With
> this:
>
> =C2=A0 =C2=A0[remote "origin"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D $over_there
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fetch =3D refs/heads/master:refs/heads/ori=
gin
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fetch =3D refs/heads/next:refs/heads/next
>
> "git fetch --prune origin master" would probably remove your local ne=
xt.

I would think "remote prune" suffered the same fate in that situation.

> get_stale_heads() seems to assume that it has the list of all existin=
g
> refs from the remote side available to make its decision. =C2=A0Unles=
s the
> fetch is done using a list of refs configured with remote.<name>.fetc=
h, I
> do not think that assumption holds.
>
> =C2=A0f2ef607 (remote: refactor some logic into get_stale_heads(), 20=
09-11-10)
> =C2=A0f360d84 (builtin-fetch: add --prune option, 2009-11-10)

I'm not sure what the best fix here is. It would seem prune should
obey the user's fetch spec.

j.
