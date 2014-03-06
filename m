From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/6] merge hook tests: fix and update tests
Date: Thu, 6 Mar 2014 17:11:47 -0500
Message-ID: <CAPig+cRXLQVcZFbawc=TzBAMqb3XwBFGZH1viMnTwtoqz6p-zA@mail.gmail.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
	<1394117424-29780-5-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 23:12:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLgWM-0003gS-IB
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 23:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbaCFWLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 17:11:50 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:59616 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaCFWLr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 17:11:47 -0500
Received: by mail-yh0-f43.google.com with SMTP id b6so3389164yha.16
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 14:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fGr8bRYMorLEG14WdGgvWn1/G6QpTiqq05vKvTQC5Uk=;
        b=VnpquDCtcOxwCO4CwvSp/OTJQqy4oQCLxh7CZKPSaKuRBg2Avj5Es6bkRIpvnhee27
         3dvyP/vJf5NyrO5o4Zt2vczn1TBY+7EtWuzY8YUll580LJzV0nSEGxFsrOYxdKuY/Yww
         CDmj6Akkst+JDXzIU/SHFOwAMOc0PfsmK2urMM6VBBkFFjxnEnLVT3Hh4N4qQsLxquHq
         f0CJddizb7RyE24ibDvOI7bed88nAcsKi1imJyORkVWi5LgI33+sOJPWzI07pV/31Yrx
         XVDNjQ8zP+p8tqEFzcy6m2MMEFFaQ3ckdj3m7emsNLrOlT1uSQ7lZbwRxxYTfS2N4GwW
         Tu6w==
X-Received: by 10.236.131.163 with SMTP id m23mr17637072yhi.61.1394143907137;
 Thu, 06 Mar 2014 14:11:47 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Thu, 6 Mar 2014 14:11:47 -0800 (PST)
In-Reply-To: <1394117424-29780-5-git-send-email-benoit.pierre@gmail.com>
X-Google-Sender-Auth: zzTeo81EMLdiWQ4pmgNxew8xiLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243565>

On Thu, Mar 6, 2014 at 9:50 AM, Benoit Pierre <benoit.pierre@gmail.com> wrote:
> - update 'no editor' hook test and add 'editor' hook test
> - reset tree at the beginning of failing hook tests to avoid failures
>   due to an unclean tree after running a previous test
>
> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
>  t/t7505-prepare-commit-msg-hook.sh | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
> index 3573751..ae7b2db 100755
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -141,7 +141,19 @@ test_expect_success 'with hook (merge)' '
>         git commit -m other &&
>         git checkout - &&
>         git merge other &&
> -       test "`git log -1 --pretty=format:%s`" = merge
> +       test "`git log -1 --pretty=format:%s`" = "merge (no editor)"
> +'
> +
> +test_expect_success 'with hook and editor (merge)' '
> +
> +       head=`git rev-parse HEAD` &&
> +       git checkout -B other HEAD@{1} &&
> +       echo "more" >> file &&

Drop space after >>.

> +       git add file &&
> +       git commit -m other &&
> +       git checkout - &&

If one of the commands above this point fails, then "git checkout -"
will never be invoked, and the working tree may be left in a state
inconsistent with what following tests expect. Instead, perhaps use
test_when_finished to perform the restorative "git checkout ...".

> +       env GIT_EDITOR="\"\$FAKE_EDITOR\"" git merge -e other &&
> +       test "`git log -1 --pretty=format:%s`" = "merge"
>  '
>
>  cat > "$HOOK" <<'EOF'
> @@ -151,6 +163,7 @@ EOF
>
>  test_expect_success 'with failing hook' '
>
> +       git reset --hard &&
>         head=`git rev-parse HEAD` &&
>         echo "more" >> file &&
>         git add file &&
> @@ -160,6 +173,7 @@ test_expect_success 'with failing hook' '
>
>  test_expect_success 'with failing hook (--no-verify)' '
>
> +       git reset --hard &&
>         head=`git rev-parse HEAD` &&
>         echo "more" >> file &&
>         git add file &&
> @@ -169,6 +183,7 @@ test_expect_success 'with failing hook (--no-verify)' '
>
>  test_expect_success 'with failing hook (merge)' '
>
> +       git reset --hard &&
>         git checkout -B other HEAD@{1} &&
>         echo "more" >> file &&
>         git add file &&
> --
> 1.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
