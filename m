From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] commit: allow core.commentChar=auto for character
 auto selection
Date: Fri, 16 May 2014 09:40:53 -0700
Message-ID: <20140516164053.GB12314@google.com>
References: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
 <1400248283-303-1-git-send-email-pclouds@gmail.com>
 <1400248283-303-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 18:41:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlLBt-0001Ri-77
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 18:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbaEPQk5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 12:40:57 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35153 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbaEPQk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 12:40:56 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so2794022pab.1
        for <git@vger.kernel.org>; Fri, 16 May 2014 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jn+ATgKf1bdQSMXTEuZTdpdONEjuicmof7gP+0z9Zoo=;
        b=iFhNIibt3C8q+JuVSLU94Cban7182n202hrcm+n4oOiMzPQl2n8EwCsTVw69/naDO4
         XTlLJYYkeHZnfWnw1RPvuoEf7l8ajsW56PZ+3f9GdHRZZtki7RMdRD3vx0Iv9VJWMlRq
         AGVz3ZU1HJ6pE1Tu7YBgkPDEeVKhQXtPhyGuVz5enKfd27Qcdpoys0e0JATayp5Tb3WM
         BhL3ASg1wusaDj+FpK/NNRqDUbm8AN1xRKzAELP25rtetubwXJvoAsFcZFfl9tPtjwqJ
         fNBpdQwqbmouvV4IbX+FvgQPbBHOCsh3snrTRYJAYq4DgHD73oMB1B3xQBB8UpJ2pjJG
         XMKw==
X-Received: by 10.68.219.162 with SMTP id pp2mr22628138pbc.47.1400258456435;
        Fri, 16 May 2014 09:40:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id uk1sm36473174pac.26.2014.05.16.09.40.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 May 2014 09:40:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400248283-303-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249355>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> core.commentChar starts with '#' as in default but if it's already in
> the prepared message, find another one among a small subset. This
> should stop surprises because git strips some lines unexpectedly.

Probably worth mentioning this only kicks in if someone explicitly
configures [core] commentchar =3D auto.

Would it be a goal to make 'auto' the default eventually if people
turn out to like it?

[...]
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -594,6 +594,40 @@ static char *cut_ident_timestamp_part(char *stri=
ng)
>  	return ket;
>  }
> =20
> +static void adjust_comment_line_char(const struct strbuf *sb)
> +{
> +	char candidates[] =3D " @!#$%^&|:;~";

This prefers '@' over '#'.  Intended?

[...]
> +	char *candidate;
> +	const char *p;
> +
> +	if (!sb->len)
> +		return;
> +
> +	if (!strchr(candidates, comment_line_char))
> +		candidates[0] =3D comment_line_char;

Could do

	if (!memchr(sb->buf, comment_line_char, sb->len))
		return;

to solve the precedence problem.  The comment_line_char not appearing
in the message is the usual case and handling it separately means it
gets handled faster.

[...]
> --- a/config.c
> +++ b/config.c
> @@ -829,6 +829,8 @@ static int git_default_core_config(const char *va=
r, const char *value)
>  		if (!ret) {
>  			if (comment[0] && !comment[1])
>  				comment_line_char =3D comment[0];
> +			else if (!strcasecmp(comment, "auto"))
> +				auto_comment_line_char =3D 1;

Is there a way to disable 'auto' if 'auto' is already set?

comment_line_char still can be set and matters when 'auto' is set.
Should they be separate settings?

> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -563,4 +563,29 @@ test_expect_success 'commit --status with custom=
 comment character' '
[...]
> +	GIT_EDITOR=3D.git/FAKE_EDITOR test_must_fail \

Shells make it obnoxiously hard to set a one-shot envvar while
calling a function without the setting leaking into later commands.

	(
		test_set_editor .git/FAKE_EDITOR &&
		test_must_fail ...
	)

or

	test_must_fail env GIT_EDITOR=3D.git/FAKE_EDITOR ...

should do the trick.

Thanks and hope that helps,
Jonathan
