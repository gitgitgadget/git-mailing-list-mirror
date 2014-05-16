From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] config: be strict on core.commentChar
Date: Fri, 16 May 2014 09:25:08 -0700
Message-ID: <20140516162508.GA12314@google.com>
References: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
 <1400248283-303-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 18:25:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlKwm-0003tQ-Hg
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 18:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757619AbaEPQZR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 12:25:17 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38832 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbaEPQZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 12:25:16 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so2779998pbb.8
        for <git@vger.kernel.org>; Fri, 16 May 2014 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CQsLdBXbwccGrbqGL4Jdml8KAhwKjq9HuSKYOwzz4Xw=;
        b=kLYOGgVE9RpJv3ftnMrHH8T9xtF4vOz6HQo3tJoN9a5wIaptWCH2ABtP9jTEcPHjs3
         Cu0vFt8GJWCn05lEWfjkrXw1kHp3iczeWsk0SiR5pWKyBBXBfITSGlaQWBzKK+gWRSIa
         JEy9EY0+XdqQ4wpqjZwh9NnHYSuqy2lwjUUhYqTq5WG4HypTiVoQcH8NopfZ9bM40XEa
         O2DtGXA5RjJmS6svhQhtjUmTEOeUHIWIuEGElBqAysn/Lg3Svmy0kbwynqhWfj6/gZ/Z
         fPOgKN+kyZKh8mlph7xem6BeIM/SBF+L9MKIKWdICpfh/KLyJoNQd1GU64mEeMNJZbhn
         ZdiA==
X-Received: by 10.68.94.133 with SMTP id dc5mr22468732pbb.114.1400257515235;
        Fri, 16 May 2014 09:25:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tb4sm36290615pac.45.2014.05.16.09.25.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 May 2014 09:25:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400248283-303-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249354>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/config.c
> +++ b/config.c
> @@ -826,8 +826,12 @@ static int git_default_core_config(const char *v=
ar, const char *value)
>  	if (!strcmp(var, "core.commentchar")) {
>  		const char *comment;
>  		int ret =3D git_config_string(&comment, var, value);
> -		if (!ret)
> -			comment_line_char =3D comment[0];
> +		if (!ret) {
> +			if (comment[0] && !comment[1])
> +				comment_line_char =3D comment[0];
> +			else
> +				return error("core.commentChar should only be one character");
> +		}

Perhaps, to decrease indentation a little:

		if (ret)
			return ret;
		if (comment[0] && !comment[1])
			comment_line_char =3D comment[0];
		else
			return error(...);
		return 0;

[...]
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1348,12 +1348,6 @@ test_expect_success "status (core.commentchar =
with submodule summary)" '
>  	test_i18ncmp expect output
>  '
> =20
> -test_expect_success "status (core.commentchar with two chars with su=
bmodule summary)" '
> -	test_config core.commentchar ";;" &&
> -	git -c status.displayCommentPrefix=3Dtrue status >output &&
> -	test_i18ncmp expect output

Could keep the test to avoid regressions:

	test_config core.commentchar ";;" &&
	test_must_fail git -c status.displayCommentPrefix=3Dtrue status

Thanks,
Jonathan
