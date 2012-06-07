From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 22:59:24 +0200
Message-ID: <4FD1162C.50405@kdbg.org>
References: <4FD0D375.9060902@web.de> <1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de, git@vger.kernel.org
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 07 22:59:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scjnq-0003D5-UP
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 22:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825Ab2FGU72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 16:59:28 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:21244 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932511Ab2FGU71 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 16:59:27 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 33CF313004A;
	Thu,  7 Jun 2012 22:59:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E259F19F686;
	Thu,  7 Jun 2012 22:59:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199451>

Am 07.06.2012 18:46, schrieb Lucien Kong:
> +# Add commands after a pick or after a squash/fixup serie
> +# in the todo list.
> +add_exec_commands () {
> +	OIFS=$IFS
> +	IFS=$LF
> +	for i in $cmd
> +	do
> +		tmp=$(sed "/^pick .*/i\exec $i" "$1")
> +		echo "$tmp" >"$1"
> +		tmp=$(sed '1d' "$1")
> +		echo "$tmp" >"$1"
> +		echo "exec $i" >>"$1"
> +	done
> +	IFS=$OIFS
> +}

How about this?

	{
		first=t
		while read -r insn rest
		do
			case $insn in
			pick)
				test -n "$first" ||
				printf "%s" "$cmd"
				;;
			esac
			printf "%s %s\n" "$insn" "$rest"
			first=
		done
		printf "%s" "$cmd"
	} <"$1" >"$1.new" &&
	mv "$1.new" "$1"

together with:

> +	-x)
> +		test 2 -le "$#" || usage
> +		cmd="${cmd:+"$cmd$LF"} $2"
> +		shift
> +		;;

		cmd="${cmd}exec $2${LF}"

(I did not test this.)

-- Hannes
