From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 1/2] t4255: test am submodule with diff.submodule
Date: Sat, 27 Dec 2014 19:00:21 -0600
Message-ID: <CAEtYS8S4JKihvC4XZC00jv6HX8t6StqGCqCArTFk0RT--hgdSg@mail.gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
	<1419635506-5045-2-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cT3gA2YpiT2Vr=F5-hB+Zy4ask-kz8DtpL3eFvz9PJb5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 02:01:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y52E9-0001SE-BS
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 02:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbaL1BAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2014 20:00:24 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:49711 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbaL1BAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 20:00:23 -0500
Received: by mail-lb0-f177.google.com with SMTP id b6so9281503lbj.8
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 17:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KS+GDq/XP8ohqRV/ujVNgpIrXAgpe19JvYZyAvSUJ4Y=;
        b=iQrO8fnumMutsxZIlA9k1G0/QFCxucGGBxJIKhkxP24MT9c7svjpxVhnqyOmconfFF
         sqjyGelUFRYnlNU9Nq0xn0t/mCvfPBV8arjdI4lASpS6kr9EYgArhJsCLSCESZREdcQr
         T0unPkkpxi5bgQ4+FzKHAwV68aG9Q/AmoSm1sVNjUaJcjI95RtqOiljj4rjkIKU8pr6p
         4lw70y8FJmBDr+xXoPmy9g8hK/SABwd7AIICoMiIY7S0V6iDL36EiECPh2vxbwE0/wlS
         RT9OAEwlkF6ESvZvaMoWqZJnBxjcz9X/V7RlGDTgxtPIKhxFauOjpjL9YVdMESVRLF+y
         QQWg==
X-Received: by 10.112.169.34 with SMTP id ab2mr49723819lbc.77.1419728421422;
 Sat, 27 Dec 2014 17:00:21 -0800 (PST)
Received: by 10.25.23.139 with HTTP; Sat, 27 Dec 2014 17:00:21 -0800 (PST)
In-Reply-To: <CAPig+cT3gA2YpiT2Vr=F5-hB+Zy4ask-kz8DtpL3eFvz9PJb5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261849>

On Sat, Dec 27, 2014 at 6:37 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Dec 26, 2014 at 6:11 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
> > git am will break when using diff.submodule=log; add some test cases
> > to illustrate this breakage as simply as possible.  There are
> > currently two ways this can fail:
> >
> > * With errors ("unrecognized input"), if only change
> > * Silently (no submodule change), if other files change
> >
> > Test for both conditions and ensure without diff.submodule this works.
> >
> > Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
> > ---
> > diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
> > index 8bde7db..d9a1d79 100755
> > --- a/t/t4255-am-submodule.sh
> > +++ b/t/t4255-am-submodule.sh
> > @@ -18,4 +18,87 @@ am_3way () {
> >  KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
> >  test_submodule_switch "am_3way"
> >
> > +test_expect_success 'setup diff.submodule' '
>
> Since the tests are actually expected to fail at this point (before
> you've fixed the problem), use test_expect_failure. The follow-up
> patch, which fixes the problem, should flip them to
> test_expect_success.

Okay, that's easy enough to do.

>
> > +       echo one >one &&
> > +       git add one &&
> > +       test_tick &&
> > +       git commit -m initial &&
>
> Rather than performing these steps manually (here and below), perhaps
> test_commit would be suitable and more succinct.
>
> > +       git rev-parse HEAD >initial &&
>
> Other scripts in the test suite don't bother with this indirection.
> Instead, they assign the variable here, then reference it in
> subsequent tests (and no need to redirect to a file).
>
>     INITIAL=$(git rev-parse HEAD) &&
>

Both good comments; wasn't sure if that'd work.  But easy to do!

> > +
> > +       git init submodule &&
> > +       (cd submodule &&
> > +               echo two >two &&
> > +               git add two &&
> > +               test_tick &&
> > +               git commit -m "initial submodule" &&
> > +               git rev-parse HEAD >../initial-submodule) &&
>
> Style: Format the subshell like this:
>
>     (
>         ...commands...
>     ) &&

Yeah, I was unsure on this style (docs were unclear), but that's easy to follow.

>
> > +       git submodule add ./submodule &&
> > +       test_tick &&
> > +       git commit -m first &&
> > +       git rev-parse HEAD >first &&
>
> Is file 'first' ever used anywhere?

Nope; somewhat vestigial code (that could probably be cleaned out --
and should).
Originally, I was testing the first commit, and then I realized that
the second commit
updating the submodule introduces the failure I was looking for.

>
> > +       (cd submodule &&
> > +               echo three >three &&
> > +               git add three &&
> > +               test_tick &&
> > +               git commit -m "first submodule" &&
> > +               git rev-parse HEAD >../first-submodule) &&
> > +       git add submodule &&
> > +       test_tick &&
> > +       git commit -m second &&
> > +       git rev-parse HEAD >second &&
> > +
> > +       (cd submodule &&
> > +               git mv two four &&
> > +               test_tick &&
> > +               git commit -m "second submodule" &&
> > +               git rev-parse HEAD >../second-submodule) &&
> > +       git add submodule &&
> > +       echo four >four &&
> > +       git add four &&
> > +       test_tick &&
> > +       git commit -m third &&
> > +       git rev-parse HEAD >third &&
> > +       git submodule update --init
> > +'
> > +
> > +INITIAL=$(cat initial)
> > +SECOND=$(cat second)
> > +THIRD=$(cat third)
>
> No need for this extra level of indirection. See above.
>
> > +run_test() {
> > +       START_COMMIT=$1
> > +       EXPECT=$2
>
> Although it's not specifically wrong here, someone adding code above
> these two lines later on may not notice the broken &&-chain, so it
> would be a good idea to keep the &&-chain intact.

OK, easy enough.

>
> > +       (git am --abort || true) &&
> > +       git reset --hard $START_COMMIT &&
> > +       rm -f *.patch &&
> > +       git format-patch -1 &&
> > +       git reset --hard $START_COMMIT^ &&
> > +       git submodule update &&
> > +       git am *.patch &&
> > +       git submodule update &&
> > +       (cd submodule && git rev-parse HEAD >../actual) &&
> > +       test_cmp $EXPECT actual
> > +}
> > +
> > +test_expect_success 'diff.submodule unset' '
> > +       (git config --unset diff.submodule || true) &&
> > +       run_test $SECOND 'first-submodule'
>
> Note that you're already inside a single-quoted string here, so
> 'first-submodule' is not quite doing what you expect. Double quotes
> would be more appropriate. Or, better, drop the quoting of
> first-submodule altogether since it's unnecessary.

Yep. Good note.

>
> > +'
> > +
> > +test_expect_success 'diff.submodule unset with extra file' '
> > +       (git config --unset diff.submodule || true) &&
> > +       run_test $THIRD 'second-submodule'
> > +'
> > +
> > +test_expect_success 'diff.submodule=log' '
> > +       git config diff.submodule log &&
> > +       run_test $SECOND 'first-submodule'
> > +'
> > +
> > +test_expect_success 'diff.submodule=log with extra file' '
> > +       git config diff.submodule log &&
> > +       run_test $THIRD 'second-submodule'
> > +'
> > +
> >  test_done
> > --
> > 2.0.5

One other note that might simplify this extra test case that I thought about
while driving home yesterday evening was changing lib-submodule-update to
set diff.submodule=log inside prolog().  This wouldn't provide very
clear failure causes, but it would perhaps reduce duplicated code and simplify
the test case.

Thanks for the feedback, though, I'll send out a new version momentarily.
