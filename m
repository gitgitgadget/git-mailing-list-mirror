From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] rebase: fix sequence continuation
Date: Tue, 28 May 2013 15:31:22 -0700
Message-ID: <7v4ndmybwl.fsf@alter.siamese.dyndns.org>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
	<1369747757-10192-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 00:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhSQT-0002me-UT
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 00:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758957Ab3E1WbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 18:31:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757364Ab3E1WbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 18:31:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DF9023F66;
	Tue, 28 May 2013 22:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KkrGDCgqGNt/EbGxgij06ewRWYs=; b=iT9AVT
	eCZ9TjXzgyZFcir4rsLslUSeIVcLp91JI5vy6pN3WO+AVDPlRch5bnCxXvIacza0
	Mut+y4fGMK8Da2rUc2sfLJatMTCSWfP5OB9hk2lQu0Rm+ejHEqQG9k4eRpvvpoq0
	jBaVMjFoGgOB+utCT1Vyt2yNAsWyfGiFnrOsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ous1GKukzH6niymWpxH+eC/MnCu3GWmk
	neyqtYHlvH5T3KqsOSWNkalWl/Q8qaeRZ35b29OlPZKPE720E0feQBJEkOqwYp6e
	7YActY+UUKNhPHOl98oXWNuumOAX31989IIIM4WSFR6CONlQ4HWXBG9AJfcfVPaE
	dIBtzQ8mnTQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60FB923F65;
	Tue, 28 May 2013 22:31:24 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0A9323F64;
	Tue, 28 May 2013 22:31:23 +0000 (UTC)
In-Reply-To: <1369747757-10192-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 28 May 2013 08:29:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53DDB7B6-C7E6-11E2-AD91-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225693>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We are not in am mode.

That may make sense, but shouldn't this part be like so from the
very beginning?  In other words, this looks like an "oops, 1/5 was
buggy and this is a hotfix".

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-rebase--cherry.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
> index ab1f8b7..ca78b1b 100644
> --- a/git-rebase--cherry.sh
> +++ b/git-rebase--cherry.sh
> @@ -5,13 +5,15 @@
>  
>  case "$action" in
>  continue)
> -	git am --resolved --resolvemsg="$resolvemsg" &&
> -	move_to_original_branch
> +	git cherry-pick --continue &&
> +	move_to_original_branch &&
> +	rm -rf "$state_dir"
>  	exit
>  	;;
>  skip)
> -	git am --skip --resolvemsg="$resolvemsg" &&
> -	move_to_original_branch
> +	git cherry-pick --skip &&
> +	move_to_original_branch &&
> +	rm -rf "$state_dir"
>  	exit
>  	;;
>  esac
