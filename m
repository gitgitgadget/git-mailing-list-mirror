From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] t4255: test am submodule with diff.submodule
Date: Sat, 27 Dec 2014 19:37:00 -0500
Message-ID: <CAPig+cT3gA2YpiT2Vr=F5-hB+Zy4ask-kz8DtpL3eFvz9PJb5Q@mail.gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
	<1419635506-5045-2-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 01:37:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y51rF-0007dZ-6b
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 01:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbaL1AhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2014 19:37:03 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:45591 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaL1AhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 19:37:02 -0500
Received: by mail-yh0-f54.google.com with SMTP id 29so6274974yhl.41
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 16:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OT+uMyeJZVQQsqtHoY1hXJ4VASsqKg2X7JZwMwgXEHg=;
        b=QF1m3kQCFaNEIU3xaW+VqtfPBMVO1O9xxU7NEedBCrtEEs2+96eBYeDrDMARI8wKwI
         VdSP01nbVt6jPdQQK0WBLHquMpdlLNzSWpCuGs0vleTy4Epu55jGS3ZaOXcRRO8CR1Iq
         5mZ5b3jiHOvlKkngZaU3Y/VkjYxGhuYaOWJNtl309j1kJAxBNBHnRcUO/j0JLL1qTR76
         hwVzLohfW/OeAu7m7XtLk8N7AVx12Xwj/TmMuD/IsCXP3vj2N0GSn3Ozz3nFgFDPGBH4
         fKBYhoVpInYDaGBgESRH5EUlmxyo/YWfD0Q4Ms0S+EX1+84a6kz2jDk87FDdq819UHq3
         EW8g==
X-Received: by 10.236.63.6 with SMTP id z6mr538527yhc.65.1419727020910; Sat,
 27 Dec 2014 16:37:00 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sat, 27 Dec 2014 16:37:00 -0800 (PST)
In-Reply-To: <1419635506-5045-2-git-send-email-dougk.ff7@gmail.com>
X-Google-Sender-Auth: I3YI82Qh0EJfcNRFFn21tKkZesU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261848>

On Fri, Dec 26, 2014 at 6:11 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
> git am will break when using diff.submodule=log; add some test cases
> to illustrate this breakage as simply as possible.  There are
> currently two ways this can fail:
>
> * With errors ("unrecognized input"), if only change
> * Silently (no submodule change), if other files change
>
> Test for both conditions and ensure without diff.submodule this works.
>
> Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
> ---
> diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
> index 8bde7db..d9a1d79 100755
> --- a/t/t4255-am-submodule.sh
> +++ b/t/t4255-am-submodule.sh
> @@ -18,4 +18,87 @@ am_3way () {
>  KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
>  test_submodule_switch "am_3way"
>
> +test_expect_success 'setup diff.submodule' '

Since the tests are actually expected to fail at this point (before
you've fixed the problem), use test_expect_failure. The follow-up
patch, which fixes the problem, should flip them to
test_expect_success.

> +       echo one >one &&
> +       git add one &&
> +       test_tick &&
> +       git commit -m initial &&

Rather than performing these steps manually (here and below), perhaps
test_commit would be suitable and more succinct.

> +       git rev-parse HEAD >initial &&

Other scripts in the test suite don't bother with this indirection.
Instead, they assign the variable here, then reference it in
subsequent tests (and no need to redirect to a file).

    INITIAL=$(git rev-parse HEAD) &&

> +
> +       git init submodule &&
> +       (cd submodule &&
> +               echo two >two &&
> +               git add two &&
> +               test_tick &&
> +               git commit -m "initial submodule" &&
> +               git rev-parse HEAD >../initial-submodule) &&

Style: Format the subshell like this:

    (
        ...commands...
    ) &&

> +       git submodule add ./submodule &&
> +       test_tick &&
> +       git commit -m first &&
> +       git rev-parse HEAD >first &&

Is file 'first' ever used anywhere?

> +       (cd submodule &&
> +               echo three >three &&
> +               git add three &&
> +               test_tick &&
> +               git commit -m "first submodule" &&
> +               git rev-parse HEAD >../first-submodule) &&
> +       git add submodule &&
> +       test_tick &&
> +       git commit -m second &&
> +       git rev-parse HEAD >second &&
> +
> +       (cd submodule &&
> +               git mv two four &&
> +               test_tick &&
> +               git commit -m "second submodule" &&
> +               git rev-parse HEAD >../second-submodule) &&
> +       git add submodule &&
> +       echo four >four &&
> +       git add four &&
> +       test_tick &&
> +       git commit -m third &&
> +       git rev-parse HEAD >third &&
> +       git submodule update --init
> +'
> +
> +INITIAL=$(cat initial)
> +SECOND=$(cat second)
> +THIRD=$(cat third)

No need for this extra level of indirection. See above.

> +run_test() {
> +       START_COMMIT=$1
> +       EXPECT=$2

Although it's not specifically wrong here, someone adding code above
these two lines later on may not notice the broken &&-chain, so it
would be a good idea to keep the &&-chain intact.

> +       (git am --abort || true) &&
> +       git reset --hard $START_COMMIT &&
> +       rm -f *.patch &&
> +       git format-patch -1 &&
> +       git reset --hard $START_COMMIT^ &&
> +       git submodule update &&
> +       git am *.patch &&
> +       git submodule update &&
> +       (cd submodule && git rev-parse HEAD >../actual) &&
> +       test_cmp $EXPECT actual
> +}
> +
> +test_expect_success 'diff.submodule unset' '
> +       (git config --unset diff.submodule || true) &&
> +       run_test $SECOND 'first-submodule'

Note that you're already inside a single-quoted string here, so
'first-submodule' is not quite doing what you expect. Double quotes
would be more appropriate. Or, better, drop the quoting of
first-submodule altogether since it's unnecessary.

> +'
> +
> +test_expect_success 'diff.submodule unset with extra file' '
> +       (git config --unset diff.submodule || true) &&
> +       run_test $THIRD 'second-submodule'
> +'
> +
> +test_expect_success 'diff.submodule=log' '
> +       git config diff.submodule log &&
> +       run_test $SECOND 'first-submodule'
> +'
> +
> +test_expect_success 'diff.submodule=log with extra file' '
> +       git config diff.submodule log &&
> +       run_test $THIRD 'second-submodule'
> +'
> +
>  test_done
> --
> 2.0.5
