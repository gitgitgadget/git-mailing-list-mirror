From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] dir.c: don't exclude whole dir prematurely if neg pattern may match
Date: Mon, 14 Sep 2015 10:15:11 -0700
Message-ID: <xmqqd1xkylb4.fsf@gitster.mtv.corp.google.com>
References: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
	<1442107141-24265-1-git-send-email-pclouds@gmail.com>
	<1442107141-24265-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:15:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXLc-0006Sw-Nd
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbbINRPO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2015 13:15:14 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33390 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbbINRPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:15:13 -0400
Received: by pacex6 with SMTP id ex6so149578723pac.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=e/OGjfvpvNdqCG42alv2gLKkDnXoUWXgJALRXDDlGpo=;
        b=WAJ+MnTuyfjM/H53SQ6zeqft9pxYHtnWaAP2qEX0/tm7j1g2Fg8kl+g9m57yMf3dEe
         /gy9VUvmHeI26KUyREJ8rl4nNHeSPqTRzAG3K66fZQd7akXICwix1y0TlveDiZ4CRUQf
         mUv8E+EP+ysLy/EXczztOHOw725NGSnGuLQUqc2S7OIv+r5PFwz3F49MHDKF0g1H4jrH
         WDMSrjlmSJi4W/o1mfPOY+/r0B7+ZP8Mx4sK9oQP6XsscgXwH7vQ2sRD4uvQVdYT2y+r
         R0Jf7NooSkLgz9vwRX2MhnHf13VuGa9w2pBKtRPQVvkiAs8OOSqIbSpLzGmMqUnwCidt
         igXw==
X-Received: by 10.68.69.70 with SMTP id c6mr37104897pbu.28.1442250912893;
        Mon, 14 Sep 2015 10:15:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id rz9sm17262336pbb.61.2015.09.14.10.15.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 10:15:12 -0700 (PDT)
In-Reply-To: <1442107141-24265-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 13
 Sep 2015 08:19:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277843>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.tx=
t
> index 473623d..889a72a 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -82,12 +82,9 @@ PATTERN FORMAT
> =20
>   - An optional prefix "`!`" which negates the pattern; any
>     matching file excluded by a previous pattern will become
> +   included again. It is possible to re-include a file if a parent
> +   directory of that file is excluded, with restrictions. See sectio=
n
> +   NOTES for detail.

Sounds like a very useful thing.

>   - If the pattern ends with a slash, it is removed for the
>     purpose of the following description, but it would only find
> @@ -141,6 +138,18 @@ not tracked by Git remain untracked.
>  To stop tracking a file that is currently tracked, use
>  'git rm --cached'.
> =20
> +To re-include a file when its parent directory is excluded, the
> +following conditions must be met:
> +
> + - The directory part in the re-include rules must be literal (i.e. =
no
> +   wildcards)
> +
> + - The rules to exclude the parent directory must not end with a
> +   trailing slash.
> +
> + - The rules to exclude the parent directory must have at least one
> +   slash.
> +

In this bulletted list, don't the readers also need to be told that
having "/abc" in .gitignore (but not "!/abc/anything" in .gitignore)
and "!foo" in abc/.gitignore would not cause us to descend into
"/abc" just to examine "abc/.gitignore" with pessimistic assumption
that there might be some exclusion in there?

> diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-ot=
hers-exclude.sh
> index 3fc484e..9de49a6 100755
> --- a/t/t3001-ls-files-others-exclude.sh
> +++ b/t/t3001-ls-files-others-exclude.sh
> @@ -305,4 +305,24 @@ test_expect_success 'ls-files with "**" patterns=
 and no slashes' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'negative patterns' '
> +	git init reinclude &&
> +	(
> +		cd reinclude &&
> +		cat >.gitignore <<-\EOF &&
> +		/foo
> +		!foo/bar/bar
> +		EOF
> +		mkdir -p foo/bar &&
> +		touch abc foo/def foo/bar/ghi foo/bar/bar &&
> +		git ls-files -o --exclude-standard >../actual &&
> +		cat >../expected <<-\EOF &&
> +		.gitignore
> +		abc
> +		foo/bar/bar
> +		EOF
> +		test_cmp ../expected ../actual
> +	)
> +'

And another test here may want to explicitly ensure that we are not
overly pessimising the ignore processing, so that later changes will
not break it, I think.  Or do we already have such a case covered by
an existing test?

Thanks.
