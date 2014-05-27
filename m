From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/5] commit test: test_set_editor in each test
Date: Tue, 27 May 2014 18:59:45 -0400
Message-ID: <CAPig+cTc_sSxLm0QGxY40awnr9MD5NoKgc8pH+K67wwV+2p5-Q@mail.gmail.com>
References: <20140525062427.GA94219@sirius.att.net>
	<1401130586-93105-1-git-send-email-caleb@calebthompson.io>
	<1401130586-93105-5-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 00:59:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpQLX-00013O-2D
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 00:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbaE0W7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 18:59:46 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34594 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbaE0W7p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 18:59:45 -0400
Received: by mail-yk0-f181.google.com with SMTP id 131so7732078ykp.12
        for <git@vger.kernel.org>; Tue, 27 May 2014 15:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/NFTriS+6MzNx4WPG+W19LK02llFd6QvmcTYzWzeOpk=;
        b=a3tUqnIxcIeIlgLp1m+2yGQtH4G3OEaRXPK5UVZW9FVdr1CAX5mPECAF75JD1bZqhZ
         1lfO3vn2F3BSsaW66F9T36BzlGC96iNthbAEtu4mkQScxHMtTMeGLvF+K+3gIFmpjcjA
         tZ8CwSm4I7jPyakNjwpfRb1PDi1+jqTz5IJu3D6K1++E3APasvE/TZ0uwPqEEwBfPt0I
         u22R/kpATP/XXE1+n6l8j0F+WDBFYKJSye2FsNuVom0KwZF2ZfOR6IN1o4XwqCfFRZMt
         oOWyg7sDSl+h/MgzzRKmQvodjj6WRgib/amU6HLci+yiKqz8qd2TQrm4BYlT/9KDood0
         AvMg==
X-Received: by 10.236.194.169 with SMTP id m29mr18031852yhn.121.1401231585224;
 Tue, 27 May 2014 15:59:45 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 27 May 2014 15:59:45 -0700 (PDT)
In-Reply-To: <1401130586-93105-5-git-send-email-caleb@calebthompson.io>
X-Google-Sender-Auth: 1KZUKLRMFuUDryXJdN4XakFJCj0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250247>

On Mon, May 26, 2014 at 2:56 PM, Caleb Thompson <cjaysson@gmail.com> wrote:
> t/t7507-commit-verbose.sh was using a global test_set_editor call to
> build its environment.
>
> Rather than building global state with test_set_editor at the beginning
> of the file, move test_set_editor calls into each test.

Rather than repeating in prose what the patch itself says more
concisely and precisely, explain the reason for this change. For
instance, you might replace the above two sentences with something
like this (or better):

    Improve robustness against global state changes by having each
    test set up the test-editor it requires rather than relying upon
    the editor set once at script start.

> Besides being inline with current practices, it also allows the tests

s/inline/in line/

> which required GIT_EDITOR=cat to avoid using a subshell and simplify
> their logic.

"required" sounds odd here. Perhaps:

    ...which set GIT_EDITOR=cat manually...

More below.

> Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
> ---
>  t/t7507-commit-verbose.sh | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index e62d921..310b68b 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -6,7 +6,6 @@ test_description='verbose commit template'
>  write_script check-for-diff <<-EOF
>         exec grep '^diff --git' "\$1"
>  EOF
> -test_set_editor "$(pwd)/check-for-diff"
>
>  cat >message <<'EOF'
>  subject
> @@ -21,10 +20,12 @@ test_expect_success 'setup' '
>  '
>
>  test_expect_success 'initial commit shows verbose diff' '
> +       test_set_editor "$(pwd)/check-for-diff" &&
>         git commit --amend -v
>  '
>
>  test_expect_success 'second commit' '
> +       test_set_editor "$(pwd)/check-for-diff" &&
>         echo content modified >file &&
>         git add file &&
>         git commit -F message

This test does not invoke the test-editor at all, so it's misleading
to insert test_set_editor here.

> @@ -36,11 +37,13 @@ check_message() {
>  }
>
>  test_expect_success 'verbose diff is stripped out' '
> +       test_set_editor "$(pwd)/check-for-diff" &&
>         git commit --amend -v &&
>         check_message message
>  '
>
>  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
> +       test_set_editor "$(pwd)/check-for-diff" &&
>         test_config diff.mnemonicprefix true &&
>         git commit --amend -v &&
>         check_message message
> @@ -59,16 +62,19 @@ index 0000000..f95c11d
>  EOF
>
>  test_expect_success 'diff in message is retained without -v' '
> +       test_set_editor "$(pwd)/check-for-diff" &&
>         git commit --amend -F diff &&
>         check_message diff
>  '

Also misleading, unnecessary test_set_editor.

>  test_expect_success 'diff in message is retained with -v' '
> +       test_set_editor "$(pwd)/check-for-diff" &&
>         git commit --amend -F diff -v &&
>         check_message diff
>  '

Ditto.

>  test_expect_success 'submodule log is stripped out too with -v' '
> +       test_set_editor "$(pwd)/check-for-diff" &&

Unnecessary. The editor isn't invoked until the test_must_fail line,
and by then you've already overridden it with 'test_set_editor cat'.

>         test_config diff.submodule log &&
>         git submodule add ./. sub &&
>         git commit -m "sub added" &&
> @@ -77,20 +83,14 @@ test_expect_success 'submodule log is stripped out too with -v' '
>                 echo "more" >>file &&
>                 git commit -a -m "submodule commit"
>         ) &&
> -       (
> -               GIT_EDITOR=cat &&
> -               export GIT_EDITOR &&
> -               test_must_fail git commit -a -v 2>err
> -       ) &&
> +       test_set_editor cat &&
> +       test_must_fail git commit -a -v 2>err

Broken &&-chain.

>         test_i18ngrep "Aborting commit due to empty commit message." err
>  '
>
>  test_expect_success 'verbose diff is stripped out with set core.commentChar' '
> -       (
> -               GIT_EDITOR=cat &&
> -               export GIT_EDITOR &&
> -               test_must_fail git -c core.commentchar=";" commit -a -v 2>err
> -       ) &&
> +       test_set_editor cat &&
> +       test_must_fail git -c core.commentchar=";" commit -a -v 2>err

Broken &&-chain.

>         test_i18ngrep "Aborting commit due to empty commit message." err
>  '
>
> --
> 1.9.3
>
