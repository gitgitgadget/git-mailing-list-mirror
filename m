From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 01/25] t/test-lib: introduce --chain-lint option
Date: Wed, 25 Mar 2015 03:53:52 +0100
Message-ID: <20150325035352.Horde.wlh5PImm_EGVzNTHeSEb7g1@webmail.informatik.kit.edu>
References: <20150320100429.GA17354@peff.net>
 <20150320100548.GA12543@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:54:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YabSL-0001dG-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 03:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbbCYCyF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 22:54:05 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:45511 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752055AbbCYCyD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 22:54:03 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YabSD-0005pT-Ab; Wed, 25 Mar 2015 03:54:01 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YabS4-0006qM-Ke; Wed, 25 Mar 2015 03:53:52 +0100
Received: from x590d0966.dyn.telefonica.de (x590d0966.dyn.telefonica.de
 [89.13.9.102]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 25 Mar 2015 03:53:52 +0100
In-Reply-To: <20150320100548.GA12543@peff.net>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1427252041.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266250>


Quoting Jeff King <peff@peff.net>:

> However, there are a number of places it cannot reach:
>
>  - it cannot find a failure to break out of loops on error,
>    like:
>
>      cmd1 &&
>      for i in a b c; do
> 	     cmd2 $i
>      done &&
>      cmd3
>
>    which will not notice failures of "cmd2 a" or "cmd b"

s/cmd b/cmd2 b/ ?

>  - it cannot find a missing &&-chain inside a block or
>    subfunction, like:
>
>      foo () {
> 	     cmd1
> 	     cmd2
>      }
>
>      foo &&
>      bar
>
>    which will not notice a failure of cmd1.

And inside subshells.  I think it's worth mentioning, too, because
subshells are used frequently when setting environment variables

   ( GIT_FOO=3Dbar && export GIT_FOO && cmd1 && ... ) && test_cmp

or changing directory

   ( cd subdir && cmd1 && ... ) && test_cmp

I was wondering whether we could do better here with helper functions,
something along the lines of:

   # Set and export environment variable, automatically unsetting it af=
ter
   # the test is over
   test_setenv () {
       eval "$1=3D\$2" &&
       export "$1" &&
       # sane_unset, to allow unsetting during the test
       test_when_finished "sane_unset '$1'"
   }

   # Change to given directory, automatically return to current working
   # directory after the test is over
   test_cd () {
       test_when_finished "cd '$PWD'" &&
       cd "$1"
   }

With these the above examples would become

   test_setenv GIT_FOO bar && cmd1 && ... && test_cmp

and

   test_cd subdir && cmd1 && ... && test_cmp

which means increased coverage for --chain-lint.


Thanks for working on this.  I looked into this after seeing Jonathan's
patch back then, got quite far but never reached a chain-lint-clean
state, and only sent patches for the two most amusing breakages
(ddeaf7ef0d, 056f34bbcd).
I'm glad it's off my TODO list and I don't have to rebase a 1.5 year ol=
d
branch to current master :)

G=C3=A1bor

>  - it only checks tests that you run; every platform will
>    have some tests skipped due to missing prequisites,
>    so it's impossible to say from one run that the test
>    suite is free of broken &&-chains. However, all tests get
>    run by _somebody_, so eventually we will notice problems.
>
>  - it does not operate on test_when_finished or prerequisite
>    blocks. It could, but these tends to be much shorter and
>    less of a problem, so I punted on them in this patch.
>
> This patch was inspired by an earlier patch by Jonathan
> Nieder:
>
>   http://article.gmane.org/gmane.comp.version-control.git/235913
>
> This implementation and all bugs are mine.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/README      | 10 ++++++++++
>  t/test-lib.sh | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/t/README b/t/README
> index d5bb0c9..35438bc 100644
> --- a/t/README
> +++ b/t/README
> @@ -168,6 +168,16 @@ appropriately before running "make".
>  	Using this option with a RAM-based filesystem (such as tmpfs)
>  	can massively speed up the test suite.
>
> +--chain-lint::
> +--no-chain-lint::
> +	If --chain-lint is enabled, the test harness will check each
> +	test to make sure that it properly "&&-chains" all commands (so
> +	that a failure in the middle does not go unnoticed by the final
> +	exit code of the test). This check is performed in addition to
> +	running the tests themselves. You may also enable or disable
> +	this feature by setting the GIT_TEST_CHAIN_LINT environment
> +	variable to "1" or "0", respectively.
> +
>  You can also set the GIT_TEST_INSTALLED environment variable to
>  the bindir of an existing git installation to test that installation=
=2E
>  You still need to have built this git sandbox, from which various
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index c096778..50b3d3f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -232,6 +232,12 @@ do
>  	--root=3D*)
>  		root=3D$(expr "z$1" : 'z[^=3D]*=3D\(.*\)')
>  		shift ;;
> +	--chain-lint)
> +		GIT_TEST_CHAIN_LINT=3D1
> +		shift ;;
> +	--no-chain-lint)
> +		GIT_TEST_CHAIN_LINT=3D0
> +		shift ;;
>  	-x)
>  		trace=3Dt
>  		verbose=3Dt
> @@ -524,6 +530,16 @@ test_eval_ () {
>  test_run_ () {
>  	test_cleanup=3D:
>  	expecting_failure=3D$2
> +
> +	if test "${GIT_TEST_CHAIN_LINT:-0}" !=3D 0; then
> +		# 117 is magic because it is unlikely to match the exit
> +		# code of other programs
> +		test_eval_ "(exit 117) && $1"
> +		if test "$?" !=3D 117; then
> +			error "bug in the test script: broken &&-chain: $1"
> +		fi
> +	fi
> +
>  	setup_malloc_check
>  	test_eval_ "$1"
>  	eval_ret=3D$?
> --
> 2.3.3.520.g3cfbb5d
