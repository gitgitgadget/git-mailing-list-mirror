From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: add configuration for making --all default
Date: Fri, 17 Jul 2015 09:08:40 -0700
Message-ID: <xmqqk2ty3gxj.fsf@gitster.dls.corp.google.com>
References: <1437139899-6210-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 18:08:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG8Bu-00011D-0J
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 18:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbbGQQIn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2015 12:08:43 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34995 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbGQQIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 12:08:42 -0400
Received: by pactm7 with SMTP id tm7so63450572pac.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=B7WTOg/MdrzgOB5kY6uqTMBGItufJeGdtxkbg37/5Cg=;
        b=nPtPNalOlCMns40wsUHOoO++gV7ovqo8/g5vVe+R52e1HhgG1coz5ym3MK+kOsIEIQ
         4YPiSO3NTrP68qnPOw84HIvX9EXzvKF1ZYGMEhVkWCAVxu5sDjewb95rvVhXo0x3e3xt
         bMRlpT2YXTjA92wAzJLShpfi0cKFXFg5W7Oz+cbN59AcAyJf1mVGKeSrxo3lwXVKCjA8
         sOC6VzZRUDSbXem5SdCbJLuNZgxcf3EVTUwMAbtZvb67uxhYF2Io+9r2wro6VyrfAUNr
         ZIB+qltaGNMujOCM8qPBuj+84H36HwtsLbb5DXllTFytkkvUNyJi8B5fQYs0NxvmMdCo
         BTkQ==
X-Received: by 10.70.98.200 with SMTP id ek8mr31112490pdb.95.1437149322294;
        Fri, 17 Jul 2015 09:08:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id x7sm11724499pas.28.2015.07.17.09.08.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 09:08:41 -0700 (PDT)
In-Reply-To: <1437139899-6210-1-git-send-email-oystwa@gmail.com>
 (=?utf-8?Q?=22=C3=98ystein?=
	Walle"'s message of "Fri, 17 Jul 2015 15:31:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274078>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Fetching from all remotes by default is useful if you're working on a
> repo with few and/or fast remotes.

That part is sensible.

> It also lets you fetch from origin
> even if the current branch's upstream is elsewhere without specifying=
 it
> explicitly.

I do not think this description is necessary or even beneficial.
The users can already do that with 'fetch --all', so there is
no value added by having a new configuration.

The only thing a new configuration gives the users is a convenience
of not having to say `--all` from the command line.

> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.tx=
t
> index e62d9a0..584f3fb 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -36,7 +36,8 @@ there is a remotes.<group> entry in the configurati=
on file.
>  (See linkgit:git-config[1]).
> =20
>  When no remote is specified, by default the `origin` remote will be =
used,
> -unless there's an upstream branch configured for the current branch.
> +unless there's an upstream branch configured for the current branch,=
 or the
> +`fetch.all` configuration variable is set to true.

This sounds a bit strange.  Other places talk about fetch.all being
the same as giving `--all`, but neither the original description nor
the resulting text with this patch says anything about what would
happen 'when no remote is given but the --all option is given', which
makes it sound as if fetch.all and `--all` behave differently here.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> ...
> @@ -1168,7 +1174,7 @@ int cmd_fetch(int argc, const char **argv, cons=
t char *prefix)
>  		git_config(submodule_config, NULL);
>  	}
> =20
> -	if (all) {
> +	if (all =3D=3D 1) {
>  		if (argc =3D=3D 1)
>  			die(_("fetch --all does not take a repository argument"));
>  		else if (argc > 1)
> @@ -1176,9 +1182,14 @@ int cmd_fetch(int argc, const char **argv, con=
st char *prefix)
>  		(void) for_each_remote(get_one_remote_for_fetch, &list);
>  		result =3D fetch_multiple(&list);
>  	} else if (argc =3D=3D 0) {
> -		/* No arguments -- use default remote */
> -		remote =3D remote_get(NULL);
> -		result =3D fetch_one(remote, argc, argv);
> +		if (fetch_all_config && all !=3D 0) {
> +			(void) for_each_remote(get_one_remote_for_fetch, &list);
> +			result =3D fetch_multiple(&list);

Can't you rearrange if/else cascade around here, so that these two
lines do not have to be duplicated?

> +		} else {
> +			/* No arguments and no --all -- use default remote */
> +			remote =3D remote_get(NULL);
> +			result =3D fetch_one(remote, argc, argv);
> +		}
>  	} else if (multiple) {
>  		/* All arguments are assumed to be remotes or groups */
>  		for (i =3D 0; i < argc; i++)
> diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
> index 4b4b667..4e773ee 100755
> --- a/t/t5514-fetch-multiple.sh
> +++ b/t/t5514-fetch-multiple.sh
> @@ -55,6 +55,18 @@ test_expect_success 'git fetch --all' '
>  	 test_cmp expect output)
>  '
> =20
> +test_expect_success 'git fetch (fetch.all =3D true)' '
> +	(git clone one test9 &&
> +	 cd test9 &&
> +	 git config fetch.all true &&
> +	 git remote add one ../one &&
> +	 git remote add two ../two &&
> +	 git remote add three ../three &&
> +	 git fetch &&
> +	 git branch -r > output &&
> +	 test_cmp ../test/expect output)
> +'
> +
>  test_expect_success 'git fetch --all should continue if a remote has=
 errors' '
>  	(git clone one test2 &&
>  	 cd test2 &&
> @@ -91,6 +103,17 @@ test_expect_success 'git fetch --multiple (but on=
ly one remote)' '
>  	 test_cmp ../expect output)
>  '
> =20
> +test_expect_success 'git fetch one (fetch.all =3D true)' '
> +	(cd test3 &&

This means that this test piece will break if the previous one did
not succeed, which is not a very good idea.

> +	 git config fetch.all true &&
> +	 git fetch three &&
> +	 git branch -r > output &&
> +	 test_cmp ../expect output &&

What future errors will this catch?

You have only "three" and "origin" and the expected output wants to
see tracking from both.  Does the test break when in some future
somebody broke the resulting code after applying this patch in such
a way that "fetch from only 'three'" from the command line gets
ignored and fetch.all went ahead and fetched from everybody?

> +	 git fetch --no-all &&
> +	 git branch -r > output &&
> +	 test_cmp ../expect output)

Same question.

> +'
> +
>  cat > expect << EOF
>    one/master
>    one/side
