From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] pull: allow dirty tree when rebase.autostash enabled
Date: Mon, 06 Jul 2015 13:39:47 -0700
Message-ID: <xmqqd205yq98.fsf@gitster.dls.corp.google.com>
References: <1434538880-15608-1-git-send-email-me@ikke.info>
	<1436046158-19426-1-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Mon Jul 06 22:39:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCDBD-0001lN-73
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 22:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbbGFUjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 16:39:51 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38360 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbbGFUjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 16:39:49 -0400
Received: by igrv9 with SMTP id v9so125117087igr.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Cu+MV9Vra4z08YYUI89PFG4wYP3XuAHyYeV26cAf+24=;
        b=H99PxLuIR6Fsx3SvyE6vqvEufT74N599s4hgOgaRf3xPJ+G0ZEEupSrU1JOYaUHOrj
         sf47okpPStuD10bFimBwDHZfpRXLYGs7aje5DXLaJtGqCkUcXsZyIOZSnLjvySkAx2JT
         EFtxmtOm3nKHFrUwu1JhLjpdXcAjAITMq7Xo25WUMwDjW+TGFqDPJUYuRu21Eiy/emt5
         OgrfUpIr0GriH9wJk9ZwC6u9FgJtnD4+ygGr2bSPWhQzZYrFo98CaWBXsqYtRHULgESy
         MS26THQNERiORImLyZI0CSx/4WGCsyFIgWLawqtTVBkMGeDAMejUi+xNQ+KHRSAiFXDT
         GeYA==
X-Received: by 10.107.135.21 with SMTP id j21mr1028970iod.33.1436215189192;
        Mon, 06 Jul 2015 13:39:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by smtp.gmail.com with ESMTPSA id h2sm16812291igv.2.2015.07.06.13.39.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 13:39:48 -0700 (PDT)
In-Reply-To: <1436046158-19426-1-git-send-email-me@ikke.info> (Kevin Daudt's
	message of "Sat, 4 Jul 2015 23:42:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273457>

Kevin Daudt <me@ikke.info> writes:

> rebase learned to stash changes when it encounters a dirty work tree, but
> git pull --rebase does not.
>
> Only verify if the working tree is dirty when rebase.autostash is not
> enabled.
>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> Helped-by: Paul Tan <pyokagan@gmail.com>
> ---

I applied it, tried to run today's integration cycle, and then ended
up ejecting it from my tree for now, as this seemed to break 5520
when merged to 'pu' X-<.

Well, that is partly expected, as Paul's builtin/pull.c does not
know about it (yet).

>  git-pull.sh     |  3 ++-
>  t/t5520-pull.sh | 11 +++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index a814bf6..ff28d3f 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -284,7 +284,8 @@ test true = "$rebase" && {
>  		then
>  			die "$(gettext "updating an unborn branch with changes added to the index")"
>  		fi
> -	else
> +	elif test $(git config --bool --get rebase.autostash || echo false) = false
> +	then
>  		require_clean_work_tree "pull with rebase" "Please commit or stash them."
>  	fi
>  	oldremoteref= &&
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index f4a7193..a0013ee 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -245,6 +245,17 @@ test_expect_success '--rebase fails with multiple branches' '
>  	test modified = "$(git show HEAD:file)"
>  '
>  
> +test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
> +	test_config rebase.autostash true &&
> +	git reset --hard before-rebase &&
> +	echo dirty >new_file &&
> +	git add new_file &&
> +	git pull --rebase . copy &&
> +	test_cmp_rev HEAD^ copy &&
> +	test "$(cat new_file)" = dirty &&
> +	test "$(cat file)" = "modified again"
> +'
> +
>  test_expect_success 'pull.rebase' '
>  	git reset --hard before-rebase &&
>  	test_config pull.rebase true &&
