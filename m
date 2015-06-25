From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] bisect: use refs infrastructure for BISECT_START
Date: Thu, 25 Jun 2015 13:52:40 -0700
Message-ID: <xmqq616by0h3.fsf@gitster.dls.corp.google.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
	<1435265110-6414-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 22:52:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8E8d-0003uV-IK
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbbFYUwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:52:44 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33055 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbFYUwm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:52:42 -0400
Received: by igbqq3 with SMTP id qq3so24067072igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=j837etk3bEI3dxWT38Jh5rPGERKNsxP8NULuF9eTWq4=;
        b=VFPbFsNW1dHGFP7m7PhzRVLXj82++BkDFjOIQk6IHvbj7i+fSiCqggOmk2MeDW0OPB
         FOa0uCQ/9jZyeX+uGN5LbVwsNQkRTyHZs9i8rb+kz4qqbSRBRcPC9ZbH5i/pNmxQMXRx
         aB31eNxO4KvxxArPu3eKs51n2nxIAN/Cn6cKJU/gXyEzYpMtYLty+T/yZgS07WTqkAC0
         /nUeC+Y7rbu7LYFK2JvalB++ltCI2o8perRR1vRB2Of7Mcd5D5MP3up0M6JBYNkwPYlB
         WSgHpifYYWXrjcPe/4kcxN8tNAqZV3nFk/LLNczTdRpchA07KezovrbnoZfTw27HHIQV
         opiQ==
X-Received: by 10.50.13.34 with SMTP id e2mr6611931igc.23.1435265561980;
        Thu, 25 Jun 2015 13:52:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id ij4sm4067117igb.7.2015.06.25.13.52.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 13:52:41 -0700 (PDT)
In-Reply-To: <1435265110-6414-3-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 25 Jun 2015 16:45:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272732>

David Turner <dturner@twopensource.com> writes:

> This ref needs to go through the refs backend, since some code assumes
> that it can be written and read as a ref.

And the reason why BISECT_HEAD cannot be treated as a ref, but must
be treated as a file under $GIT_DIR, is...?

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
