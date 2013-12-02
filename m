From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Subject: Re: [PATCH v3] gettext.c: detect the vsnprintf bug at runtime
Date: Mon, 02 Dec 2013 07:31:29 +0700
Message-ID: <529BD4E1.8040408@gmail.com>
References: <1385812884-23776-1-git-send-email-pclouds@gmail.com> <1385865938-16392-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	schwab@linux-m68k.org, tboegi@web.de
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 01:32:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnHQe-0004xN-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 01:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892Ab3LBAbm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Dec 2013 19:31:42 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:48314 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab3LBAbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 19:31:41 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so17703004pbc.35
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 16:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YjW87nN7NQE1ULPdM+cROjbCyOoL0GxEEeLk7W8aWOs=;
        b=HjsMhr23cQ+HnmaMze66GK1CnV5M7dCufFwKL2rEbaHhRENbhKmBiFXwA5ZnxUOOp7
         K99XbhrlJrZ7QaL/9zE0b2pM30hGolQMnzlVv7VEEPNgCgmnKl6+Trh3uJ4DQfInpoyg
         1s0GNNud8Bkx9PBxKsmTLwDRcqq6G0DV0jhr2vHImt87e/STEYB7jxkSziQTybuo93H0
         8U2Jr/21vfydAbsEsQcExJ2NIFV8ONf57d6pehXE12rn+yyvvrmA6VQpbRg9ueyoOIAZ
         awPVxXqUD5kHYeugMLrIGNk8Bk/BXgKj3kFBwZLhG+h24mnjGAeBToDp4XcYQMt1KGz9
         aBuw==
X-Received: by 10.66.226.46 with SMTP id rp14mr40332264pac.133.1385944300722;
        Sun, 01 Dec 2013 16:31:40 -0800 (PST)
Received: from vnwildman.myftp.org ([113.171.219.242])
        by mx.google.com with ESMTPSA id pl1sm118085353pbb.20.2013.12.01.16.31.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 01 Dec 2013 16:31:40 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1385865938-16392-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238606>

On 01/12/2013 09:45, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Bug 6530 [1] in glibc causes "git show v0.99.6~1" to fail with error
> "your vsnprintf is broken". The workaround avoids that, but it
> corrupts system error messages in non-C locales.
>
> The bug has been fixed since 2.17. We could know running glibc versio=
n
> with gnu_get_libc_version(). But version is not a sure way to detect
> the bug because downstream may back port the fix to older versions. D=
o
> a runtime test that immitates the call flow that leads to "your
> vsnprintf is broken". Only enable the workaround if the test fails.
>
> Tested on Gentoo Linux, glibc 2.16.0 and 2.17, amd64.
>
> [1] http://sourceware.org/bugzilla/show_bug.cgi?id=3D6530
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  v3 goes with runtime test instead of version check.
>
>  gettext.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/gettext.c b/gettext.c
> index 71e9545..eed7c7f 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -29,6 +29,17 @@ int use_gettext_poison(void)
>  #endif
> =20
>  #ifndef NO_GETTEXT
> +static int test_vsnprintf(const char *fmt, ...)
> +{
> +	char buf[26];
> +	int ret;
> +	va_list ap;
> +	va_start(ap, fmt);
> +	ret =3D vsnprintf(buf, sizeof(buf), fmt, ap);
> +	va_end(ap);
> +	return ret;
> +}
> +
this function alway run each time we run git commad while libc is
static. It is waste.
> +	/* the string is taken from v0.99.6~1 */
> +	if (test_vsnprintf("%.*s", 13, "David_K\345gedal") < 0)
> +		setlocale(LC_CTYPE, "C");
>  }
> =20
>  void git_setup_gettext(void)

I suggest use C preprocessor instead. The person who complete git (make=
 debian, rpm etc. package) decide  enable it or not (disable by default=
). Most of people use git from distribution instead of complete it from=
 source.

#ifndef VSNPRINTF_OK
	setlocale(LC_CTYPE, "C");
#endif


--=20
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
