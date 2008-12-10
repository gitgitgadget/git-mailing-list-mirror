From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-sh-setup: Fix scripts whose PWD is a symlink into
 a git work-dir
Date: Wed, 10 Dec 2008 12:18:15 -0800
Message-ID: <7viqprzsvs.fsf@gitster.siamese.dyndns.org>
References: <7viqq1hghw.fsf@gitster.siamese.dyndns.org>
 <1228921454-22416-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, ae@op5.se,
	j.sixt@viscovery.net
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:19:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAVXC-0002gl-I5
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYLJUSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 15:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbYLJUSc
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 15:18:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbYLJUSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 15:18:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7657118929;
	Wed, 10 Dec 2008 15:18:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B0120188BB; Wed,
 10 Dec 2008 15:18:16 -0500 (EST)
In-Reply-To: <1228921454-22416-1-git-send-email-marcel@oak.homeunix.org>
 (Marcel M. Cary's message of "Wed, 10 Dec 2008 07:04:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B577A5D0-C6F7-11DD-BD1E-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102714>

"Marcel M. Cary" <marcel@oak.homeunix.org> writes:

> * When interpretting a relative upward (../) path in cd_to_toplevel,
>   prepend the cwd without symlinks, given by /bin/pwd
> * Add tests for cd_to_toplevel and "git pull" in a symlinked
>   directory that failed before this fix, plus constrasting
>   scenarios that already worked

These are descriptions of changes (and good ones at that, but
"constrasting?").

It however is a good idea to describe the problem the patch tries to solve
*before* going into details of what you did.  "If A is B, operation C
tries to incorrectly access directory D; it should use directory E.  This
breakage is because F is confused by G..."

Yes, the "Subject:" already hints about the "If A is B" part, and the
second bullet point uses the word "failed" to hint that there was a
breakage, but that will not be sufficient description to recall the
analysis you did of the problem, when you have read the commit log message
6 months from now what the breakage was about.

In order to justify the change against "Doctor if A is B, it hurts ---
don't do it then" rebuttals, it further may make sense to defend why it is
sometimes useful to be able to satisify the precondition that triggers the
existing problem.  That would come before the problem description to
prepare readers with the context of the patch.

> diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
> new file mode 100755
> index 0000000..293dc35
> --- /dev/null
> +++ b/t/t2300-cd-to-toplevel.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description='cd_to_toplevel'
> +
> +. ./test-lib.sh
> +
> +test_cd_to_toplevel () {
> +	test_expect_success "$2" '
> +		(
> +			cd '"'$1'"' &&
> +			. git-sh-setup &&
> +			cd_to_toplevel &&
> +			[ "$(pwd -P)" = "$TOPLEVEL" ]
> +		)
> +	'
> +}
> +
> +TOPLEVEL="$(pwd -P)/repo"

Hmm.  Does it make sense to assume everybody's pwd can take -P when the
primary change this patch introduces carefully avoids assuming the
availability of -P for "cd"?

> +ln -s repo symrepo
> +test_cd_to_toplevel symrepo 'at symbolic root'
> +
> +ln -s repo/sub/dir subdir-link
> +test_cd_to_toplevel subdir-link 'at symbolic subdir'
> +
> +cd repo
> +ln -s sub/dir internal-link
> +test_cd_to_toplevel internal-link 'at internal symbolic subdir'

To be very honest, although it is good that you made them work, I am still
not getting why the latter two scenarios are worth supporting.  The first
one I am Ok with, though.

> diff --git a/t/t5521-pull-symlink.sh b/t/t5521-pull-symlink.sh
> new file mode 100755
> index 0000000..f18fec7
> --- /dev/null
> +++ b/t/t5521-pull-symlink.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +
> +test_description='pulling from symlinked subdir'
> +
> +. ./test-lib.sh
> +
> +D=`pwd`
> +
> +# The scenario we are building:
> +#
> +#   trash\ directory/
> +#     clone-repo/
> +#       subdir/
> +#         bar
> +#     subdir-link -> clone-repo/subdir/
> +#
> +# The working directory is subdir-link.
> +#

It is great to see the scenario explained like this.  It makes it easier
to follow what the tests are trying to do.

> +test_expect_success setup '
> +
> +    mkdir subdir &&
> +    touch subdir/bar &&
> +    git add subdir/bar &&
> +    git commit -m empty &&
> +    git clone . clone-repo &&
> +    # demonstrate that things work without the symlink
> +    test_debug "cd clone-repo/subdir/ && git pull; cd ../.." &&
> +    ln -s clone-repo/subdir/ subdir-link &&
> +    cd subdir-link/ &&
> +    test_debug "set +x"
> +'
> +
> +# From subdir-link, pulling should work as it does from
> +# clone-repo/subdir/.
> +#
> +# Instead, the error pull gave was:
> +#
> +#   fatal: 'origin': unable to chdir or not a git archive
> +#   fatal: The remote end hung up unexpectedly
> +#
> +# because git would find the .git/config for the "trash directory"
> +# repo, not for the clone-repo repo.  The "trash directory" repo
> +# had no entry for origin.  Git found the wrong .git because
> +# git rev-parse --show-cdup printed a path relative to
> +# clone-repo/subdir/, not subdir-link/.  Git rev-parse --show-cdup
> +# used the correct .git, but when the git pull shell script did
> +# "cd `git rev-parse --show-cdup`", it ended up in the wrong
> +# directory.  Shell "cd" works a little different from chdir() in C.
> +# Bash's "cd -P" works like chdir() in C.

This is a very good analysis.  s/Bash's "cd -P"/"cd -P" in POSIX shells/,
though.

> +#
> +test_expect_success 'pulling from symlinked subdir' '
> +
> +    git pull
> +'

I'd prefer to see each test_expect_success be able to fail independently,
which would mean (1) when you chdir around, do so in a subshell, and (2)
each test_expect_success assumes it begins in the same directory.

In the case of these tests, I think it is just the matter of moving the
last two lines from the previous test to the beginning of this test and
enclosing this test in (), right?

> +
> +# Prove that the remote end really is a repo, and other commands
> +# work fine in this context.
> +#
> +test_debug "
> +    test_expect_success 'pushing from symlinked subdir' '
> +
> +        git push
> +    '
> +"

Why should this be hidden inside test_debug?
