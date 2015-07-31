From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] am: let command-line options override saved options
Date: Fri, 31 Jul 2015 18:58:48 +0800
Message-ID: <CACRoPnR1df+uEnpFArJtwEBCh+HiQYDYGOyZ7KQEGtrdiaX3GQ@mail.gmail.com>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
	<20150724180921.GA17730@peff.net>
	<CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
	<xmqq8ua1k7fc.fsf@gitster.dls.corp.google.com>
	<20150728164311.GA1948@yoshi.chippynet.com>
	<xmqqegjsfbtk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 12:58:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL81f-0003h8-3Q
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 12:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbbGaK6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 06:58:51 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34522 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbbGaK6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 06:58:50 -0400
Received: by lbqc9 with SMTP id c9so18633079lbq.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 03:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ckXR597S89GobSWLJYFlbsR91Lg9Y6AzADXFYONK3zs=;
        b=Q/6aBUcAy9skMLhsXxpON+g2gBc392y5SAvPkzobAGTL12nTYq0/zY5HiRzLrNXjLD
         YQJkZIE1cq+AKJmzf3hRNo4/Ijb4I0MtwlQ8B2EufnYBGf1+KwqFdqqPWX8OXyNOcHFS
         RCJmWtNHKjDum88CW/vgMS6Gx4gqhd/tYalt+dXvOu28hzqgzjba473YtUaYDXhHbi04
         TobpssSoxFSjrRqnfzSiLGtZgGz7aY8Xfml3OPMg3+77SaDsIPoeoqEwEClvEDAOOP6I
         EbAs8j1RH9SYd15TnrT0mGS9XxvEJgLOyeFFUlWnzYSY03Ih3q7M6EnV7BQmsxNFSZcI
         OAtA==
X-Received: by 10.112.159.226 with SMTP id xf2mr2144443lbb.74.1438340328439;
 Fri, 31 Jul 2015 03:58:48 -0700 (PDT)
Received: by 10.112.62.196 with HTTP; Fri, 31 Jul 2015 03:58:48 -0700 (PDT)
In-Reply-To: <xmqqegjsfbtk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275044>

On Wed, Jul 29, 2015 at 1:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
>> new file mode 100755
>> index 0000000..c49457c
>> --- /dev/null
>> +++ b/t/t4153-am-resume-override-opts.sh
>> @@ -0,0 +1,144 @@
>> +#!/bin/sh
>> +
>> +test_description='git-am command-line options override saved options'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup' '
>> +     test_commit initial file &&
>> +     test_commit first file &&
>> +
>> +     git checkout -b side initial &&
>> +     test_commit side-first file &&
>> +     test_commit side-second file &&
>> +
>> +     {
>> +             echo "Message-Id: <side-first@example.com>" &&
>> +             git format-patch --stdout -1 side-first | sed -e "1d"
>> +     } >side-first.patch &&
>> +     {
>> +             sed -ne "1,/^\$/p" side-first.patch &&
>
> sed -e "/^\$/q" would work just as well here

OK.

>> +             echo "-- >8 --" &&
>> +             sed -e "1,/^\$/d" side-first.patch
>> +     } >side-first.scissors &&
>> +     {
>> +             echo "Message-Id: <side-second@example.com>" &&
>> +             git format-patch --stdout -1 side-second | sed -e "1d"
>> +     } >side-second.patch &&
>> +     {
>> +             sed -ne "1,/^\$/p" side-second.patch &&
>> +             echo "-- >8 --" &&
>> +             sed -e "1,/^\$/d" side-second.patch
>> +     } >side-second.scissors
>> +'
>
> A helper function that takes the branch name may be a good idea,
> not just to consolidate the implementation but as a place to
> document how these pairs of files are constructed and why.

I think I will introduce a format_patch() function that takes a single
commit-ish so that we can use tag names to name the patches:

# Given a single commit $commit, formats the following patches with
# git-format-patch:
#
# 1. $commit.eml: an email patch with a Message-Id header.
# 2. $commit.scissors: like $commit.eml but contains a scissors line at the
#    start of the commit message body.
format_patch () {
    {
        echo "Message-Id: <$1@example.com>" &&
        git format-patch --stdout -1 "$1" | sed -e '1d'
    } >"$1".eml &&
    {
        sed -e '/^$/q' "$1".eml &&
        echo '-- >8 --' &&
        sed -e '1,/^$/d' "$1".eml
    } >"$1".scissors
}

