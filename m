From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] push: fail early with detached HEAD and current
Date: Wed, 29 May 2013 12:34:29 -0700
Message-ID: <7vppw9shq2.fsf@alter.siamese.dyndns.org>
References: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
	<1369855311-23367-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 21:35:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhm9d-0003WF-JR
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966764Ab3E2Ten (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:34:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966702Ab3E2Teg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:34:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51481228DF;
	Wed, 29 May 2013 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j9Yi3cwzZr/s8m4IfvlURAt3QAM=; b=edyMpZ
	sSYS+t9RqkMEmbVyR4OzkaVehsGXd0n6MgodygHPob5uBgzQhGQ/2HGDGQnBQVf8
	UjCY4SZFIAgm8RXJjWwc1JZHiTrjgPE/jhFjGrzkN2fSK9D4Wa2FA/ufCYBlXCwp
	DGZdV+hmMHwOz9SepTU33XZs+wTz/HhraglzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ooW68PkHqMxYn1XwS8Yc50Xp66HuDJGA
	3MFFpBZut495L4AkSCWqy9zHl26icEqR5Ny23OZnAMmvAUE4+iyejaQdFs9aMFXY
	v3VWhXmu5jDWKfmUf2OFDeW4s6uvj4wd6N3cawfleHQbHrUckglsdIAUly0QxUrF
	9BYQQF46Piw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48480228DE;
	Wed, 29 May 2013 19:34:32 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C8C4228DC;
	Wed, 29 May 2013 19:34:31 +0000 (UTC)
In-Reply-To: <1369855311-23367-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 30 May 2013 00:51:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8D49458-C896-11E2-BA59-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225875>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Setting push.default to current adds the refspec "HEAD" for the
> transport layer to handle.  If "HEAD" doesn't resolve to a branch (and
> since no refspec rhs is specified), the push fails after some time with
> a cryptic error message:
>
>   $ git push
>   error: unable to push to unqualified destination: HEAD
>   The destination refspec neither matches an existing ref on the remote nor
>   begins with refs/, and we are unable to guess a prefix based on the source ref.
>   error: failed to push some refs to 'git@github.com:artagnon/git'
>
> Fail early with a nicer error message:
>
>   $ git push
>   fatal: You are not currently on a branch.
>   To push the history leading to the current (detached HEAD)
>   state now, use
>
>     git push ram HEAD:<name-of-remote-branch>
>
> Just like in the upstream and simple cases.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  builtin/push.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index ef3aa97..a79038c 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -175,6 +175,8 @@ static void warn_unspecified_push_default_configuration(void)
>  
>  static void setup_default_push_refspecs(struct remote *remote)
>  {
> +	struct branch *branch = branch_get(NULL);
> +
>  	switch (push_default) {
>  	default:
>  	case PUSH_DEFAULT_UNSPECIFIED:
> @@ -194,6 +196,8 @@ static void setup_default_push_refspecs(struct remote *remote)
>  		break;
>  
>  	case PUSH_DEFAULT_CURRENT:
> +		if (!branch)
> +			die(_(message_detached_head_die), remote->name);
>  		add_refspec("HEAD");
>  		break;

This means well, but I am not sure calling branch_get() for all
other cases that do not care about the current branch is a right
thing to do.  It's not like you need branch variable to free some
resource after done, or pass it around to callees from this
function.

Would it hurt to do

	if (!branch_get(NULL))
		die(...);

here, without the first hunk?  
