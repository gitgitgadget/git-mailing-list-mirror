From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 11:12:36 +0200
Message-ID: <20120413091236.GC2164@goldbirke>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 11:13:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIcZ9-0002Vu-Jf
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 11:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933132Ab2DMJNK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 05:13:10 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:60923 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932720Ab2DMJNI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 05:13:08 -0400
Received: from localhost6.localdomain6 (p5B130584.dip0.t-ipconnect.de [91.19.5.132])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MOzJP-1SL6jT3VqR-006DSL; Fri, 13 Apr 2012 11:12:37 +0200
Content-Disposition: inline
In-Reply-To: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:0tTdLY/YUYd8hCGm6LJeU0tC8E1/IPG+gt2Erqm+gk0
 hhDpxa1itX/qH5a2SL+kCyqysxq2Z4yFapLEGow2SYaIauQy2M
 tIPFAMgGk3xtkxzR63ZFpxiGk9Qg9E3/hOzKgmFo0G4eC+iTo2
 ivvmB4E7iZEzZYMznOEh/RgQg0VA8Pqd+FsBF0gsddz/syF3iR
 NRUK4+8pdsXnzIvGQewjCqGpbWuzUuAeT1TABg0U6VY2yK2wUA
 /wvkjG/C/P3GxUPSGVRd9VG9pVJExV6bNU1F+R3LYEIH/fu7il
 6hBCEBLjU5pFVXGBRchuC394UykQD6WoBaudGyKQZBDQFHbg82
 tn3CrrdetpXJWCAEI5QI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195405>

Hi,


On Thu, Apr 12, 2012 at 12:57:03AM +0300, Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>=20
> Since v1:
>=20
>  * Check if we are running bash in posix mode
>  * Don't check for all git porcelain commands
>=20
>  t/t9902-completion.sh |  115 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100755 t/t9902-completion.sh
>=20
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> new file mode 100755
> index 0000000..cbda6b5
> --- /dev/null
> +++ b/t/t9902-completion.sh
> @@ -0,0 +1,115 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Felipe Contreras
> +#
> +
> +if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
> +	# we are in full-on bash mode
> +	true
> +elif type bash >/dev/null 2>&1; then
> +	# execute in full-on bash mode
> +	unset POSIXLY_CORRECT
> +	exec bash "$0" "$@"
> +else
> +	echo '1..0 #SKIP skipping bash completion tests; bash not available=
'
> +	exit 0
> +fi
> +
> +test_description=3D'test bash completion'
> +
> +. ./test-lib.sh
> +
> +complete ()
> +{
> +	# do nothing
> +	return 0
> +}
> +
> +. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
> +
> +_get_comp_words_by_ref ()
> +{
> +	while [ $# -gt 0 ]; do
> +		case "$1" in
> +		cur)
> +			cur=3D${_words[_cword]}
> +			;;
> +		prev)
> +			prev=3D${_words[_cword-1]}
> +			;;
> +		words)
> +			words=3D("${_words[@]}")
> +			;;
> +		cword)
> +			cword=3D$_cword
> +			;;
> +		esac
> +		shift
> +	done
> +}

Git's completion script already implements this function.  Why
override it here?

> +print_comp ()
> +{
> +	local IFS=3D$'\n'
> +	echo "${COMPREPLY[*]}" > out
> +}
> +
> +run_completion ()
> +{
> +	local -a COMPREPLY _words
> +	local _cword
> +	_words=3D( $1 )
> +	(( _cword =3D ${#_words[@]} - 1 ))
> +	_git && print_comp
> +}
> +
> +test_completion ()
> +{
> +	test $# -gt 1 && echo "$2" > expected
> +	run_completion "$@" &&
> +	test_cmp expected out
> +}
> +
> +test_expect_success 'basic' '
> +	run_completion "git \"\"" &&
> +	# built-in
> +	grep -q "^add \$" out &&
> +	# script
> +	grep -q "^filter-branch \$" out &&
> +	# plumbing
> +	! grep -q "^ls-files \$" out

The && is missing here at the end of the line.

> +	run_completion "git f" &&
> +	! grep -q -v "^f" out

grep is not a git command, so I'm not sure, but shouldn't these use
'test_must_fail grep' instead of '! grep'?


Anyway, thanks for pushing this forward.  I have a bunch of tests for
my __git_ps1() optimizations, but, being a bash function, I could
never figure out how to integrate it with the test framework.


Best,
G=E1bor
