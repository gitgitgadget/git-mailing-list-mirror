From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase -i: Preserve whitespace at beginning of
 commit header in $GIT_EDITOR
Date: Fri, 09 Jul 2010 15:37:40 -0700
Message-ID: <7vpqywl1sb.fsf@alter.siamese.dyndns.org>
References: <1278652843-30872-1-git-send-email-ayiehere@gmail.com>
 <1278652843-30872-2-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 00:37:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXMCi-0001R9-36
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 00:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab0GIWhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 18:37:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab0GIWhu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 18:37:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CAF1C3FD4;
	Fri,  9 Jul 2010 18:37:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qct6VEqTxfVhTM5g/Mf6XfK1ONE=; b=jzbveX
	RzRMG+DWCt4Vcdaks3HowXjCxnjAND+zelem8ktAm8EWnuKeoKjYAn6k8obsxZCQ
	HlN3R7U9qsx75CBCvIMrb0oUVt24EoS6MyrHP4c4bFNBRMfFVa8cJ0kCVx+sZcrz
	cg+y8IiR7AjC1DjezTrP3yBq19/HSx6xgO2c4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JEuQC3wJomqP+BXqK8hTVdbf9fWJRO2k
	T68ecE+6NZBr2yAzkVwJRRtFZLiMOqtkWVFhaxrlsUSR7C+O17cyxhtuYGF0cEXv
	GJytm3uh0/MsCWoWPiEVblkMrnb0UwqRFdMN7DCG34BdlAQDEsaZ9AF4Upw5yM9H
	ehJq1PjXE1Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C10C3FD3;
	Fri,  9 Jul 2010 18:37:46 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37ECDC3FD1; Fri,  9 Jul
 2010 18:37:42 -0400 (EDT)
In-Reply-To: <1278652843-30872-2-git-send-email-ayiehere@gmail.com> (Nazri
 Ramliy's message of "Fri\,  9 Jul 2010 13\:20\:43 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9862EA76-8BAA-11DF-8495-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150695>

Nazri Ramliy <ayiehere@gmail.com> writes:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 31e6860..726cb6a 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -889,14 +889,15 @@ first and then run 'git rebase --continue' again."
>  		fi
>  		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
>  			--abbrev=7 --reverse --left-right --topo-order \
> +			$REVISIONS | sed -n "s/^>//p" > "$TODO.tmp"
> +
> +		if test t != "$PRESERVE_MERGES"
> +		then
> +			cat "$TODO.tmp" | sed "s/^/pick /" > "$TODO"

Do not cat a single file into a pipeline.

	sed "s/^/pick /" <"$TODO.tmp" >"$TODO"

> +		else
> +			cat "$TODO.tmp" |

Likewise.

> +			while read -r shortsha1 rest
> +			do
>  				sha1=$(git rev-parse $shortsha1)
>  				if test -z "$REBASE_ROOT"
>  				then
> @@ -914,10 +915,12 @@ first and then run 'git rebase --continue' again."
>  				if test f = "$preserve"
>  				then
>  					touch "$REWRITTEN"/$sha1
> +					grep "^$shortsha1" "$TODO.tmp" | sed "s/^/pick /" >> "$TODO"

Don't pipe output of grep into sed.

	sed -ne "/^$shortsha1 /s/^/pick /p" <"$TODO.tmp" >>"$TODO"
