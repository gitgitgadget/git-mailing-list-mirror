From: Junio C Hamano <gitster@pobox.com>
Subject: Re: mergetool: include custom tools in '--tool-help'
Date: Sun, 27 Jan 2013 10:03:19 -0800
Message-ID: <7vobgawljs.fsf@alter.siamese.dyndns.org>
References: <20130127163442.GQ7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 27 19:03:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzWa4-0007WU-Cb
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 19:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab3A0SDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 13:03:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265Ab3A0SDW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 13:03:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 805D7C998;
	Sun, 27 Jan 2013 13:03:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bEQ0Tvv9+iEsroqttPTHuNAvM6o=; b=fqWIvQ
	JLsw/yA6E0nhZnRc9PW7pgN5rLAY4NmXxX6LwqlZ8vHri3QxHR76SLKGyR8zDsWl
	axXAwSF7pA6a3H+69D5/vW1Fv4guttdx4zOR7XpM2nMer1L0HaTIeypINwyZ8cui
	PYWeRfI9i2ZKIv5qbxul5OxEL4uuWz1HdechE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x4wyr0O7Va2eEoMOLqCgwOx/vpnDn/uQ
	PaDyMLj72M+i8447hMQjXl7CfjCDcJnHY8BGOHHYzCG5I2j4iJ4I1P9PfbixAEIS
	sGIUCgjHEBY3iYQUhnwETnARK3h71Jqr1P3z1GarZZgJHadwx8VxFDpoCAQORu2g
	zRZoHc/i8NI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 749AEC997;
	Sun, 27 Jan 2013 13:03:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9792C993; Sun, 27 Jan 2013
 13:03:20 -0500 (EST)
In-Reply-To: <20130127163442.GQ7498@serenity.lan> (John Keeping's message of
 "Sun, 27 Jan 2013 16:34:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5A69A1E-68AB-11E2-8600-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214712>

John Keeping <john@keeping.me.uk> writes:

> 'git mergetool --tool-help' only lists builtin tools, not those that the
> user has configured via a 'mergetool.<tool>.cmd' config value.  Fix this
> by inspecting the tools configured in this way and adding them to the
> available and unavailable lists before displaying them.

Although I am not a mergetool user, I would imagine that it would
make sense to show it as available.

Just like "git help -a" lists subcommands in a way that can be easy
to tell which ones are the standard ones and which ones are user
customizations, this may want to give a similar distinction, though.
I dunno.

>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> After the recent changes to mergetool, do we want to do something like
> this as well, so that 'git mergetool --tool-help' will display any tools
> configured by the user/system administrator?
>
> This is on top of jk/mergetool.
>
>  git-mergetool--lib.sh | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 1d0fb12..f9a617c 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -206,6 +206,29 @@ list_merge_tool_candidates () {
>  	esac
>  }
>  
> +# Adds tools from git-config to the available and unavailable lists.
> +# The tools are found in "$1.<tool>.cmd".
> +add_config_tools() {
> +	section=$1
> +
> +	eval $(git config --get-regexp $section'\..*\.cmd' |
> +		while read -r key value
> +		do
> +			tool=${key#mergetool.}
> +			tool=${tool%.cmd}
> +
> +			tool=$(echo "$tool" |sed -e 's/'\''/'\''\\'\'\''/g')
> +
> +			cmd=$(eval -- "set -- $value"; echo "$1")
> +			if type "$cmd" >/dev/null 2>&1
> +			then
> +				echo "available=\"\${available}\"'$tool'\"\$LF\""
> +			else
> +				echo "unavailable=\"\${unavailable}\"'$tool'\"\$LF\""
> +			fi
> +		done)
> +}
> +
>  show_tool_help () {
>  	unavailable= available= LF='
>  '
> @@ -223,6 +246,12 @@ show_tool_help () {
>  		fi
>  	done
>  
> +	add_config_tools mergetool
> +	if diff_mode
> +	then
> +		add_config_tools difftool
> +	fi
> +
>  	cmd_name=${TOOL_MODE}tool
>  	if test -n "$available"
>  	then
