From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Thu, 8 Sep 2011 08:21:05 +1000
Message-ID: <CACsJy8Cy_Nn3EExV0D=RWtft+1pc9RBdJgpmES4AeQgYsUfU3A@mail.gmail.com>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org> <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Sep 08 00:21:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1QV4-0008F3-N6
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 00:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345Ab1IGWVh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 18:21:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62799 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757294Ab1IGWVh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 18:21:37 -0400
Received: by bke5 with SMTP id 5so107794bke.19
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tRb3OamaEBEKJ9akEYjFi/TcxoptMdO75+gmFZm2YI8=;
        b=cTdlYkcaIfDD2g68zLPOz5k6kAViex3PNVKihp98DFflKS4tTolo3iYRyX6TFRl+42
         yMMIFopfr+yOIK3O1gw2N/AygMBsiu8ODPUlygiWIq+mEWueEg1sYYgKKeCvEYsq8dIq
         xtYmucjUIIPCy93ROykwHyIQF6f/lUUEZ4yrg=
Received: by 10.204.150.203 with SMTP id z11mr438734bkv.237.1315434095790;
 Wed, 07 Sep 2011 15:21:35 -0700 (PDT)
Received: by 10.204.7.138 with HTTP; Wed, 7 Sep 2011 15:21:05 -0700 (PDT)
In-Reply-To: <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180923>

On Thu, Sep 8, 2011 at 6:57 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> A better alternative could be to sign a "push certificate" (for the l=
ack
> of better name) every time you push, asserting that what commits you =
are
> pushing to update which refs. The basic workflow goes like this:
>
> =C2=A01. You push out your work with "git push -s";
>
> =C2=A02. "git push", as usual, learns where the remote refs are and w=
hich refs
> =C2=A0 =C2=A0are to be updated with this push. It prepares a text fil=
e in memory
> =C2=A0 =C2=A0that looks like this using this information:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Push-Certificate-Version: 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Pusher: Junio C Hamano <gitster@pobox.com>=
 1315427886 -0700
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Update: e83c51633... d4e58965f... refs/hea=
ds/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Update: 5a144a288... 7931f38a2... refs/hea=
ds/next
>
> =C2=A0 =C2=A0An actual push certificate records full 40-char object n=
ame, but it is
> =C2=A0 =C2=A0ellided for brevity here.
>
> =C2=A0 =C2=A0The user then is asked to sign this push certificate usi=
ng GPG. The
> =C2=A0 =C2=A0result is carried to the other side (i.e. receive-pack).=
 In the
> =C2=A0 =C2=A0protocol exchange, this step comes immediately after the=
 sender tells
> =C2=A0 =C2=A0what the result of the push should be, before it sends t=
he pack data.
>
> =C2=A03. The receiving end will keep the signed push certificate in c=
ore,
> =C2=A0 =C2=A0receives the pack data and unpacks (or stores and runs i=
ndex-pack)
> =C2=A0 =C2=A0as usual.
>
> =C2=A04. A new phase to record the push certificate is introduced in =
the
> =C2=A0 =C2=A0codepath after the receiving end runs receive_hook(). It=
 is envisioned
> =C2=A0 =C2=A0that this phase:
>
> =C2=A0 =C2=A0a. parses the updated-to object names, and appends the p=
ush
> =C2=A0 =C2=A0 =C2=A0 certificate (still GPG signed) to a note attache=
d to each of the
> =C2=A0 =C2=A0 =C2=A0 objects that will sit at the tip of the refs;

I recall Gentoo wanted something like this (recording who pushes
what). Pulling Robin in if he has any comments.
--=20
Duy
