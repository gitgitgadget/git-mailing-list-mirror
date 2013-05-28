From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] rebase: fix 'cherry' mode storage
Date: Tue, 28 May 2013 15:29:15 -0700
Message-ID: <7v8v2yyc04.fsf@alter.siamese.dyndns.org>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
	<1369747757-10192-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 00:29:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhSOQ-0000qO-MG
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 00:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758804Ab3E1W3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 18:29:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756973Ab3E1W3S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 18:29:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AF6823E23;
	Tue, 28 May 2013 22:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TDLSJYOJa7p0rYrzLr4skAAMSYU=; b=w3pmRA
	rXk83craf/JgcD5U6Q95B+tk7BMMNtSgrOydOVzg6V7coCQG2p4PuuoBhE6K2ClN
	LxO6jCQuZMNa1xkyVNo+KTpSHXMhH9ut6GY4BoIPCuCsuyvaVcWpeliNjca0O+QM
	/UhoAntPrOCcICimJQ0PyNUf7kgvwoGuAueeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hKzqXw1CilGrQNfOd/ahyjPcgxuHI16+
	JqOyU2DyZsIDOLbsnp7B7UXytGQBgePpQIC92uM7cDR2+6QVtfRmjHhszxLBe8j7
	eWeUmpY/O4FLBcq78Ei28Ac3m+0i6AmSlRXE7hBQZAWuyW30ZzT6/RveWH4+9Bf8
	ndXwiYYhZxE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F34023E21;
	Tue, 28 May 2013 22:29:17 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A211023E20;
	Tue, 28 May 2013 22:29:16 +0000 (UTC)
In-Reply-To: <1369747757-10192-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 28 May 2013 08:29:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0818325C-C7E6-11E2-825B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225692>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We don't use the 'rebase-apply'.

s/.$/; we will use rebase-merge instead./ I think.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-rebase--cherry.sh | 4 ++++
>  git-rebase.sh         | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
> index cbf80f9..ab1f8b7 100644
> --- a/git-rebase--cherry.sh
> +++ b/git-rebase--cherry.sh
> @@ -18,6 +18,9 @@ esac
>  
>  test -n "$rebase_root" && root_flag=--root
>  
> +mkdir "$state_dir" || die "Could not create temporary $state_dir"
> +: > "$state_dir"/cherry || die "Could not mark as cherry"

Style:

	>"$state_dir/cherry-pick"

I am not sure if the user _cares_ that internally we use cherry-pick
when s/he asks us to do a keep-empty, and I suspect "mark as cherry"
incomprehensible.  I do not even know what is going on at this point
(yet).

I _suspect_ that you are using cherry-pick when --keep-empty is given,
so it might even make sense to talk in the end-users' terms,
i.e. call this "$state_dir/keep-empty" (I am not sure if calling
this split half "git-rebase--keep-empty.sh" makes sense, yet).

> +
>  # we have to do this the hard way.  git format-patch completely squashes
>  # empty commits and even if it didn't the format doesn't really lend
>  # itself well to recording empty patches.  fortunately, cherry-pick
> @@ -32,3 +35,4 @@ then
>  fi
>  
>  move_to_original_branch
> +rm -rf "$state_dir"
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 2754985..b7759d5 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -174,6 +174,9 @@ then
>  	then
>  		type=interactive
>  		interactive_rebase=explicit
> +	elif test -f "$merge_dir"/cherry
> +	then
> +		type=cherry
>  	else
>  		type=merge
>  	fi
> @@ -382,7 +385,7 @@ then
>  elif test -n "$keep_empty"
>  then
>  	type=cherry
> -	state_dir="$apply_dir"
> +	state_dir="$merge_dir"
>  else
>  	type=am
>  	state_dir="$apply_dir"
