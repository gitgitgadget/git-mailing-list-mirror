From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/7] t5520: test work tree fast-forward when fetch updates head
Date: Sat, 2 May 2015 22:42:52 -0400
Message-ID: <CAPig+cTBm9iN8bFEZx3rHzYhwapSk4wYcAQXiqtu_BzxNd9VSA@mail.gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<1430581035-29464-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 04:48:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yojwu-00089A-KV
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 04:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbbECCmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 22:42:54 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37565 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbECCmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 22:42:53 -0400
Received: by igblo3 with SMTP id lo3so61393351igb.0
        for <git@vger.kernel.org>; Sat, 02 May 2015 19:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qKEQ4q0dgsg59pINGPq4YfcPVTcJmySA4/y5cVnmXQk=;
        b=b/cipL0nrbX2fROMbE06FDYLuPKIrQCNFY57wLwld9BC/qOHU7Yq4ZBMlRpOhMSOZO
         ALOfLYXrCe4cBlAV8CU50h3ZoTFJA0bF/xh8u1B38aufRvkTjwAOAYwXq6E4p0F1cmau
         iciIRL+yHJwthJGdwqrOC2u1ieAu0uEg8X9FoBDyAc0ykY/7DE/KlHxLzo8EAH4dtjZz
         rBdT0r644Drf36fRKqulFjcFqeFHRJs2KcNd6UvTZ5VPTLd7GHEwxge7bHlZ1arShhAX
         K/TzfF41TrZf/9nZM5dbfFOn4zQfJRgXCtKC29feJqeIxQP89IkGYq6OvQwogmgNJHTP
         /hOw==
X-Received: by 10.42.67.80 with SMTP id s16mr21510152ici.25.1430620972386;
 Sat, 02 May 2015 19:42:52 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sat, 2 May 2015 19:42:52 -0700 (PDT)
In-Reply-To: <1430581035-29464-5-git-send-email-pyokagan@gmail.com>
X-Google-Sender-Auth: DVEttVZidDJO4xKOwnwbrTxa1N8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268255>

On Sat, May 2, 2015 at 11:37 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Since commit b10ac50f (Fix pulling into the same branch), git-pull,
> upon detecting that git-fetch updated the current head, will
> fast-forward the working tree to the updated head commit.
>
> Implement tests to ensure that the fast-forward occurs in such a case,
> as well as to ensure that the user-friendly advice is printed upon
> failure.

Missing sign-off.

> ---
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 9f57e0d..25d519d 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -189,6 +189,27 @@ test_expect_success 'fail if the index has unresolved entries' '
>         test_i18ngrep "You have not concluded your merge" out
>  '
>
> +test_expect_success 'fast-forwards working tree if branch head is updated' '
> +       git checkout -b third master^ &&
> +       test_when_finished "git checkout -f copy && git branch -D third" &&
> +       echo file >expected &&
> +       test_cmp expected file &&
> +       git pull . second:third 2>out &&
> +       test_i18ngrep "fetch updated the current branch head" out &&
> +       echo modified >expected &&
> +       test_cmp expected file
> +'
> +
> +test_expect_success 'fast-forward fails with conflicting work tree' '
> +       git checkout -b third master^ &&
> +       test_when_finished "git checkout -f copy && git branch -D third" &&
> +       echo file >expected &&
> +       test_cmp expected file &&
> +       echo conflict >file &&
> +       test_must_fail git pull . second:third 2>out &&
> +       test_i18ngrep "Cannot fast-forward your working tree" out
> +'
> +
>  test_expect_success '--rebase' '
>         git branch to-rebase &&
>         echo modified again > file &&
> --
> 2.1.4
