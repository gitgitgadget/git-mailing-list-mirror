From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/7] git-rebase--interactive.sh: look up subject in add_pick_line
Date: Fri, 20 Jul 2012 10:14:20 +0200
Message-ID: <5009135C.208@viscovery.net>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com> <1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 10:14:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ss8ME-0004Da-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 10:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab2GTIOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 04:14:32 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:28307 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752532Ab2GTIOY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 04:14:24 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ss8Lt-00072m-7h; Fri, 20 Jul 2012 10:14:21 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F2E3D1660F;
	Fri, 20 Jul 2012 10:14:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201762>

Am 7/18/2012 9:27, schrieb Martin von Zweigbergk:
> @@ -814,7 +814,8 @@ add_pick_line () {
>  	else
>  		comment_out=
>  	fi
> -	printf '%s\n' "${comment_out}pick $1 $2" >>"$todo"
> +	line=$(git rev-list -1 --pretty=oneline --abbrev-commit --abbrev=7 $1)
> +	printf '%s\n' "${comment_out}pick $line" >>"$todo"

I don't like this. On Windows, rebase -i is already slow, and these extra
processes will make it even slower.

> +	git rev-list $revisions --reverse --left-right --topo-order |
>  	sed -n "s/^>//p" |
> -	while read -r shortsha1 rest
> +	while read -r sha1
>  	do
> -		sha1=$(git rev-parse $shortsha1)
>  		if test -z "$rebase_root"
...
> -			add_pick_line $shortsha1 "$rest"
> +			add_pick_line $sha1
>  		fi

This is 'rebase -p' case, and you trade the new processes for some old ones.

> +	git rev-list $revisions --reverse --left-right --topo-order \
> +		--no-merges --cherry-pick |
>  	sed -n "s/^>//p" |
> -	while read -r shortsha1 rest
> +	while read -r sha1
>  	do
> -		add_pick_line $shortsha1 "$rest"
> +		add_pick_line $sha1
>  	done

But in the regulare case, you don't; the processes are really new.

Anything that can be done about this? Perhaps the rev-list call can
generate all of the full SHA1, the short SHA1, and the subject with a
--pretty format?

-- Hannes
