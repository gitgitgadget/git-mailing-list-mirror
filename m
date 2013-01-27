From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] mergetool--lib: Add functions for finding available
 tools
Date: Sun, 27 Jan 2013 14:31:37 -0800
Message-ID: <7vvcaitfzq.fsf@alter.siamese.dyndns.org>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
 <1359321886-80523-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:32:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzale-0002Pj-As
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 23:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767Ab3A0Wbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 17:31:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199Ab3A0Wbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 17:31:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42AC1C983;
	Sun, 27 Jan 2013 17:31:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6u1TWVFgd1XjR35A2FyQQpDyjFk=; b=wBX/KP
	ImRInnyqV+UkhsZ3PomjnIOVaF4Jzhk4BXVVs8u9EoFbzKser7w2xngWlHdiI7Hc
	+i0aAEouOA/3x+k07pSxrtnRishjZSLHP+g+YLq9dhueG+PqIiTGpXB7v8D64J9w
	wQh/rHfO1mWpQvMUBQNBpKRWm6S05NB7mTToI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G2z0tYEcYd/QZO/lG1vU3L6L6Xvf++Do
	u2Tz/nIP7SafKuSwkusBeptfVfJU579gOBGDGifGX+GKbYkzrbYXZByGi/f66Z9j
	FmHu+3f6VcwQ/Wy7/GpmiRcOTaS2EmbALUzvnLD2zigjvGb/SagK3f3zlceBKVO9
	JoduV/xs12o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 384DFC981;
	Sun, 27 Jan 2013 17:31:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC941C980; Sun, 27 Jan 2013
 17:31:38 -0500 (EST)
In-Reply-To: <1359321886-80523-4-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 13:24:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50C60214-68D1-11E2-9A45-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214742>

David Aguilar <davvid@gmail.com> writes:

> Refactor show_tool_help() so that the tool-finding logic is broken out
> into separate functions.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool--lib.sh | 60 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index cf52423..894b849 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -2,6 +2,33 @@
>  # git-mergetool--lib is a library for common merge tool functions
>  MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
>  
> +mode_ok () {
> +	diff_mode && can_diff ||
> +	merge_mode && can_merge
> +}

I think you got the operator precedence mixed up.

What happens when diff_mode=true, can_diff=true, merge_mode=true and
can_merge=false?

	if true && true || true && false
	then
		echo OK
	else
		echo NO
	fi
	if (true && true) || (true && false)
	then
		echo OK
	else
		echo NO
	fi

> +is_available () {
> +	merge_tool_path=$(translate_merge_tool_path "$1") &&
> +	type "$merge_tool_path" >/dev/null 2>&1
> +}
> +
> +filter_tools () {
> +	filter="$1"
> +	prefix="$2"
> +	(
> +		cd "$MERGE_TOOLS_DIR" &&
> +		for i in *
> +		do
> +			echo "$i"
> +		done
> +	) | sort | while read tool
> +	do

Please start a new line before keywords that define the syntactic
structure, like "while", i.e.

	... piped | commands |
	while read tool
	do
		...
