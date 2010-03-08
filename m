From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git status: Show detailed dirty status of submodules
 in long format
Date: Mon, 08 Mar 2010 00:33:28 -0800
Message-ID: <7vvdd7yzzb.fsf@alter.siamese.dyndns.org>
References: <4B90EB19.2070300@web.de>
 <7vtyssadtx.fsf@alter.siamese.dyndns.org> <4B9406A5.2090300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 08 09:33:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoYPI-000755-T4
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 09:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab0CHIdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 03:33:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587Ab0CHIdh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 03:33:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E386A0571;
	Mon,  8 Mar 2010 03:33:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xIhaeyM8ZPmQHQgmbWPQym7RjEU=; b=heDbKEoMZMowDm66SFg9SzJ
	TDbMsD1gbcjcxHZvGqNM5HV210zNM+Dom58K17pbWvrLLnXngWQHnOlHiaSlnJX6
	xc+BRurskU7zNN+hNUs01CKjvMoo6ubSBp/U0lzCrN48Urw8vWvAzxJgBm+rTPj6
	XNfk3i3Oa/d7eY1w6Iv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=qcnSQkpDUCCVIyl5tPwn5fU9EFEfzDNhydQoTNtaHEACZDS0c
	AZcYOu+sPDW6zUXitilcVMaBqM6PdDQcd7zYV4YPVXmjR1oM+zT8NH2VShT9beq3
	CwYqPiNhD2+haX8lfgmlrRMNZLy4/SEivi9cP+TeofphMtc9Py+DrFFnUs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BB96A056F;
	Mon,  8 Mar 2010 03:33:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4ACA0A056E; Mon,  8 Mar
 2010 03:33:30 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 48943B86-2A8D-11DF-9D14-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141754>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I was planning a cleanup patch anyway to get rid of the test for
> DIFF_FORMAT_PATCH by setting DIFF_OPT_DIRTY_SUBMODULES at the appropriate
> call sites and then only test for DIFF_OPT_DIRTY_SUBMODULES here. Putting
> the duplicated code into a new function is a good idea, so I'll do that
> in the cleanup patch, o.k.?

Sounds sensible, thanks.

> diff --git a/wt-status.c b/wt-status.c
> index 5807fc3..c028afd 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -153,6 +157,21 @@ static void wt_status_print_change_data(struct wt_status *s,
>  			one_name = d->head_path;
>  		break;
>  	case WT_STATUS_CHANGED:
> +		if (d->new_submodule_commits || d->dirty_submodule) {
> +			const char *sep = "";
> +			strbuf_addstr(&extra, " (");
> +			if (d->new_submodule_commits) {
> +				strbuf_addf(&extra, "new commits");
> +				sep = ", ";
> +			}
> +			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
> +				strbuf_addf(&extra, "%smodified content", sep);
> +				sep = ", ";
> +			}
> +			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> +				strbuf_addf(&extra, "%suntracked content",sep);
> +			strbuf_addch(&extra, ')');
> +		}

This may be easier to read and maintain if you always added ", " at each
step, and then backed up by two places before closing the thing with ')',
without doing the sep = ", " in the middle.

> @@ -189,6 +208,10 @@ static void wt_status_print_change_data(struct wt_status *s,
>  	default:
>  		die("bug: unhandled diff status %c", status);
>  	}
> +	if (extra.len) {
> +		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), extra.buf);
> +		strbuf_release(&extra);
> +	}

This needs to be touched up as:

	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "%s", extra.buf);

just in case we may start adding some more free strings in extra.buf
later.  Also we tell the compiler that the third parameter to the function
quacks like printf format string, and get a warning for passing an
arbitrary string extra.buf to it.
