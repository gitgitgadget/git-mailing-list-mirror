From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/7] merge hook tests: fix and update tests
Date: Mon, 10 Mar 2014 16:27:40 -0400
Message-ID: <CAPig+cRsFTNAAzAD99v+A1KCVRNTUOaSyuf_gqPZa8-MLMyoBQ@mail.gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
	<1394477377-10994-7-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 21:27:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6na-00058M-4n
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 21:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbaCJU1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 16:27:42 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:59470 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbaCJU1l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 16:27:41 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so1069988yho.29
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Gawaadu9WnSynhJRiNOicfs2tm12Vahczd9nB48xo2g=;
        b=IS+x7sBgDE2GY+saOLsjFOPf122dCZYjJwc3KD78NcrveBu8qLOsuH4Jd3fXTphAdQ
         WwJmNwoi+jaTEJRe9Fhmed2MnzYj3AVcGfLPVxK/o53eN08YwL6CqWNh5JFYRDhONvZ5
         dVWxQCrL8H23vhK8sGBgoPPENCSS85dZnhVXopZMvTHdgeaNue7gRgmQaTo4nupVkype
         kG4IAFslxHwTT7vIVQI5x2R5ZU2hn+eOVofRUGjADFnvYtAAZMljUhcKn8bjpODBNPwY
         0auRQwDG9MZjhKiWUYG9v5mqejnkilb9KQ8I1HUA5MLrVKxGR7UcyOnOyfXP/HwlZRK7
         Sx1A==
X-Received: by 10.236.53.135 with SMTP id g7mr6501628yhc.106.1394483260923;
 Mon, 10 Mar 2014 13:27:40 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 10 Mar 2014 13:27:40 -0700 (PDT)
In-Reply-To: <1394477377-10994-7-git-send-email-benoit.pierre@gmail.com>
X-Google-Sender-Auth: od0IpnFY4lGbOcoykRf2wSeyWbo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243810>

On Mon, Mar 10, 2014 at 2:49 PM, Benoit Pierre <benoit.pierre@gmail.com> wrote:
> - update 'no editor' hook test and add 'editor' hook test
> - make sure the tree is reset to a clean state after running a test
>   (using test_when_finished) so later tests are not impacted

As conceptually distinct changes, it might make sense to split these
into two patches, one a purely cleanup patch adding
test_when_finished, and the second introducing your new test. Doing so
would ease the review process and make the intended changes more
obvious.

> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
>  t/t7505-prepare-commit-msg-hook.sh | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
> index 5531abb..03dce09 100755
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -134,14 +134,26 @@ test_expect_success 'with hook (-c)' '
>
>  test_expect_success 'with hook (merge)' '
>
> -       head=`git rev-parse HEAD` &&
> -       git checkout -b other HEAD@{1} &&
> -       echo "more" >> file &&
> +       test_when_finished "git checkout -f master" &&
> +       git checkout -B other HEAD@{1} &&
> +       echo "more" >>file &&
> +       git add file &&
> +       git commit -m other &&
> +       git checkout - &&
> +       git merge --no-ff other &&
> +       test "`git log -1 --pretty=format:%s`" = "merge (no editor)"
> +'
> +
> +test_expect_success 'with hook and editor (merge)' '
> +
> +       test_when_finished "git checkout -f master" &&
> +       git checkout -B other HEAD@{1} &&
> +       echo "more" >>file &&
>         git add file &&
>         git commit -m other &&
>         git checkout - &&
> -       git merge other &&
> -       test "`git log -1 --pretty=format:%s`" = merge
> +       env GIT_EDITOR="\"\$FAKE_EDITOR\"" git merge --no-ff -e other &&
> +       test "`git log -1 --pretty=format:%s`" = "merge"
>  '
>
>  cat > "$HOOK" <<'EOF'
> @@ -151,6 +163,7 @@ EOF
>
>  test_expect_success 'with failing hook' '
>
> +       test_when_finished "git checkout -f master" &&
>         head=`git rev-parse HEAD` &&
>         echo "more" >> file &&
>         git add file &&
> @@ -160,6 +173,7 @@ test_expect_success 'with failing hook' '
>
>  test_expect_success 'with failing hook (--no-verify)' '
>
> +       test_when_finished "git checkout -f master" &&
>         head=`git rev-parse HEAD` &&
>         echo "more" >> file &&
>         git add file &&
> @@ -169,6 +183,7 @@ test_expect_success 'with failing hook (--no-verify)' '
>
>  test_expect_success 'with failing hook (merge)' '
>
> +       test_when_finished "git checkout -f master" &&
>         git checkout -B other HEAD@{1} &&
>         echo "more" >> file &&
>         git add file &&
> @@ -178,7 +193,7 @@ test_expect_success 'with failing hook (merge)' '
>         exit 1
>         EOF
>         git checkout - &&
> -       test_must_fail git merge other
> +       test_must_fail git merge --no-ff other
>
>  '
>
> --
> 1.9.0
