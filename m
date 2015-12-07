From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] clean: new option --exclude-from
Date: Mon, 7 Dec 2015 17:53:33 -0500
Message-ID: <CAPig+cQb754exY9KTTyohTqoin_uzRspQwrmeoDeJ5bQ=0jzLQ@mail.gmail.com>
References: <CAPig+cRa31uriO4qkZUydooNx0V+dNrUgFvTUxoLL9gCjq9AHQ@mail.gmail.com>
	<1449413906-23256-1-git-send-email-rouzier@gmail.com>
	<1449413906-23256-2-git-send-email-rouzier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: James <rouzier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 23:53:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a64fC-00075i-AV
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 23:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656AbbLGWxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 17:53:36 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34808 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574AbbLGWxe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 17:53:34 -0500
Received: by vkbs1 with SMTP id s1so1396719vkb.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 14:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wrTJd9fFLf69M2VBl3rHZfSW+opdKLCOlUE3exxq/gA=;
        b=HOTyTbZx6y9coGdIgx8JNtX8IqEuhb4hB6kqDvxxE5ofUPAwDSz9Rxu4PeRLY6m3MI
         WQbDhJ3wKJGZTnDl5e67NMxFRTdJShPNxkb7LHY2HvxvdeUCpGiyBnWlcc5ZcV2I2Buq
         8slg6tIH8HsGwXUBU07YMrH/uQOHgr/2WHJnxQusCtpvNW8im2+Y0hx4CxFR+rMdws1Y
         /9bHQLNW9TquMMWPABTzTuznwaEsjMqGygXeRO9AF4BBj7wpnEzGrh0N2AywGeSh0n2j
         HPssbTkTn2EVQZFq2kGPKG/nLxJChFvdqab3DXa1MQb/CzkU6K3UPhmmKeG0+TiHoUoF
         Ilog==
X-Received: by 10.31.13.205 with SMTP id 196mr252864vkn.37.1449528813901; Mon,
 07 Dec 2015 14:53:33 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 7 Dec 2015 14:53:33 -0800 (PST)
In-Reply-To: <1449413906-23256-2-git-send-email-rouzier@gmail.com>
X-Google-Sender-Auth: WrvA6xwl0RVrKlZMnK0XMb0x7FM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282137>

In addition to Peff's and Junio's review comments...

On Sun, Dec 6, 2015 at 9:58 AM, James <rouzier@gmail.com> wrote:
> From: James Rouzier <rouzier@gmail.com>
>
> Specify a file to read for exclude patterns.

Missing Signed-off-by:.

> ---
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> @@ -628,6 +628,66 @@ test_expect_success 'git clean -e' '
> +test_expect_success 'git clean --exclude-from' '
> +       rm -fr repo &&
> +       mkdir repo &&
> +       cd repo &&

See my review comments for patch 1/2 as to why you want to wrap 'cd'
and remaining statements in a subshell.

> +       git init &&
> +       touch known 1 2 3 &&

Likewise, use '>' rather than 'touch' to create empty files when the
timestamp isn't significant.

   >1 &&
   >2 &&
   >3 &&

> +       git add known &&
> +       cat >.git/clean-exclude <<-\EOF &&
> +       1
> +       2
> +       EOF
> +       git clean -f --exclude-from=.git/clean-exclude &&
> +       test_path_is_file 1 &&
> +       test_path_is_file 2 &&
> +       test_path_is_missing 3 &&
> +       test_path_is_file known
> +'
> +
> +test_expect_success 'git clean -e --exclude-from' '
> +       rm -fr repo &&
> +       mkdir repo &&
> +       cd repo &&
> +       git init &&
> +       touch known 1 2 3 &&
> +       git add known &&
> +       echo 1 >> .git/clean-exclude &&
> +       git clean -f -e 2 --exclude-from=.git/clean-exclude &&
> +       test_path_is_file 1 &&
> +       test_path_is_file 2 &&
> +       test_path_is_missing 3 &&
> +       test_path_is_file known
> +'
> +
> +test_expect_success 'git clean --exclude-from --exclude-from' '
> +       rm -fr repo &&
> +       mkdir repo &&
> +       git init &&
> +       touch known 1 2 3 &&
> +       git add known &&
> +       cat >.git/clean-exclude1 <<-\EOF &&
> +       1
> +       EOF
> +       cat >.git/clean-exclude2 <<-\EOF &&
> +       2
> +       EOF

Creation of these single-line files probably would be more readable
using 'echo', as you do in the test just above (for
.git/clean-exclude):

    echo 1 >.git/clean-exclude1 &&
    echo 2 >.git/clean-exclude2 &&

> +       git clean -f --exclude-from=.git/clean-exclude1 --exclude-from=.git/clean-exclude2 &&
> +       test_path_is_file 1 &&
> +       test_path_is_file 2 &&
> +       test_path_is_missing 3 &&
> +       test_path_is_file known
> +'
> +
> +test_expect_success 'git clean --exclude-from=BADFILE' '
> +       rm -fr repo &&
> +       mkdir repo &&
> +       cd repo &&
> +       git init &&
> +       test_expect_code 128 git clean -f --exclude-from=.git/clean-exclude-not-there
> +'
> +
>  test_expect_success SANITY 'git clean -d with an unreadable empty directory' '
>         mkdir foo &&
>         chmod a= foo &&
> --
> 2.3.6
