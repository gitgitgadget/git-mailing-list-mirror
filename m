From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] pull: allow dirty tree when rebase.autostash enabled
Date: Wed, 17 Jun 2015 08:36:34 -0700
Message-ID: <xmqqh9q64a9p.fsf@gitster.dls.corp.google.com>
References: <1433625145-29668-2-git-send-email-me@ikke.info>
	<1434538880-15608-1-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Wed Jun 17 17:36:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5FOL-0002BC-RK
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 17:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905AbbFQPgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 11:36:37 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33305 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691AbbFQPgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 11:36:36 -0400
Received: by igbos3 with SMTP id os3so71366171igb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=be454q2Qv/zF9Z1EHsY+yymt3kqpiOh9FTqpTZUi6Jg=;
        b=D2aOi+7j+94G/4mF5ISZrKHxUpaSqZjtYr0QsTCS9SOL00VqMdsVgN/1IryAc+E1/X
         zziWwBU4tGyouoKwXTR9KY213MCy9WMS4RG3izZ8d2E4FryLBMEPmBRZdjAHJ2L7dvEz
         B1BLRrPTw6CqZooewLJCtAhhfyDaJm+X7GUyODN5H7QkNxpoOt04EpdEaPtiT0H//Zzp
         IoaGzdF+jLjRRI53QKVVrfIEzZygU4sOgNPdmOMa0jBwkAIgnAWhv8ew1hLcvpHeoDct
         L6mSI2iwPiriy3j+g9LrKNdf+drCAbqUFjloPhkVIjxsksDKoThQFjsE6f3N4NWFOB86
         QddA==
X-Received: by 10.50.141.164 with SMTP id rp4mr36519945igb.2.1434555396116;
        Wed, 17 Jun 2015 08:36:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id 77sm2805369ioi.20.2015.06.17.08.36.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 08:36:35 -0700 (PDT)
In-Reply-To: <1434538880-15608-1-git-send-email-me@ikke.info> (Kevin Daudt's
	message of "Wed, 17 Jun 2015 13:01:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271858>

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
> Changes to v2:
>  - Dropped the change of the existing --rebase test
>  - Improvements to the test.
>
> Verified that the test fails before the change, and succeeds after the change.
>
>  git-pull.sh     |  5 ++++-
>  t/t5520-pull.sh | 11 +++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 0917d0d..f0a3b6e 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -239,7 +239,10 @@ test true = "$rebase" && {
>  			die "$(gettext "updating an unborn branch with changes added to the index")"
>  		fi
>  	else
> -		require_clean_work_tree "pull with rebase" "Please commit or stash them."
> +		if [ $(git config --bool --get rebase.autostash || echo false) = false ]

Style (use of []).

Shouldn't you be doing

	if ...
	then        	
		on an unborn
	elif we are not doing autostash
		require clean work tree
	fi

which does not need unnecessarily deep nesting?

> +		then
> +			require_clean_work_tree "pull with rebase" "Please commit or stash them."
> +		fi
>  	fi
>  	oldremoteref= &&
>  	test -n "$curr_branch" &&
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index af31f04..aa247ec 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -233,6 +233,17 @@ test_expect_success '--rebase fails with multiple branches' '
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
