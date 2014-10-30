From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] send-pack.c: add an --atomic-push command line argument
Date: Thu, 30 Oct 2014 13:04:26 -0700
Message-ID: <xmqqioj1uxx1.fsf@gitster.dls.corp.google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
	<1413924400-15418-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 21:04:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjvxS-0000Dn-BQ
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 21:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933926AbaJ3UEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 16:04:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932513AbaJ3UEa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 16:04:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DB461979D;
	Thu, 30 Oct 2014 16:04:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kfK/IkBdN7Ll3FUnpbcbncGnZc4=; b=HrxE4i
	TeMFBtdRwNiNEQRz56Hz9ak8dgi0j7bqilWrBMp1lh/GK1uLZxUxAEOGSFs79WkS
	6UPAZA6JzppvPXt5j4WmBql2lUwUWOD/1J0znwDnWkQTx15As/Mc7cYVDpdohauH
	2RihX18hY+hnI3CEa354wDkV+DgGHrVzGQ/70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ouDnvMrqnzQtkoTl2cN9lQV+6h+8E9dV
	KguJp05k8b1pq4lM9M73Fuzc4vOkkUHxb7Dx+k++FRQWdo50/YC0EJMYuw/A0Lz7
	OWwAEsMy8+HlHKTE5lSjHRbNNCeJ2HcTwweX0UbuukIypGXpBPJ73WA8im/jmO9v
	TcAyD4vs4n8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45EA31979C;
	Thu, 30 Oct 2014 16:04:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B51041979B;
	Thu, 30 Oct 2014 16:04:27 -0400 (EDT)
In-Reply-To: <1413924400-15418-3-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 13:46:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3E5C366-606F-11E4-9212-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
> index 2a0de42..8f64feb 100644
> --- a/Documentation/git-send-pack.txt
> +++ b/Documentation/git-send-pack.txt
> @@ -9,7 +9,7 @@ git-send-pack - Push objects over Git protocol to another repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
> +'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic-push] [<host>:]<directory> [<ref>...]
>  
>  DESCRIPTION
>  -----------
> @@ -62,6 +62,11 @@ be in a separate packet, and the list must end with a flush packet.
>  	Send a "thin" pack, which records objects in deltified form based
>  	on objects not included in the pack to reduce network traffic.
>  
> +--atomic-push::
> +	With atomic-push all refs are updated in one single atomic transaction.
> +	This means that if any of the refs fails then the entire push will
> +	fail without changing any refs.

Whenever you say "This means that", please read it twice to see if
everything before and including that phrase can be removed.  It is a
sign that you found what you wrote before it is not understandable
and what follows is the version that would be understood by the
readers.

> @@ -203,6 +203,13 @@ static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_a
>  	case REF_STATUS_REJECT_NEEDS_FORCE:
>  	case REF_STATUS_REJECT_STALE:
>  	case REF_STATUS_REJECT_NODELETE:
> +		if (atomic_push_failed && args->use_atomic_push) {

Hmph.  Can we even get atomis_push_failed when args->use_atomic_push
is not set?

> +			fprintf(stderr, "Atomic push is not possible "
> +				"for ref %s. Status:%d\n", ref->name,
> +				ref->status);
> +			*atomic_push_failed = 1;
> +		}
> +		/* fallthrough */

Is this "is not possible" (hence we do not let the user use it), or
"failed" (i.e. we tried and we failed)?
