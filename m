From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] completion: fix alias listings with newlines
Date: Wed, 07 Oct 2009 11:33:09 +0200
Message-ID: <4ACC6055.1070204@viscovery.net>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 11:37:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvSvP-0000Xr-Bx
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 11:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbZJGJdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 05:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753055AbZJGJdx
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 05:33:53 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2364 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbZJGJdw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 05:33:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MvStS-0006xr-2e; Wed, 07 Oct 2009 11:33:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7AE4F9614; Wed,  7 Oct 2009 11:33:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1254905331-29516-1-git-send-email-bebarino@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129643>

Stephen Boyd schrieb:
>  __git_aliases ()
>  {
> -	local i IFS=$'\n'
> -	for i in $(git --git-dir="$(__gitdir)" config --get-regexp "alias\..*" 2>/dev/null); do
> -		i="${i#alias.}"
> -		echo "${i/ */}"
> +	local i
> +	git --git-dir="$(__gitdir)" config -z --get-regexp "alias\..*" 2>/dev/null |
> +	while IFS= read -rd '' i; do
> +		echo ${i#alias.} | cut -d' ' -f1
>  	done
>  }

Is it necessary to change the body of the loop? Your version spawns two
processes on each iteration, while the original spawned no processes.

You can avoid the pipeline (i.e. yet another process) using a "here-string":

	local i aliases=$(git --git-dir="$(__gitdir)" config -z \
				--get-regexp "alias\..*" 2>/dev/null)
	while IFS= read -rd '' i; do
		i="${i#alias.}"
		echo "${i/ */}"	# could be: echo "${i%% *}"
  	done <<< "$aliases"

but I don't know how well bash handles variable values with embedded NULs.

-- Hannes
