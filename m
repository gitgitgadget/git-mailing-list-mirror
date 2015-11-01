From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] t5509: add basic tests for hideRefs
Date: Sun, 1 Nov 2015 16:13:51 -0500
Message-ID: <CAPig+cR7sCqigz=--_d-bW0X=+vpbV-_N9hxriLH9fMjLJUfsA@mail.gmail.com>
References: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
	<1446406463-22527-5-git-send-email-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Sun Nov 01 22:13:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zszwq-0006LC-Cf
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 22:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbbKAVNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 16:13:52 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33576 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbbKAVNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 16:13:52 -0500
Received: by vkgy127 with SMTP id y127so75374238vkg.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 13:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CB1WH7Llvf6xXX442FW7obwK47y/LdTjVWzExBv+W/k=;
        b=xtAkj2iK4/ITwJNJR5Xi8RPF5lVLIbXD8eloQPvb1b9BN+XDm/u19KNXaljS8UxsO7
         BURRThPjJGlCeXA/c0Np6GoOQLOPuwb6g/kSridmERqUAiz89Qsil9aEUbD/vVWN6JTP
         HFpZB7d1jZeVVcFtjHipZEuEv+jXFkh1h+IFarxUc4PMJ/tIeF7nWAPs7CX1D0vkoM77
         xE8gxUG3i+hUGvX2zfUgUcU/ilhCuFZn8fv6a74xFGq1Z45iGBg6vOxEJgt6CMRVCH3M
         YY21chEB2glsAOhOZscZrAPZpALykaRaSIPfZwaUb8wI/IJPU1ej0s9rlDncXEbOvYYt
         NI1Q==
X-Received: by 10.31.163.85 with SMTP id m82mr11377334vke.19.1446412431517;
 Sun, 01 Nov 2015 13:13:51 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 13:13:51 -0800 (PST)
In-Reply-To: <1446406463-22527-5-git-send-email-lfleischer@lfos.de>
X-Google-Sender-Auth: IABs2G8sSI2H3prFTORAr0b8kSc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280671>

On Sun, Nov 1, 2015 at 2:34 PM, Lukas Fleischer <lfleischer@lfos.de> wrote:
> Test whether regular and full hideRefs patterns work as expected when
> namespaces are used.
>
> Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> ---
> diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
> @@ -82,4 +82,33 @@ test_expect_success 'mirroring a repository using a ref namespace' '
>         )
>  '
>
> +test_expect_success "Hide namespaced refs with transfer.hideRefs" '

None of the other tests in this file capitalize the test description.
These new test descriptions should probably follow suit by beginning
with lowercase. It is also typical to use single quotes for the
description rather than double.

> +       cd pushee &&
> +       test_config transfer.hideRefs refs/tags &&
> +       GIT_NAMESPACE=namespace git ls-remote "ext::git %s ." >actual &&
> +       printf "$commit1\trefs/heads/master\n" >expected &&
> +       test_cmp expected actual &&
> +       cd ..

If any of the commands above "cd .." fail, then "cd .." will never be
invoked, thus subsequent tests will fail since they won't be executed
in the expected directory. The typical way to handle this is to place
the "cd foo" and remaining test body in a subshell, and drop "cd .."
altogether. When the subshell exits (via success or failure), the
working directory will be restored automatically.

    test_expect_success '...' '
        (
            cd pushee &&
            test_config ... &&
            ...
        )
    '

> +'
> +
> +test_expect_success "Check that transfer.hideRefs does not match unstripped refs" '
> +       cd pushee &&
> +       test_config transfer.hideRefs "refs/namespaces/namespace/refs/tags" &&
> +       GIT_NAMESPACE=namespace git ls-remote "ext::git %s ." >actual &&
> +       printf "$commit1\trefs/heads/master\n" >expected &&
> +       printf "$commit0\trefs/tags/0\n" >>expected &&
> +       printf "$commit1\trefs/tags/1\n" >>expected &&
> +       test_cmp expected actual &&
> +       cd ..
> +'
> +
> +test_expect_success "Hide full refs with transfer.hideRefs" '
> +       cd pushee &&
> +       test_config transfer.hideRefs "^refs/namespaces/namespace/refs/tags" &&
> +       GIT_NAMESPACE=namespace git ls-remote "ext::git %s ." >actual &&
> +       printf "$commit1\trefs/heads/master\n" >expected &&
> +       test_cmp expected actual &&
> +       cd ..
> +'
> +
>  test_done
> --
> 2.6.2
