From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-testgit: avoid process substitution
Date: Thu, 25 Apr 2013 07:57:16 -0700
Message-ID: <7vehdy7j5f.fsf@alter.siamese.dyndns.org>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net> <5178C583.6000703@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 25 16:57:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVNbx-0007Wj-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 16:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757920Ab3DYO5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 10:57:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756916Ab3DYO5U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 10:57:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 109E718ABA;
	Thu, 25 Apr 2013 14:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G6VNr9hUVAK3V08Ic4W3hSO9kbA=; b=uoDru6
	mzQ9Av+FS+3pQdWWOyf4zwTqbpj3kaWKZ/KoAkTh7q1iqe9af+HfPpdT7gVPsFCK
	gHIfKeqL8qsG0J7diL+jG69bN9y9YVmRztYEB2lMFD7DkpgZdIuhNnDdrz2RzZee
	Hr/1isZPzXCayCEeanpMh5Mby1eV/hRDAHGis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O3dg2+6iK6SML9sBhbaTLH7WiYNfg/mH
	F+FPZ2sRRyrTO32G6G09I6/MxLqiTdF4ZJE4BRXZk6fuSeRy42j/tv2fvv5PcdcO
	sWuSgjeuyYQhULlHnxvA0xLpzG9LlBg8Za1QQhJiISelLXU5ZriVd4ofc0r0faCi
	iMc7egc1JP4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0360018AAF;
	Thu, 25 Apr 2013 14:57:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60B5C18AAE;
	Thu, 25 Apr 2013 14:57:18 +0000 (UTC)
In-Reply-To: <5178C583.6000703@viscovery.net> (Johannes Sixt's message of
	"Thu, 25 Apr 2013 07:56:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CB6F754-ADB8-11E2-9A94-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222386>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> Bash on Windows does not implement process substitution.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> ...
> Here is a fix. It assumes that the list of refs after the import is
> a superset of the refs before the import. (Can refs be deleted
> via fast-import?)
>
>  git-remote-testgit | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/git-remote-testgit b/git-remote-testgit
> index 23c9d40..e99d5fa 100755
> --- a/git-remote-testgit
> +++ b/git-remote-testgit
> @@ -91,13 +91,15 @@ do
>  
>  		git fast-import "${testgitmarks_args[@]}" --quiet
>  
> -		after=$(git for-each-ref --format='%(refname) %(objectname)')
> -
>  		# figure out which refs were updated
> -		join -e 0 -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after") |
> -		while read ref a b
> +		git for-each-ref --format='%(refname) %(objectname)' |
> +		while read ref a
>  		do
> -			test $a == $b && continue
> +			case "$before" in
> +			*"$ref $a"*)
> +				continue

This just like the original 'join' depends on the two output from
for-each-ref to be sorted the same way, which is true and fine.  But
I wonder one thing.  When $before has this in it:

	refs/heads/refs/heads/master 664059...126eaa7

and your "read ref a" got this in the input:

	refs/heads/master 664059...126eaa7

would the pattern matching by case work corretly?

Doing something like this might be needed.

	case "$LF$before$LF" in
        *"$LF$ref $a$LF"*)
        	continue ;; # matches
	esac
