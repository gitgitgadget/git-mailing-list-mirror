From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: fix issue with process substitution not
 working on Git for Windows
Date: Wed, 26 Oct 2011 13:02:47 -0700
Message-ID: <7vvcrb1py0.fsf@alter.siamese.dyndns.org>
References: <CAJzBP5QYKOf4OUMm4vfVay=b7F_fHJf40JgzDAZZa7p0fxLpyA@mail.gmail.com>
 <1319656389-9515-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 22:02:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ9gf-0000FR-6r
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 22:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab1JZUCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 16:02:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab1JZUCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 16:02:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D52C6C4C;
	Wed, 26 Oct 2011 16:02:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ctNxc2v5gMNjF1tNbQhOSyK8i5k=; b=pncqj9LV7jbmnh9TfjxT
	BkMjJm70geaLG0eIfxJELDFbjI24p1xJWP4yrK6nNW9K2xgSHQ1TjcjP5HF+MPLS
	cNl2PKTnGwrW+LBOnk9Goqz0GQLByQipWWuqxXh9Gfw68EsWqFhb/JDzT2he3zZf
	593LUWJhpn8K7M8M8Rlr9Ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ptpCXqPHhuORC0hQSzR0fyRXxXHTpntXbioUa2zFzJJ+7v
	davIphI+URFTWunVac10uPswFMKqASJsINlDUGnUtkZPvsKs6t+/h36yTPukR6Ng
	IbBaFsmuhl67DJ6pHl/IKKQa1WrnBCYi370rTPnK+bEnkIU7tFfktCVWieTFs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 441EF6C4B;
	Wed, 26 Oct 2011 16:02:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8D9B6C4A; Wed, 26 Oct 2011
 16:02:48 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A8B04F6-000D-11E1-96BC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184275>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> Git for Windows comes with a bash that doesn't support process substitution.
> It issues the following error when using git-completion.bash with
> GIT_PS1_SHOWUPSTREAM set:
>
> $ export GIT_PS1_SHOWUPSTREAM=1
> sh.exe": cannot make pipe for process substitution: Function not implemented
> sh.exe": cannot make pipe for process substitution: Function not implemented
> sh.exe": <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n '): ambiguous redirect
>
> Replace the process substitution with a 'here string'.
>
> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>

Yuck, but I honestly shouldn't care about the yuckiness as this script is
inherently intimately dependent on bash anyway ;-).

>  contrib/completion/git-completion.bash |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8648a36..0b3d47e 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -110,6 +110,7 @@ __git_ps1_show_upstream ()
>  	local upstream=git legacy="" verbose=""
>  
>  	# get some config options from git-config
> +	output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
>  	while read key value; do
>  		case "$key" in
>  		bash.showupstream)
> @@ -125,7 +126,7 @@ __git_ps1_show_upstream ()
>  			upstream=svn+git # default upstream is SVN if available, else git
>  			;;
>  		esac
> -	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')
> +	done <<< "$output"
>  
>  	# parse configuration values
>  	for option in ${GIT_PS1_SHOWUPSTREAM}; do
