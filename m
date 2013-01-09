From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/19] reset.c: replace switch by if-else
Date: Wed, 09 Jan 2013 11:53:00 -0800
Message-ID: <7vhamq5e1v.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-10-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:53:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1iN-0008HY-DH
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446Ab3AITxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:53:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932413Ab3AITxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:53:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 315F7B594;
	Wed,  9 Jan 2013 14:53:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bbQJ6FR9jRAjWRK+tGtMkse8KOE=; b=HlkMqg
	uMf1hgtKnPSzmuyVbs1zvu/pawRNXFngPc0huA8cq20D3W3pevzVVip/sW+nzAbz
	5GpUGACI0DS+n3evYSU1W2gQTIR+JIGMIGyPo1NhMyPGh6IqBbM6Hc+f8ElCmxFq
	nOh24y/arYOLA1QOET3IbiNOWrqJmY79imU6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K4TC6+NStZ6x+ZuVxe19WpchwcgC/XBv
	VH8ooUZDS1uBmgNKhZvJZ2xNOppDvZU8zu9BdvVdWcgKcJefOKgRI7bykjFxDtRA
	ypSTWnBievmk9RYgnUbE4O8iv3V0nLp7Gm56M/38lbHVGESYFohJj2JXUGOiowzq
	u5lECwIojvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24CE5B592;
	Wed,  9 Jan 2013 14:53:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77FD7B583; Wed,  9 Jan 2013
 14:53:01 -0500 (EST)
In-Reply-To: <1357719376-16406-10-git-send-email-martinvonz@gmail.com>
 (Martin von Zweigbergk's message of "Wed, 9 Jan 2013 00:16:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D3CA972-5A96-11E2-BEAA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213092>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> ---
>  builtin/reset.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 42d1563..05ccfd4 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -351,18 +351,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	 * saving the previous head in ORIG_HEAD before. */
>  	update_ref_status = update_refs(rev, sha1);
>  
> -	switch (reset_type) {
> -	case HARD:
> -		if (!update_ref_status && !quiet)
> -			print_new_head_line(commit);
> -		break;
> -	case SOFT: /* Nothing else to do. */
> -		break;
> -	case MIXED: /* Report what has not been updated. */
> +	if (reset_type == HARD && !update_ref_status && !quiet)
> +		print_new_head_line(commit);
> +	else if (reset_type == MIXED) /* Report what has not been updated. */
>  		update_index_refresh(0, NULL,
>  				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
> -		break;
> -	}

Justification?

It might be shorter, but I somehow find the original _much_ easier
to follow, and to possibly extend.  The case arms delineate the
major modes of operation, and when somebody is interested in what
happens in "reset --hard", the case labels allow eyes to immediately
spot and skip uninteresting case arms.  On the other hand, the
updated one forces you to read the if/else cascade through.
