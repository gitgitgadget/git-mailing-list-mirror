From: Michael Blume <blume.mike@gmail.com>
Subject: Re: mac test failure -- test 3301
Date: Mon, 10 Nov 2014 17:46:44 -0800
Message-ID: <CAO2U3Qh1dpmwhfhMCbSrUXKZ+hby2Ku_Qm-wvxPThzBeL+kXXA@mail.gmail.com>
References: <CAO2U3QhiWVvVKivBhE5R2xhjf8SPPtg6VSaQMxw7vbm_454jBQ@mail.gmail.com>
 <CAPig+cRxCj82F5aak0Y+Ce_SvUETtQ5dwM1RtzjUUvwtJ=WPYw@mail.gmail.com> <CALKQrgexnrCy-P6yTZB+U0--5peaTys9KqB+KGKqbAuyLA=NqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 02:47:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xo0YZ-0000x7-93
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 02:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbaKKBrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 20:47:06 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:57594 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaKKBrF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 20:47:05 -0500
Received: by mail-oi0-f46.google.com with SMTP id g201so6335872oib.19
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 17:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BEYiF3c/T6wGPl+wswszfzlBb5mF2ghWRWGb3GqXld8=;
        b=zgIzYtORRAsjZAaDif7nVVvJH8MU0RHL4TyDVmVni1JzglJoxNzS2ETw8rmvpuS4A2
         h6zOqvzYJtvH0++F5BSiw9U1qR7iQo/bbhP5CL2p553ckYW8zxBmJXrTEoijxRz9BPhB
         mwu3zok+baepOW8KR5hXCEZFBblrABh/TYv57Jw8HpNHEFE/m+qMoS6hl6vb/EkYBy41
         U6iTttyo4gBXRhr3hP8dQHYiVcb+X85eR+LgXl2bf0So2LNtqFPbJOXGCK3JHOMuchLt
         UTkoCH/4d1I31XS3hmZB5obEnCHGT8ALV0HGcEfTy7jRnPVeQJnDc12bbsfRIG/nV5EB
         MQsQ==
X-Received: by 10.182.163.33 with SMTP id yf1mr30312043obb.0.1415670424944;
 Mon, 10 Nov 2014 17:47:04 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Mon, 10 Nov 2014 17:46:44 -0800 (PST)
In-Reply-To: <CALKQrgexnrCy-P6yTZB+U0--5peaTys9KqB+KGKqbAuyLA=NqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If quoting is generally preferred as a best practice, we could force
wc to behave more consistently before we start testing

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0d93e33..57ed608 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -515,6 +515,14 @@ test_path_is_missing () {
  fi
 }

+# Some platforms disagree about wc output format.
+
+SYS_WC=$(which wc)
+
+wc () {
+ $SYS_WC $@ | sed -e 's/^ *//' -e 's/ *$//'
+}
+
 # test_line_count checks that a file has the number of lines it
 # ought to. For example:
 #

On Mon, Nov 10, 2014 at 5:40 PM, Johan Herland <johan@herland.net> wrote:
> On Tue, Nov 11, 2014 at 2:19 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Nov 10, 2014 at 7:17 PM, Michael Blume <blume.mike@gmail.com> wrote:
>>> the commit modernizing test 3301
>>> (https://github.com/git/git/commit/fbe4f74865acfd) appears to break it
>>> on my mac
>>>
>>> $ ./t3301-notes.sh -v
>>> expecting success:
>>> MSG=b4 git notes add &&
>>> test_path_is_missing .git/NOTES_EDITMSG &&
>>> test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>>> test "b4" = "$(git notes show)" &&
>>> git show HEAD^ &&
>>> test_must_fail git notes show HEAD^
>>>
>>> b4
>>> not ok 8 - create notes
>>
>> This and all other failures are due to the output of 'wc -l', which on
>> Mac is "{whitespace}1" rather than just "1" as it is on other
>> platforms. fbe4f748 added quotes around the $(... | wc -l) invocation
>> which caused the whitespace to be retained. A minimum fix would be to
>> drop the quotes surrounding $().
>
> Ah, thanks!
>
> I thought that quoting command output was a good idea in general. Am I
> wrong, or is this just one exception to an otherwise good guideline?
>
> Anyway, here is the minimal diff to remove quoting from the $(... | wc
> -l) commands (probably whitespace damaged by GMail - sorry). Junio:
> feel free to squash this in, or ask for a re-roll:
>
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index cd756ec..2c8abbc 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -52,7 +52,7 @@ test_expect_success 'show non-existent notes entry with %N' '
>  test_expect_success 'create notes' '
>      MSG=b4 git notes add &&
>      test_path_is_missing .git/NOTES_EDITMSG &&
> -    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
> +    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
>      test "b4" = "$(git notes show)" &&
>      git show HEAD^ &&
>      test_must_fail git notes show HEAD^
> @@ -75,7 +75,7 @@ test_expect_success 'create reflog entry' '
>  test_expect_success 'edit existing notes' '
>      MSG=b3 git notes edit &&
>      test_path_is_missing .git/NOTES_EDITMSG &&
> -    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
> +    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
>      test "b3" = "$(git notes show)" &&
>      git show HEAD^ &&
>      test_must_fail git notes show HEAD^
> @@ -84,7 +84,7 @@ test_expect_success 'edit existing notes' '
>  test_expect_success 'cannot "git notes add -m" where notes already exists' '
>      test_must_fail git notes add -m "b2" &&
>      test_path_is_missing .git/NOTES_EDITMSG &&
> -    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
> +    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
>      test "b3" = "$(git notes show)" &&
>      git show HEAD^ &&
>      test_must_fail git notes show HEAD^
> @@ -93,7 +93,7 @@ test_expect_success 'cannot "git notes add -m" where
> notes already exists' '
>  test_expect_success 'can overwrite existing note with "git notes add -f -m"' '
>      git notes add -f -m "b1" &&
>      test_path_is_missing .git/NOTES_EDITMSG &&
> -    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
> +    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
>      test "b1" = "$(git notes show)" &&
>      git show HEAD^ &&
>      test_must_fail git notes show HEAD^
> @@ -102,7 +102,7 @@ test_expect_success 'can overwrite existing note
> with "git notes add -f -m"' '
>  test_expect_success 'add w/no options on existing note morphs into edit' '
>      MSG=b2 git notes add &&
>      test_path_is_missing .git/NOTES_EDITMSG &&
> -    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
> +    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
>      test "b2" = "$(git notes show)" &&
>      git show HEAD^ &&
>      test_must_fail git notes show HEAD^
> @@ -111,7 +111,7 @@ test_expect_success 'add w/no options on existing
> note morphs into edit' '
>  test_expect_success 'can overwrite existing note with "git notes add -f"' '
>      MSG=b1 git notes add -f &&
>      test_path_is_missing .git/NOTES_EDITMSG &&
> -    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
> +    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
>      test "b1" = "$(git notes show)" &&
>      git show HEAD^ &&
>      test_must_fail git notes show HEAD^
>
>
> ...Johan
>
> --
> Johan Herland, <johan@herland.net>
> www.herland.net
