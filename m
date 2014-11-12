From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv5 9/9] t3301: Modernize
Date: Tue, 11 Nov 2014 20:57:41 -0500
Message-ID: <CAPig+cSVtAi-n4EKaOgNwDqLvajzvozRG5_o3XjfZAMzW8T8-g@mail.gmail.com>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
	<1415752816-22782-10-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>, Jeff King <peff@peff.net>,
	Michael Blume <blume.mike@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 02:58:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoNC3-00074D-0L
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 02:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966057AbaKLB5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 20:57:44 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:58218 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965545AbaKLB5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 20:57:42 -0500
Received: by mail-yk0-f182.google.com with SMTP id q9so597871ykb.13
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 17:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cvdtKZLUjgpZsL/qLmYouWk5o321TvyQSQB69NK4034=;
        b=xZKlJfilQAdaB6VYoO4i+/5ddvEvUHXvTiM9tAUskTXp/qqMIFrnY0tPqnG+Lc3gsE
         52lAAsL4P4yqA8BHYPWlemONcjUe3jIAXXTdomminj3biw8qJC7se+dADiwfmMilnWKL
         wDoVhS8ma5SEsvTrQhvulis9lzwA7dvbdGSII57GHkr00y+efTxtQ06xolTcv4ZSxJKB
         c9SNitqkNRyw0yL6nXA7jA1cKWW+6bQOehfqylniweTDRmmGkVAS8/FiPvz4PD6wDTbr
         gOaU183W+r5AYbnG6I6d8UIi+N2lsf69LQ/SXy2wteRbopfuLoA5TV3xQcvb8vLFIlqb
         oMGw==
X-Received: by 10.170.51.210 with SMTP id 201mr46579470ykt.18.1415757461944;
 Tue, 11 Nov 2014 17:57:41 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 11 Nov 2014 17:57:41 -0800 (PST)
In-Reply-To: <1415752816-22782-10-git-send-email-johan@herland.net>
X-Google-Sender-Auth: 7z1MCAFWXKNIOtEfI2ME7ZCxVUU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 11, 2014 at 7:40 PM, Johan Herland <johan@herland.net> wrote:
> Make this test script appear somewhat less old-fashioned:
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 416ed9e..861c159 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -50,206 +44,186 @@ test_expect_success 'handle empty notes gracefully' '
>  '
>
>  test_expect_success 'create notes' '
> -       git config core.notesRef refs/notes/commits &&
>         MSG=b4 git notes add &&
> -       test ! -f .git/NOTES_EDITMSG &&
> -       test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
> -       test b4 = $(git notes show) &&
> +       test_path_is_missing .git/NOTES_EDITMSG &&
> +       git ls-tree -r refs/notes/commits >actual &&
> +       test_line_count = 1 actual

Broken &&-chain. This problem is repeated each place use invoke
test_line_count().

> +       test "b4" = "$(git notes show)" &&
>         git show HEAD^ &&
>         test_must_fail git notes show HEAD^
>  '
>
>  test_expect_success 'show notes entry with %N' '
> -       for l in A b4 B
> -       do
> -               echo "$l"
> -       done >expect &&
> -       git show -s --format='A%n%NB' >output &&
> -       test_cmp expect output
> +       test_write_lines A b4 B >expect &&
> +       git show -s --format="A%n%NB" >actual &&
> +       test_cmp expect actual
>  '
>
> -cat >expect <<EOF
> -d423f8c refs/notes/commits@{0}: notes: Notes added by 'git notes add'
> -EOF
> -
>  test_expect_success 'create reflog entry' '
> -       git reflog show refs/notes/commits >output &&
> -       test_cmp expect output
> +       cat <<-EOF >expect &&
> +               a1d8fa6 refs/notes/commits@{0}: notes: Notes added by '"'"'git notes add'"'"'
> +       EOF
> +       git reflog show refs/notes/commits >actual &&
> +       test_cmp expect actual
>  '
>
>  test_expect_success 'edit existing notes' '
>         MSG=b3 git notes edit &&
> -       test ! -f .git/NOTES_EDITMSG &&
> -       test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
> -       test b3 = $(git notes show) &&
> +       test_path_is_missing .git/NOTES_EDITMSG &&
> +       git ls-tree -r refs/notes/commits >actual &&
> +       test_line_count = 1 actual
> +       test "b3" = "$(git notes show)" &&
>         git show HEAD^ &&
>         test_must_fail git notes show HEAD^
>  '
>
>  test_expect_success 'cannot "git notes add -m" where notes already exists' '
>         test_must_fail git notes add -m "b2" &&
> -       test ! -f .git/NOTES_EDITMSG &&
> -       test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
> -       test b3 = $(git notes show) &&
> +       test_path_is_missing .git/NOTES_EDITMSG &&
> +       git ls-tree -r refs/notes/commits >actual &&
> +       test_line_count = 1 actual
> +       test "b3" = "$(git notes show)" &&
>         git show HEAD^ &&
>         test_must_fail git notes show HEAD^
>  '
>
>  test_expect_success 'can overwrite existing note with "git notes add -f -m"' '
>         git notes add -f -m "b1" &&
> -       test ! -f .git/NOTES_EDITMSG &&
> -       test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
> -       test b1 = $(git notes show) &&
> +       test_path_is_missing .git/NOTES_EDITMSG &&
> +       git ls-tree -r refs/notes/commits >actual &&
> +       test_line_count = 1 actual
> +       test "b1" = "$(git notes show)" &&
>         git show HEAD^ &&
>         test_must_fail git notes show HEAD^
>  '
>
>  test_expect_success 'add w/no options on existing note morphs into edit' '
>         MSG=b2 git notes add &&
> -       test ! -f .git/NOTES_EDITMSG &&
> -       test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
> -       test b2 = $(git notes show) &&
> +       test_path_is_missing .git/NOTES_EDITMSG &&
> +       git ls-tree -r refs/notes/commits >actual &&
> +       test_line_count = 1 actual
> +       test "b2" = "$(git notes show)" &&
>         git show HEAD^ &&
>         test_must_fail git notes show HEAD^
>  '
>
>  test_expect_success 'can overwrite existing note with "git notes add -f"' '
>         MSG=b1 git notes add -f &&
> -       test ! -f .git/NOTES_EDITMSG &&
> -       test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
> -       test b1 = $(git notes show) &&
> +       test_path_is_missing .git/NOTES_EDITMSG &&
> +       git ls-tree -r refs/notes/commits >actual &&
> +       test_line_count = 1 actual
> +       test "b1" = "$(git notes show)" &&
>         git show HEAD^ &&
>         test_must_fail git notes show HEAD^
>  '
