From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Remove perl dependency from git-submodule.sh
Date: Thu, 31 May 2012 11:19:04 +0200
Message-ID: <4FC73788.6070805@viscovery.net>
References: <1338454126-30441-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jens.lehmann@web.de, gitster@pobox.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu May 31 11:19:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa1XL-0003aO-H0
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 11:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab2EaJTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 05:19:12 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19547 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753168Ab2EaJTM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 05:19:12 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Sa1X7-0005Jt-1v; Thu, 31 May 2012 11:19:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A17961660F;
	Thu, 31 May 2012 11:19:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1338454126-30441-1-git-send-email-iveqy@iveqy.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198875>

Am 5/31/2012 10:48, schrieb Fredrik Gustafsson:
> Rewrote a perl section in sh.

> The code may be a bit slower (doing grep on strings instead of using
> perl-lists).

"A lot" would be more correct on Windows :-) But it can be avoided, I think.

>  module_list()
>  {
> +	unmerged=
> +	null_sha1=0000000000000000000000000000000000000000
>  	git ls-files --error-unmatch --stage -- "$@" |
> -	perl -e '
> -	my %unmerged = ();
> -	my ($null_sha1) = ("0" x 40);
> -	while (<STDIN>) {
> -		chomp;
> -		my ($mode, $sha1, $stage, $path) =
> -			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
> -		next unless $mode eq "160000";
> -		if ($stage ne "0") {
> -			if (!$unmerged{$path}++) {
> -				print "$mode $null_sha1 U\t$path\n";
> -			}
> -			next;
> -		}
> -		print "$_\n";
> -	}
> -	'
> +	while read mode sha1 stage path

Be prepared for backslashes in the path name:

	while read -r mode sha1 stage path

> +	do
> +		if test $mode -eq 160000

$mode is not a number, but a string: test "$mode" = 160000

> +		then
> +			if test $stage -ne 0

That $stage looks like a number is of no importance, either.

> +			then
> +				if test -z "$(echo $unmerged | grep "|$path|")"
> +					then
> +					echo "$mode $null_sha1 U\t$path"
> +				fi
> +				unmerged="$unmerged|$path|"

IIUC, the purpose of $unmerged and this check is to avoid that an unmerged
path is dumped for each stage that is listed by ls-files. Therefore it
should be sufficient to just check that the current path is different from
the last path.

> +			else
> +				echo "$mode $sha1 $stage\t$path"
> +			fi
> +		fi
> +	done
>  }
>  
>  #

-- Hannes
