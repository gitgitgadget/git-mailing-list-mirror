From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Test suite
Date: Thu, 12 May 2005 21:29:41 +0200
Message-ID: <20050512192941.GC324@pasky.ji.cz>
References: <118833cc05050911255e601fc@mail.gmail.com> <7vr7gewuxt.fsf@assigned-by-dhcp.cox.net> <20050510230357.GF26384@pasky.ji.cz> <7vsm0us5p5.fsf@assigned-by-dhcp.cox.net> <118833cc050511113122e2d17d@mail.gmail.com> <7vpsvxqwab.fsf@assigned-by-dhcp.cox.net> <7vd5rxquo5.fsf@assigned-by-dhcp.cox.net> <20050511224044.GI22686@pasky.ji.cz> <7vu0l9nwgx.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 21:22:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWJG4-00042I-Rr
	for gcvg-git@gmane.org; Thu, 12 May 2005 21:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVELT3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 15:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVELT3x
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 15:29:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:21977 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261420AbVELT3n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 15:29:43 -0400
Received: (qmail 8798 invoked by uid 2001); 12 May 2005 19:29:41 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0l9nwgx.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 02:01:34AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Commit    1da683e1247046796a094c4917bc0c4591530272
> Author    Junio C Hamano <junkio@cox.net>, Wed May 11 16:59:35 2005 -0700
> Committer Junio C Hamano <junkio@cox.net>, Wed May 11 16:59:35 2005 -0700
> 
> Test suite: infrastructure and examples.
> 
> This adds the test suite infrastructure with two example tests.
> The current git-checkout-cache the example tests would fail this
> test and will be corrected in a separate patch.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Admittely, I'm not happy with this. From the design standpoint it looks
mostly fine now, but the code is rather crude. I wanted to go over it at
first and fix the obvious stuff, but it appeared to be overall quite
broken, so I decided to return it to you for another iteration. I don't
mind if you just fix the broken code for now, we can fix the semantics
and design stuff later - what is in the patch is already good enough for
the start.

I'll drop the testcases from your other patches for now so that we don't
get long stalls.

> --- /dev/null
> +++ b/t/test-lib.sh
> +# For repeatability, reset the environment to known value.
> +export LANG C
> +export TZ UTC

Dunno about *your* shell but this just exports variables $LANG, $C, $TZ
and $UTC here. You probably wanted assignments there?

> +# Each test should start with something like this, after copyright notices:
> +#
> +# . ./testlib.sh

test-lib.sh

> +# test_description "$@" 'Description of this test...
> +# This test checks if command xyzzy does the right thing...
> +# '

I think this usage is pretty weird. Why not just

test_description='Description, blah blah.'
. ./testlib.sh

I think it would be quite less confusing than test_description, which
actually does effectively something different anyway.

> +
> +test_description () {
> +	while case "$#" in 0) break;; esac

Duh. This looks mysterious - why not a simple test?

> +	do
> +		case "$1" in
> +		-d|--d|--de|--deb|--debu|--debug)
> +			debug=t; shift ;;
> +		-h|--h|--he|--hel|--help)
> +			eval echo '"$'$#'"'
> +			exit 0
> +			;;
> +		*)
> +			break ;;

This branch makes no sense, I think.

> +		esac
> +	done
> +	test_failure=0
> +}
> +
> +say () {
> +	echo "* $*"
> +}
> +
> +test_debug () {
> +	case "$debug" in '') ;; ?*) eval "$*" ;; esac

Again, why not a simple test?

[ "$debug" ] && eval "$*"

(Actually, eval will do the wrong thing here - it just concatenates the
arguments. Just "$@" would do, I guess.)

> +}
> +
> +test_ok () {
> +	echo "* $*";
> +}
> +
> +test_failure () {
> +	echo "* $*";
> +	test_failure=1;
> +}
> +
> +test_expect_failure () {
> +	say "expecting failure: $1"
> +	eval "$1"
> +	case $? in
> +	0)	test_failure "did not fail as expected" ;;
> +	*) 	test_ok "failed as expected" ;;
> +	esac
> +}
> +
> +test_expect_success () {
> +	say "expecting success: $1"
> +	eval "$1"
> +	case $? in
> +	0) 	test_ok "succeeded as expected" ;;
> +	*)	test_failure "did not succeed as expected" ;;
> +	esac
> +}
> +
> +test_done () {
> +	case "$test_failure" in
> +	0)	exit 0 ;;

Please clean up after yourself in this case.

> +	'')	echo "*** test script did not start with test_description";
> +		exit 2 ;;
> +	*)	exit 1 ;;
> +	esac
> +}
> +
> +# Test the binaries we have just built.  The tests are kept in
> +# t/ subdirectory and are run in test-repo subdirectory.
> +PATH=$(pwd)/..:$PATH
> +
> +# Test repository
> +test=test-repo
> +rm -fr "$test"
> +mkdir "$test"
> +cd "$test"
> +git-init-db 2>/dev/null || error "cannot run git-init-db"

But there's no 'error' thing.

> --- /dev/null
> +++ b/t/t1000-checkout-cache.sh
> +git-update-cache --add path0 path1/file1

You should make sure even those preparations calls actually succeed.

> --- /dev/null
> +++ b/t/t1001-checkout-cache.sh
> +git-update-cache --add path0/file0
> +tree1=$(git-write-tree)

Here too.


The testcases currently utterly fail, which is not good sign - either
they are ahead of the current code, or they are broken. This is the main
hurdle making me not accept it yet - it does not work for me. If you fix
this and the nits above, it can go in, I think.


* expecting failure: git-checkout-cache -a
checkout-cache: path0 already exists
error: checkout-cache: unable to create file path1/file1 (Not a directory)
* did not fail as expected
* expecting success: git-checkout-cache -f -a
error: checkout-cache: unable to create file path0 (Is a directory)
* succeeded as expected
* checkout failed

I consider this output... well, totally confusing. checkout-cache fails
but testcase thinks it does not, then it fails again but testcase thinks
it succeeded as expected but dies anyway.

I think it's too messy. I would much more appreciate output like this:

* checkout-cache test [1/3]: git-checkout-cache -a... passed
* checkout-cache test [2/3]: git-checkout-cache -f -a... NOT PASSED
Expected success, but the command failed. Output:
error: checkout-cache: unable to create file path0 (Is a directory)
* checkout-cache test [3/3]: git-checkout-cache foobar... NOT PASSED
Expected failure, but the command succeeded.

Much less cluttered, it is clear what went wrong etc.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
