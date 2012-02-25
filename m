From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] grep -P: Fix matching ^ and $
Date: Sat, 25 Feb 2012 10:30:50 +0100
Message-ID: <20120225103050.14f52a91@gmail.com>
References: <1330161868-7954-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	Zbigniew =?UTF-8?B?SsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 10:31:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1Dy2-0002li-Tl
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 10:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645Ab2BYJa4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 04:30:56 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43687 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537Ab2BYJaz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Feb 2012 04:30:55 -0500
Received: by eekc4 with SMTP id c4so1252437eek.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 01:30:54 -0800 (PST)
Received-SPF: pass (google.com: domain of michal.kiedrowicz@gmail.com designates 10.213.20.8 as permitted sender) client-ip=10.213.20.8;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of michal.kiedrowicz@gmail.com designates 10.213.20.8 as permitted sender) smtp.mail=michal.kiedrowicz@gmail.com; dkim=pass header.i=michal.kiedrowicz@gmail.com
Received: from mr.google.com ([10.213.20.8])
        by 10.213.20.8 with SMTP id d8mr1725464ebb.79.1330162254065 (num_hops = 1);
        Sat, 25 Feb 2012 01:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=vYIAb+KCY3cExNXa5pvXP+TqTTnhjOhlicGFPDzS8QM=;
        b=NRkGK8ydA8MRHpJqkrz+loegH0izMo6pvWUwAiRM7l9E0ywktFvrI1eeXZKkKrw8Jc
         YEXCdcz6OWQwBLcCmcrN74RNRcoC65xGihn9XGDexcMfnmCXT2+qsRKAZd7cM1oF8dk/
         nMadd0yQRmok8ZJbKdgCeFiKxZ3q8Ly/DU7rk=
Received: by 10.213.20.8 with SMTP id d8mr1304523ebb.79.1330162253851;
        Sat, 25 Feb 2012 01:30:53 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id v51sm29162483eef.2.2012.02.25.01.30.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 01:30:53 -0800 (PST)
In-Reply-To: <1330161868-7954-1-git-send-email-michal.kiedrowicz@gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191514>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> wrote:

> When `git-grep` is run with -P/--perl-regexp, it doesn't match ^ and =
$ at
> the beginning/end of the line.  This is because PCRE normally matches=
 ^
> and $ at the beginning/end of the whole text, not for each line, and =
git-grep
> firstly passes a large chunk of text (possibly containing many lines)=
 to
> pcre_exec() before it splits the text into lines.  This makes `git-gr=
ep -P`
> behave differently from `git-grep -E` and also from `grep -P` and `pc=
regrep`:
>=20
> 	$ cat file
> 	a
> 	 b
> 	$ git --no-pager grep --no-index -P '^ ' file
> 	$ git --no-pager grep --no-index -E '^ ' file
> 	file: b
> 	$ grep -c -P '^ ' file
> 	 b
> 	$ pcregrep -c '^ ' file
> 	 b
>=20

Original report:
http://permalink.gmane.org/gmane.comp.version-control.git/190830

> Reported-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>  grep.c          |    2 +-
>  t/t7810-grep.sh |   23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletions(-)
>=20
> diff --git a/grep.c b/grep.c
> index 3821400..f492d26 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -79,7 +79,7 @@ static void compile_pcre_regexp(struct grep_pat *p,=
 const struct grep_opt *opt)
>  {
>  	const char *error;
>  	int erroffset;
> -	int options =3D 0;
> +	int options =3D PCRE_MULTILINE;
> =20
>  	if (opt->ignore_case)
>  		options |=3D PCRE_CASELESS;
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 75f4716..dd6e6d5 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -47,6 +47,13 @@ test_expect_success setup '
>  	echo vvv >t/v &&
>  	mkdir t/a &&
>  	echo vvv >t/a/v &&
> +	{
> +		echo "line without leading space1"
> +		echo " line with leading space1"
> +		echo " line with leading space2"
> +		echo " line with leading space3"
> +		echo "line without leading space2"
> +	} >space &&
>  	git add . &&
>  	test_tick &&
>  	git commit -m initial
> @@ -893,4 +900,20 @@ test_expect_success 'mimic ack-grep --group' '
>  	test_cmp expected actual
>  '
> =20
> +cat >expected <<EOF
> +space: line with leading space1
> +space: line with leading space2
> +space: line with leading space3
> +EOF
> +
> +test_expect_success 'grep -E "^ "' '
> +	git grep -E "^ " space >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success "grep -P '^ '" '
> +	git grep -P "^ " space >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
