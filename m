From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/3] blame: refactor porcelain output
Date: Mon, 9 May 2011 12:39:39 -0300
Message-ID: <BANLkTi=EvgRsrULEFiZsOOM4cdfVFATcSg@mail.gmail.com>
References: <20110509133153.GA10998@sigill.intra.peff.net>
	<20110509133402.GB11022@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 17:39:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJSYo-0003Ig-4N
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 17:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab1EIPjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 11:39:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47633 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab1EIPjk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 11:39:40 -0400
Received: by wwa36 with SMTP id 36so5889338wwa.1
        for <git@vger.kernel.org>; Mon, 09 May 2011 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=69k17ru6xKQy+f7JkMv2zm1UWoUtm1satERCM2q7zWI=;
        b=tm4VYZ5pjP5+4QjSKCvKTuGpMJyBFihv1BhrkPVMO1cppGebfamnRlAG41JN/K8MuH
         1NV4MHTIyDtvxKDPtdXX33nHWbwCjVASQMvmnin0rBDB9ZfhKox61dFYLG5AzmKMNRAd
         1cYrW5/NBg/PqcEcyTwH8KTak/l0z7W6j6hOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XB6Z4Gq5aiq4Zgt5jzZB2nXkHGY+HAC8v4Kd29NCmzvI5Ck76L6mZnxSL8X8ayzjtY
         d/l7fJoan0TZ5P2iQieuGulasjnJa70nEKD0spKXwo0LQ1KFp1OvUEpEg7FKJB16H4cw
         gvIu6oyPdwxFiG3z2FfJknuuZm3OF2KSjNgPs=
Received: by 10.216.236.208 with SMTP id w58mr2816779weq.62.1304955579541;
 Mon, 09 May 2011 08:39:39 -0700 (PDT)
Received: by 10.217.3.6 with HTTP; Mon, 9 May 2011 08:39:39 -0700 (PDT)
In-Reply-To: <20110509133402.GB11022@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173238>

On Mon, May 9, 2011 at 10:34 AM, Jeff King <peff@peff.net> wrote:
> This is in preparation for adding more porcelain output
> options. The three changes are:
>
> =C2=A01. emit_porcelain now receives the format option flags
>
> =C2=A02. emit_one_suspect_detail takes an optional "repeat"
> =C2=A0 =C2=A0 parameter to suppress the "show only once" behavior
>
> =C2=A03. The code for emitting porcelain suspect is factored
> =C2=A0 =C2=A0 into its own function for repeatability.
>
> There should be no functional changes.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I broke this out for readability. I can break each of the 3 out into =
a
> separate patch if that helps, but it seemed excessive.
>
> =C2=A0builtin/blame.c | =C2=A0 25 ++++++++++++++++---------
> =C2=A01 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 4242e4b..d74e18f 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1484,13 +1484,14 @@ static void write_filename_info(const char *p=
ath)
> =C2=A0/*
> =C2=A0* Porcelain/Incremental format wants to show a lot of details p=
er
> =C2=A0* commit. =C2=A0Instead of repeating this every line, emit it o=
nly once,
> - * the first time each commit appears in the output.
> + * the first time each commit appears in the output (unless the
> + * user has specifically asked for us to repeat).
> =C2=A0*/
> -static int emit_one_suspect_detail(struct origin *suspect)
> +static int emit_one_suspect_detail(struct origin *suspect, int repea=
t)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit_info ci;
>
> - =C2=A0 =C2=A0 =C2=A0 if (suspect->commit->object.flags & METAINFO_S=
HOWN)
> + =C2=A0 =C2=A0 =C2=A0 if (!repeat && suspect->commit->object.flags &=
 METAINFO_SHOWN)

Maybe would be worth adding parentheses here:

if (!repeat && (...))
  return 0;

?

Probably is fine as is though.
