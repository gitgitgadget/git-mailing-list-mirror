From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] modernize t7300
Date: Mon, 7 Dec 2015 17:43:48 -0500
Message-ID: <CAPig+cRqG3mG89Htmjd3a=YzMG36V3an1qUC4siJNBqHzDHQFA@mail.gmail.com>
References: <CAPig+cRa31uriO4qkZUydooNx0V+dNrUgFvTUxoLL9gCjq9AHQ@mail.gmail.com>
	<1449413906-23256-1-git-send-email-rouzier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: James <rouzier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 23:43:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a64Vf-0004iU-0R
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 23:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbbLGWnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 17:43:51 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33451 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604AbbLGWnt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 17:43:49 -0500
Received: by vkca188 with SMTP id a188so1311215vkc.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 14:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=sVD4/PFASfj+QFd31icjsXClCqvl8M7FEIFa/xqCftg=;
        b=JE2z3vQzZ9lv3xKaj0kc8fv476HYHzVTVVYwBJS6I8hdXPUmd8yt4HiDdbOJUqVoUO
         yAn+/AjJZGmowqJdfpDz2b61+8BMhZYfsUXau+jE7sfdyXhlDvPX3soMo6ZBq26JsVv6
         fR7j4XxBO7pUrkk63vEU0/2nFR5qZWmNKuqDHx9kGk8bG+YC7TwQRKvoNdmLDl46K/2n
         9mN+ko1ZCopqdaU4R9OBxbM9fNgNcQgJF7G+Z6suz2sY5OqcSOlBo7pCLeBv9wX3TkrO
         4JrVYq5VHH5tX8WzDEG4nzw1V90TLUguw/vbN8PsOgwCnHC37YyRQAmYhcPOCWZADtEH
         r5hQ==
X-Received: by 10.31.47.130 with SMTP id v124mr23670081vkv.117.1449528228431;
 Mon, 07 Dec 2015 14:43:48 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 7 Dec 2015 14:43:48 -0800 (PST)
In-Reply-To: <1449413906-23256-1-git-send-email-rouzier@gmail.com>
X-Google-Sender-Auth: wT_UWXHYhYaLm_koUMJjfMBat50
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282134>

On Sun, Dec 6, 2015 at 9:58 AM, James <rouzier@gmail.com> wrote:
> From: James Rouzier <rouzier@gmail.com>

This would be a good place to explain how you are modernizing the test
script. Right now, you're just updating to take advantage of
test_path_is_foo(), but some other modernizations you could do
include:

* using '>' rather than 'touch' to create empty files when the
timestamp doesn't matter (which is all cases in this script)

* (optional) replace unnecessarily complex 'mkdir -p foo' with simpler
'mkdir foo' (but leave "mkdir -p foo/bar" as is)

* drop blank lines before and after test body; for instance:

    test_expect_success 'foo' '

        blah &&
        bloo

    '

becomes:

    test_expect_success 'foo' '
        blah &&
        bloo
    '

> ---
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> @@ -609,32 +609,30 @@ test_expect_success 'force removal of nested git work tree' '
>  test_expect_success 'git clean -e' '
>         rm -fr repo &&
>         mkdir repo &&
> -       (
> -               cd repo &&
> -               git init &&
> -               touch known 1 2 3 &&
> -               git add known &&
> -               git clean -f -e 1 -e 2 &&
> -               test -e 1 &&
> -               test -e 2 &&
> -               ! (test -e 3) &&
> -               test -e known
> -       )
> +       cd repo &&

The previous working directory is not automatically restored at the
end of the test, so this "cd" without corresponding "cd .." causes
following tests to execute at the incorrect location. Unfortunately,
you can't just place "cd .." at the end of a test since it will be
skipped if something before the "cd .." fails. The way the existing
code deals with this is by using a subshell:

    mkdir repo &&
    (
        cd repo &&
        ...
    )

The "cd repo" is inside the subshell, so it doesn't affect the parent
shell, and when the subshell exits, the parent shell remains at the
correct working directory (regardless of whether the test succeeded or
failed). Therefore, you don't want to drop the subshell.

> +       git init &&
> +       touch known 1 2 3 &&
> +       git add known &&
> +       git clean -f -e 1 -e 2 &&
> +       test_path_is_file 1 &&
> +       test_path_is_file 2 &&
> +       test_path_is_missing 3 &&
> +       test_path_is_file known
>  '
