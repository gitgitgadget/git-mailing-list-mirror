From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] mergetool: don't skip modify/remove conflicts
Date: Mon, 14 Feb 2011 16:54:41 -0800
Message-ID: <7v1v3aqfqm.fsf@alter.siamese.dyndns.org>
References: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297570198-21103-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297570198-21103-2-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 01:55:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp9CA-0003yw-Up
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 01:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab1BOAyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 19:54:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab1BOAyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 19:54:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 709D5494D;
	Mon, 14 Feb 2011 19:55:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aGktpyF2HKEfoxkZyfEFJXJl3Oc=; b=BafI8b
	uvT5A8WbaE1Gtstnv3JrJ52Z/8H9ug7LfXdBo/UVmpekr6W5FawDrPX+CJGZhDA5
	B3jxWKfS4UO+VOroE8durvc+LVJp6bW7oR19G+VMtPvQn6L2DYo+bNmUlGhizqAq
	Any60l3n7163ROyZ2dG+3w3crY1pfVsZjEu7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U8wU07XSu48mrc1zx5VWlBgjQygV5W/b
	HatEFPdnD0lbXmOFDOuZMf69+dnDsjLztwxwJRlM2ZOz8C0RjAyyURgB+T4poRQC
	YtD5SwWEGdUHLd3e0Ye5avIrpQj/dCeVoTJDw/V8r4Kkp7psmGznpegWIJGlidHl
	LO+UWuwNLIM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F4DF494C;
	Mon, 14 Feb 2011 19:55:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 013F2494B; Mon, 14 Feb 2011
 19:55:46 -0500 (EST)
In-Reply-To: <1297570198-21103-2-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Sat\, 12 Feb 2011 23\:09\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5589B29C-389E-11E0-9276-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166804>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> diff --git a/builtin/rerere.c b/builtin/rerere.c
> index 081fccc..7b9fe18 100644
> --- a/builtin/rerere.c
> +++ b/builtin/rerere.c
> @@ -147,8 +147,6 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
>  	if (!strcmp(argv[0], "clear")) {
>  		for (i = 0; i < merge_rr.nr; i++) {
>  			const char *name = (const char *)merge_rr.items[i].util;
> -			if (!name)
> -				continue;
>  			if (!has_rerere_resolution(name))
>  				unlink_rr_item(name);
>  		}
> @@ -157,19 +155,22 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
>  		garbage_collect(&merge_rr);
>  	else if (!strcmp(argv[0], "status"))
>  		for (i = 0; i < merge_rr.nr; i++) {
> -			if (!merge_rr.items[i].util)
> -				continue;
>  			printf("%s\n", merge_rr.items[i].string);
>  		}
> -	else if (!strcmp(argv[0], "remaining"))
> -		for (i = 0; i < merge_rr.nr; i++)
> -			printf("%s\n", merge_rr.items[i].string);
> -	else if (!strcmp(argv[0], "diff"))
> +	else if (!strcmp(argv[0], "remaining")) {
> +		rerere_remaining(&merge_rr);
> +		for (i = 0; i < merge_rr.nr; i++) {
> +			if (merge_rr.items[i].util != RERERE_RESOLVED)
> +				printf("%s\n", merge_rr.items[i].string);
> +			else
> +				/* prepare for later call to
> +				 * string_list_clear() */
> +				merge_rr.items[i].util = NULL;
> +		}
> +	} else if (!strcmp(argv[0], "diff"))
>  		for (i = 0; i < merge_rr.nr; i++) {
>  			const char *path = merge_rr.items[i].string;
>  			const char *name = (const char *)merge_rr.items[i].util;
> -			if (!name)
> -				continue;
>  			diff_two(rerere_path(name, "preimage"), path, path, path);
>  		}
>  	else

By looking at the diff between the parent of f322b35 (my earlier "rerere
remaining" patch) and the result of applying this patch on top of the
patch, I think the basic idea of this is to correct my stupid mistake of
contaminating merge_rr unconditionally, and instead adding the "remaining"
entries only when handling the "rerere remaining" command (hence many
removal of special cases "if (!name) continue" introduced by my patch.
The result looks _much_ cleaner than the above patch shows and I am happy
with it.

But shouldn't you also revert the parts of my patch to do_plain_rerere()
and rerere_forget() that have similar special cases?
