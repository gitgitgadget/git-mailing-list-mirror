From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC]  test-lib.sh: preprocess to use PERL_PATH
Date: Sat, 23 Jun 2012 15:11:31 +0200
Message-ID: <4FE5C083.8010903@web.de>
References: <201206230704.38648.tboegi@web.de> <7vsjdmli06.fsf@alter.siamese.dyndns.org> <4FE55372.3080008@web.de> <7vipeilfe9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 15:11:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiQ7x-0001F1-4r
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 15:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab2FWNLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jun 2012 09:11:42 -0400
Received: from mout.web.de ([212.227.17.12]:62885 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab2FWNLl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 09:11:41 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MZDKy-1SRrkF3NT2-00LOeM; Sat, 23 Jun 2012 15:11:32 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7vipeilfe9.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:XriYVjS5ZHXsj0XU+ljI6M3ROm6MgIBFF0EwfoKDBDm
 XNk0kaXxdJdEXC/wGxIo74rOLPshc6e0znjjmev8uNhjq0to+d
 nQvA01R0UghxmZpnDLm+4SfrGbHMVuwpWNntq/bY3i2Mb2a/jk
 xohdz038gsiHX1R5LBAxPA2YUYa+JG+sPlcZJMlX7ImWpZA+KG
 qy1az9KH9vHOtGJpyhxKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200500>

On 23.06.12 08:18, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> On 23.06.12 07:22, Junio C Hamano wrote:
>>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>>
>>>> All test cases found in t/*.sh must include test-lib instead of te=
st-lib.sh
>>> Please don't.  That is too much churning for too little gain, I am =
afraid.
>> Ok, would it be better to rename
>>
>> t/test-lib.sh -> t/test-lib.sh.sh
>>
>> and let the Makefile generate t/test-lib.sh?
> It isn't as bad as the patch posted, but not very much.
>
> There are number of a lot lower impact options before you
> contemplate such a large change, given that there is only one
> invocation of bare "perl" before GIT-BUILD-OPTIONS is dot-sourced.
>
>  (1) Perhaps that use does not have any portability issues, and we
>      can leave it as-is, with a comment to forbid people from
>      turning into "$PERL_PATH" and be done with it?
>
>  (2) Perhaps that use can be rewritten in such a way that it does
>      not have to be done with perl in the first place?
>
>  (3) Perhaps what that use of perl does can be delayed until we
>      dot-source GIT-BUILD-OPTIONS and have $PERL_PATH defined, in
>      which case we can move that use to a later position (and we can
>      turn that sole use of perl into "$PERL_PATH")?
>
>  (3) Perhaps what test-lib.sh does before it dot-sources
>      GIT-BUILD-OPTIONS does not be affected if we dot-sourced
>      GIT-BUILD-OPTIONS a lot earlier (and we can turn that sole use
>      of perl into "$PERL_PATH")?
>
>
> For example (this is not tested at all, nor I did not think it
> through), a patch that moves the definition of TEST_DIRECTORY which
> GIT_BUILD_DIR depends on higher, so that we can dot-source the file
> a lot earlier, may look like this.
>
>
>  t/test-lib.sh | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9e2b711..f3e7cf9 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -34,6 +34,26 @@ esac
>  # Keep the original TERM for say_color
>  ORIGINAL_TERM=3D$TERM
> =20
> +# Test the binaries we have just built.  The tests are kept in
> +# t/ subdirectory and are run in 'trash directory' subdirectory.
> +if test -z "$TEST_DIRECTORY"
> +then
> +	# We allow tests to override this, in case they want to run tests
> +	# outside of t/, e.g. for running tests on the test library
> +	# itself.
> +	TEST_DIRECTORY=3D$(pwd)
> +fi
> +if test -z "$TEST_OUTPUT_DIRECTORY"
> +then
> +	# Similarly, override this to store the test-results subdir
> +	# elsewhere
> +	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
> +fi
> +GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
> +
> +. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> +export PERL_PATH SHELL_PATH
> +
>  # For repeatability, reset the environment to known value.
>  LANG=3DC
>  LC_ALL=3DC
> @@ -46,7 +66,7 @@ EDITOR=3D:
>  # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
>  # deriving from the command substitution clustered with the other
>  # ones.
> -unset VISUAL EMAIL LANGUAGE COLUMNS $(perl -e '
> +unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
>  	my @env =3D keys %ENV;
>  	my $ok =3D join("|", qw(
>  		TRACE
> @@ -229,7 +249,7 @@ trap 'die' EXIT
> =20
>  # The user-facing functions are loaded from a separate file so that
>  # test_perf subshells can have them too
> -. "${TEST_DIRECTORY:-.}"/test-lib-functions.sh
> +. "$TEST_DIRECTORY/test-lib-functions.sh"
> =20
>  # You are not expected to call test_ok_ and test_failure_ directly, =
use
>  # the text_expect_* functions instead.
> @@ -380,23 +400,6 @@ test_done () {
>  	esac
>  }
> =20
> -# Test the binaries we have just built.  The tests are kept in
> -# t/ subdirectory and are run in 'trash directory' subdirectory.
> -if test -z "$TEST_DIRECTORY"
> -then
> -	# We allow tests to override this, in case they want to run tests
> -	# outside of t/, e.g. for running tests on the test library
> -	# itself.
> -	TEST_DIRECTORY=3D$(pwd)
> -fi
> -if test -z "$TEST_OUTPUT_DIRECTORY"
> -then
> -	# Similarly, override this to store the test-results subdir
> -	# elsewhere
> -	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
> -fi
> -GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
> -
>  if test -n "$valgrind"
>  then
>  	make_symlink () {
> @@ -492,8 +495,6 @@ GIT_CONFIG_NOSYSTEM=3D1
>  GIT_ATTR_NOSYSTEM=3D1
>  export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_A=
TTR_NOSYSTEM
> =20
> -. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> -
>  if test -z "$GIT_TEST_CMP"
>  then
>  	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
Excellent!
Thanks: enjoyed & tested OK both on

457f08c4777b552ad35 (where t4030 was broken when testing here)

and

>commit 9746b046e5651aa7277a0b853819e2d076d403c6
>Date:   Fri Jun 22 22:20:27 2012 -0700
