From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 22/23] worktree: add: auto-vivify new branch when <branch> is omitted
Date: Mon, 06 Jul 2015 12:19:14 -0700
Message-ID: <xmqqpp45ytzh.fsf@gitster.dls.corp.google.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
	<1436203860-846-23-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 21:19:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCBvG-000404-78
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 21:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbbGFTTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 15:19:18 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36258 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbbGFTTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 15:19:17 -0400
Received: by iecvh10 with SMTP id vh10so120176784iec.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pqimn+3joVgbIS3R8u0eC6SpWPZmdglEkIaBO6MF7gg=;
        b=xOUbv38IvAeeJEaftlxbRKJEprokiPDahV0AJ6i6U4dEmWmZtWzIKiB7LR9yzQX8qM
         QudIwvHkW28BC4os5ZKDRpp3igXfnKITYNLYftL+PVuUlXXSi0t1LTCqzFbJOcquggp0
         sxCNNDNWQdFLdLDHmyONPxlymLycK6e1WGx9WV3cuZfBH/i1gTS3GhYMKIBaxjAEiX0o
         OjQnTQF99I+vQUOSAH9mWKjnVY7GKB9Xsl+yWa9Nsk5BqAWUecZMzWrccrSa2R+ZNrIY
         Ce+87atGFHCAKIsvhtJpqy/4Qd1eXcfYwXYeFHli7KsWbxw/RGNA613+uk0eBIKVhHZI
         G5gw==
X-Received: by 10.50.33.18 with SMTP id n18mr8017167igi.26.1436210356825;
        Mon, 06 Jul 2015 12:19:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id s5sm10267256igh.6.2015.07.06.12.19.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 12:19:16 -0700 (PDT)
In-Reply-To: <1436203860-846-23-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Mon, 6 Jul 2015 13:30:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273450>

Eric Sunshine <sunshine@sunshineco.com> writes:

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 377ae0f..da71f50 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -9,7 +9,7 @@ git-worktree - Manage multiple worktrees
>  SYNOPSIS
>  --------
>  [verse]
> -'git worktree add' [-f] [--detach] [-b <new-branch>] <path> <branch>
> +'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]

Ahh, OK, this answers my previous question.

> +	if (ac < 2 && !new_branch && !new_branch_force) {
> +		int n;
> +		const char *s = worktree_basename(path, &n);
> +		new_branch = xstrndup(s, n);
> +	}
> +

and because this is new_branch, not new_branch_force, we will not
accidentally clobber an existing branch.  The "hotfix" time is when
the end-user tends to be less careful, and it is a good thing to
make sure "git worktree add ../hotfix" will not clobber an unrelated
"hotfix" branch.

Good.

Which may be something we would want to have a test for, though.

> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 8964dec..8fe242f 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -145,4 +145,9 @@ test_expect_success '"add -b" with <branch> omitted' '
>  	test_cmp_rev HEAD burble
>  '
>  
> +test_expect_success '"add" with <branch> omitted' '
> +	git worktree add wiffle/bat &&
> +	test_cmp_rev HEAD bat
> +'
> +
>  test_done
