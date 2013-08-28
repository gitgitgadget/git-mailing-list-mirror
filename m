From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH v2 2/3] submodule: introduce --[no-]display-comment-char
Date: Wed, 28 Aug 2013 23:07:00 +0200
Message-ID: <521E6674.1010201@web.de>
References: <vpqhaeaasuf.fsf@anie.imag.fr> <1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr> <1377694024-24173-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j.sixt@viscovery.net,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 28 23:07:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEmxO-0002xE-8y
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776Ab3H1VHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 17:07:08 -0400
Received: from mout.web.de ([212.227.15.14]:59331 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755770Ab3H1VHH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 17:07:07 -0400
Received: from [192.168.178.41] ([91.3.168.10]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MfYTr-1VPT6p1zcx-00P8wl for <git@vger.kernel.org>;
 Wed, 28 Aug 2013 23:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1377694024-24173-2-git-send-email-Matthieu.Moy@imag.fr>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:MZBX5SrvkaEMpo1qADhlcTBAtwlC1v6sz5X5oiv122sh+E8WvAW
 cYBU21YbnIqIou1RVpXQm/e3RTwJ3P9FUJCwOciw8HU6sTyyllhAfUunZ0QpZ5/XC3SOBM0
 C+lmecZLULeOsPuJtTX2a2DntuGbJWRp8C/Ungl0wYXqjZAgXV4CZZkI+Ss6jisi4895Tjw
 GCozikNeoAfPayhO5e0tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233215>

Am 28.08.2013 14:47, schrieb Matthieu Moy:
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> (--for-status was undocumented, so I didn't bother documenting this either)

That's fine, as both if these options will - hopefully - only be used
by wt-status.c internally.

But I'm not terribly happy about having the --for-status option in the
submodule script in the first place, as I believe it should rather be
handled by wt-status.c itself (reading the output of submodule summary
using the start_command()/finish_command() combo instead of the simple
run_command() currently used and prepending the comment char by using
status_printf() & friends for each line).

Having said that (and currently not having the time to do the above
myself), if we go along the route you are currently taking I'd prefer
to only add one other to-be-obsoleted-some-time-later option to the
submodule script. So what about only adding --no-display-comment-char
(and maybe call it --drop-status-comment-char or such to make meaning
and context a bit more obvious ;-)?

>  git-submodule.sh | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2979197..ac0fdad 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -966,6 +966,7 @@ set_name_rev () {
>  cmd_summary() {
>  	summary_limit=-1
>  	for_status=
> +	display_comment_char=t
>  	diff_cmd=diff-index
>  
>  	# parse $args after "submodule ... summary".
> @@ -981,6 +982,12 @@ cmd_summary() {
>  		--for-status)
>  			for_status="$1"
>  			;;
> +		--display-comment-char)
> +			display_comment_char=t
> +			;;
> +		--no-display-comment-char)
> +			display_comment_char=
> +			;;
>  		-n|--summary-limit)
>  			summary_limit="$2"
>  			isnumber "$summary_limit" || usage
> @@ -1151,13 +1158,18 @@ cmd_summary() {
>  		echo
>  	done |
>  	if test -n "$for_status"; then
> +		if test -n "$display_comment_char"; then
> +			filter_cmd='git stripspace -c'
> +		else
> +			filter_cmd=cat
> +		fi
>  		if [ -n "$files" ]; then
> -			gettextln "Submodules changed but not updated:" | git stripspace -c
> +			gettextln "Submodules changed but not updated:" | $filter_cmd
>  		else
> -			gettextln "Submodule changes to be committed:" | git stripspace -c
> +			gettextln "Submodule changes to be committed:" | $filter_cmd
>  		fi
> -		printf "\n" | git stripspace -c
> -		git stripspace -c
> +		printf "\n" | $filter_cmd
> +		$filter_cmd
>  	else
>  		cat
>  	fi
> 