>> +'
>> +
>> +test_expect_success '--signoff, --no-signoff' '
>> +     rm -fr .git/rebase-apply &&
>> +     git reset --hard &&
>> +     git checkout first &&
>> +     test_must_fail git am --signoff side-first.patch side-second.patch &&
>> +     echo side-first >file &&
>> +     git add file &&
>> +     git am --no-signoff --continue &&
>> +
>> +     # applied side-first will be signed off
>> +     echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
>> +     git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
>> +     test_cmp expected actual &&
>> +
>> +     # applied side-second will not be signed off
>> +     test $(git cat-file commit HEAD | grep -c "Signed-off-by:") -eq 0
>> +'
>
> Hmm, the command was run with --signoff at the start, first gets
> applied with "am --no-signoff --resolved" so I would expect it does
> not get signed off, but the second one will apply cleanly on top, so
> shouldn't it get signed off?  Or perhaps somehow I misread Peff's
> idea to make these override one-shot in $gmane/274635?

Ah, I was just following the structure of the code, but stepping back
to think about it, I think there are 2 bugs:

1. The signoff is appended during the email-parsing stage. As such,
when we are resuming, --no-signoff will have no effect, because the
signoff has already been appended at that stage.

A solution for this is tricky though, as there are functions of git-am
that probably depend on the present behavior of the appended signoff
being present in the commit message:

* The applypatch-msg hook

* The --interactive prompt, where the user can edit the commit message
(to remove or edit the signoff maybe?)

These functions are called before we attempt to apply the patch, so we
should probably call append_signoff before then. However, this still
means that --no-signoff will have no effect should the patch
application fail and we resume, as the signoff would still have
already been appended...

So I dunno. I think the cleanest solution would be to change the
behavior so the commit message passed to the applypatch-msg hook and
--interactive prompt  do not contain the appended signoff, and instead
only append the signoff just before we commit. That way, both
--signoff and --no-signoff overriding will work. What do you think?

2. Re-reading Peff's message, I see that he expects the command-line
options to affect just the current patch, which makes sense. This
patch would need to be extended to call am_load() after we finish
processing the current patch when resuming. Something like:

diff --git a/builtin/am.c b/builtin/am.c
index 8a0b0e4..228d4b1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1779,7 +1779,6 @@ static void am_run(struct am_state *state, int resume)

         if (resume) {
             validate_resume_state(state);
-            resume = 0;
         } else {
             int skip;

@@ -1841,6 +1840,10 @@ static void am_run(struct am_state *state, int resume)

 next:
         am_next(state);
+
+        if (resume)
+            am_load(state);
+        resume = 0;
     }

     if (!is_empty_file(am_path(state, "rewritten"))) {
@@ -1895,6 +1898,7 @@ static void am_resolve(struct am_state *state)

 next:
     am_next(state);
+    am_load(state);
     am_run(state, 0);
 }

@@ -2022,6 +2026,7 @@ static void am_skip(struct am_state *state)
         die(_("failed to clean index"));

     am_next(state);
+    am_load(state);
     am_run(state, 0);
 }

The tests will also need to be modified as well.

>> +test_expect_success '--3way, --no-3way' '
>> +     rm -fr .git/rebase-apply &&
>> +     git reset --hard &&
>> +     git checkout first &&
>> +     test_must_fail git am --3way side-first.patch side-second.patch &&
>> +     test -n "$(git ls-files -u)" &&
>> +     echo will-conflict >file &&
>> +     git add file &&
>> +     test_must_fail git am --no-3way --continue &&
>> +     test -z "$(git ls-files -u)"
>> +'
>> +

... Although if I implement the above change, I can't implement the
test for --3way, as I think the only way to check if --3way/--no-3way
successfully overrides the saved options for the current patch only is
to run "git am --3way", but that does not work in the test runner as
it expects stdin to be a TTY :-/ So I may have to remove this test.
This shouldn't be a problem though, as all the tests in this test
suite all test the same mechanism.

>> +test_expect_success '--no-quiet, --quiet' '
>> +     rm -fr .git/rebase-apply &&
>> +     git reset --hard &&
>> +     git checkout first &&
>> +     test_must_fail git am --no-quiet side-first.patch side-second.patch &&
>> +     test_must_be_empty out &&
>
> Where did this 'out' come from?

It was a leftover from a previous iteration. Will fix.

>
>> +     echo side-first >file &&
>> +     git add file &&
>> +     git am --quiet --continue >out &&
>> +     test_must_be_empty out
>
> I can see this one, though I am not sure if it is sensible to see
> what the command says under --quiet option, especially if you are
> making sure it does not fail, which you already have checked for its
> exit status.

Well, if --quiet fails to override --no-quiet, then there would be
something written to the stdout, no?

But anyway, if we are implementing the above "command-line option
overriding only affects current patch" behavior, then this test would
be checking if --quiet only affects a single patch, which in practice
would be quite silly. Maybe I should flip it around to "--no-quiet
overrides --quiet", but even then it may still be unlikely to come up
with practice... Still, it may be useful to keep this test to check if
the option overriding mechanism is working properly.

Thanks,
Paul
