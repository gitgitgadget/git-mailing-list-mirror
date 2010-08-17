From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 2/2] blame: fix output in case of replacement by using parse_commit_repl()
Date: Tue, 17 Aug 2010 13:44:11 +1000
Message-ID: <AANLkTimMXmi1ZhVYXtbMz3doOUZMzbRggqcUY0L7wKyY@mail.gmail.com>
References: <20100817015901.5592.419.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 17 05:44:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlD62-0005mC-Ml
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 05:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab0HQDoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 23:44:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46829 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab0HQDoM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 23:44:12 -0400
Received: by wyb32 with SMTP id 32so6501381wyb.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 20:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZPIr0VgyhEKn/DD3fnFqH/SXpa61oeMiHIoYWTwi8xg=;
        b=Vd3kPttzlYmR+3so169WNMEVoY3heWwN+tOVQ/cGR/8m1VfaMW1/fvIDGB3LjSYagk
         /C/D6ApMRG0OH++EeS0KUKETfle6B1Q+sv0n2C/xr9dq78vXp7DopeIznSNN4MJGCosq
         P28lzJ97iL2vgJUMGtX0oxoAFs6BaeWVhQDDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CDtz/5r8Sn5zsep+nxd1LtXqI8XRYqSvTGBfTHoMyJfPugMH5OnzkD91JSXDkQYG6z
         g3B4fmn4ljLiBSYNi+wMQ5cXdz81rwVeC9g8RlTmgSloFzcrJt2NxnCFC0/1Du1y15tO
         sfBk2TERIkw4WefHgObCJYwo0YP0Vyt7BYTHk=
Received: by 10.216.11.130 with SMTP id 2mr5063417wex.100.1282016651481; Mon,
 16 Aug 2010 20:44:11 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Mon, 16 Aug 2010 20:44:11 -0700 (PDT)
In-Reply-To: <20100817015901.5592.419.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153692>

On Tue, Aug 17, 2010 at 11:59 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> git blame was not showing the sha1 of the replacement commit while
> it was properly showing other information from the replacement commit=
,
> because parse_commit() is buggy regarding replacement.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> =C2=A0builtin/blame.c =C2=A0 =C2=A0| =C2=A0 =C2=A04 ++--
> =C2=A0t/t6050-replace.sh | =C2=A0 =C2=A08 ++++++++
> =C2=A02 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 8f9e7b0..c469e09 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1226,7 +1226,7 @@ static void pass_blame(struct scoreboard *sb, s=
truct origin *origin, int opt)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (sg_origin[i])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (parse_commit(p))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (parse_commit_repl(&p))

This is the hard way. There are another ~40 parse_commit() calls
elsewhere. Most of them are in git commands, so we can check one by
one. There are some calls in revision.c, sha1_name.c, tree.c,
upload-pack.c and walker.c, which may be used in many places. Checking
them would be harder.
--=20
Duy
