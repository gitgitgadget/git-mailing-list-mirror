From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mergetools: create mergetool_find_win32_cmd() helper function for winmerge
Date: Fri, 25 Mar 2016 16:00:06 -0700
Message-ID: <xmqqio0a17ux.fsf@gitster.mtv.corp.google.com>
References: <xmqq60wbc24h.fsf@gitster.mtv.corp.google.com>
	<1458946376-30296-1-git-send-email-jacob.nisnevich@gmail.com>
	<1458946376-30296-2-git-send-email-jacob.nisnevich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: davvid@gmail.com, git@vger.kernel.org
To: Jacob Nisnevich <jacob.nisnevich@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 00:00:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajaiI-0004v9-9k
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbcCYXAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:00:11 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753828AbcCYXAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:00:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B9675007E;
	Fri, 25 Mar 2016 19:00:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v3wyRcgH03iFV6N1tzro9ke9UXQ=; b=VK5BOk
	uO1zZvGhARt4T9x7dKd8YSKAsdYa46IgE+eb/fgxoTXpVZS9rl/413NbXNR4BB3q
	6yE5SF6GpC5otXrUFVgcJISxEcGADkZZ80D3VnskJqvE0h/xsQQne9vFiVdLEyxD
	RfV+/aRHweR/99OBpj3IqxsI7CbKRhCUFyUVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VShRuFEgdPzolv+oNuXxI/3oC62H0pGy
	vyfaskNbnBTSDC3sbOMfoJHXoChTx182/tO9UOBdR/DVM2+Vm8VeLKzL1shTbUkR
	YtBGNA1aPDfHMHOP9ZcGHeqajEUdMBVFknSuFhREAMzbIyb1TYZtpa5nnU4nCMWv
	hUFWWe+Kr+U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21C745007C;
	Fri, 25 Mar 2016 19:00:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D58715006F;
	Fri, 25 Mar 2016 19:00:07 -0400 (EDT)
In-Reply-To: <1458946376-30296-2-git-send-email-jacob.nisnevich@gmail.com>
	(Jacob Nisnevich's message of "Fri, 25 Mar 2016 15:52:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 51CEF38E-F2DD-11E5-BA8F-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289963>

Jacob Nisnevich <jacob.nisnevich@gmail.com> writes:

> Signed-off-by: Jacob Nisnevich <jacob.nisnevich@gmail.com>
> ---
>  git-mergetool--lib.sh | 25 +++++++++++++++++++++++++
>  mergetools/winmerge   | 21 +--------------------
>  2 files changed, 26 insertions(+), 20 deletions(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 54ac8e4..c5fa820 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -372,3 +372,28 @@ get_merge_tool () {
>  	fi
>  	echo "$merge_tool"
>  }
> +
> +mergetool_find_win32_cmd () {
> +	executable=$1
> +	folder=$2
> +
> +	# Use executable.com if it exists in $PATH

s/executable.com/$executable/

> +	if type -p $executable >/dev/null 2>&1

This needs to be quoted,

	if type -p "$executable" >/dev/null 2>&1

> +	then
> +		printf '%s' $executable

Likewise.

> +		return
> +	fi
> +
> +	# Look for executable in the typical locations
> +	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
> +		cut -d '=' -f 2- | sort -u)
> +	do
> +		if test -n "$directory" && test -x "$directory/$folder/$executable"
> +		then
> +			printf '%s' "$directory/$folder/$executable"
> +			return
> +		fi
> +	done
> +
> +	printf '%s' $executable

Likewise.

Other than these points, I do not see anything wrong in this patch.
Thanks.

By the way, "directory/folder/stuff" sounds somewhat strange, no?
