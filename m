From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] submodule update --init: correct path handling in recursive submodules
Date: Tue, 29 Mar 2016 12:46:26 -0700
Message-ID: <xmqqbn5xxe25.fsf@gitster.mtv.corp.google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
	<1459207703-1635-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:46:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzb8-0002Bv-BQ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757892AbcC2Tqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:46:31 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754110AbcC2Tqa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:46:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6A7AB507F2;
	Tue, 29 Mar 2016 15:46:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z5K9sRaSA9SQWlz1zJAvqlVj22Y=; b=B1HZ9w
	fwCZRY9JY/arrlPWjZAki6qTah+FGZssSHWD6dQWC4uFtcz8nv14twZtq8mxbWMU
	OBvW1bupH7etd5t4xj2O4npkETCfPwbKqA0dgR9akGRqFyJF1M2IH+oxNqHXCc0T
	jeHg4QLZ2bWEooToVnXVA2Mw/yZkr3YU0HPBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eqkNYfoNOGAU7PufoJLMCeicuQbEjXKd
	U+/F7+njBQn+d9xKQ3cfG7B0nGqkd8FBq23dDCwAZYJ7QNoXcm2iEeg7kEZnaypL
	J9dPtCmxz6zO4Knww2f+4Lw2vrySx8VawUfo9F/RpqFUubaq5jQgZC/wvFx2wlqo
	v7WuyFT5ZH0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6174C507F1;
	Tue, 29 Mar 2016 15:46:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CA578507F0;
	Tue, 29 Mar 2016 15:46:27 -0400 (EDT)
In-Reply-To: <1459207703-1635-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 28 Mar 2016 16:28:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED605098-F5E6-11E5-9911-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290175>

Stefan Beller <sbeller@google.com> writes:

> This fixes the test introduced by the parent commit.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

The first hunk in this patch touches lines that goes away with
d5bc3cd2 (submodule: port init from shell to C, 2016-03-14) on
your sb/submodule-init topic and the whole block is replaced
by a call to "submodule--helper init".

I'll drop the first hunk when merging this series to 'pu' for now;
hopefully you did not inherit the bug when rewriting the part into
"submodule--helper init".

Thanks.

>  git-submodule.sh            | 5 +++--
>  t/t7406-submodule-update.sh | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2838069..a7c8599 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -474,7 +474,7 @@ cmd_init()
>  		die_if_unmatched "$mode"
>  		name=$(git submodule--helper name "$sm_path") || exit
>  
> -		displaypath=$(relative_path "$sm_path")
> +		displaypath=$(relative_path "$prefix$sm_path")
>  
>  		# Copy url setting when it is not set yet
>  		if test -z "$(git config "submodule.$name.url")"
> @@ -826,8 +826,9 @@ Maybe you want to use 'update --init'?")"
>  		if test -n "$recursive"
>  		then
>  			(
> -				prefix="$prefix$sm_path/"
> +				prefix="$(relative_path $prefix$sm_path)/"
>  				clear_local_git_env
> +				wt_prefix=
>  				cd "$sm_path" &&
>  				eval cmd_update
>  			)
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index c1b9ffa..3bd1552 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -118,7 +118,7 @@ Submodule path '../super/rebasing': checked out '${rebasingsha1}'
>  Submodule path '../super/submodule': checked out '${submodulesha1}'
>  EOF
>  
> -test_expect_failure 'submodule update --init --recursive from subdirectory' '
> +test_expect_success 'submodule update --init --recursive from subdirectory' '
>  	git -C recursivesuper/super reset --hard HEAD^ &&
>  	(cd recursivesuper &&
>  	 mkdir tmp &&
