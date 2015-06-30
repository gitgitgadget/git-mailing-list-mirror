From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid the need of "--" when wildcard pathspec is used
Date: Tue, 30 Jun 2015 11:10:40 -0700
Message-ID: <xmqqk2ulcbj3.fsf@gitster.dls.corp.google.com>
References: <1435668007-31231-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 20:10:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9zzf-00070N-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 20:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbbF3SKq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 14:10:46 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37068 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbF3SKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 14:10:44 -0400
Received: by igblr2 with SMTP id lr2so18304385igb.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=+d4bfuDrL5bZ7BrV9AVxGcdzrtqRZ6LXxvyWRDfo8BM=;
        b=zqZBPblsKiZv4tUQ8/FfAFLQ82aIXGCc6mjHjvdtk3XemGkURogy472iJc5RM6gI0d
         3y0xiEn8+jJzPKZ05VsbQJ56OKugxZW4Q43rWHyfgdkb9SpJeVpuH3mhcUPOZV+ACrQn
         QsIaLD3J4VJgL34XULX7BWmOjfMPHCwoNf9EDXqWB4iQTHA/sNns91P8rJifNybEtrTk
         qbhGNrRHHo3XVquCEQrnyQv3uHyK4ZkklrkDO5iWB/nVPlZLzMhxy5IMKyigxqY/SRRx
         +2qDaXzD0pKLTLj2sRkjkWXXUt7rEhrpBWBk9Htf9D43fbKs/A72fpLUbiJtHKynrf53
         7zmA==
X-Received: by 10.43.58.143 with SMTP id wk15mr9800860icb.81.1435687843165;
        Tue, 30 Jun 2015 11:10:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id g3sm8247225igi.10.2015.06.30.11.10.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 11:10:42 -0700 (PDT)
In-Reply-To: <1435668007-31231-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 30
 Jun 2015 19:40:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273092>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When "--" is lacking from the command line and a command can take bot=
h
> revs and paths, the idea is if an argument can be seen as both an
> extended SHA-1 and a path, then "--" is required or git refuses to
> continue. It's currently implemented as:
> ...

Hmph, how does this relate to 28fcc0b7 (pathspec: avoid the need of
"--" when wildcard is used, 2015-05-02)?  A follow-up?  "Oops, I did
it wrong"?  something else?

> diff --git a/setup.c b/setup.c
> index 82c0cc2..f7cb93b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -143,6 +143,8 @@ int check_filename(const char *prefix, const char=
 *arg)
>  		name =3D arg + 2;
>  	} else if (!no_wildcard(arg))
>  		return 1;
> +	else if (!no_wildcard(arg))
> +		return 1;

Puzzling.  You already checked if arg has an wildcard and returned
with 1 if there is none.  The added check looks like a no-op to me.

> diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-amb=
iguous-ref.sh
> index b99d519..e5ceba3 100755
> --- a/t/t2019-checkout-ambiguous-ref.sh
> +++ b/t/t2019-checkout-ambiguous-ref.sh
> @@ -56,4 +56,30 @@ test_expect_success VAGUENESS_SUCCESS 'checkout re=
ports switch to branch' '
>  	test_i18ngrep ! "^HEAD is now at" stderr
>  '
> =20
> +test_expect_success 'wildcard ambiguation' '
> +	git init ambi &&
> +	(
> +		cd ambi &&
> +		echo a >a.c &&
> +		git add a.c &&
> +		echo b >a.c &&
> +		git checkout "*.c" &&
> +		echo a >expect &&
> +		test_cmp expect a.c
> +	)
> +'
> +
> +test_expect_success 'wildcard ambiguation (2)' '
> +	git init ambi2 &&
> +	(
> +		cd ambi2 &&
> +		echo a >"*.c" &&
> +		git add . &&
> +		test_must_fail git show :"*.c" &&
> +		git show :"*.c" -- >actual &&
> +		echo a >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done
