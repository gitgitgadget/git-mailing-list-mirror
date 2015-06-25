From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] bisect: use refs infrastructure for BISECT_START
Date: Thu, 25 Jun 2015 09:52:03 -0700
Message-ID: <xmqqr3ozzq6k.fsf@gitster.dls.corp.google.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
	<1435173388-8346-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:52:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ANo-0008Rv-0g
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 18:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbbFYQwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 12:52:08 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35922 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbbFYQwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 12:52:06 -0400
Received: by igbiq7 with SMTP id iq7so123066694igb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=R3tFeJ7yAZ1RmoQi6APbB3XFcrzooVrj8b8CvseJzEQ=;
        b=qjJZinjttDH8OcUl4jMHEHQ0/sloNW+cvZhA2Wy6iBH4IN6wl82JsqHZSrF3W9CrNc
         nl4BCmVEaiH/r9+K0iVFlWi5J0FNmuDMq7vu2WFiI2CmkaU954zdiRGArh2wn68aNRwD
         vEuiNyOlAnjcvBxMSODt0gbRfWTFadvf8CjlsIiq+6SnI/547LVl3MrahFR7g6MdhAlR
         Hzn+KcMSY9sp1KKa6Gw7ffrARzyDENB9WB7b8iK5zTnoCCk8q/dGGwxbcP7Ea3YarxcS
         0oSE2tyUISkrB0uaBVh3NHsMhRvl3JirfgqQof7i0FQ6mf6MgSXd3je2G6t/Yb7dS+al
         K1ng==
X-Received: by 10.50.30.197 with SMTP id u5mr5459705igh.9.1435251125649;
        Thu, 25 Jun 2015 09:52:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id k74sm19933753iok.30.2015.06.25.09.52.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 09:52:05 -0700 (PDT)
In-Reply-To: <1435173388-8346-4-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 24 Jun 2015 15:16:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272694>

David Turner <dturner@twopensource.com> writes:

> This ref needs to go through the refs backend, since some code assumes
> that it can be written and read as a ref.

And BISECT_HEAD should no longer be a ref because...?

>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  git-bisect.sh                          | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 93716c4..c4d4d80 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -938,7 +938,7 @@ _git_bisect ()
>  	local subcommands="start bad good skip reset visualize replay log run"
>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
>  	if [ -z "$subcommand" ]; then
> -		if [ -f "$(__gitdir)"/BISECT_START ]; then
> +		if [ git rev-parse BISECT_START 2>/dev/null ]; then
>  			__gitcomp "$subcommands"
>  		else
>  			__gitcomp "replay start"
> diff --git a/git-bisect.sh b/git-bisect.sh
> index ae3fec2..8658772 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -166,7 +166,7 @@ bisect_start() {
>  	#
>  	echo "$start_head" >"$GIT_DIR/BISECT_START" && {
>  		test "z$mode" != "z--no-checkout" ||
> -		git update-ref --no-deref BISECT_HEAD "$start_head"
> +		git rev-parse "$start_head" > "$GIT_DIR/BISECT_HEAD"
>  	} &&
>  	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
>  	eval "$eval true" &&
> @@ -399,7 +399,7 @@ bisect_clean_state() {
>  	rm -f "$GIT_DIR/BISECT_RUN" &&
>  	# Cleanup head-name if it got left by an old version of git-bisect
>  	rm -f "$GIT_DIR/head-name" &&
> -	git update-ref -d --no-deref BISECT_HEAD &&
> +	rm -f "$GIT_DIR/BISECT_HEAD" &&
>  	# clean up BISECT_START last
>  	rm -f "$GIT_DIR/BISECT_START"
>  }
