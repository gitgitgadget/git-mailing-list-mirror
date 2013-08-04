From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: Fix cloning and sharing bug
Date: Sun, 4 Aug 2013 08:22:32 -0500
Message-ID: <CAMP44s3_S6PBKu_xqXKyPV_U1okGf1ydxMRi2HCaC5wvA-ypFg@mail.gmail.com>
References: <1A5ABD76-D3D9-400E-AC8F-26C0DEF43723@joernhees.de>
	<1375612683-9104-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 15:22:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5yGs-0003S9-OH
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 15:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab3HDNWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Aug 2013 09:22:37 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:43539 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab3HDNWh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Aug 2013 09:22:37 -0400
Received: by mail-la0-f50.google.com with SMTP id fn20so1428884lab.37
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0iliCIa+adFdhGSpV4X1wCdrzPu+t8zD6CAGpZTrcVo=;
        b=IwLeXIZcIYuM5uB8YOv+xgWrTu0sAHMNYrVkbkcA3/8eK2Xeo03eehgc810EMQsn9C
         B533uuqxGXHmk7cs3BBMUiQ5RXWT+K48Ou081MA8v00GBrI5bPmWUqTMnaHugbWsk55t
         +I2SaZJe6M3j4VZK3YZEevAx2+7jKYpBDUB4dHlbk5L5ydfNE9YIP5Igp9uDlDEC0WY7
         hDfI4bnyE7R42BtQ9XmoOO9BAhSz0N5YXvKMo28hteRzSENrtKDOrtFKN/e1PcfnEedA
         78ev4EnxqXnU0dYoXSYPds1vqxm9gBPQ82D3U0lJQVkbBdTIpaVFrsMyKsXGcEA06zgH
         ffUg==
X-Received: by 10.112.63.132 with SMTP id g4mr7138562lbs.25.1375622553043;
 Sun, 04 Aug 2013 06:22:33 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 4 Aug 2013 06:22:32 -0700 (PDT)
In-Reply-To: <1375612683-9104-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231626>

On Sun, Aug 4, 2013 at 5:38 AM, Antoine Pelisse <apelisse@gmail.com> wr=
ote:
> 6796d49 (remote-hg: use a shared repository store) introduced sharing
> repository capability, but it broke backward-compatibility with alrea=
dy
> existing repositories.
>
> Indeed, 6796d49 assumes that .git/hg/.hg (the shared repository) will
> exist if .git/hg exists.
> This can be false for already existing clones. It can also be false f=
or
> local repository that are not cloned.
>
> Fixes the compatibility break by always cloning into .git/hg/.shared
> (even for local repositories).

This seems to presume that there's no way to fix it otherwise, but ther=
e is.

Maybe always cloning is a good idea, maybe it's not, but that is a
change that should be done in a separate commit, and it can.

> In order to avoid expensive clone
> retrieval from slow remotes, also look for already existing clones in
> .git/hg/$aliases/clone.

This is yet another change that should be in yet another patch.

> Reported-by: Joern Hees <dev@joernhees.de>
> Suggested-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> Hey,
>
> OK, I think this version will work in all cases.
> Either you clone local and then remote, or remote and then local,
> or old version local and then remote, or old version remote and then =
local:
> You will always either have .shared repo already cloned, or will find=
 a way to
> create it: either by using an already existing clone, or by cloning t=
he given
> url (and that last step can't be done if we don't use .shared).

Perhaps it would work in all the cases, but it would need to reclone
if the user is updating from v1.8.3.

> I also decided to always clone local repositories because what J=C3=B6=
rn Hees
> said makes sense:
> If you have a local clone of a big repository, and then want to add a=
 slow
> remote, you would have to reclone everything.
> I think the trade-off is good, because clone from local should not be=
 that
> time expensive (maybe it can be on disk-space though).

As I said; this should be discussed in a different patch. Personally I
think the current behavior is all right, because the use case of
cloning a local repository is way more common that cloning a
repository, and then adding a slow remote. We should optimize for the
common use-case.

--=20
=46elipe Contreras
