From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: Expose an API corresponding to 'clear'
 functionality
Date: Mon, 11 Apr 2011 11:36:05 -0700
Message-ID: <7vmxjwws8a.fsf@alter.siamese.dyndns.org>
References: <1302511916-23320-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 20:36:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9LyL-00086v-5M
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 20:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab1DKSgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 14:36:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224Ab1DKSgT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 14:36:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 233875418;
	Mon, 11 Apr 2011 14:38:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J5YPnGG8RQFNX0vzuDdIe1+LvXw=; b=fh5l8Q
	KOZO6Ai1zHflGLoWPNwrN4oauNxwd3gBJk4ZDfHELvqYlpZBTN0iDTEdZAXfWuC6
	F2SXZBezxuBJJYFLAPg6EDgdGNjP7umCEJM+nlnwkGCoA+lPt1iUKSpPHYj/UkY1
	AuDBQ67J4eeQQRIprodULXI9bonT34DJy0vzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GFvUIQS+k7QJpetcTtKoohX+Q7aus84+
	qw+ZxrMlL8IlzMXBpCOhCZwX+VooTrUPqB3LK4/IyEJcvBXyofTy4772l74+ibmU
	CG213ja+nq/D2Eu1cnew+elhcu5sth1jwur0a+Be6ZyZ8vYKG00OZYCVCSlioi0z
	8IfZTfCJUjw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D66E85414;
	Mon, 11 Apr 2011 14:38:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 510725413; Mon, 11 Apr 2011
 14:38:05 -0400 (EDT)
In-Reply-To: <1302511916-23320-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Mon, 11 Apr 2011 14:21:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA019B78-646A-11E0-B7ED-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171348>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Expose a new function called rerere_clear, and rework
> 'builtin/rerere.c' to use this when the corresponding command-line
> argument is passed.

> @@ -142,19 +134,14 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
>  		pathspec = get_pathspec(prefix, argv + 1);
>  		return rerere_forget(pathspec);
>  	}
> +	if (!strcmp(argv[0], "clear"))
> +		return rerere_clear();
>  
>  	fd = setup_rerere(&merge_rr, flags);
>  	if (fd < 0)
>  		return 0;
>  
> -	if (!strcmp(argv[0], "clear")) {
> -		for (i = 0; i < merge_rr.nr; i++) {
> -			const char *name = (const char *)merge_rr.items[i].util;
> -			if (!has_rerere_resolution(name))
> -				unlink_rr_item(name);
> -		}
> -		unlink_or_warn(git_path("MERGE_RR"));
> -	} else if (!strcmp(argv[0], "gc"))

In your version, the call of rerere_clear() is not protected by a check
that used to return early in a repository that is configured not to use
rerere.  I don't see there is a corresponding early return in the new
function rerere_clear() you created in rerere.c, either.

Would that cause a user-visible regression?

> diff --git a/rerere.h b/rerere.h
> index 595f49f..b9ab839 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -16,8 +16,10 @@ extern void *RERERE_RESOLVED;
>  extern int setup_rerere(struct string_list *, int);
>  extern int rerere(int);
>  extern const char *rerere_path(const char *hex, const char *file);
> +extern void unlink_rr_item(const char *name);

The name was perfectly fine while it was a file-scope static, but is
unacceptable as a public function.  At least please spell "rerere" out
somewhere to ensure that even first-time readers can tell what area of the
system the function is about.
