From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: parse ws-error-highlight option more strictly
Date: Sun, 12 Jul 2015 09:55:17 -0700
Message-ID: <xmqq4ml9joy2.fsf@gitster.dls.corp.google.com>
References: <55A112ED.3090004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 12 18:55:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEKXE-00052n-MA
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 18:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbbGLQzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2015 12:55:20 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34163 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbGLQzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 12:55:19 -0400
Received: by igczg2 with SMTP id zg2so4832398igc.1
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=zapzFDAAIDz8fgQBP+NbpvFJWCmzxdx7xV93erpWJFA=;
        b=mFQTnfl+sPFVgb3cagHKzp3Qq5/AHcHvJtu0RTFZq5stQwYOKqMXa7zAFNSZtIQHCx
         br/FMMch7NiufcCpvjrdYQZOSB2rfjhXErE152o3zSZXXh35EovJUbalSbIa4j4cD0fX
         ivVgPBj3Uhqa9Dh6QZtElyYRytLbPdeEhTHLFSfVHMK5I7CvjM4ExTEg2mJnPkUxyH8f
         Kze6i8Z8BPACOwpmRScgUGrfyP127Y1uw4UVddZhwHwRQMR4273/+/PNlg1TgpymuzVU
         vinS+zG0LIJWp2514yIjeisR75Wcs8VYB31i5SwdFz8pXAJ1IxZde8bfZgnYkCKtYOn8
         qRGQ==
X-Received: by 10.107.164.38 with SMTP id n38mr3987378ioe.73.1436720118716;
        Sun, 12 Jul 2015 09:55:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b9be:d9fd:18d2:4319])
        by smtp.gmail.com with ESMTPSA id y11sm10807561iod.13.2015.07.12.09.55.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 09:55:18 -0700 (PDT)
In-Reply-To: <55A112ED.3090004@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 11
	Jul 2015 14:58:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273897>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Check if a matched token is followed by a delimiter before advancing =
the
> pointer arg.  This avoids accepting composite words like "allnew" or
> "defaultcontext".
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  diff.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 87b16d5..0f17ec5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3653,7 +3653,12 @@ static void enable_patch_output(int *fmt) {
> =20
>  static int parse_one_token(const char **arg, const char *token)
>  {
> -	return skip_prefix(*arg, token, arg) && (!**arg || **arg =3D=3D ','=
);
> +	const char *rest;
> +	if (skip_prefix(*arg, token, &rest) && (!*rest || *rest =3D=3D ',')=
) {
> +		*arg =3D rest;
> +		return 1;
> +	}
> +	return 0;
>  }

So the bug is, when fed "allnew", calls to this function are done
with "none" and "default" (both of which fail skip_prefix()), then
with "all", at which point skip_prefix() advance the *arg pointer to
"allnew"+3 (i.e. pointing at 'n') and the check on the "are we at
the end of token?" fails. The next call is for "new" and it
incorrectly passes.

Thanks for spotting.

An unrelated tangent, but I misnamed this function grossly, it
seems.  Even if this is a file-scope static, it is selfish to claim
that this function is the only one that will ever parse any kind of
token in this file.  As this is a helper that can be used to parse
any string with comma-separated tokens, I should have named it with
some word that hints that fact.
