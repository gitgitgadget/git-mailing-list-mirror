From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Add support for a 'pre-push' hook
Date: Fri, 16 Nov 2012 21:25:41 +0100
Message-ID: <vpq625547ne.fsf@grenoble-inp.fr>
References: <CAJwKrPYwCE4ExmK09PURMfjYezn6vdCH_BBXU4WCwrnotyV9CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Aske Olsson <askeolsson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 21:26:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZSUJ-0000bR-CZ
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 21:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab2KPUZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 15:25:48 -0500
Received: from mx1.imag.fr ([129.88.30.5]:34707 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478Ab2KPUZr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 15:25:47 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qAGKI0e2023032
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Nov 2012 21:18:00 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TZSTt-0004mQ-MC; Fri, 16 Nov 2012 21:25:41 +0100
In-Reply-To: <CAJwKrPYwCE4ExmK09PURMfjYezn6vdCH_BBXU4WCwrnotyV9CA@mail.gmail.com>
	(Aske Olsson's message of "Fri, 16 Nov 2012 20:42:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 16 Nov 2012 21:18:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qAGKI0e2023032
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1353701884.1535@qB4pqEjyVeDj0R65PwGDhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209905>

Aske Olsson <askeolsson@gmail.com> writes:

> If the script .git/hooks/pre-push exists and is executable it will be
> called before a `git push` command, and when the script exits with a
> non-zero status the push will be aborted.

That sounds like a sane thing to do.

>  Documentation/git-push.txt |  11 +++-
>  Documentation/githooks.txt |  12 +++++
>  builtin/push.c             |   6 +++
>  t/t5542-pre-push-hook.sh   | 132 +++++++++++++++++++++++++++++++++++++++++++++

It would be nice to provide a sample hook in the default template. See
the template/ directory in Git's source code.

> +--no-verify::
> + This option bypasses the pre-push hook.
> + See also linkgit:githooks[5].
> +
>  -q::
>  --quiet::
>   Suppress all output, including the listing of updated refs,

Here, and below: you seem to have whitespace damage. Somebody replaced
tabs with spaces I guess. Using git send-email helps avoiding this.

> +D=`pwd`

Unused variable, left from previous hacking I guess.

> +# hook that always succeeds
> +mk_hook_exec () {
> +cat > "$HOOK" <<EOF
> +#!/bin/sh
> +exit 0
> +EOF
> +chmod +x "$HOOK"
> +}
> +
> +# hook that fails
> +mk_hook_fail () {
> +cat > "$HOOK" <<EOF
> +#!/bin/sh
> +exit 1
> +EOF
> +chmod +x "$HOOK"
> +}

I'd add a "touch hook-ran" in the script, a "rm -f hook-ran" before
launching git-push, and test the file existance after the hook to make
sure it was ran.

> +test_expect_success 'push with no pre-push hook' '
> + mk_repo_pair &&
> + (
> + cd master &&
> + echo one >foo && git add foo && git commit -m one &&
> + git push --mirror up
> + )
> +'
> +
> +test_expect_success 'push --no-verify with no pre-push hook' '
> + mk_repo_pair &&

I don't think you need to re-create the repos for each tests. Tests are
good, but they're better when they're fast so avoiding useless
operations is good.

We try to write tests so that one test failure does not imply failures
of the next tests (i.e. stopping in the middle should not not leave
garbage that would prevent the next test from running), but do not
necessarily write 100% self-contained tests.

> + echo one >foo && git add foo && git commit -m one &&

test_commit ?

> +test_expect_success 'push with failing pre-push hook' '
> + mk_repo_pair &&
> + (
> + mk_hook_fail &&
> + cd master &&
> + echo one >foo && git add foo && git commit -m one &&
> + test_must_fail git push --mirror up
> + )
> +'

It would be cool to actually check that the push was not performed
(verify that the target repo is still pointing to the old revision).
Otherwise, an implementation that would call run_hook after pushing
would pass the tests.

> +test_expect_success 'push with non-executable pre-push hook' '
> + mk_repo_pair &&
> + (
> + mk_hook_no_exec &&
> + cd master &&
> + echo one >foo && git add foo && git commit -m one &&
> + git push --mirror up
> + )
> +'
> +
> +test_expect_success 'push --no-verify with non-executable pre-push hook' '
> + mk_repo_pair &&
> + (
> + mk_hook_no_exec &&
> + cd master &&
> + echo one >foo && git add foo && git commit -m one &&
> + git push --no-verify --mirror up
> + )
> +'

These two tests are not testing much. The hook is not executable, so it
shouldn't be ran, but you do not check whether the hook is ran or not.
At least make the "exit 0" an "exit 1" in the hook.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
