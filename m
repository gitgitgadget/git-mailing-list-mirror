From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH/RFC v2] grep: Add --[no-]recurse options.
Date: Sun, 12 Jul 2009 11:39:50 +0200
Message-ID: <4A59AF66.8030105@lsrfire.ath.cx>
References: <1247347208-2624-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 11:40:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPvXa-0006kv-SU
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 11:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbZGLJkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2009 05:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbZGLJkG
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 05:40:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:57989 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbZGLJkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 05:40:04 -0400
Received: from [10.0.1.101] (p57B7E8EB.dip.t-dialin.net [87.183.232.235])
	by india601.server4you.de (Postfix) with ESMTPSA id 9D48D2F803F;
	Sun, 12 Jul 2009 11:40:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <1247347208-2624-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123138>

Micha=C5=82 Kiedrowicz schrieb:
> Sometimes it is useful to grep directories non-recursive. E.g. if I w=
ant
> to look for all files in main directory, but not in any subdirectory.
> Or in Documentation/, but not in Documentation/technical/ and so on.
>=20
> This patch adds support for --no-recurse and (for symmetry) --recurse
> options to git-grep. If --no-recurse is set, git-grep does not descen=
d
> to subdirectories. When --recurse option is set, directories are
> searched recursively (this is the default behavior).
>=20
> If path specified on command line contains wildcards, option --no-rec=
urse
> makes no sense, i.e.
>=20
> $ git grep -l --no-recurse GNU -- 'contrib/*'
>=20
> (note the quotes) will search all files in contrib/, even in
> subdirectories, because '*' matches all files.
>
> Documentation updates, bash-completion and simple test cases are also
> provided.
>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>=20
> Changes from previous version:
>  * Renamed '--directories=3Daction' to '--[no-]recurse', because my
>    implementation is not compatible with GNU. Also parsing this optio=
n was
>    simplified.

OK.  Yet another idea: if we can't copy an option from grep, perhaps we
can steal it from another program?  Would find's -maxdepth option fit
the bill?  I imagine it git grep --max-depth=3D<n> counting the slashes=
 in
path specs and files and rejecting those files whose count is higher
than the one of its (otherwise matching) pattern plus n.

> diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
> index b13aa7e..0633673 100755
> --- a/t/t7002-grep.sh
> +++ b/t/t7002-grep.sh
> @@ -31,7 +31,9 @@ test_expect_success setup '
>  	echo zzz > z &&
>  	mkdir t &&
>  	echo test >t/t &&
> -	git add file w x y z t/t hello.c &&
> +	mkdir t/a &&
> +	echo aa aa aa aa >t/a/a &&
> +	git add file w x y z t/t t/a/a hello.c &&
>  	test_tick &&
>  	git commit -m initial
>  '
> @@ -132,6 +134,36 @@ do
>  		! git grep -c test $H | grep /dev/null
>          '
> =20
> +	test_expect_success "grep --recurse $L" '
> +		echo "${HC}t/t:1:test" >expected &&
> +		git grep --recurse -n -e test $H >actual &&
> +		diff expected actual
> +	'

Use test_cmp instead of diff.

> +
> +	test_expect_success "grep --no-recurse $L" '
> +		: >expected &&
> +		if git grep --no-recurse -e test $H >actual
> +		then
> +			echo should not have matched
> +			cat actual
> +			false
> +		else
> +			diff expected actual
> +		fi
> +	'

Hmm, if git crashed and only wrote to stderr, this test would pass
(hint: try this with git's master, that doesn't know this option).
Better to devise a test in which the tested command still has to print
something (a restricted set of results in this case).

> +
> +	test_expect_success "grep --no-recurse $L -- t" '
> +		: >expected &&
> +		if git grep --no-recurse -e aa $H -- t >actual
> +		then
> +			echo should not have matched
> +			cat actual
> +			false
> +		else
> +			diff expected actual
> +		fi
> +	'

Same here.
