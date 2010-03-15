From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Improve error messages from 'git stash show'
Date: Mon, 15 Mar 2010 16:17:50 -0700
Message-ID: <7vbpepb2e9.fsf@alter.siamese.dyndns.org>
References: <1268691590-27100-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Tue Mar 16 00:18:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJY0-0002xb-5g
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937146Ab0COXSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 19:18:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410Ab0COXSA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 19:18:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16DFEA2243;
	Mon, 15 Mar 2010 19:17:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2KgIcle7SyOL5zZ/184LkwSA5v8=; b=cKIpGx
	sbQTcaY/j2UIMoDWuHxZSR2nr5U511fMSFcMFeI4OdEPY1HG7mZWhqeiXC+nBccK
	wgbq1hiGFcMbybogdgcbNl0DKYgXl28vFkKuNjYPK/QSfzCr561SSwSNz4inAo19
	DfOEWdLP7IpdB824bC02sXUVDoyXdkep//7YY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WXh6fFoz4gKtQ0m4UGHnaZVa3AJqXyg8
	6Obly6OyJjSTk0ClsegshHGPCgfEdGZvWcclotnPVWe7ORcuq9Xg4D728oc3x9lr
	bS65BDSLf+ASDwu2CavbqnN3OUJ/Tn1wfCrZgOWWXDilMNNIRJTW19UsHy7kB5az
	0uISyaT4Q6M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1640A2242;
	Mon, 15 Mar 2010 19:17:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43E3AA2240; Mon, 15 Mar
 2010 19:17:52 -0400 (EDT)
In-Reply-To: <1268691590-27100-1-git-send-email-hendeby@isy.liu.se> (Gustaf
 Hendeby's message of "Mon\, 15 Mar 2010 23\:19\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC2CD1E8-3088-11DF-B6FB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142273>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> The previous error message "fatal: Needed a single revision" is not
> very informative.
>
> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
> ---
>  git-stash.sh |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index aa47e54..cf221c6 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -210,14 +210,18 @@ list_stash () {
>  }
>  
>  show_stash () {
> +	have_stash || die 'No stash found'
> +
>  	flags=$(git rev-parse --no-revs --flags "$@")
>  	if test -z "$flags"
>  	then
>  		flags=--stat
>  	fi
>  
> -	w_commit=$(git rev-parse --verify --default $ref_stash "$@") &&
> -	b_commit=$(git rev-parse --verify "$w_commit^") &&
> +	w_commit=$(git rev-parse --quiet --verify --default $ref_stash "$@") &&
> +	b_commit=$(git rev-parse --quiet --verify "$w_commit^") ||
> +		die 'Stash not found'
> +

Because you checked have_stash upfront, an error detected here cannot be
"stash not found".  It is something else, isn't it?

>  	git diff $flags $b_commit $w_commit
>  }
>  
> -- 
> 1.7.0.2.274.gc376e.dirty
